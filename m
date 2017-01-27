Received: from eggs.gnu.org ([2001:4830:134:3::10]:33487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qv-000518-FT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qu-0003ym-BS
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:09 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qu-0003y0-5n
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:08 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so58623057wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:23 +0100
Message-Id: <1485524749-118532-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/41] hw/scsi: Fix debug message of cdb
 structure in scsi-generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.vnet.ibm.com>

From: Eric Farman <farman@linux.vnet.ibm.com>

When running with debug enabled, the scsi-generic cdb that is
dumped skips byte 0 of the command, which is the opcode.  This
makes identifying which command is being issued/completed a
little difficult.  Example:

  0x00 0x00 0x01 0x00 0x00
  scsi-generic: scsi_read_data 0x0
  scsi-generic: Data ready tag=0x0 len=164
  scsi-generic: scsi_read_data 0x0
  scsi-generic: Command complete 0x0x10a42c60 tag=0x0 status=0

Improve this by adding a message prior to the loop, similar to
what exists for scsi-disk.  Clean up a few other messages to be
more explicit of what is being represented.  Example:

  scsi-generic: Command: data=0x12 0x00 0x00 0x01 0x00 0x00
  scsi-generic: scsi_read_data tag=0x0
  scsi-generic: Data ready tag=0x0 len=164
  scsi-generic: scsi_read_data tag=0x0
  scsi-generic: Command complete 0x0x10a452d0 tag=0x0 status=0

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Message-Id: <20170120162527.66075-2-farman@linux.vnet.ibm.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7a588a7..92f091a 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -246,7 +246,7 @@ static void scsi_read_data(SCSIRequest *req)
     SCSIDevice *s = r->req.dev;
     int ret;
 
-    DPRINTF("scsi_read_data 0x%x\n", req->tag);
+    DPRINTF("scsi_read_data tag=0x%x\n", req->tag);
 
     /* The request is used as the AIO opaque value, so add a ref.  */
     scsi_req_ref(&r->req);
@@ -294,7 +294,7 @@ static void scsi_write_data(SCSIRequest *req)
     SCSIDevice *s = r->req.dev;
     int ret;
 
-    DPRINTF("scsi_write_data 0x%x\n", req->tag);
+    DPRINTF("scsi_write_data tag=0x%x\n", req->tag);
     if (r->len == 0) {
         r->len = r->buflen;
         scsi_req_data(&r->req, r->len);
@@ -329,6 +329,7 @@ static int32_t scsi_send_command(SCSIRequest *req, uint8_t *cmd)
     int ret;
 
 #ifdef DEBUG_SCSI
+    DPRINTF("Command: data=0x%02x", cmd[0]);
     {
         int i;
         for (i = 1; i < r->req.cmd.len; i++) {
-- 
1.8.3.1
