Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F0D20663
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efGkBJRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F0D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu4sL-0005BK-C7
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 20:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iu4oW-0001CE-Pj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iu4oV-0004Ms-H8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iu4oV-0004MW-Do
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579656490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOT9TfIeQEVy/0w6maL3TiaNhLxc1wdsdkJGKUIqTn4=;
 b=efGkBJRyDotTA2O9Q6LsKjlO6hMe2pHe3BEymchVlfquob7ojKl00RUOxacbWMI7b8k2JT
 A0pp8JL6R+sPzni3Xu4RvdFhbOHM4BEK9m2eE1lMG2IzwBPAI1Ylg7AXRPEmt10ScaFhLD
 cUh5N4wf91UGgzpJQeYJyx/k8SIoJ6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-YNPIP5lhP1SGgW3PNmxXSg-1; Tue, 21 Jan 2020 20:28:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34EA48010D7;
 Wed, 22 Jan 2020 01:28:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-78.gru2.redhat.com
 [10.97.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9A8985733;
 Wed, 22 Jan 2020 01:28:02 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] tests/acceptance: avocado_qemu: Introduce the 'accel'
 test parameter
Date: Tue, 21 Jan 2020 22:27:50 -0300
Message-Id: <20200122012753.9846-2-wainersm@redhat.com>
In-Reply-To: <20200122012753.9846-1-wainersm@redhat.com>
References: <20200122012753.9846-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: YNPIP5lhP1SGgW3PNmxXSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: philmd@redhat.com, thuth@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test case may need to boot the VM with an accelerator that
isn't actually enabled on the QEMU binary and/or present in the host. In
this case the test behavior is undefined, and the best course of
action is to skip its execution.

This change introduced the 'accel' parameter (and the handler of
tag with same name) used to indicate the test case requires a
given accelerator available. It was implemented a mechanism to
skip the test case if the accelerator is not available. Moreover,
 the QEMU -accel argument is set automatically to any VM
launched if the parameter is present.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 docs/devel/testing.rst                    | 16 ++++++++++++++++
 tests/acceptance/avocado_qemu/__init__.py | 23 +++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index ab5be0c729..d17d0e90aa 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -759,6 +759,17 @@ name.  If one is not given explicitly, it will either =
be set to
 ``None``, or, if the test is tagged with one (and only one)
 ``:avocado: tags=3Dmachine:VALUE`` tag, it will be set to ``VALUE``.
=20
+accel
+~~~~~
+The accelerator that will be set to all QEMUMachine instances created
+by the test.
+
+The ``accel`` attribute will be set to the test parameter of the same
+name.  If one is not given explicitly, it will either be set to
+``None``, or, if the test is tagged with one (and only one)
+``:avocado: tags=3Daccel:VALUE`` tag, it will be set to ``VALUE``. Current=
ly
+``VALUE`` should be either ``kvm`` or ``tcg``.
+
 qemu_bin
 ~~~~~~~~
=20
@@ -800,6 +811,11 @@ machine
 The machine type that will be set to all QEMUMachine instances created
 by the test.
=20
+accel
+~~~~~
+The accelerator that will be set to all QEMUMachine instances created
+by the test. In case the accelerator is not available (both QEMU
+binary and the host system are checked) then the test is canceled.
=20
 qemu_bin
 ~~~~~~~~
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 6618ea67c1..c83a75ccbc 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), =
'..', '..', '..')
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
 from qemu.machine import QEMUMachine
+from qemu.accel import kvm_available, tcg_available
=20
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
@@ -111,6 +112,8 @@ class Test(avocado.Test):
=20
     def setUp(self):
         self._vms =3D {}
+        # VM argumments that are mapped from parameters
+        self._param_to_vm_args =3D []
=20
         self.arch =3D self.params.get('arch',
                                     default=3Dself._get_unique_tag_val('ar=
ch'))
@@ -124,10 +127,30 @@ class Test(avocado.Test):
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source tre=
e")
=20
+        self.accel =3D self.params.get('accel',
+                                     default=3Dself._get_unique_tag_val('a=
ccel'))
+        if self.accel:
+            avail =3D False
+            if self.accel =3D=3D 'kvm':
+                if kvm_available(self.arch, self.qemu_bin):
+                    avail =3D True
+            elif self.accel =3D=3D 'tcg':
+                if tcg_available(self.qemu_bin):
+                    avail =3D True
+            else:
+                self.cancel("Unknown accelerator: %s" % self.accel)
+
+            if avail:
+                self._param_to_vm_args.extend(['-accel', self.accel])
+            else:
+                self.cancel("%s is not available" % self.accel)
+
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
         if args:
             vm.add_args(*args)
+        if self._param_to_vm_args:
+            vm.add_args(*self._param_to_vm_args)
         return vm
=20
     @property
--=20
2.23.0


