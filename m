Received: from eggs.gnu.org ([2001:4830:134:3::10]:36079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gJzxn-00042U-Nz
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gJzxj-0007M1-JS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:56:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gJzxj-0007La-EB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:56:03 -0500
From: P J P <ppandit@redhat.com>
Date: Tue,  6 Nov 2018 17:23:51 +0530
Message-Id: <20181106115351.9422-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] lsi53c895a: check script ram address value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While accessing script ram[2048] via 'lsi_ram_read/write' routines,
'addr' could exceed the ram range. Mask high order bits to avoid
OOB access.

Reported-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/lsi53c895a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 3f207f607c..0800df416e 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2035,6 +2035,7 @@ static void lsi_ram_write(void *opaque, hwaddr addr,
     uint32_t mask;
     int shift;
 
+    addr &= 0x01FFF;
     newval = s->script_ram[addr >> 2];
     shift = (addr & 3) * 8;
     mask = ((uint64_t)1 << (size * 8)) - 1;
@@ -2050,6 +2051,7 @@ static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
     uint32_t val;
     uint32_t mask;
 
+    addr &= 0x01FFF;
     val = s->script_ram[addr >> 2];
     mask = ((uint64_t)1 << (size * 8)) - 1;
     val >>= (addr & 3) * 8;
-- 
2.17.2
