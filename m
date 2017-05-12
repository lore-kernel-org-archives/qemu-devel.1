Received: from eggs.gnu.org ([2001:4830:134:3::10]:39612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97hB-00051o-3T
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97h7-00064Z-Ug
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39443 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1d97h7-0005z8-NZ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:09 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri, 12 May 2017 12:20:55 +0200
Message-Id: <20170512102057.5855-3-hare@suse.de>
In-Reply-To: <20170512102057.5855-1-hare@suse.de>
References: <20170512102057.5855-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 2/4] scsi: use host default timeouts for SCSI
 commands
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

Instead of disabling command aborts by setting the command timeout
to infinity we should be setting it to '0' per default, allowing
the host to fall back to its default values.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-disk.c    | 3 +--
 hw/scsi/scsi-generic.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index dd01ff7e06..4ac4c872fe 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2898,8 +2898,7 @@ static Property scsi_hd_properties[] = {
                        DEFAULT_MAX_UNMAP_SIZE),
     DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
                        DEFAULT_MAX_IO_SIZE),
-    DEFINE_PROP_UINT32("timeout", SCSIDevice, timeout,
-                       MAX_UINT),
+    DEFINE_PROP_UINT32("timeout", SCSIDevice, timeout, 0),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index fd02a0f4b2..998b6a4558 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -601,7 +601,7 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
 
 static Property scsi_generic_properties[] = {
     DEFINE_PROP_DRIVE("drive", SCSIDevice, conf.blk),
-    DEFINE_PROP_UINT32("timeout", SCSIDevice, timeout, MAX_UINT),
+    DEFINE_PROP_UINT32("timeout", SCSIDevice, timeout, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.12.0
