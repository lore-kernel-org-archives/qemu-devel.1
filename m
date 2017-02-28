Received: from eggs.gnu.org ([2001:4830:134:3::10]:51076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cipmo-00052f-E4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cipmk-0005dM-6L
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:58:22 -0500
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 28 Feb 2017 13:58:01 -0800
Message-ID: <20170228215801.10472-3-Andrew.Baumann@microsoft.com>
In-Reply-To: <20170228215801.10472-1-Andrew.Baumann@microsoft.com>
References: <20170228215801.10472-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] target/arm: lie more convincingly about
 memory attributes in PAR_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On a successful long-descriptor translation, PAR_EL1 bits 56:63 are
expected to report the memory attributes of the page. However, the
page table walker (get_phys_addr()) does not currently retrieve these
attributes. Rather than leaving these bits clear (which implies
uncacheable device memory), this change sets them to 0xff, which
corresponds to write-back cached normal memory.

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
---
In my (biased!) opinion, this is a better lie to tell for an emulated
environment. It also happens to un-break the Windows boot process, and
enable an NT kernel optimisation (DC ZVA for page zeroing).

 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 760092a..b858d6d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2159,7 +2159,13 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
             if (!attrs.secure) {
                 par64 |= (1 << 9); /* NS */
             }
-            /* We don't set the ATTR or SH fields in the PAR. */
+            /* ATTR bits are all set, which implies:
+             *   normal memory
+             *   outer write-back non-transient, read/write-allocate
+             *   inner write-back non-transient, read/write-allocate
+             */
+            par64 |= ((uint64_t)0xff << 56); /* ATTR */
+            /* We don't set the SH field in the PAR. */
         } else {
             par64 |= 1; /* F */
             par64 |= (fsr & 0x3f) << 1; /* FS */
-- 
2.8.3
