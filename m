Received: from eggs.gnu.org ([2001:4830:134:3::10]:39609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97hB-00051m-2c
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97h7-00064X-UP
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39442 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1d97h7-0005z6-NY
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:09 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri, 12 May 2017 12:20:54 +0200
Message-Id: <20170512102057.5855-2-hare@suse.de>
In-Reply-To: <20170512102057.5855-1-hare@suse.de>
References: <20170512102057.5855-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 1/4] scsi: make default command timeout
 user-settable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.com>, qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

Per default any SCSI commands are sent with an infinite timeout,
which essentially disables any command abort mechanism on the
host and causes the guest to stall.
This patch adds a new option 'timeout' for scsi-generic and
scsi-disk which allows the user to set the timeout value to
something sensible.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-disk.c    | 4 +++-
 hw/scsi/scsi-generic.c | 5 ++++-
 include/hw/scsi/scsi.h | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a53f058621..dd01ff7e06 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2679,7 +2679,7 @@ static BlockAIOCB *scsi_block_do_sgio(SCSIBlockReq *req,
     /* The rest is as in scsi-generic.c.  */
     io_header->mx_sb_len = sizeof(r->req.sense);
     io_header->sbp = r->req.sense;
-    io_header->timeout = UINT_MAX;
+    io_header->timeout = s->qdev.timeout;
     io_header->usr_ptr = r;
     io_header->flags |= SG_FLAG_DIRECT_IO;
 
@@ -2898,6 +2898,8 @@ static Property scsi_hd_properties[] = {
                        DEFAULT_MAX_UNMAP_SIZE),
     DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
                        DEFAULT_MAX_IO_SIZE),
+    DEFINE_PROP_UINT32("timeout", SCSIDevice, timeout,
+                       MAX_UINT),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index a55ff87c22..fd02a0f4b2 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -157,6 +157,8 @@ static int execute_command(BlockBackend *blk,
                            SCSIGenericReq *r, int direction,
                            BlockCompletionFunc *complete)
 {
+    SCSIDevice *s = r->req.dev;
+
     r->io_header.interface_id = 'S';
     r->io_header.dxfer_direction = direction;
     r->io_header.dxferp = r->buf;
@@ -165,7 +167,7 @@ static int execute_command(BlockBackend *blk,
     r->io_header.cmd_len = r->req.cmd.len;
     r->io_header.mx_sb_len = sizeof(r->req.sense);
     r->io_header.sbp = r->req.sense;
-    r->io_header.timeout = MAX_UINT;
+    r->io_header.timeout = s->timeout;
     r->io_header.usr_ptr = r;
     r->io_header.flags |= SG_FLAG_DIRECT_IO;
 
@@ -599,6 +601,7 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
 
 static Property scsi_generic_properties[] = {
     DEFINE_PROP_DRIVE("drive", SCSIDevice, conf.blk),
+    DEFINE_PROP_UINT32("timeout", SCSIDevice, timeout, MAX_UINT),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 6b85786dbf..a976e85cfa 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -110,6 +110,7 @@ struct SCSIDevice
     uint64_t max_lba;
     uint64_t wwn;
     uint64_t port_wwn;
+    uint32_t timeout;
 };
 
 extern const VMStateDescription vmstate_scsi_device;
-- 
2.12.0
