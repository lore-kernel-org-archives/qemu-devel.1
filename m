Received: from eggs.gnu.org ([2001:4830:134:3::10]:40532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUc0T-0005Dh-I6
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUc0P-0000Z6-HM
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:25:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cUc0P-0000YF-6M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:25:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0KGOYgV061245
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:25:36 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2833bghbxw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:25:35 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 20 Jan 2017 16:25:32 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri, 20 Jan 2017 17:25:25 +0100
In-Reply-To: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
Message-Id: <20170120162527.66075-2-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/3] hw/scsi: Fix debug message of cdb
 structure in scsi-generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Farman <farman@linux.vnet.ibm.com>, pbonzini@redhat.com

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
2.8.4
