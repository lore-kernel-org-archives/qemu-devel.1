Received: from eggs.gnu.org ([2001:4830:134:3::10]:44160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqT-00083n-E7
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqQ-0001HM-Ao
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:29 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:53 +1100
Message-Id: <20170303032507.16142-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/17] powernv: Don't test POWER9 CPU yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

A couple of tests for the work-in-progress 'powernv' machine type attempt
to test on POWER9 CPUs.  However the POWER9 CPU support is incomplete and
this doesn't really work.  In particular the firmware image we have
currently assumes the presence of the SDR1 register, which no longer exists
on POWER9.  We only got away with this so far, because of a different bug
which added SDR1 to POWER9 even though it shouldn't be there.

For now, remove POWER9 testing of powernv, POWER8 testing will do for now
until the POWER9 support is more complete.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/boot-serial-test.c | 2 +-
 tests/pnv-xscom-test.c   | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 44c82e5..57edf6a 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -29,7 +29,7 @@ static testdef_t tests[] = {
     { "ppc64", "ppce500", "", "U-Boot" },
     { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
     { "ppc64", "pseries", "", "Open Firmware" },
-    { "ppc64", "powernv", "-cpu POWER9", "SkiBoot" },
+    { "ppc64", "powernv", "-cpu POWER8", "SkiBoot" },
     { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "i386", "pc", "-device sga", "SGABIOS" },
     { "i386", "q35", "-device sga", "SGABIOS" },
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 5951da1..5adc3fd 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -41,7 +41,9 @@ static const PnvChip pnv_chips[] = {
         .xscom_core_base = 0x10000000ull,
         .cfam_id    = 0x120d304980000000ull,
         .first_core = 0x1,
-    }, {
+    },
+#if 0 /* POWER9 support is not ready yet */
+    {
         .chip_type  = PNV_CHIP_POWER9,
         .cpu_model  = "POWER9",
         .xscom_base = 0x000603fc00000000ull,
@@ -49,6 +51,7 @@ static const PnvChip pnv_chips[] = {
         .cfam_id    = 0x100d104980000000ull,
         .first_core = 0x20,
     },
+#endif
 };
 
 static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
-- 
2.9.3
