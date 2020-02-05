Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FF3C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7240B21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPrlwDFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7240B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izM7X-0007J9-KX
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6Y-0005h2-To
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6X-00053g-CK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1izM6X-0004n1-3v
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015ErLTi164936;
 Wed, 5 Feb 2020 14:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=lNpGPJsnVdcfQaHio7GgIkDxvJeaBi00glRdjay70+8=;
 b=YPrlwDFBLu/Jnyq3/y3jsCCBUpwGGJQlMjwMe+HKqtLx06yr2WxWMvX9Lhj6DUmeU8l1
 jg+nWU0EGevxwOMpJzVF+/1Zvzzs5FCnaXqV/uITHVp2ABHbu1cpRa7qcqLdeizGMK+L
 Gqa5M5T4Wja9mKN9+3bgeo8GfI8B6JIRebrww9BC3uDl/UJ7lwDtQWXSsOVO/tPX15H3
 E11m0ALHMor/F8lo+7w367DqQwNTutd9ABo22blLaO1UDXaqW05uZzjiaJh29db0pqb2
 zPkivA1Ixzhojzlj1EkT6Bzo2BcTrzi0k0cxcfYZvO1lSvM8j/aWbAhaMqnTlJxyGg6R PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2xykbp3h93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015EsAvD158746;
 Wed, 5 Feb 2020 14:56:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2xykc31wqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015EuOdm021980;
 Wed, 5 Feb 2020 14:56:24 GMT
Received: from ol7.uk.oracle.com (/10.175.206.136)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 06:56:23 -0800
From: Liam Merwick <liam.merwick@oracle.com>
To: alex.bennee@linaro.org, fam@euphon.net, philmd@redhat.com
Subject: [PATCH v2 5/6] tests/boot_linux_console: add PVH acceptance tests
Date: Wed,  5 Feb 2020 14:56:04 +0000
Message-Id: <1580914565-19675-6-git-send-email-liam.merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: slp@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 pbonzini@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add tests to boot an uncompressed kernel using the x86/HVM direct boot ABI.
The vmlinux binary is obtained from a small RPM for Kata containers and
extracted using the new extract_from_rpm() method.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 tests/acceptance/boot_linux_console.py | 60 ++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 6a473363a122..9c55218cb5bb 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -67,16 +67,40 @@ class BootLinuxConsole(Test):
         os.chdir(cwd)
         return os.path.normpath(os.path.join(self.workdir, path))
 
-    def do_test_x86_64_machine(self):
+    def do_test_x86_64_machine(self, kernel_type='bzImage'):
         """
         Common routine to boot an x86_64 guest.
         Caller must specify tags=arch and tags=machine
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        :param kernel: specify kernel type to be downloaded and booted:
+                       compressed = 'bzImage', uncompressed = 'vmlinux'
+        """
+
+        KERNEL_PATH_INFO = {
+            'bzImage': {
+                'type': 'file',
+                'url': 'https://archives.fedoraproject.org/'
+                       'pub/archive/fedora/linux/releases/29/Everything/'
+                       'x86_64/os/images/pxeboot/vmlinuz',
+                'hash': '23bebd2680757891cf7adedb033532163a792495'
+            },
+            'vmlinux': {
+                'type': 'rpm',
+                'url': 'https://yum.oracle.com/'
+                       'repo/OracleLinux/OL7/olcne/x86_64/getPackage/'
+                       'kernel-uek-container-4.14.35-1902.6.6.1.el7.x86_64.rpm',
+                'file': './usr/share/kata-containers/'
+                        'vmlinux-4.14.35-1902.6.6.1.el7.container',
+                'hash': '4c781711a9d32dcb8e81da2b397cb98926744e23'
+            }
+        }
+
+        k = KERNEL_PATH_INFO[kernel_type]
+        if k['type'] is 'file':
+            kernel_path = self.fetch_asset(k['url'], asset_hash=k['hash'])
+        else:
+            assert k['type'] is 'rpm'
+            rpm_path = self.fetch_asset(k['url'], asset_hash=k['hash'])
+            kernel_path = self.extract_from_rpm(rpm_path, k['file'])
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -100,6 +124,21 @@ class BootLinuxConsole(Test):
         self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
         self.do_test_x86_64_machine()
 
+    def test_x86_64_pc_pvh(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:pc
+        """
+        self.do_test_x86_64_machine(kernel_type='vmlinux')
+
+    def test_x86_64_pc_qboot_pvh(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:pc
+        """
+        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
+        self.do_test_x86_64_machine(kernel_type='vmlinux')
+
     def test_x86_64_microvm(self):
         """
         :avocado: tags=arch:x86_64
@@ -115,6 +154,13 @@ class BootLinuxConsole(Test):
         self.vm.add_args('-bios', 'pc-bios/bios.bin')
         self.do_test_x86_64_machine()
 
+    def test_x86_64_microvm_pvh(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:microvm
+        """
+        self.do_test_x86_64_machine(kernel_type='vmlinux')
+
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
-- 
1.8.3.1


