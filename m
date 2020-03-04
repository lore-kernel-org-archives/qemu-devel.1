Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7214FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C37E2072D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gi7t4uiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C37E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Qu7-0003kh-AB
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqs-00070O-IZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqq-0000cd-Ps
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:06 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqq-0000aD-Da
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:04 -0500
Received: by mail-wm1-x329.google.com with SMTP id i9so1281265wml.4
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YDS2krmEOwHmyFHZND8chhdsDOBM1s0eAUxp7rCjnHk=;
 b=gi7t4uivDk4XaBJ8/Opj2+UHYexHhEaaOtGLWu6aNoNxguNL1I1ctEGcq6mjuejGgZ
 LOMmNLKJ5FZ4TEN6cGCuePL/JGF4fztlQiMkie2j5ypabAEBCwgC77zLNX7hM4lRvFZ+
 kro9bh1nfzVliF3f4AOf6ZkvpxM7QVCR4DdwX+yGxCwpsF7xkx4V16A4aSSEqb7/Doyj
 tp7trLm7M8Pi8J3ezazifJSMB9oBqfoaBF7ezVKLFPsXooKfhczg7h2iZ9BLysnKzxZ3
 zelqTlCxGsg9zX5YMcrDWyoG1bwdW5jQXBHeYQUfXy49QSxivfX6/Mup1PaRh8MYlevd
 +RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YDS2krmEOwHmyFHZND8chhdsDOBM1s0eAUxp7rCjnHk=;
 b=H2c1n87KnXGwDa8m6ueQCaGpU2BKex7mDCo+VW9QnGPQECxlvpFOlta7azioFoq1Xa
 /MZQtw1DCTFyBo0eAZWqewsNADjXXx7GNJK5+HxPm7j8EEfebBKNAomjXUwfx9H+8l78
 PEKxNyHv3UW1zVBapxjkqrgZKO/SWZ/US+TnoaKoCj/ujduHFpP1OJyQHEaOnMVy6C1q
 z+Q46efGxwiSY0ee0rKtV5ywmGcGAxMB1WAwRqCYKjAEKAKfOZVJg2998gUsM6JwqqIK
 t4nnqHLDESW+TciIhnEjNpAi6QOjm0kRxe7BulCUtSuDIjl4sfM1m7ed/J4TU2nLfXvA
 nz1w==
X-Gm-Message-State: ANhLgQ2GTp2qXY0VHaNPg7WPgrlkmXiw1aVDMVUVYyF248Yb4nKp8rOs
 p2ITu8nzHlJcTRR4/X4R9n2NcuaRmZs=
X-Google-Smtp-Source: ADFU+vv5GwxIoo9Kc7vi+MXPP9koJtc3BXb99d27YwSA+ppE8wCyCCOEFrJnaWUPoZnqNXGjDeiOSg==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr2811611wmj.41.1583316123360;
 Wed, 04 Mar 2020 02:02:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h16sm3318625wmd.10.2020.03.04.02.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:02:00 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 572AF1FF92;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 5/9] tests/vm: Added gen_cloud_init_iso() to basevm.py
Date: Wed,  4 Mar 2020 10:01:50 +0000
Message-Id: <20200304100154.14822-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

This method was located in both centos and ubuntu.i386.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219163537.22098-6-robert.foley@linaro.org>
Message-Id: <20200303150622.20133-6-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7f268922685..8400b0e07f6 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -345,6 +345,46 @@ class BaseVM(object):
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
+    def gen_cloud_init_iso(self):
+        cidir = self._tmpdir
+        mdata = open(os.path.join(cidir, "meta-data"), "w")
+        name = self.name.replace(".","-")
+        mdata.writelines(["instance-id: {}-vm-0\n".format(name),
+                          "local-hostname: {}-guest\n".format(name)])
+        mdata.close()
+        udata = open(os.path.join(cidir, "user-data"), "w")
+        print("guest user:pw {}:{}".format(self._config['guest_user'],
+                                           self._config['guest_pass']))
+        udata.writelines(["#cloud-config\n",
+                          "chpasswd:\n",
+                          "  list: |\n",
+                          "    root:%s\n" % self._config['root_pass'],
+                          "    %s:%s\n" % (self._config['guest_user'],
+                                           self._config['guest_pass']),
+                          "  expire: False\n",
+                          "users:\n",
+                          "  - name: %s\n" % self._config['guest_user'],
+                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "  - name: root\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % self._config['ssh_pub_key'],
+                          "locale: en_US.UTF-8\n"])
+        proxy = os.environ.get("http_proxy")
+        if not proxy is None:
+            udata.writelines(["apt:\n",
+                              "  proxy: %s" % proxy])
+        udata.close()
+        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
+                               "-volid", "cidata", "-joliet", "-rock",
+                               "user-data", "meta-data"],
+                               cwd=cidir,
+                               stdin=self._devnull, stdout=self._stdout,
+                               stderr=self._stdout)
+
+        return os.path.join(cidir, "cloud-init.iso")
+
 def parse_args(vmcls):
 
     def get_default_jobs():
diff --git a/tests/vm/centos b/tests/vm/centos
index a41ff109eb5..0ad4ecf4190 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -31,37 +31,6 @@ class CentosVM(basevm.BaseVM):
         make docker-test-mingw@fedora  {verbose} J={jobs} NETWORK=1;
     """
 
-    def _gen_cloud_init_iso(self):
-        cidir = self._tmpdir
-        mdata = open(os.path.join(cidir, "meta-data"), "w")
-        mdata.writelines(["instance-id: centos-vm-0\n",
-                          "local-hostname: centos-guest\n"])
-        mdata.close()
-        udata = open(os.path.join(cidir, "user-data"), "w")
-        udata.writelines(["#cloud-config\n",
-                          "chpasswd:\n",
-                          "  list: |\n",
-                          "    root:%s\n" % self.ROOT_PASS,
-                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_PASS),
-                          "  expire: False\n",
-                          "users:\n",
-                          "  - name: %s\n" % self.GUEST_USER,
-                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "  - name: root\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "locale: en_US.UTF-8\n"])
-        udata.close()
-        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
-                               "-volid", "cidata", "-joliet", "-rock",
-                               "user-data", "meta-data"],
-                               cwd=cidir,
-                               stdin=self._devnull, stdout=self._stdout,
-                               stderr=self._stdout)
-        return os.path.join(cidir, "cloud-init.iso")
-
     def build_image(self, img):
         cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
         img_tmp = img + ".tmp"
@@ -69,7 +38,7 @@ class CentosVM(basevm.BaseVM):
         subprocess.check_call(["ln", "-f", cimg, img_tmp + ".xz"])
         subprocess.check_call(["xz", "--keep", "-dvf", img_tmp + ".xz"])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
+        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("yum update -y")
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 48e9cb1ad3d..3266038fbde 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -29,41 +29,6 @@ class UbuntuX86VM(basevm.BaseVM):
         make --output-sync {target} -j{jobs} {verbose};
     """
 
-    def _gen_cloud_init_iso(self):
-        cidir = self._tmpdir
-        mdata = open(os.path.join(cidir, "meta-data"), "w")
-        mdata.writelines(["instance-id: ubuntu-vm-0\n",
-                          "local-hostname: ubuntu-guest\n"])
-        mdata.close()
-        udata = open(os.path.join(cidir, "user-data"), "w")
-        udata.writelines(["#cloud-config\n",
-                          "chpasswd:\n",
-                          "  list: |\n",
-                          "    root:%s\n" % self.ROOT_PASS,
-                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_PASS),
-                          "  expire: False\n",
-                          "users:\n",
-                          "  - name: %s\n" % self.GUEST_USER,
-                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "  - name: root\n",
-                          "    ssh-authorized-keys:\n",
-                          "    - %s\n" % basevm.SSH_PUB_KEY,
-                          "locale: en_US.UTF-8\n"])
-        proxy = os.environ.get("http_proxy")
-        if not proxy is None:
-            udata.writelines(["apt:\n",
-                              "  proxy: %s" % proxy])
-        udata.close()
-        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
-                               "-volid", "cidata", "-joliet", "-rock",
-                               "user-data", "meta-data"],
-                               cwd=cidir,
-                               stdin=self._devnull, stdout=self._stdout,
-                               stderr=self._stdout)
-        return os.path.join(cidir, "cloud-init.iso")
-
     def build_image(self, img):
         cimg = self._download_with_cache(
             "https://cloud-images.ubuntu.com/releases/bionic/release-20191114/ubuntu-18.04-server-cloudimg-i386.img",
@@ -71,7 +36,7 @@ class UbuntuX86VM(basevm.BaseVM):
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         self.exec_qemu_img("resize", img_tmp, "50G")
-        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
+        self.boot(img_tmp, extra_args = ["-cdrom", self.gen_cloud_init_iso()])
         self.wait_ssh()
         self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
         self.ssh_root_check("apt-get update")
-- 
2.20.1


