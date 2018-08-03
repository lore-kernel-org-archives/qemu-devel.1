Received: from eggs.gnu.org ([2001:4830:134:3::10]:49035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dracc@dracc.se>) id 1flZeW-0002db-9t
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dracc@dracc.se>) id 1flZeS-0002bG-Fu
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:57:56 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dracc@dracc.se>) id 1flZeS-0002ah-8W
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:57:52 -0400
Received: by mail-lf1-x144.google.com with SMTP id u14-v6so4018122lfu.0
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 05:57:52 -0700 (PDT)
Date: Fri, 3 Aug 2018 14:57:42 +0200
From: Lucas Eriksson <dracc@dracc.se>
Message-ID: <20180803125736.GA3476@SEJKG-L-LAN04.air5.flaktwoods.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] Makefile: Don't add -dirty to pkgversion when
 tree is not dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, qemu-trivial@nongnu.org

On a clean just-cloned repo, git-diff-index has no local index to
compare with, leading to all files being marked as new on some systems.
git-diff on the other hand actually compares the files contents with the
repository tree and then updates said local index.
This problem was found when trying to automate xqemu builds (an xbox
emulator based on qemu) through the use of AppVeyor.

Signed-off-by: Lucas Eriksson <dracc@dracc.se>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2da686be33..7b48c43734 100644
--- a/Makefile
+++ b/Makefile
@@ -446,7 +446,7 @@ qemu-version.h: FORCE
 		else \
 			if test -d .git; then \
 				pkgvers=$$(git describe --match 'v*' 2>/dev/null | tr -d '\n');\
-				if ! git diff-index --quiet HEAD &>/dev/null; then \
+				if ! git diff --quiet HEAD >/dev/null 2>&1; then \
 					pkgvers="$${pkgvers}-dirty"; \
 				fi; \
 			fi; \
--
2.18.0
