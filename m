Received: from eggs.gnu.org ([2001:4830:134:3::10]:52437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8r-0007yv-PB
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8m-00088d-RP
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:53 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:44063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8m-00088I-M1
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:48 -0400
Received: by mail-oi0-x229.google.com with SMTP id l74so3684278oih.1
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:21 -0700
Message-Id: <20170917150535.8284-4-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/17] accel/tcg: move user-exec to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170911213328.9701-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target                                | 4 ++--
 user-exec-stub.c => accel/tcg/user-exec-stub.c | 0
 user-exec.c => accel/tcg/user-exec.c           | 0
 MAINTAINERS                                    | 3 +--
 accel/tcg/Makefile.objs                        | 3 +++
 5 files changed, 6 insertions(+), 4 deletions(-)
 rename user-exec-stub.c => accel/tcg/user-exec-stub.c (100%)
 rename user-exec.c => accel/tcg/user-exec.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 7f42c45db8..520305b025 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -119,7 +119,7 @@ QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
              -I$(SRC_PATH)/linux-user
 
 obj-y += linux-user/
-obj-y += gdbstub.o thunk.o user-exec.o user-exec-stub.o
+obj-y += gdbstub.o thunk.o
 
 endif #CONFIG_LINUX_USER
 
@@ -132,7 +132,7 @@ QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
 			 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
 
 obj-y += bsd-user/
-obj-y += gdbstub.o user-exec.o user-exec-stub.o
+obj-y += gdbstub.o
 
 endif #CONFIG_BSD_USER
 
diff --git a/user-exec-stub.c b/accel/tcg/user-exec-stub.c
similarity index 100%
rename from user-exec-stub.c
rename to accel/tcg/user-exec-stub.c
diff --git a/user-exec.c b/accel/tcg/user-exec.c
similarity index 100%
rename from user-exec.c
rename to accel/tcg/user-exec.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 2127bb241a..4bd1797330 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1603,8 +1603,7 @@ Overall
 M: Riku Voipio <riku.voipio@iki.fi>
 S: Maintained
 F: thunk.c
-F: user-exec.c
-F: user-exec-stub.c
+F: accel/tcg/user-exec*.c
 
 BSD user
 S: Orphan
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 22642e6f75..f2422d0fb3 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -2,3 +2,6 @@ obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
+
+obj-$(CONFIG_USER_ONLY) += user-exec.o
+obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
-- 
2.13.5
