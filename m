Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrs-0004bM-4v
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrn-00072a-K0
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:34 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrn-00072O-G2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:31 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so9571818qta.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:03:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 28 Jun 2017 22:02:58 -0300
Message-Id: <20170629010300.2848-7-f4bug@amsat.org>
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
References: <20170629010300.2848-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/8] tcg/tci: disable MTTCG if TCI is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

TCI + MTTCG cause strange errors...

  $ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
  qemu-system-arm: Guest expects a stronger memory ordering than the host provides
  This may cause strange/hard to debug errors
  Segmentation fault (core dumped)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index c571ad14e5..510f443e06 100755
--- a/configure
+++ b/configure
@@ -6225,7 +6225,11 @@ fi
 if test "$target_softmmu" = "yes" ; then
   echo "CONFIG_SOFTMMU=y" >> $config_target_mak
   if test "$mttcg" = "yes" ; then
-    echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
+    if test "$tcg_interpreter" = "yes" ; then
+        echo "TCI enabled, disabling MTTCG"
+    else
+        echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
+    fi
   fi
 fi
 if test "$target_user_only" = "yes" ; then
-- 
2.13.1
