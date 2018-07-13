Received: from eggs.gnu.org ([2001:4830:134:3::10]:41221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpa-00046A-Vx
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpY-0003UW-VS
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpY-0003Sn-OH
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A9588185343
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:03 +0200
Message-Id: <20180713130916.4153-17-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 16/29] vhost-user: add
 vhost_user_gpu_set_socket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new vhost-user message to give a unix socket to a vhost-user
backend for GPU display updates.

Back when I started that work, I added a new GPU channel because the
vhost-user protocol wasn't bidirectional. Since then, there is a
vhost-user-slave channel for the slave to send requests to the master.
We could extend it with GPU messages. However, the GPU protocol is
quite orthogonal to vhost-user, thus I chose to have a new dedicated
channel.

See vhost-user-gpu.rst for the protocol details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |   1 +
 include/hw/virtio/vhost-backend.h     |   1 +
 hw/virtio/vhost-user.c                |  11 ++
 MAINTAINERS                           |   6 +
 docs/interop/vhost-user-gpu.rst       | 236 ++++++++++++++++++++++++++
 docs/interop/vhost-user.txt           |   9 +
 6 files changed, 264 insertions(+)
 create mode 100644 docs/interop/vhost-user-gpu.rst

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index a4afbc3a46..42e227cce6 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -92,6 +92,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG =3D 31,
+    VHOST_USER_GPU_SET_SOCKET   =3D 32,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
index 1fca321d8a..daf9180c33 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -163,5 +163,6 @@ int vhost_backend_handle_iotlb_msg(struct vhost_dev *=
dev,
=20
 int vhost_user_input_get_config(struct vhost_dev *dev,
                                 struct virtio_input_config **config);
+int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
=20
 #endif /* VHOST_BACKEND_H */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 0c6914fab7..8c1a1742b0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -90,6 +90,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG =3D 31,
+    VHOST_USER_GPU_SET_SOCKET   =3D 32,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -397,6 +398,16 @@ err:
     return -1;
 }
=20
+int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd)
+{
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_GPU_SET_SOCKET,
+        .hdr.flags =3D VHOST_USER_VERSION,
+    };
+
+    return vhost_user_write(dev, &msg, &fd, 1);
+}
+
 static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
                                    struct vhost_log *log)
 {
diff --git a/MAINTAINERS b/MAINTAINERS
index 50ace65b3b..5a83bf56a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1371,6 +1371,12 @@ F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.c
 F: include/hw/virtio/virtio-gpu.h
=20
+vhost-user-gpu
+M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+M: Gerd Hoffmann <kraxel@redhat.com>
+S: Maintained
+F: docs/interop/vhost-user-gpu.rst
+
 Cirrus VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
diff --git a/docs/interop/vhost-user-gpu.rst b/docs/interop/vhost-user-gp=
u.rst
new file mode 100644
index 0000000000..309d07fd6d
--- /dev/null
+++ b/docs/interop/vhost-user-gpu.rst
@@ -0,0 +1,236 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Vhost-user-gpu Protocol
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This work is licensed under the terms of the GNU GPL, version 2 or later=
.
+See the COPYING file in the top-level directory.
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The vhost-user-gpu protocol is aiming at sharing the rendering result
+of a virtio-gpu, done from a vhost-user slave process to a vhost-user
+master process (such as QEMU). It bears a resemblance to a display
+server protocol, if you consider QEMU as the display server and the
+slave as the client, but in a very limited way. Typically, it will
+work by setting a scanout/display configuration, before sending flush
+events for the display updates. It will also update the cursor shape
+and position.
+
+The protocol is sent over a UNIX domain stream socket, since it uses
+socket ancillary data to share opened file descriptors (DMABUF fds or
+shared memory).
+
+Requests are sent by the slave, and the optional replies by the master.
+
+Wire format
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Unless specified differently, numbers are in the machine native byte
+order.
+
+A vhost-user-gpu request consists of 2 header fields and a payload:
+
+::
+
+  ------------------------------------
+  | u32:request | u32:size | payload |
+  ------------------------------------
+
+- request: 32-bit type of the request
+- size: 32-bit size of the payload
+
+A reply consists only of a payload, whose content depends on on the requ=
est.
+
+
+Payload types
+-------------
+
+VhostUserGpuCursorPos
+^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+   ----------------------------------
+   | u32:scanout-id | u32:x | u32:y |
+   ----------------------------------
+
+- scanout-id: the scanout where the cursor is located
+- x/y: the cursor postion
+
+VhostUserGpuCursorUpdate
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+   ---------------------------------------------------------------------=
--------
+   | VhostUserGpuCursorPos:pos | u32:hot_x | u32:hot_y | [u32; 64 * 64] =
cursor |
+   ---------------------------------------------------------------------=
--------
+
+- pos: the cursor location
+- hot_x/hot_y: the cursor hot location
+- cursor: RGBA cursor data
+
+VhostUserGpuScanout
+^^^^^^^^^^^^^^^^^^^
+
+::
+
+   ----------------------------------
+   | u32:scanout-id | u32:w | u32:h |
+   ----------------------------------
+
+- scanout-id: the scanout configuration to set
+- w/h: the scanout width/height size
+
+
+VhostUserGpuUpdate
+^^^^^^^^^^^^^^^^^^
+
+::
+
+   ---------------------------------------------------------
+   | u32:scanout-id | u32:x | u32:y | u32:w | u32:h | data |
+   ---------------------------------------------------------
+
+- scanout-id: the scanout content to update
+- x/y/w/h: region of the update
+- data: RGBA data (size is computed based on the region size, and reques=
t type)
+
+VhostUserGpuDMABUFScanout
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+   ---------------------------------------------------
+   | u32:scanout-id | u32:x | u32:y | u32:w | u32:h | ...
+   ----------------------------------------------------------
+    u32:fdw | u32:fwh | u32:stride | u32:flags | i32:fourcc |
+   ----------------------------------------------------------
+
+- scanout-id: the scanout configuration to set
+- x/y: the location of the scanout within the DMABUF
+- w/h: the scanout width/height size
+- fdw/fdh/stride/flags/fourcc: the DMABUF width/height/stride/flags/drm-=
fourcc
+
+
+In QEMU the vhost-user-gpu message is implemented with the following str=
uct:
+
+::
+
+  typedef struct VhostUserGpuMsg {
+      uint32_t request; /* VhostUserGpuRequest */
+      uint32_t size; /* the following payload size */
+      union {
+          VhostUserGpuCursorPos cursor_pos;
+          VhostUserGpuCursorUpdate cursor_update;
+          VhostUserGpuScanout scanout;
+          VhostUserGpuUpdate update;
+          VhostUserGpuDMABUFScanout dmabuf_scanout;
+          uint64_t u64;
+      } payload;
+  } QEMU_PACKED VhostUserGpuMsg;
+
+Protocol features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+None yet.
+
+As the protocol may need to evolve, new messages and communication
+changes are negotiated thanks to preliminary
+VHOST_USER_GPU_GET_PROTOCOL_FEATURES and
+VHOST_USER_GPU_SET_PROTOCOL_FEATURES requests.
+
+Message types
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- VHOST_USER_GPU_GET_PROTOCOL_FEATURES
+
+  Id:1
+  Request payload: N/A
+  Reply payload: uint64_t
+
+  Get the supported protocol features bitmask.
+
+- VHOST_USER_GPU_SET_PROTOCOL_FEATURES
+
+  Id:2
+  Request payload: uint64_t
+  Reply payload: N/A
+
+  Enable protocol features using a bitmask.
+
+- VHOST_USER_GPU_GET_DISPLAY_INFO
+
+  Id:3
+  Request payload: N/A
+  Reply payload: struct virtio_gpu_resp_display_info (numbers in LE,
+                 according to the virtio protocol)
+
+  Get the preferred display configuration.
+
+- VHOST_USER_GPU_CURSOR_POS
+
+  Id: 4
+  Request payload: struct VhostUserGpuCursorPos
+  Reply payload: N/A
+
+  Set/show the cursor position.
+
+- VHOST_USER_GPU_CURSOR_POS_HIDE
+
+  Id:5
+  Request payload: struct VhostUserGpuCursorPos
+  Reply payload: N/A
+
+  Set/hide the cursor.
+
+- VHOST_USER_GPU_CURSOR_UPDATE
+
+  Id:6
+  Request payload: struct VhostUserGpuCursorUpdate
+  Reply payload: N/A
+
+  Update the cursor shape and location.
+
+- VHOST_USER_GPU_SCANOUT
+
+  Id:7
+  Request payload: struct VhostUserGpuScanout
+  Reply payload: N/A
+
+  Set the scanout resolution. To disable a scanout, the dimensions
+  width/height are set to 0.
+
+- VHOST_USER_GPU_UPDATE
+
+  Id:8
+  Request payload: struct VhostUserGpuUpdate
+  Reply payload: N/A
+
+  Update the scanout content. The data payload contains the graphical bi=
ts.
+  The display should be flushed and presented.
+
+- VHOST_USER_GPU_DMABUF_SCANOUT
+
+  Id:9
+  Request payload: struct VhostUserGpuDMABUFScanout
+  Reply payload: N/A
+
+  Set the scanout resolution/configuration, and share a DMABUF file
+  descriptor for the scanout content, which is passed as ancillary
+  data. To disable a scanout, the dimensions width/height are set
+  to 0, there is no file descriptor passed.
+
+- VHOST_USER_GPU_DMABUF_UPDATE
+
+  Id:10
+  Request payload: struct VhostUserGpuUpdate
+  Reply payload: u32
+
+  The display should be flushed and presented according to updated
+  region from VhostUserGpuUpdate.
+
+  Note: there is no data payload, since the scanout is shared thanks
+  to DMABUF, that must have been set previously with
+  VHOST_USER_GPU_DMABUF_SCANOUT.
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index cba1ddde16..c4c063a8c0 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -768,6 +768,15 @@ Master message types
=20
       Ask vhost user input backend the list of virtio_input_config.
=20
+ * VHOST_USER_GPU_SET_SOCKET
+      Id: 32
+      Master payload: N/A
+      Slave payload: N/A
+
+      Sets the GPU protocol socket file descriptor, which is passed as
+      ancillary data. The GPU protocol is used to inform the master of
+      rendering state and updates. See vhost-user-gpu.rst for details.
+
 Slave message types
 -------------------
=20
--=20
2.18.0.129.ge3331758f1
