Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1E420702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAMXphjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1E420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuy1-0004Gx-LT
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuph-0006jx-HR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupg-0001hG-Am
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupg-0001gF-70
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3iF7RTXUCdUng+9f9aD8oKOgqH0Szn6o2gMmimREsc=;
 b=jAMXphjCYzwnXiYcm7DLpGk7zvhb1jFiAXUS6JyP/kqptrnjFCtKzhaBqX68Z3skKaPrjJ
 65vyEGZgaKFKFpbY0pYwhC3Z8u9NlvIQ6L1K0tdfNAsNc9q7Hr6ufE9mcLyfUTfDufsuDf
 TU4E/cMKQQPihUmI+RWwGPE7JZ0qdfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-VWM5lc2kPPal1YLPLDVMOQ-1; Wed, 29 Jan 2020 16:25:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 540D0800D48;
 Wed, 29 Jan 2020 21:25:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59DA560BF3;
 Wed, 29 Jan 2020 21:24:59 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/29] tests/acceptance/virtio_check_params: Skip test if
 arch is not supported
Date: Wed, 29 Jan 2020 22:23:36 +0100
Message-Id: <20200129212345.20547-21-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VWM5lc2kPPal1YLPLDVMOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refactor the X86 specific code. If we run this test on an
architecture which is not explicitly supported, the test
will be cancelled (skipped).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 37 +++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index ad736bcda3..8752e25f08 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -26,6 +26,8 @@ import logging
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu.machine import QEMUMachine
 from avocado_qemu import Test
+from qemu.binutils import binary_get_arch
+from avocado.core.exceptions import TestCancel
=20
 #list of machine types and virtqueue properties to test
 VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
@@ -96,18 +98,21 @@ class VirtioMaxSegSettingsCheck(Test):
             self.assertEqual(expected_val, prop_val)
=20
     @staticmethod
-    def seg_max_adjust_enabled(mt):
-        # machine types >=3D 5.0 should have seg_max_adjust =3D true
-        # others seg_max_adjust =3D false
-        mt =3D mt.split("-")
+    def seg_max_adjust_enabled(arch, mt):
+        if arch in ['i386', 'x86_64']:
+            # machine types >=3D 5.0 should have seg_max_adjust =3D true
+            # others seg_max_adjust =3D false
+            mt =3D mt.split("-")
=20
-        # machine types with one line name and name like pc-x.x
-        if len(mt) <=3D 2:
-            return False
+            # machine types with one line name and name like pc-x.x
+            if len(mt) <=3D 2:
+                return False
=20
-        # machine types like pc-<chip_name>-x.x[.x]
-        ver =3D mt[2]
-        ver =3D ver.split(".");
+            # machine types like pc-<chip_name>-x.x[.x]
+            ver =3D mt[2]
+            ver =3D ver.split(".");
+        else:
+            raise TestCancel('Unsupported architecture: %s' % arch)
=20
         # versions >=3D 5.0 goes with seg_max_adjust enabled
         major =3D int(ver[0])
@@ -117,9 +122,13 @@ class VirtioMaxSegSettingsCheck(Test):
         return False
=20
     def test_machine_types(self):
-        EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']
-        if os.geteuid() !=3D 0:
-            EXCLUDED_MACHINES +=3D ['xenfv', 'xenpv']
+        arch =3D binary_get_arch(self.qemu_bin)
+
+        EXCLUDED_MACHINES =3D ['none']
+        if arch in ['i386', 'x86_64']:
+            EXCLUDED_MACHINES +=3D ['isapc', 'microvm']
+            if os.geteuid() !=3D 0:
+                EXCLUDED_MACHINES +=3D ['xenfv', 'xenpv']
         # collect all machine types except the ones in EXCLUDED_MACHINES
         with QEMUMachine(self.qemu_bin) as vm:
             vm.launch()
@@ -133,7 +142,7 @@ class VirtioMaxSegSettingsCheck(Test):
             # create the list of machine types and their parameters.
             mtypes =3D list()
             for m in machines:
-                if self.seg_max_adjust_enabled(m):
+                if self.seg_max_adjust_enabled(arch, m):
                     enabled =3D 'true'
                 else:
                     enabled =3D 'false'
--=20
2.21.1


