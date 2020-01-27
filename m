Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39261214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F4dE5o9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39261214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw7Tt-0007QH-CZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1iw7Of-0000g9-B2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1iw7Oe-000279-2I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:37:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1iw7Od-00026G-Rc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:37:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RGITMH029602;
 Mon, 27 Jan 2020 16:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=76PyguuYYMo6qSZp/ndM0S3i88TB7MQ5KuBWKBCwxv4=;
 b=F4dE5o9In5O/LtmfPf84Ya16BTEusCDbpiM9gDBtk66cfml6BnZcSpe332IlVA139NlQ
 EndfRfQd1t1iL+4XwFnoBeL1Q2FfF/ckA423GImMrc8eXnoThP42Ukc64b9K/J0TyI+g
 fqN2uzRHs5bn0ThYxRdqFfe0YV2BbO9g6aetNaEyxbSEgSPXlJeOJ+Nl5UD9GShfwx5M
 1VQbMy/WhvhfyK1MIISG+EtSjLDSZSpMjnsK1TM8CNnEALSx6TlnuZn03pQKo0PrTzHT
 BNH3atcAyPgdOtMY7sL8phSSblqoqRvKVyEXstB/3L0fHy+hGOQycZsbbF0WPH54xRrU kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2xrdmq8hmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 16:37:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RGNSEa144964;
 Mon, 27 Jan 2020 16:37:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2xryu9r9tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 16:37:47 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00RGbkU3027332;
 Mon, 27 Jan 2020 16:37:46 GMT
Received: from ol7.uk.oracle.com (/10.175.203.109)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jan 2020 08:37:46 -0800
From: Liam Merwick <liam.merwick@oracle.com>
To: alex.bennee@linaro.org, fam@euphon.net, philmd@redhat.com
Subject: [PATCH 6/6] tests/boot_linux_console: add PVH acceptance tests
Date: Mon, 27 Jan 2020 16:36:34 +0000
Message-Id: <1580142994-1836-7-git-send-email-liam.merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=985 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
 tests/acceptance/boot_linux_console.py | 49 +++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 6af19ae3b14a..ab2200aa0e47 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -65,15 +65,26 @@ class BootLinuxConsole(Test):
         os.chdir(cwd)
         return self.workdir + '/' + path
 
-    def do_test_x86_64_machine(self):
+    def do_test_x86_64_machine(self, pvh=False):
         """
         :avocado: tags=arch:x86_64
         """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        if pvh:
+            rpm_url = ('https://yum.oracle.com/repo/OracleLinux/'
+                       'OL7/olcne/x86_64/getPackage/'
+                       'kernel-uek-container-4.14.35-1902.6.6.1.el7.x86_64.rpm')
+            rpm_hash = '4c781711a9d32dcb8e81da2b397cb98926744e23'
+            rpm_path = self.fetch_asset(rpm_url, asset_hash=rpm_hash)
+            kernel_path = self.extract_from_rpm(rpm_path,
+                                                './usr/share/kata-containers/'
+                                    'vmlinux-4.14.35-1902.6.6.1.el7.container')
+        else:
+            kernel_url = ('https://archives.fedoraproject.org/pub/archive/'
+                          'fedora/linux/releases/29/Everything/x86_64/os/'
+                          'images/pxeboot/vmlinuz')
+            kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
+            kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
         self.vm.add_args('-kernel', kernel_path,
@@ -95,6 +106,19 @@ class BootLinuxConsole(Test):
         self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
         self.do_test_x86_64_machine()
 
+    def test_x86_64_pc_pvh(self):
+        """
+        :avocado: tags=machine:pc
+        """
+        self.do_test_x86_64_machine(pvh=True)
+
+    def test_x86_64_pc_qboot_pvh(self):
+        """
+        :avocado: tags=machine:pc
+        """
+        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
+        self.do_test_x86_64_machine(pvh=True)
+
     def test_x86_64_microvm(self):
         """
         :avocado: tags=machine:microvm
@@ -108,6 +132,19 @@ class BootLinuxConsole(Test):
         self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
         self.do_test_x86_64_machine()
 
+    def test_x86_64_microvm_pvh(self):
+        """
+        :avocado: tags=machine:microvm
+        """
+        self.do_test_x86_64_machine(pvh=True)
+
+    def test_x86_64_microvm_qboot_pvh(self):
+        """
+        :avocado: tags=machine:microvm
+        """
+        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
+        self.do_test_x86_64_machine(pvh=True)
+
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
-- 
1.8.3.1


