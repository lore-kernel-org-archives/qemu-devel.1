Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF3C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4372071A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcptzwCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4372071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioS9q-00042J-Ij
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 08:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioS94-00036Z-Hp
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioS91-0007l4-2j
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:10:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioS90-0007jE-Ox
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578316205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EBJo5O2O6f9hi2tJc2mLTcCl2pbwneP09KgrZui8rzk=;
 b=fcptzwCB0/OGBfLF4l4VEqoRZSFgdy8We+H9K6foyxxKbVwSg9uYHAVjhwes2zD47y8aDF
 M6E+z/a5iT0hUkFChiz3/jvDGT1V+0nqQSi9Dg2Bn/mGAmjqrAA1oFPPIfYAfTQONQqnD8
 +OnON40K+HilAvNInuBRn/zWY62eJ74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-ME8v3rAtMKyzE-EUKCmp1A-1; Mon, 06 Jan 2020 08:10:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD06E800D41;
 Mon,  6 Jan 2020 13:10:02 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 847C81C4;
 Mon,  6 Jan 2020 13:09:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qemu-iotests: Update tests to recent desugarized -accel
 option
Date: Mon,  6 Jan 2020 14:09:51 +0100
Message-Id: <20200106130951.29873-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ME8v3rAtMKyzE-EUKCmp1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 6f6e1698a6 desugarized "-machine accel=3D" to a list
of "-accel" options. Since now "-machine accel" and "-accel"
became incompatible, update the iotests to the new format.

Error reported here:
https://gitlab.com/qemu-project/qemu/-/jobs/385801004#L3400

Reported-by: GitLab CI
Fixes: 6f6e1698a6 (vl: configure accelerators from -accel options)
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/235   | 2 +-
 tests/qemu-iotests/check | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index fedd111fd4..3d7533980d 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,7 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocatio=
n=3Dmetadata', disk,
                 str(size))
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=3Dkvm:tcg')
+vm.add_args('-accel', 'kvm', '-accel', 'tcg')
 if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
         vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 90970b0549..2890785a10 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -587,13 +587,13 @@ export QEMU_PROG=3D"$(type -p "$QEMU_PROG")"
=20
 case "$QEMU_PROG" in
     *qemu-system-arm|*qemu-system-aarch64)
-        export QEMU_OPTIONS=3D"-nodefaults -display none -machine virt,acc=
el=3Dqtest"
+        export QEMU_OPTIONS=3D"-nodefaults -display none -machine virt -ac=
cel qtest"
         ;;
     *qemu-system-tricore)
-        export QEMU_OPTIONS=3D"-nodefaults -display none -machine tricore_=
testboard,accel=3Dqtest"
+        export QEMU_OPTIONS=3D"-nodefaults -display none -machine tricore_=
testboard -accel qtest"
         ;;
     *)
-        export QEMU_OPTIONS=3D"-nodefaults -display none -machine accel=3D=
qtest"
+        export QEMU_OPTIONS=3D"-nodefaults -display none -accel qtest"
         ;;
 esac
=20
--=20
2.21.1


