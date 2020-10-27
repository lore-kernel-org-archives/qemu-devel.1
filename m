Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46994C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC86522263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR/HQRcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC86522263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXM86-0002aB-Jz
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXM6e-0001I4-To
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:21:32 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXM6c-0008FT-Pb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:21:32 -0400
Received: by mail-ed1-x542.google.com with SMTP id a6so837927edx.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rtfnSQ41UqP2rpV3krqcrl9KAXpaVHu1NjKBUWp+JCo=;
 b=gR/HQRczD/iPgSaDw4WGjlc3qt32ggngKg2uxvOEdg9IfVFR3UPGvrHKpr1x2z9fuN
 d8loIJDGEqpGLS5fO4v9uA+gVeyXfFtIj8wsUi5o5xR83mKZ7YrEau9Zb5HcMEjknM77
 2QyS+NtSN/yf9n+Dj4FR1ZKTdM8RzQH6R7eg6XexXzgu+6w2B3xqrDieGiDjYctqPiNK
 EdjkV/fXixZFZoK3AyWjHJkrwAyV5ng6LsSX6kA6biUQjzJGjwmPZPZ6P82feNCZJJFc
 5NeoMDTasz9x9ZEuVk/AwxKgCTlXTWE5pKG553sc6XdTUH//vLy8vtght+mWxZNiM2uX
 KSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rtfnSQ41UqP2rpV3krqcrl9KAXpaVHu1NjKBUWp+JCo=;
 b=H0Sjbbq2jkmm3F4Cj7Q4yFlRDzFRywoUSc7JXA2XAR6+pf/b6HWY9nWxxOJrBneVLt
 RWFaWaK8uIbGkCWDrfDd5I59DswAWlZZlz2XwbGhW+IGYTQl8rWUnrgLInjvHsT1G6wk
 1XMXbeqoQLX6m1K+5IIAHHegeQ9naaS9fTG4D02K7zGwDtUC6fkJCZiYDxQdvYtFWYlZ
 cSkJDIsiPjRPPaOIkqFYQVYMrcmmvat7SKn11cIcyva4TZ8t5OC9/taztauwORTZeCux
 gExMJEMbHwL6bQsoKHzTSA+0ZQ0MopsIh85fm+9Ju26eEsaysskzdAUI5vQitZeluMoY
 7M5w==
X-Gm-Message-State: AOAM530SJjM/CYzupQy1VEuIk91Rri5lbF7aSQRS+nhOmoePJzfZD4Iz
 yVdBISqKtgzDeycOzHQVzMAz8/dKklI=
X-Google-Smtp-Source: ABdhPJzLxqBvUUDkJ7BY9K4Jz2OqdEC2OBK7+VdAx+o4yELMnNN1z8YMOZtZQxSqSVWFrRYvQJlKrQ==
X-Received: by 2002:a50:8f61:: with SMTP id 88mr1455434edy.175.1603794088897; 
 Tue, 27 Oct 2020 03:21:28 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i3sm529029edd.75.2020.10.27.03.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 03:21:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 1/1] tests/vm: Add Haiku test based on their vagrant
 images
Date: Tue, 27 Oct 2020 11:21:21 +0100
Message-Id: <20201027102121.264963-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027102121.264963-1-f4bug@amsat.org>
References: <20201027102121.264963-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, PDS_BTC_ID=0.499,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Alexander von Gluck IV <kallisti5@unixzen.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander von Gluck IV <kallisti5@unixzen.com>

Signed-off-by: Alexander von Gluck IV <kallisti5@unixzen.com>
[PMD: Avoid recreating the image each time]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/keys/vagrant        |  27 +++++++++
 tests/keys/vagrant.pub    |   1 +
 tests/vm/Makefile.include |   3 +-
 tests/vm/basevm.py        |   5 +-
 tests/vm/haiku.x86_64     | 116 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 3 deletions(-)
 create mode 100644 tests/keys/vagrant
 create mode 100644 tests/keys/vagrant.pub
 create mode 100755 tests/vm/haiku.x86_64

diff --git a/tests/keys/vagrant b/tests/keys/vagrant
new file mode 100644
index 00000000000..7d6a083909e
--- /dev/null
+++ b/tests/keys/vagrant
@@ -0,0 +1,27 @@
+-----BEGIN RSA PRIVATE KEY-----
+MIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzI
+w+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoP
+kcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2
+hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NO
+Td0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW
+yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQIBIwKCAQEA4iqWPJXtzZA68mKd
+ELs4jJsdyky+ewdZeNds5tjcnHU5zUYE25K+ffJED9qUWICcLZDc81TGWjHyAqD1
+Bw7XpgUwFgeUJwUlzQurAv+/ySnxiwuaGJfhFM1CaQHzfXphgVml+fZUvnJUTvzf
+TK2Lg6EdbUE9TarUlBf/xPfuEhMSlIE5keb/Zz3/LUlRg8yDqz5w+QWVJ4utnKnK
+iqwZN0mwpwU7YSyJhlT4YV1F3n4YjLswM5wJs2oqm0jssQu/BT0tyEXNDYBLEF4A
+sClaWuSJ2kjq7KhrrYXzagqhnSei9ODYFShJu8UWVec3Ihb5ZXlzO6vdNQ1J9Xsf
+4m+2ywKBgQD6qFxx/Rv9CNN96l/4rb14HKirC2o/orApiHmHDsURs5rUKDx0f9iP
+cXN7S1uePXuJRK/5hsubaOCx3Owd2u9gD6Oq0CsMkE4CUSiJcYrMANtx54cGH7Rk
+EjFZxK8xAv1ldELEyxrFqkbE4BKd8QOt414qjvTGyAK+OLD3M2QdCQKBgQDtx8pN
+CAxR7yhHbIWT1AH66+XWN8bXq7l3RO/ukeaci98JfkbkxURZhtxV/HHuvUhnPLdX
+3TwygPBYZFNo4pzVEhzWoTtnEtrFueKxyc3+LjZpuo+mBlQ6ORtfgkr9gBVphXZG
+YEzkCD3lVdl8L4cw9BVpKrJCs1c5taGjDgdInQKBgHm/fVvv96bJxc9x1tffXAcj
+3OVdUN0UgXNCSaf/3A/phbeBQe9xS+3mpc4r6qvx+iy69mNBeNZ0xOitIjpjBo2+
+dBEjSBwLk5q5tJqHmy/jKMJL4n9ROlx93XS+njxgibTvU6Fp9w+NOFD/HvxB3Tcz
+6+jJF85D5BNAG3DBMKBjAoGBAOAxZvgsKN+JuENXsST7F89Tck2iTcQIT8g5rwWC
+P9Vt74yboe2kDT531w8+egz7nAmRBKNM751U/95P9t88EDacDI/Z2OwnuFQHCPDF
+llYOUI+SpLJ6/vURRbHSnnn8a/XG+nzedGH5JGqEJNQsz+xT2axM0/W/CRknmGaJ
+kda/AoGANWrLCz708y7VYgAtW2Uf1DPOIYMdvo6fxIB5i9ZfISgcJ/bbCUkFrhoH
++vq/5CIWxCPp0f85R4qxxQ5ihxJ0YDQT9Jpx4TMss4PSavPaBH3RXow5Ohe+bYoQ
+NE5OgEXk2wVfZczCZpigBKbKZHNYcelXtTt/nP3rsCuGcM4h53s=
+-----END RSA PRIVATE KEY-----
diff --git a/tests/keys/vagrant.pub b/tests/keys/vagrant.pub
new file mode 100644
index 00000000000..b8d012d787f
--- /dev/null
+++ b/tests/keys/vagrant.pub
@@ -0,0 +1 @@
+ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== well-known vagrant key for qemu-test, do not use on any machine exposed to an external network
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 61f893ffdc0..e94d95ec541 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -4,7 +4,7 @@
 
 EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
 
-IMAGES := freebsd netbsd openbsd centos fedora
+IMAGES := freebsd netbsd openbsd centos fedora haiku.x86_64
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
 ifneq ($(EFI_AARCH64),)
@@ -41,6 +41,7 @@ endif
 else
 	@echo "  (install genisoimage to build centos/ubuntu images)"
 endif
+	@echo "  vm-build-haiku.x86_64           - Build QEMU in Haiku VM"
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3fac20e929a..00f1d5ca8da 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -44,6 +44,7 @@
     'machine'         : 'pc',
     'guest_user'      : "qemu",
     'guest_pass'      : "qemupass",
+    'root_user'       : "root",
     'root_pass'       : "qemupass",
     'ssh_key_file'    : SSH_KEY_FILE,
     'ssh_pub_key_file': SSH_PUB_KEY_FILE,
@@ -245,13 +246,13 @@ def ssh(self, *cmd):
         return self._ssh_do(self._config["guest_user"], cmd, False)
 
     def ssh_root(self, *cmd):
-        return self._ssh_do("root", cmd, False)
+        return self._ssh_do(self._config["root_user"], cmd, False)
 
     def ssh_check(self, *cmd):
         self._ssh_do(self._config["guest_user"], cmd, True)
 
     def ssh_root_check(self, *cmd):
-        self._ssh_do("root", cmd, True)
+        self._ssh_do(self._config["root_user"], cmd, True)
 
     def build_image(self, img):
         raise NotImplementedError
diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
new file mode 100755
index 00000000000..634ef774870
--- /dev/null
+++ b/tests/vm/haiku.x86_64
@@ -0,0 +1,116 @@
+#!/usr/bin/env python3
+#
+# Haiku VM image
+#
+# Copyright 2020 Haiku, Inc.
+#
+# Authors:
+#  Alexander von Gluck IV <kallisti5@unixzen.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import re
+import sys
+import time
+import socket
+import subprocess
+import basevm
+
+VAGRANT_KEY_FILE = os.path.join(os.path.dirname(__file__),
+    "..", "keys", "vagrant")
+
+VAGRANT_PUB_KEY_FILE = os.path.join(os.path.dirname(__file__),
+    "..", "keys", "vagrant.pub")
+
+HAIKU_CONFIG = {
+    'cpu'             : "max",
+    'machine'         : 'pc',
+    'guest_user'      : "vagrant",
+    'guest_pass'      : "",
+    'root_user'       : "vagrant",
+    'root_pass'       : "",
+    'ssh_key_file'    : VAGRANT_KEY_FILE,
+    'ssh_pub_key_file': VAGRANT_PUB_KEY_FILE,
+    'memory'          : "4G",
+    'extra_args'      : [],
+    'qemu_args'       : "-device VGA",
+    'dns'             : "",
+    'ssh_port'        : 0,
+    'install_cmds'    : "",
+    'boot_dev_type'   : "block",
+    'ssh_timeout'     : 1,
+}
+
+class HaikuVM(basevm.BaseVM):
+    name = "haiku"
+    arch = "x86_64"
+
+    link = "https://app.vagrantup.com/haiku-os/boxes/r1beta2-x86_64/versions/20200702/providers/libvirt.box"
+    csum = "41c38b316e0cbdbc66b5dbaf3612b866700a4f35807cb1eb266a5bf83e9e68d5"
+
+    poweroff = "shutdown"
+
+    requirements = [
+        "devel:libbz2",
+        "devel:libcapstone",
+        "devel:libcurl",
+        "devel:libfdt",
+        "devel:libgcrypt",
+        "devel:libgl",
+        "devel:libglib_2.0",
+        "devel:libgnutls",
+        "devel:libgpg_error",
+        "devel:libintl",
+        "devel:libjpeg",
+        "devel:liblzo2",
+        "devel:libncursesw",
+        "devel:libnettle",
+        "devel:libpixman_1",
+        "devel:libpng16",
+        "devel:libsdl2_2.0",
+        "devel:libsnappy",
+        "devel:libssh2",
+        "devel:libtasn1",
+        "devel:libusb_1.0",
+        "devel:libz",
+        "setuptools_python3"
+    ]
+
+    # https://dev.haiku-os.org/ticket/16512 virtio disk1 shows up as 0 (reversed order)
+    BUILD_SCRIPT = """
+        set -e;
+        rm -rf /tmp/qemu-test.*
+        cd $(mktemp -d /tmp/qemu-test.XXXXXX);
+        mkdir src build; cd src;
+        tar -xf /dev/disk/virtual/virtio_block/0/raw;
+        cd ../build
+        ../src/configure --python=python3 {configure_opts};
+        make --output-sync -j{jobs} {target} {verbose};
+    """
+
+    def build_image(self, img):
+        self.print_step("Downloading disk image")
+        tarball = self._download_with_cache(self.link, sha256sum=self.csum)
+
+        self.print_step("Extracting disk image")
+
+        subprocess.check_call(["tar", "xzf", tarball, "./box.img", "-O"],
+                              stdout=open(img, 'wb'))
+
+        self.print_step("Preparing disk image")
+        self.boot(img)
+
+        # Wait for ssh to be available.
+        self.wait_ssh(wait_root=True, cmd="exit 0")
+
+        # Install packages
+        self.ssh_root("pkgman install -y %s" % " ".join(self.requirements))
+        self.graceful_shutdown()
+
+        self.print_step("All done")
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(HaikuVM, config=HAIKU_CONFIG))
-- 
2.26.2


