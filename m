Received: from eggs.gnu.org ([2001:4830:134:3::10]:52615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gRiSC-0001of-1H
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gRiQW-0006uG-7m
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:49:41 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 27 Nov 2018 13:49:29 -0500
Message-Id: <20181127184929.20065-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: Address spurious clang warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>

Some versions of Clang prior to 6.0 (and some builds of clang after,
such as 6.0.1-2.fc28) fail to recognize { 0 } as a valid initializer
for a struct with subobjects when -Wmissing-braces is enabled.

https://bugs.llvm.org/show_bug.cgi?id=21689 and
https://reviews.llvm.org/rL314499 suggests this should be fixed in 6.0,
but it might not be the case for older versions or downstream versions.

For now, follow the precedent of ebf2a499 and replace the standard { 0 }
with the accepted { } to silence this warning and allow the build to
work under clang 6.0.1-2.fc28, and builds prior to 6.0.

Signed-off-by: John Snow <jsnow@redhat.com>

---

What I am actually less clear on is why this appears to be a problem
only now; since the introduction of { 0 } was in 2.11. It might be
a regression only in the fedora distribution of Clang 6.0.

With apologies to Paolo, who hates these patches.
---
 scsi/qemu-pr-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index ce40008bfc..e7af637232 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -236,7 +236,7 @@ static void dm_init(void)
         perror("Cannot open " CONTROL_PATH);
         exit(1);
     }
-    struct dm_ioctl dm = { 0 };
+    struct dm_ioctl dm = { };
     if (!dm_ioctl(DM_VERSION, &dm)) {
         perror("ioctl");
         exit(1);
-- 
2.17.2
