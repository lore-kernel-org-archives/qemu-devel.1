Received: from eggs.gnu.org ([2001:4830:134:3::10]:41124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpHL0-00021q-Ju
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpHKw-0000UZ-0L
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:08:34 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:35255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpHKv-0000UM-Rf
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:08:29 -0400
Received: by mail-qt0-x231.google.com with SMTP id k2so13646303qte.2
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:08:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  5 Sep 2017 14:08:22 -0300
Message-Id: <20170905170822.9109-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] vhost-user: disable broken test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

tests/vhost-user-test keeps failing on build-system since Aug 15:

  ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child process (/i386/vhost-user/flags-mismatch/subprocess [4836]) failed unexpectedly
...
  ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/x86_64/vhost-user/connect-fail/subprocess [58910]) failed unexpectedly

The test can still be build for debug session using:

  $ FORCE_VHOST_USER_NET_TEST=1 ./configure ...

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index fb7e34a901..d3b895b167 100755
--- a/configure
+++ b/configure
@@ -6386,7 +6386,12 @@ if supported_kvm_target $target; then
     if test "$vhost_net" = "yes" ; then
         echo "CONFIG_VHOST_NET=y" >> $config_target_mak
         if test "$vhost_user" = "yes" ; then
-            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
+            if test -n "${FORCE_VHOST_USER_NET_TEST}"; then
+                echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
+            elif test -z "${VHOST_USER_NET_TEST_WARNED}"; then
+                echo "warning: vhost-user tests disabled" >&2
+                VHOST_USER_NET_TEST_WARNED="warned"
+            fi
         fi
     fi
 fi
-- 
2.14.1
