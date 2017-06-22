Received: from eggs.gnu.org ([2001:4830:134:3::10]:56474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssS-0006NZ-5Z
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssP-0005Ij-1m
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:52 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNssO-0005If-Tn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:48 -0400
Received: by mail-qt0-x241.google.com with SMTP id c20so596525qte.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:31 -0300
Message-Id: <20170622033231.19344-22-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 21/21] ui/vnc: silent unuseful OSX clang
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

    ui/vnc.c:3945:20: warning: 'sasl_server_init' is deprecated: first deprecated in OS X 10.11 [-Wdeprecated-declarations]
        if ((saslErr = sasl_server_init(NULL, "qemu")) != SASL_OK) {
                       ^
    /usr/include/sasl/sasl.h:1016:17: note: 'sasl_server_init' has been explicitly marked deprecated here
    LIBSASL_API int sasl_server_init(const sasl_callback_t *callbacks,
                    ^

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ui/Makefile.objs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3369451285..08fb573a48 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -6,6 +6,14 @@ vnc-obj-y += vnc-auth-vencrypt.o
 vnc-obj-$(CONFIG_VNC_SASL) += vnc-auth-sasl.o
 vnc-obj-y += vnc-ws.o
 vnc-obj-y += vnc-jobs.o
+ifeq ($(CONFIG_VNC_SASL),y)
+# silent OSX SASL warnings (from https://stackoverflow.com/a/7406994):
+# because OpenSSL doesn’t offer API compatibility between versions, [...] Apple
+# can't provide security updates without breaking existing apps, so is migrating
+# from OpenSSL to Common Crypto.
+vnc.o-cflags := -Wno-deprecated-declarations
+vnc-auth-sasl.o-cflags := -Wno-deprecated-declarations
+endif
 
 common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o
-- 
2.11.0
