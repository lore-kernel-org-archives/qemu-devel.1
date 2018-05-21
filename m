Received: from eggs.gnu.org ([2001:4830:134:3::10]:56264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fKi9s-0001QH-R9
	for qemu-devel@nongnu.org; Mon, 21 May 2018 06:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fKi9o-0004cT-Th
	for qemu-devel@nongnu.org; Mon, 21 May 2018 06:35:16 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fKi9o-0004bJ-MQ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 06:35:12 -0400
Received: by mail-wr0-x22c.google.com with SMTP id x9-v6so12623712wrl.13
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 03:35:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 21 May 2018 11:35:04 +0100
Message-Id: <20180521103504.26432-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] tests/docker/Makefile.include: handle empty
 TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

If the user doesn't specify a TARGET_LIST they get the current
configuration but with spaces and hilarity ensues. This adds some make
magic to turn the TARGET_LIST back into a comma separated list.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use common $(SPACE) and $(COMMA) in rules.mak
---
 rules.mak                     | 3 +++
 tests/docker/Makefile.include | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/rules.mak b/rules.mak
index 04c7f74d07..bbb2667928 100644
--- a/rules.mak
+++ b/rules.mak
@@ -1,4 +1,7 @@
 
+# These are used when we want to do substitutions without confusing Make
+NULL  :=
+SPACE := $(NULL) #
 COMMA := ,
 
 # Don't use implicit rules or variables
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index d00887bdf1..e911d44d9f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -148,7 +148,7 @@ docker-run: docker-qemu-src
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
-			-e TARGET_LIST=$(TARGET_LIST) 			\
+			-e TARGET_LIST=$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
 			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
 			-e SHOW_ENV=$(SHOW_ENV) 			\
-- 
2.17.0
