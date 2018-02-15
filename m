Received: from eggs.gnu.org ([2001:4830:134:3::10]:54013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-00022l-QO
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgP-0003Kp-Io
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgP-0003Kc-DL
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:50:57 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:44 +0000
Message-Id: <20180215175044.8159-8-berrange@redhat.com>
In-Reply-To: <20180215175044.8159-1-berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] allow to build with older sed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Beulich <JBeulich@suse.com>, Jan Beulich <jbeulich@suse.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Jan Beulich <JBeulich@suse.com>

sed's -E option may not be supported by older distros. As there's no
point using sed here at all, use just shell mechanisms to establish the
variable values, starting from the stem instead of the full target.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b5a6d602b2..90e05ac409 100644
--- a/Makefile
+++ b/Makefile
@@ -256,8 +256,7 @@ GENERATED_FILES += $(KEYCODEMAP_FILES)
 
 ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
 	$(call quiet-command,\
-	    src=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\1,") && \
-	    dst=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\2,") && \
+	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
 	    test -e $(KEYCODEMAP_GEN) && \
 	    $(PYTHON) $(KEYCODEMAP_GEN) \
 	          --lang glib2 \
-- 
2.14.3
