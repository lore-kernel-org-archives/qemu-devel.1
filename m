Received: from eggs.gnu.org ([209.51.188.92]:59751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9120a6573=anthony.perard@citrix.com>)
	id 1gjp6K-0008F8-KI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9120a6573=anthony.perard@citrix.com>)
	id 1gjp6I-0007Cz-HZ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:35:40 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:16923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9120a6573=anthony.perard@citrix.com>)
	id 1gjp6I-0007BU-9r
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:35:38 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Wed, 16 Jan 2019 17:35:27 +0000
Message-ID: <20190116173527.27741-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] accel: Allow to build QEMU without TCG or KVM
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>

Instead of deny build of QEMU without a default accelerator, simply
report an error when the user haven't passed -accel or -machine accel=
and TCG and KVM isn't builtin.

./configure already check that at least one accelerator is available.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 accel/accel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/accel.c b/accel/accel.c
index 68b6d56323..0d5b370dfd 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -91,7 +91,9 @@ void configure_accelerator(MachineState *ms, const char *progname)
 #elif defined(CONFIG_KVM)
             accel = "kvm";
 #else
-#error "No default accelerator available"
+            error_report("No accelerator selected and"
+                         " no default accelerator available");
+            exit(1);
 #endif
         }
     }
-- 
Anthony PERARD
