Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD983CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73E320820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73E320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWtr-0006NP-K5
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iLWoa-0007Cu-QY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iLWoZ-0001Ta-RT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:17:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iLWoZ-0001Sr-Ld
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:17:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C54453175295;
 Fri, 18 Oct 2019 18:17:26 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BA255D713;
 Fri, 18 Oct 2019 18:17:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/3] tests/vm: Let subclasses disable IPv6
Date: Fri, 18 Oct 2019 15:17:04 -0300
Message-Id: <20191018181705.17957-3-ehabkost@redhat.com>
In-Reply-To: <20191018181705.17957-1-ehabkost@redhat.com>
References: <20191018181705.17957-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 18 Oct 2019 18:17:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mechanism will be used to work around issues related to IPv6
on the netbsd image builder.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/vm/basevm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index b5d1479bee..2929de23aa 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -57,6 +57,8 @@ class BaseVM(object):
     arch =3D "#arch"
     # command to halt the guest, can be overridden by subclasses
     poweroff =3D "poweroff"
+    # enable IPv6 networking
+    ipv6 =3D True
     def __init__(self, debug=3DFalse, vcpus=3DNone):
         self._guest =3D None
         self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
@@ -81,7 +83,8 @@ class BaseVM(object):
         self._args =3D [ \
             "-nodefaults", "-m", "4G",
             "-cpu", "max",
-            "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22",
+            "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22" +
+                       (",ipv6=3Dno" if not self.ipv6 else ""),
             "-device", "virtio-net-pci,netdev=3Dvnet",
             "-vnc", "127.0.0.1:0,to=3D20"]
         if vcpus and vcpus > 1:
--=20
2.21.0


