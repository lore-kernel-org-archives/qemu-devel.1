Received: from eggs.gnu.org ([2001:4830:134:3::10]:52597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp1t-0008Nd-R8
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp1s-0001kf-Sk
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp1s-0001kJ-KD
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:02:24 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:02:10 +0200
Message-Id: <20170602160210.1868-3-lersek@redhat.com>
In-Reply-To: <20170602160210.1868-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160210.1868-1-lersek@redhat.com>
Subject: [Qemu-devel] [seabios PATCH 2/2] romfile_loader: alloc: cope with
 the UEFI-oriented 64BIT zone hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS@seabios.org, qemu-devel@nongnu.org, edk2-devel@lists.01.org
Cc: Kevin O'Connor <kevin@koconnor.net>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

ROMFILE_LOADER_ALLOC_ZONE_64BIT permits the guest firmware to allocate the
blob being downloaded anywhere in the 64-bit address space. In SeaBIOS, we
can simply alias this zone request to ROMFILE_LOADER_ALLOC_ZONE_HIGH
(i.e., allocate the blob in 32-bit address space.)

Cc: "Kevin O'Connor" <kevin@koconnor.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 src/fw/romfile_loader.h | 7 ++++---
 src/fw/romfile_loader.c | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/fw/romfile_loader.h b/src/fw/romfile_loader.h
index d90c3db24331..9828d4ad1094 100644
--- a/src/fw/romfile_loader.h
+++ b/src/fw/romfile_loader.h
@@ -11,11 +11,11 @@ struct romfile_loader_entry_s {
     u32 command;
     union {
         /*
          * COMMAND_ALLOCATE - allocate a table from @alloc.file
          * subject to @alloc.align alignment (must be power of 2)
-         * and @alloc.zone (can be HIGH or FSEG) requirements.
+         * and @alloc.zone (see ROMFILE_LOADER_ALLOC_ZONE_*) requirements.
          * The most significant bit (bit 7) of @alloc.zone is used as a content
          * hint for UEFI guest firmware, see ROMFILE_LOADER_ALLOC_CONTENT_*.
          *
          * Must appear exactly once for each file, and before
          * this file is referenced by any other command.
@@ -80,12 +80,13 @@ enum {
     ROMFILE_LOADER_COMMAND_ADD_CHECKSUM  = 0x3,
     ROMFILE_LOADER_COMMAND_WRITE_POINTER = 0x4,
 };
 
 enum {
-    ROMFILE_LOADER_ALLOC_ZONE_HIGH = 0x1,
-    ROMFILE_LOADER_ALLOC_ZONE_FSEG = 0x2,
+    ROMFILE_LOADER_ALLOC_ZONE_HIGH  = 0x1,
+    ROMFILE_LOADER_ALLOC_ZONE_FSEG  = 0x2,
+    ROMFILE_LOADER_ALLOC_ZONE_64BIT = 0x3,
 };
 
 enum {
     ROMFILE_LOADER_ALLOC_CONTENT_MIXED  = 0x00,
     ROMFILE_LOADER_ALLOC_CONTENT_NOACPI = 0x80,
diff --git a/src/fw/romfile_loader.c b/src/fw/romfile_loader.c
index 6a457902a36a..c0c476b58990 100644
--- a/src/fw/romfile_loader.c
+++ b/src/fw/romfile_loader.c
@@ -68,10 +68,11 @@ static void romfile_loader_allocate(struct romfile_loader_entry_s *entry,
 
     zone_req = entry->alloc.zone;
     zone_req &= ~(unsigned)ROMFILE_LOADER_ALLOC_CONTENT_NOACPI;
     switch (zone_req) {
         case ROMFILE_LOADER_ALLOC_ZONE_HIGH:
+        case ROMFILE_LOADER_ALLOC_ZONE_64BIT:
             zone = &ZoneHigh;
             break;
         case ROMFILE_LOADER_ALLOC_ZONE_FSEG:
             zone = &ZoneFSeg;
             break;
-- 
2.9.3
