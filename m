Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E78AC33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5A920716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgPSWZqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5A920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwusy-00049F-EA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwup8-0005S3-8i
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwup7-0000aX-1o
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwup6-0000a7-TM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wB8QA9w3gkRDqeavrH3bnAfJGucCtNtNhxG6KxdGwUY=;
 b=WgPSWZqi+CFCYh72C7ljbML7cGWQSfvPb5lyqqZwNGKKdpZn1Buu91W+//gv+r2L1PsbQI
 NU/lZyANL8eE65JsZ9JOZSfqumex2fu8/dRRHYemqPS5Cl3hbKVV9usWGsAFrL4m0XVhSt
 ejqnP72h3qZMbjiqLa9xgdrk5u+2sPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-jFrrYbEpNpaE6g96EICeRg-1; Wed, 29 Jan 2020 16:24:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBEF110054E3;
 Wed, 29 Jan 2020 21:24:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E302860C81;
 Wed, 29 Jan 2020 21:24:20 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/29] tests/acceptance: Use 'machine' tag to check if
 available in QEMU binary
Date: Wed, 29 Jan 2020 22:23:25 +0100
Message-Id: <20200129212345.20547-10-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jFrrYbEpNpaE6g96EICeRg-1
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

We already use the 'machine' tag in Avocado tests.
If the requested machine is not available in the QEMU binary,
the tests will be cancelled (skipped):

  $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_model_versi=
ons.py
   ...
   (04/11) CascadelakeArchCapabilities.test_4_1: CANCEL: Test expects machi=
ne 'pc-i440fx-4.1' which is missing from QEMU binary (0.10 s)
   (05/11) CascadelakeArchCapabilities.test_4_0: CANCEL: Test expects machi=
ne 'pc-i440fx-4.0' which is missing from QEMU binary (0.11 s)
   ...

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index e7d5affe24..53ec8512d1 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), =
'..', '..', '..')
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
 from qemu.binutils import binary_get_arch
+from qemu.binutils import binary_get_machines
 from qemu.binutils import binary_get_version
 from qemu.machine import QEMUMachine
=20
@@ -118,9 +119,6 @@ class Test(avocado.Test):
         self.arch =3D self.params.get('arch',
                                     default=3Dself._get_unique_tag_val('ar=
ch'))
=20
-        self.machine =3D self.params.get('machine',
-                                       default=3Dself._get_unique_tag_val(=
'machine'))
-
         # Verify qemu_bin
         default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
@@ -151,6 +149,15 @@ class Test(avocado.Test):
             if bin_arch !=3D self.arch:
                 self.cancel(fmt.format(self.arch, bin_arch))
=20
+        # Verify machine
+        self.machine =3D self.params.get('machine',
+                                       default=3Dself._get_unique_tag_val(=
'machine'))
+        logger.debug('machine: {}'.format(self.machine))
+        if self.machine:
+            fmt =3D "Test expects machine '{}' which is missing from QEMU =
binary"
+            if self.machine not in binary_get_machines(self.qemu_bin):
+                self.cancel(fmt.format(self.machine))
+
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
         if args:
--=20
2.21.1


