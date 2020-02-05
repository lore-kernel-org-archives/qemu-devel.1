Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF0C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC8F20659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asFemNE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC8F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izROX-0002wT-BI
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1izRMA-0006ip-GM
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1izRM9-0004PN-8i
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1izRM9-0004Ld-4s
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580934784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQRbzIUcnufUVFf+NWbNUmQbce3BA+STKioUNBZCc0M=;
 b=asFemNE2UVPq6W35ptaBDLHHtGEdsDiwAQdWhnxduGOHIC4bZYQp/ZckgMd7ZrZo2jJjAJ
 6/HRT6UpTi+f+BoChCkiyms14WYxZOlznNWyk6NatirYPh3F22mFI9m4A7HnZKdJ5Tf2sA
 uJkBWI1iFDu8Q5PFTr3d6S3JCt/ppB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-SEZChmZEPo6EhVCdkxcK7A-1; Wed, 05 Feb 2020 15:33:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58B4F184AEA6;
 Wed,  5 Feb 2020 20:32:59 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E39210013A1;
 Wed,  5 Feb 2020 20:32:58 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/8] tests/acceptance: boot_linux_console: Add boot
 Linux/s390x with KVM
Date: Wed,  5 Feb 2020 15:32:48 -0500
Message-Id: <20200205203250.30526-7-wainersm@redhat.com>
In-Reply-To: <20200205203250.30526-1-wainersm@redhat.com>
References: <20200205203250.30526-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: SEZChmZEPo6EhVCdkxcK7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: drjones@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 thuth@redhat.com, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yet another splitting of boot the Linux tests between KVM and TCG. This
time for s390x.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index ca385c90a4..2256623f7e 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -512,11 +512,7 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system=
')
=20
-    def test_s390x_s390_ccw_virtio(self):
-        """
-        :avocado: tags=3Darch:s390x
-        :avocado: tags=3Dmachine:s390-ccw-virtio
-        """
+    def do_test_s390x_s390_ccw_virtio(self):
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/s390x/os/i=
mages'
                       '/kernel.img')
@@ -532,6 +528,22 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_s390x_s390_ccw_virtio_kvm(self):
+        """
+        :avocado: tags=3Darch:s390x
+        :avocado: tags=3Dmachine:s390-ccw-virtio
+        :avocado: tags=3Daccel:kvm
+        """
+        self.do_test_s390x_s390_ccw_virtio()
+
+    def test_s390x_s390_ccw_virtio_tcg(self):
+        """
+        :avocado: tags=3Darch:s390x
+        :avocado: tags=3Dmachine:s390-ccw-virtio
+        :avocado: tags=3Daccel:tcg
+        """
+        self.do_test_s390x_s390_ccw_virtio()
+
     def test_alpha_clipper(self):
         """
         :avocado: tags=3Darch:alpha
--=20
2.24.1


