Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A19C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DDB20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRkHQJ3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DDB20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwuph-00069o-EY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuoi-0004Nd-QH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuoh-0008Oq-MV
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuoh-0008Oa-Ik
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5EhdtKtzy3iIu7t4TS1UJj5f+Zm+SWvYjiABxTxpa0=;
 b=gRkHQJ3qiLJuNeSR8rj97nu5DKVLtXQ0CEL+zPy6bY9w1MLAq5KZcqBOQBLCvn5Qw1y8++
 fBdIuLtqyO/ZttposK+JbJxSP59gWDgSWwVMlKLOEUq0aCcFyI0uFg8hRNjzHua7L7nTLN
 mJIaA25sZU3ahPCDoiMIYQK+fdBkPBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-PPVmnNFJMmyEKK0zcP4YPA-1; Wed, 29 Jan 2020 16:24:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B29E7800D4E;
 Wed, 29 Jan 2020 21:24:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B4760BF3;
 Wed, 29 Jan 2020 21:24:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/29] tests/acceptance: Use 'version-min' tag to verify
 QEMU binary version
Date: Wed, 29 Jan 2020 22:23:20 +0100
Message-Id: <20200129212345.20547-5-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PPVmnNFJMmyEKK0zcP4YPA-1
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

Introduce the 'version-min' tag.
Tests can set it to the minimum version of QEMU they require.
If QEMU is older, the tests will be cancelled (skipped):

  $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_model_versi=
ons.py
   (01/11) X86CPUModelAliases.test_4_0_alias_compatibility: CANCEL: Test ex=
pects version '4.1' but QEMU binary is '3.1.1' (0.10 s)
   (02/11) X86CPUModelAliases.test_4_1_alias: CANCEL: Test expects version =
'4.1' but QEMU binary is '3.1.1' (0.10 s)
   (03/11) X86CPUModelAliases.test_none_alias: CANCEL: Test expects version=
 '4.1' but QEMU binary is '3.1.1' (0.10 s)
   ...

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 6618ea67c1..67c75822d5 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -19,6 +19,7 @@ import avocado
 SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..')
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
+from qemu.binutils import binary_get_version
 from qemu.machine import QEMUMachine
=20
 def is_readable_executable_file(path):
@@ -111,6 +112,7 @@ class Test(avocado.Test):
=20
     def setUp(self):
         self._vms =3D {}
+        logger =3D logging.getLogger('core')
=20
         self.arch =3D self.params.get('arch',
                                     default=3Dself._get_unique_tag_val('ar=
ch'))
@@ -118,12 +120,28 @@ class Test(avocado.Test):
         self.machine =3D self.params.get('machine',
                                        default=3Dself._get_unique_tag_val(=
'machine'))
=20
+        # Verify qemu_bin
         default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source tre=
e")
=20
+        # Verify version
+        min_version =3D self._get_unique_tag_val('version-min')
+        logger.debug('version-min: {}'.format(min_version))
+        if min_version:
+            min_v =3D [int(n) for n in min_version.split('.')]
+            if len(min_v) < 3:
+                min_v.append(0)
+            logger.debug(min_v)
+            bin_v =3D binary_get_version(self.qemu_bin)
+            bin_v =3D (bin_v['major'], bin_v['minor'], bin_v['micro'])
+            logger.debug(bin_v)
+            fmt =3D "Test expects version '{}' but QEMU binary is '{}.{}.{=
}'"
+            if bin_v[0] < min_v[0] or bin_v[1] < min_v[1] or bin_v[2] < mi=
n_v[2]:
+                self.cancel(fmt.format(min_version, bin_v[0], bin_v[1], bi=
n_v[2]))
+
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
         if args:
--=20
2.21.1


