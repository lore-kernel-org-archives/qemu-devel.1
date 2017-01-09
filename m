Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQdNu-0002vz-Il
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQdNt-0006Zr-Lo
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:05:26 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 17:05:21 +0000
Message-Id: <1483981521-6789-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/i386/kvmvapic: Remove dead code in
 patch_hypercalls()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

The patch_hypercalls() function sets up a 'patches'
variable and checks it at the end of the function, but
never modifies it in the middle. Remove this dead code,
which seems to have been present since the function was
added in commit e5ad936b0fd7 in 2012.

(Spotted by Coverity: CID 1005581.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Perhaps this was unintentionally retained debug code?
It's not clear to me why the ROM should be required to
have exactly zero or two hypercalls in it. In any case
we've been fine without checking the patch count for
five years :-)

CC'd Jan as original code author just in case he remembers.
---
 hw/i386/kvmvapic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index b30d1b9..418dba1 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -534,7 +534,6 @@ static int patch_hypercalls(VAPICROMState *s)
     uint8_t alternates[2];
     const uint8_t *pattern;
     const uint8_t *patch;
-    int patches = 0;
     off_t pos;
     uint8_t *rom;
 
@@ -565,11 +564,6 @@ static int patch_hypercalls(VAPICROMState *s)
     }
 
     g_free(rom);
-
-    if (patches != 0 && patches != 2) {
-        return -1;
-    }
-
     return 0;
 }
 
-- 
2.7.4
