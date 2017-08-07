Received: from eggs.gnu.org ([2001:4830:134:3::10]:50523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek8A-0004fB-0u
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek85-0006ZV-8J
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:46 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dek85-0006Ys-2B
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:41 -0400
Received: by mail-wr0-x231.google.com with SMTP id v105so3325195wrb.0
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 08:39:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  7 Aug 2017 16:39:31 +0100
Message-Id: <20170807153934.29477-4-alex.bennee@linaro.org>
In-Reply-To: <20170807153934.29477-1-alex.bennee@linaro.org>
References: <20170807153934.29477-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v3 3/6] docker: ignore submodules when
 checking diff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The QEMU tree often has dirty submodules in it but this will confuse
things as git stash is not going to save their state directly. They
are likely just dirty from build files anyway. Ignore them in the
diff-index command.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ff580edfad..2a560a5327 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -20,7 +20,7 @@ IMAGES ?= %
 # Make archive from git repo $1 to tar.gz $2
 make-archive-maybe = $(if $(wildcard $1/*), \
 	$(call quiet-command, \
-		(cd $1; if git diff-index --quiet HEAD -- 2>/dev/null; then \
+		(cd $1; if git diff-index --quiet --ignore-submodules HEAD -- 2>/dev/null; then \
 			git archive -1 HEAD --format=tar.gz; \
 		else \
 			git archive -1 $$(git stash create) --format=tar.gz; \
-- 
2.13.0
