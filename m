Received: from eggs.gnu.org ([2001:4830:134:3::10]:48233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fRNfx-0008WQ-BC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fRNfv-0007Ln-GZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:57 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:46098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fRNfv-0007LY-Aa
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:55 -0400
Received: by mail-qk0-x242.google.com with SMTP id k86-v6so9507439qkh.13
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 13:07:55 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Fri,  8 Jun 2018 17:07:38 -0300
Message-Id: <20180608200740.24915-2-danielhb413@gmail.com>
In-Reply-To: <20180608200740.24915-1-danielhb413@gmail.com>
References: <20180608200740.24915-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/3] scsi-block: emulate missing Block
 Limits response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

The VPD Block Limits Inquiry page is optional, allowing SCSI devices
to not implement it. This is the case for devices like the MegaRAID
SAS 9361-8i and Microsemi PM8069.

In case of SCSI passthrough, the response of this request is used by
the QEMU SCSI layer to set the max_io_sectors that the guest
device will support, based on the value of the max_sectors_kb that
the device has set in the host at that time. Without this response,
the guest kernel is free to assume any value of max_io_sectors
for the SCSI device. If this value is greater than the value from
the host, SCSI Sense errors will occur because the guest will send
read/write requests that are larger than the underlying host device
is configured to support. An example of this behavior can be seen
in [1].

A workaround is to set the max_sectors_kb host value back in the guest
kernel (a process that can be automated using rc.local startup scripts
and the like), but this has several drawbacks:

- it can be troublesome if the guest has many passthrough devices that
needs this tuning;

- if a change in max_sectors_kb is made in the host side, manual change
in the guests will also be required;

- during an OS install it is difficult, and sometimes not possible, to go
to a terminal and change the max_sectors_kb prior to the installation.
This means that the disk can't be used during the install process. The
easiest alternative here is to roll back to scsi-hd, install the guest
and then go back to SCSI passthrough when the installation is done and
max_sectors_kb can be set.

An easier way would be to QEMU handle the absence of the VPD Block Limits
device response, setting max_io_sectors accordingly and allowing the guest
to use the device without the hassle.

This patch is the first step to tackle this. Inside scsi_read_complete,
snoop into the io_header and see if there is a SENSE error from a VPD
Block Limits request. If that's the case, return an emulated response
based on what we already do in scsi-disk. Clean up the io_header
fields what would trigger a SCSI sense error later on now that
we have a valid response to give.

Note that this patch alone does not fix [1] - the guest is still unaware
of the VPD Block Limits page support if the hardware does not implement
it. This will be taken care of in the next patch. For now, we can see the
emulated Block Limits response by using sg3_utils:

[root@boston-ess054p2 ~]# sg_vpd --page=bl  /dev/sdb --verbose
    inquiry cdb: 12 01 b0 00 fc 00
Block limits VPD page (SBC):
   [PQual=0  Peripheral device type: disk]
  Write same no zero (WSNZ): 1
  Maximum compare and write length: 0 blocks
  Optimal transfer length granularity: 0 blocks
  Maximum transfer length: 512 blocks
  Optimal transfer length: 0 blocks
  Maximum prefetch length: 0 blocks
  Maximum unmap LBA count: 2097152
  Maximum unmap block descriptor count: 255
  Optimal unmap granularity: 0
  Unmap granularity alignment valid: 0
  Unmap granularity alignment: 0
  Maximum write same length: 0x200 blocks
[root@boston-ess054p2 ~]#

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1566195

Reported-by: Dac Nguyen <dacng@us.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/scsi/scsi-disk.c    |   2 -
 hw/scsi/scsi-generic.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++---
 include/hw/scsi/scsi.h |   3 ++
 3 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ded23d36ca..4461a592e5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -50,8 +50,6 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #define SCSI_MAX_MODE_LEN           256
 
 #define DEFAULT_DISCARD_GRANULARITY 4096
-#define DEFAULT_MAX_UNMAP_SIZE      (1 << 30)   /* 1 GB */
-#define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
 
 #define TYPE_SCSI_DISK_BASE         "scsi-disk-base"
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 03bce8ff39..579872908c 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -76,6 +76,103 @@ static void scsi_free_request(SCSIRequest *req)
     g_free(r->buf);
 }
 
+/*
+ * Takes a buffer and fill it with contents of a SCSI Inquiry VPD
+ * Block Limits response, based on the attributes of the SCSIDevice
+ * and other default values, returning the size written in the
+ * buffer.
+ *
+ * This function is a modified version of 'scsi_disk_emulate_inquiry'
+ * from scsi-disk.c.
+ */
+static int scsi_emulate_vpd_bl_page(SCSIDevice *s, uint8_t *outbuf)
+{
+    int buflen = 0;
+    int start;
+
+    outbuf[buflen++] = TYPE_DISK & 0x1f;
+    outbuf[buflen++] = 0xb0;
+    outbuf[buflen++] = 0x00;
+    outbuf[buflen++] = 0x00;
+    start = buflen;
+
+    unsigned int unmap_sectors = s->conf.discard_granularity / s->blocksize;
+    unsigned int min_io_size = s->conf.min_io_size / s->blocksize;
+    unsigned int opt_io_size = s->conf.opt_io_size / s->blocksize;
+    unsigned int max_unmap_sectors = DEFAULT_MAX_UNMAP_SIZE / s->blocksize;
+    unsigned int max_io_sectors =  DEFAULT_MAX_IO_SIZE / s->blocksize;
+
+    int max_transfer_blk = blk_get_max_transfer(s->conf.blk);
+    int max_io_sectors_blk = max_transfer_blk / s->blocksize;
+
+    max_io_sectors =  MIN_NON_ZERO(max_io_sectors_blk, max_io_sectors);
+
+    /* min_io_size and opt_io_size can't be greater than max_io_sectors */
+    if (min_io_size) {
+        min_io_size = MIN(min_io_size, max_io_sectors);
+    }
+    if (opt_io_size) {
+        opt_io_size = MIN(opt_io_size, max_io_sectors);
+    }
+
+    /* required VPD size with unmap support */
+    buflen = 0x40;
+    memset(outbuf + 4, 0, buflen - 4);
+
+    outbuf[4] = 0x1; /* wsnz */
+
+    /* optimal transfer length granularity */
+    outbuf[6] = (min_io_size >> 8) & 0xff;
+    outbuf[7] = min_io_size & 0xff;
+
+    /* maximum transfer length */
+    outbuf[8] = (max_io_sectors >> 24) & 0xff;
+    outbuf[9] = (max_io_sectors >> 16) & 0xff;
+    outbuf[10] = (max_io_sectors >> 8) & 0xff;
+    outbuf[11] = max_io_sectors & 0xff;
+
+    /* optimal transfer length */
+    outbuf[12] = (opt_io_size >> 24) & 0xff;
+    outbuf[13] = (opt_io_size >> 16) & 0xff;
+    outbuf[14] = (opt_io_size >> 8) & 0xff;
+    outbuf[15] = opt_io_size & 0xff;
+
+    /* max unmap LBA count, default is 1GB */
+    outbuf[20] = (max_unmap_sectors >> 24) & 0xff;
+    outbuf[21] = (max_unmap_sectors >> 16) & 0xff;
+    outbuf[22] = (max_unmap_sectors >> 8) & 0xff;
+    outbuf[23] = max_unmap_sectors & 0xff;
+
+    /* max unmap descriptors, 255 fit in 4 kb with an 8-byte header.  */
+    outbuf[24] = 0;
+    outbuf[25] = 0;
+    outbuf[26] = 0;
+    outbuf[27] = 255;
+
+    /* optimal unmap granularity */
+    outbuf[28] = (unmap_sectors >> 24) & 0xff;
+    outbuf[29] = (unmap_sectors >> 16) & 0xff;
+    outbuf[30] = (unmap_sectors >> 8) & 0xff;
+    outbuf[31] = unmap_sectors & 0xff;
+
+    /* max write same size */
+    outbuf[36] = 0;
+    outbuf[37] = 0;
+    outbuf[38] = 0;
+    outbuf[39] = 0;
+
+    outbuf[40] = (max_io_sectors >> 24) & 0xff;
+    outbuf[41] = (max_io_sectors >> 16) & 0xff;
+    outbuf[42] = (max_io_sectors >> 8) & 0xff;
+    outbuf[43] = max_io_sectors & 0xff;
+
+    /* done with EVPD */
+    assert(buflen - start <= 255);
+    outbuf[start - 1] = buflen - start;
+
+    return buflen;
+}
+
 /* Helper function for command completion.  */
 static void scsi_command_complete_noio(SCSIGenericReq *r, int ret)
 {
@@ -146,6 +243,7 @@ static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
     SCSIDevice *s = r->req.dev;
+    SCSISense sense;
     int len;
 
     assert(r->req.aiocb != NULL);
@@ -218,14 +316,33 @@ static void scsi_read_complete(void * opaque, int ret)
             }
         }
         if (s->type == TYPE_DISK && r->req.cmd.buf[2] == 0xb0) {
-            uint32_t max_transfer =
-                blk_get_max_transfer(s->conf.blk) / s->blocksize;
-
-            assert(max_transfer);
-            stl_be_p(&r->buf[8], max_transfer);
-            /* Also take care of the opt xfer len. */
-            stl_be_p(&r->buf[12],
-                     MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+            /*
+             * Take a look to see if this VPD Block Limits request will
+             * result in a sense error in scsi_command_complete_noio.
+             * In this case, emulate a valid VPD response.
+             *
+             * After that, given that now there are valid contents in the
+             * buffer, clean up the io_header to avoid firing up the
+             * sense error.
+             */
+            if (sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
+                r->buflen = scsi_emulate_vpd_bl_page(s, r->buf);
+                r->io_header.sb_len_wr = 0;
+
+                /* Clean sg_io_sense */
+                r->io_header.driver_status = 0;
+                r->io_header.status = 0;
+
+            }  else {
+                uint32_t max_transfer =
+                    blk_get_max_transfer(s->conf.blk) / s->blocksize;
+
+                assert(max_transfer);
+                stl_be_p(&r->buf[8], max_transfer);
+                /* Also take care of the opt xfer len. */
+                stl_be_p(&r->buf[12],
+                         MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+            }
         }
     }
     scsi_req_data(&r->req, len);
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index e35137ea78..4fdde102b8 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -18,6 +18,9 @@ typedef struct SCSIReqOps SCSIReqOps;
 #define SCSI_SENSE_BUF_SIZE_OLD 96
 #define SCSI_SENSE_BUF_SIZE 252
 
+#define DEFAULT_MAX_UNMAP_SIZE      (1 << 30)   /* 1 GB */
+#define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
+
 struct SCSIRequest {
     SCSIBus           *bus;
     SCSIDevice        *dev;
-- 
2.14.3
