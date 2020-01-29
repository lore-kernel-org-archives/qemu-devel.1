Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0FF20702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO5XyZ/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0FF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwutD-0004ex-I3
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuow-0004ww-5s
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuov-0000B8-1i
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuou-00009p-U5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TkTf8IKWEO91YZjdYAA0yK6hwYHJrVi0nCZl4vTjXw=;
 b=MO5XyZ/xYvAL8AasduyyHtjaOJ41QAJ9SazFr4nQY2l+D7x1FaQtP3bcrNSd3SoXLlmUX0
 tnpfKsIZGi8I7vJAPO66ijImiFOAV4CqC7X4yVHz3/CsG4yUh7vDWZr5bdQCq2lNDXgOaB
 wOhiuZrbbw6OLoCkmLy1WmCAHMrdXyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-3xz-PJ-UNWCu1wroy8cMFg-1; Wed, 29 Jan 2020 16:24:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1747477;
 Wed, 29 Jan 2020 21:24:17 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 029C760BF3;
 Wed, 29 Jan 2020 21:24:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/29] tests/acceptance: Use the 'arch' tag to verify QEMU
 binary target
Date: Wed, 29 Jan 2020 22:23:23 +0100
Message-Id: <20200129212345.20547-8-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3xz-PJ-UNWCu1wroy8cMFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already use the 'arch' tag in Avocado tests. Tests can set
it to restrict their use on a particular target architecture.

If the QEMU binary does not target the required architecture,
the tests will be cancelled (skipped):

  $ avocado --show=3Dapp run tests/acceptance/boot_linux_console.py
   ...
   (14/19) BootLinuxConsole.test_arm_cubieboard_initrd: CANCEL: Test expect=
s arch 'arm' while QEMU binary is targetting 'mips' (0.16 s)
   (15/19) BootLinuxConsole.test_arm_cubieboard_sata: CANCEL: Test expects =
arch 'arm' while QEMU binary is targetting 'mips' (0.18 s)
   (16/19) BootLinuxConsole.test_s390x_s390_ccw_virtio: CANCEL: Test expect=
s arch 's390x' while QEMU binary is targetting 'mips' (0.14 s)
   (17/19) BootLinuxConsole.test_alpha_clipper: CANCEL: Test expects arch '=
alpha' while QEMU binary is targetting 'mips' (0.16 s)
   (18/19) BootLinuxConsole.test_ppc64_pseries: CANCEL: Test expects arch '=
ppc64' while QEMU binary is targetting 'mips' (0.18 s)
   (19/19) BootLinuxConsole.test_m68k_q800: CANCEL: Test expects arch 'm68k=
' while QEMU binary is targetting 'mips' (0.17 s)
  RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 1 | WARN 0 | INTERRUPT 0 | =
CANCEL 16
  JOB TIME   : 19.18 s

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 67c75822d5..e7d5affe24 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -19,6 +19,7 @@ import avocado
 SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..')
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
+from qemu.binutils import binary_get_arch
 from qemu.binutils import binary_get_version
 from qemu.machine import QEMUMachine
=20
@@ -142,6 +143,14 @@ class Test(avocado.Test):
             if bin_v[0] < min_v[0] or bin_v[1] < min_v[1] or bin_v[2] < mi=
n_v[2]:
                 self.cancel(fmt.format(min_version, bin_v[0], bin_v[1], bi=
n_v[2]))
=20
+        # Verify architecture
+        if self.arch:
+            fmt =3D "Test expects arch '{}' while QEMU binary is targettin=
g '{}'"
+            bin_arch =3D binary_get_arch(self.qemu_bin)
+            logger.debug('arch: {}'.format(bin_arch))
+            if bin_arch !=3D self.arch:
+                self.cancel(fmt.format(self.arch, bin_arch))
+
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin, sock_dir=3Dtempfile.mkdtemp())
         if args:
--=20
2.21.1


