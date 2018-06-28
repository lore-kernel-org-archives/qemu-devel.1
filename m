Received: from eggs.gnu.org ([2001:4830:134:3::10]:60498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxg-0002BX-Hu
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxf-0000tt-JB
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:56 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:42117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxf-0000so-Ea
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:55 -0400
Received: by mail-qk0-x243.google.com with SMTP id u62-v6so3204480qkf.9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:35:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 12:35:32 -0300
Message-Id: <20180628153535.1411-2-f4bug@amsat.org>
In-Reply-To: <20180628153535.1411-1-f4bug@amsat.org>
References: <20180628153535.1411-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] tests/vm: Support proxy / corporate
 firewall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

If ftp_proxy/http_proxy/https_proxy standard environment variables
are available, pass them to the vm images.

As per 06cc3551714:
This is required when building behind corporate proxy/firewall, but
also help when using local cache server (ie: apt/yum).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/ubuntu.i386 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index fc319e0e6e..be16ceed50 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -68,6 +68,10 @@ class UbuntuX86VM(basevm.BaseVM):
         self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
+        for k, v in os.environ.iteritems():
+            kl = k.lower()
+            if kl in ['ftp_proxy', 'http_proxy', 'https_proxy']:
+                self.ssh_root_check("echo 'Acquire::{}::Proxy \"{}\";' >> /etc/apt/apt.conf.d/01proxy".format(kl[:-6].upper(), v))
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get install -y cloud-initramfs-growroot")
         # Don't check the status in case the guest hang up too quickly
-- 
2.18.0
