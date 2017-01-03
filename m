Received: from eggs.gnu.org ([2001:4830:134:3::10]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cOTe4-0007zM-1g
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cOTdz-0007Gs-TS
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:17:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:42894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1cOTdz-0007Gm-JG
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:17:07 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7A148AAB5
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 18:17:05 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
Date: Tue,  3 Jan 2017 19:16:48 +0100
Message-Id: <ee97fcda99c77c62d64c1baa88fd17fed7639626.1483467324.git.msuchanek@suse.de>
In-Reply-To: <20161213173354.jffasav66gdl7v4q@wingsuit>
References: <20161213173354.jffasav66gdl7v4q@wingsuit>
Subject: [Qemu-devel] [PATCH v2 1/2] Do endian swapping.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Suchanek <msuchanek@suse.de>

This allows running big endian and little endian guest side by side using
cut & paste between them.

There is a general design idea that swapping should come as close to
virtio_read/virtio_write as possible. In particular, the protocol
between vdagent and vdagentd is guest-specific and in native endian.
With muliple layers of headers this is a bit tricky. A few message types
have to be swapped fully before passing through vdagentd.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>

---
v2:
 - introduce helper functions to swap (a portion of) a message wholesale
 - pollute fewer places with swapping sometimes at the cost of slightly
   more verbose code
---
 src/vdagentd/vdagentd.c    | 99 +++++++++++++++++++++++++++++++++++++---------
 src/vdagentd/virtio-port.c | 35 ++++++++++------
 2 files changed, 102 insertions(+), 32 deletions(-)

diff --git a/src/vdagentd/vdagentd.c b/src/vdagentd/vdagentd.c
index a1faf23..991514e 100644
--- a/src/vdagentd/vdagentd.c
+++ b/src/vdagentd/vdagentd.c
@@ -78,6 +78,34 @@ static int client_connected = 0;
 static int max_clipboard = -1;
 
 /* utility functions */
+static void virtio_msg_htole32(uint8_t *_msg, uint32_t size, uint32_t offset)
+{
+    uint32_t i, *msg = (uint32_t *)(_msg + offset);
+
+    /* offset - size % 4 should be 0 */
+    for (i = 0; i < (size - offset) / 4; i++)
+        msg[i] = htole32(msg[i]);
+}
+
+static void virtio_msg_le32toh(uint8_t *_msg, uint32_t size, uint32_t offset)
+{
+    uint32_t i, *msg = (uint32_t *)(_msg + offset);
+
+    /* offset - size % 4 should be 0 */
+    for (i = 0; i < (size - offset) / 4; i++)
+        msg[i] = le32toh(msg[i]);
+}
+
+static void virtio_msg_le16toh(uint8_t *_msg, uint32_t size, uint32_t offset)
+{
+    uint32_t i;
+    uint16_t *msg = (uint16_t *)(_msg + offset);
+
+    /* offset - size % 2 should be 0 */
+    for (i = 0; i < (size - offset) / 2; i++)
+        msg[i] = le16toh(msg[i]);
+}
+
 /* vdagentd <-> spice-client communication handling */
 static void send_capabilities(struct vdagent_virtio_port *vport,
     uint32_t request)
@@ -102,6 +130,7 @@ static void send_capabilities(struct vdagent_virtio_port *vport,
     VD_AGENT_SET_CAPABILITY(caps->caps, VD_AGENT_CAP_GUEST_LINEEND_LF);
     VD_AGENT_SET_CAPABILITY(caps->caps, VD_AGENT_CAP_MAX_CLIPBOARD);
     VD_AGENT_SET_CAPABILITY(caps->caps, VD_AGENT_CAP_AUDIO_VOLUME_SYNC);
+    virtio_msg_htole32((uint8_t *)caps, size, 0);
 
     vdagent_virtio_port_write(vport, VDP_CLIENT_PORT,
                               VD_AGENT_ANNOUNCE_CAPABILITIES, 0,
@@ -151,8 +180,8 @@ static void do_client_monitors(struct vdagent_virtio_port *vport, int port_nr,
                     (uint8_t *)mon_config, size);
 
     /* Acknowledge reception of monitors config to spice server / client */
-    reply.type  = VD_AGENT_MONITORS_CONFIG;
-    reply.error = VD_AGENT_SUCCESS;
+    reply.type  = htole32(VD_AGENT_MONITORS_CONFIG);
+    reply.error = htole32(VD_AGENT_SUCCESS);
     vdagent_virtio_port_write(vport, port_nr, VD_AGENT_REPLY, 0,
                               (uint8_t *)&reply, sizeof(reply));
 }
@@ -255,8 +284,8 @@ static void send_file_xfer_status(struct vdagent_virtio_port *vport,
                                   const char *msg, uint32_t id, uint32_t xfer_status)
 {
     VDAgentFileXferStatusMessage status = {
-        .id = id,
-        .result = xfer_status,
+        .id = htole32(id),
+        .result = htole32(xfer_status),
     };
     syslog(LOG_WARNING, msg, id);
     if (vport)
@@ -333,6 +362,7 @@ static int virtio_port_read_complete(
     case VD_AGENT_MOUSE_STATE:
         if (message_header->size != sizeof(VDAgentMouseState))
             goto size_error;
+        virtio_msg_le32toh(data, message_header->size, 0);
         vdagentd_uinput_do_mouse(&uinput, (VDAgentMouseState *)data);
         if (!uinput) {
             /* Try to re-open the tablet */
@@ -356,12 +386,14 @@ static int virtio_port_read_complete(
     case VD_AGENT_MONITORS_CONFIG:
         if (message_header->size < sizeof(VDAgentMonitorsConfig))
             goto size_error;
+        virtio_msg_le32toh(data, message_header->size, 0);
         do_client_monitors(vport, port_nr, message_header,
                     (VDAgentMonitorsConfig *)data);
         break;
     case VD_AGENT_ANNOUNCE_CAPABILITIES:
         if (message_header->size < sizeof(VDAgentAnnounceCapabilities))
             goto size_error;
+        virtio_msg_le32toh(data, message_header->size, 0);
         do_client_capabilities(vport, message_header,
                         (VDAgentAnnounceCapabilities *)data);
         break;
@@ -369,26 +401,50 @@ static int virtio_port_read_complete(
     case VD_AGENT_CLIPBOARD_REQUEST:
     case VD_AGENT_CLIPBOARD:
     case VD_AGENT_CLIPBOARD_RELEASE:
+        if (VD_AGENT_HAS_CAPABILITY(capabilities, capabilities_size,
+                                    VD_AGENT_CAP_CLIPBOARD_SELECTION))
+            min_size += 4;
+        uint32_t *data_type = (uint32_t *)(data + min_size);
         switch (message_header->type) {
         case VD_AGENT_CLIPBOARD_GRAB:
-            min_size = sizeof(VDAgentClipboardGrab); break;
+            virtio_msg_le32toh(data, message_header->size, min_size);
+            min_size += sizeof(VDAgentClipboardGrab);
+            break;
         case VD_AGENT_CLIPBOARD_REQUEST:
-            min_size = sizeof(VDAgentClipboardRequest); break;
+            min_size += sizeof(VDAgentClipboardRequest); break;
         case VD_AGENT_CLIPBOARD:
-            min_size = sizeof(VDAgentClipboard); break;
-        }
-        if (VD_AGENT_HAS_CAPABILITY(capabilities, capabilities_size,
-                                    VD_AGENT_CAP_CLIPBOARD_SELECTION)) {
-            min_size += 4;
+            min_size += sizeof(VDAgentClipboard); break;
         }
         if (message_header->size < min_size) {
             goto size_error;
         }
+        switch (message_header->type) {
+        case VD_AGENT_CLIPBOARD_REQUEST:
+        case VD_AGENT_CLIPBOARD:
+            *data_type = le32toh(*data_type); break;
+        }
         do_client_clipboard(vport, message_header, data);
         break;
     case VD_AGENT_FILE_XFER_START:
     case VD_AGENT_FILE_XFER_STATUS:
     case VD_AGENT_FILE_XFER_DATA:
+        if (message_header->size < sizeof(VDAgentFileXferStartMessage))
+            goto size_error;
+        uint32_t *id = (uint32_t *)data;
+        *id = le32toh(*id);
+        id++; /* size/status */
+        switch (message_header->type) {
+        case VD_AGENT_FILE_XFER_DATA:
+           if (message_header->size < sizeof(VDAgentFileXferDataMessage))
+               goto size_error;
+           *((uint64_t *)id) = le64toh(*((uint64_t *)id)); /* size */
+           break;
+        case VD_AGENT_FILE_XFER_STATUS:
+           if (message_header->size < sizeof(VDAgentFileXferStatusMessage))
+               goto size_error;
+           *id = le32toh(*id); /* status */
+           break;
+        }
         do_client_file_xfer(vport, message_header, data);
         break;
     case VD_AGENT_CLIENT_DISCONNECTED:
@@ -399,15 +455,17 @@ static int virtio_port_read_complete(
         if (message_header->size != sizeof(VDAgentMaxClipboard))
             goto size_error;
         VDAgentMaxClipboard *msg = (VDAgentMaxClipboard *)data;
-        syslog(LOG_DEBUG, "Set max clipboard: %d", msg->max);
-        max_clipboard = msg->max;
+        syslog(LOG_DEBUG, "Set max clipboard: %d", le32toh(msg->max));
+        max_clipboard = le32toh(msg->max);
         break;
     case VD_AGENT_AUDIO_VOLUME_SYNC:
         if (message_header->size < sizeof(VDAgentAudioVolumeSync))
             goto size_error;
+        VDAgentAudioVolumeSync *vdata = (VDAgentAudioVolumeSync *)data;
+        virtio_msg_le16toh((uint8_t *)vdata, message_header->size,
+            offsetof(VDAgentAudioVolumeSync, volume));
 
-        do_client_volume_sync(vport, port_nr, message_header,
-                (VDAgentAudioVolumeSync *)data);
+        do_client_volume_sync(vport, port_nr, message_header, vdata);
         break;
     default:
         syslog(LOG_WARNING, "unknown message type %d, ignoring",
@@ -423,7 +481,7 @@ size_error:
 }
 
 static void virtio_write_clipboard(uint8_t selection, uint32_t msg_type,
-    uint32_t data_type, const uint8_t *data, uint32_t data_size)
+    uint32_t data_type, uint8_t *data, uint32_t data_size)
 {
     uint32_t size = data_size;
 
@@ -444,15 +502,18 @@ static void virtio_write_clipboard(uint8_t selection, uint32_t msg_type,
         vdagent_virtio_port_write_append(virtio_port, sel, 4);
     }
     if (data_type != -1) {
+        data_type = htole32(data_type);
         vdagent_virtio_port_write_append(virtio_port, (uint8_t*)&data_type, 4);
     }
 
+    if (msg_type == VD_AGENT_CLIPBOARD_GRAB)
+        virtio_msg_htole32(data, data_size, 0);
     vdagent_virtio_port_write_append(virtio_port, data, data_size);
 }
 
 /* vdagentd <-> vdagent communication handling */
 static int do_agent_clipboard(struct udscs_connection *conn,
-        struct udscs_message_header *header, const uint8_t *data)
+        struct udscs_message_header *header, uint8_t *data)
 {
     uint8_t selection = header->arg1;
     uint32_t msg_type = 0, data_type = -1, size = header->size;
@@ -763,8 +824,8 @@ static void agent_read_complete(struct udscs_connection **connp,
         break;
     case VDAGENTD_FILE_XFER_STATUS:{
         VDAgentFileXferStatusMessage status;
-        status.id = header->arg1;
-        status.result = header->arg2;
+        status.id = htole32(header->arg1);
+        status.result = htole32(header->arg2);
         vdagent_virtio_port_write(virtio_port, VDP_CLIENT_PORT,
                                   VD_AGENT_FILE_XFER_STATUS, 0,
                                   (uint8_t *)&status, sizeof(status));
diff --git a/src/vdagentd/virtio-port.c b/src/vdagentd/virtio-port.c
index cedda4d..ac4d805 100644
--- a/src/vdagentd/virtio-port.c
+++ b/src/vdagentd/virtio-port.c
@@ -216,16 +216,16 @@ int vdagent_virtio_port_write_start(
         return -1;
     }
 
-    chunk_header.port = port_nr;
-    chunk_header.size = sizeof(message_header) + data_size;
+    chunk_header.port = htole32(port_nr);
+    chunk_header.size = htole32(sizeof(message_header) + data_size);
     memcpy(new_wbuf->buf + new_wbuf->write_pos, &chunk_header,
            sizeof(chunk_header));
     new_wbuf->write_pos += sizeof(chunk_header);
 
-    message_header.protocol = VD_AGENT_PROTOCOL;
-    message_header.type = message_type;
-    message_header.opaque = message_opaque;
-    message_header.size = data_size;
+    message_header.protocol = htole32(VD_AGENT_PROTOCOL);
+    message_header.type = htole32(message_type);
+    message_header.opaque = htole64(message_opaque);
+    message_header.size = htole32(data_size);
     memcpy(new_wbuf->buf + new_wbuf->write_pos, &message_header,
            sizeof(message_header));
     new_wbuf->write_pos += sizeof(message_header);
@@ -309,13 +309,20 @@ static void vdagent_virtio_port_do_chunk(struct vdagent_virtio_port **vportp)
         memcpy((uint8_t *)&port->message_header + port->message_header_read,
                vport->chunk_data, read);
         port->message_header_read += read;
-        if (port->message_header_read == sizeof(port->message_header) &&
-                port->message_header.size) {
-            port->message_data = malloc(port->message_header.size);
-            if (!port->message_data) {
-                syslog(LOG_ERR, "out of memory, disconnecting virtio");
-                vdagent_virtio_port_destroy(vportp);
-                return;
+        if (port->message_header_read == sizeof(port->message_header)) {
+
+            port->message_header.protocol = le32toh(port->message_header.protocol);
+            port->message_header.type = le32toh(port->message_header.type);
+            port->message_header.opaque = le64toh(port->message_header.opaque);
+            port->message_header.size = le32toh(port->message_header.size);
+
+            if (port->message_header.size) {
+                port->message_data = malloc(port->message_header.size);
+                if (!port->message_data) {
+                    syslog(LOG_ERR, "out of memory, disconnecting virtio");
+                    vdagent_virtio_port_destroy(vportp);
+                    return;
+                }
             }
         }
         pos = read;
@@ -420,6 +427,8 @@ static void vdagent_virtio_port_do_read(struct vdagent_virtio_port **vportp)
     if (vport->chunk_header_read < sizeof(vport->chunk_header)) {
         vport->chunk_header_read += n;
         if (vport->chunk_header_read == sizeof(vport->chunk_header)) {
+            vport->chunk_header.size = le32toh(vport->chunk_header.size);
+            vport->chunk_header.port = le32toh(vport->chunk_header.port);
             if (vport->chunk_header.size > VD_AGENT_MAX_DATA_SIZE) {
                 syslog(LOG_ERR, "chunk size %u too large",
                        vport->chunk_header.size);
-- 
2.10.2
