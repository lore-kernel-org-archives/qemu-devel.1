Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98441C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6780E2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e43EX67a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6780E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTzA-0004EI-US
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbo-0007bs-K4
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbn-000110-Bo
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbn-00010b-7m
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7Akc2g6+ZtezNqGf6u4OHmfIRFxxk2IeHyU8NufqK0=;
 b=e43EX67ag8de1a1a4LkTXtPq07dSNAEgYDpgNWB5OZvVMD0IyMjHwXlcPM5eeXkNCEXQ8G
 VL1oM759bN6alDN9Gxh7HgjZtODbdSUULFhxBKTbGpz81n5PMvmNvOrdBWG11preREdyUP
 1N4tB99o1B1NRH7RCtWWUCurMlPlaN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-gGjyLUidPF2vshOLloWtUA-1; Mon, 06 Jan 2020 09:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 382CC976E6;
 Mon,  6 Jan 2020 14:43:52 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0236100164D;
 Mon,  6 Jan 2020 14:43:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 33/34] tests/qemu-iotests: Update tests to recent desugarized
 -accel option
Date: Mon,  6 Jan 2020 15:42:05 +0100
Message-Id: <20200106144206.698920-34-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: gGjyLUidPF2vshOLloWtUA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Commit 6f6e1698a6 desugarized "-machine accel=3D" to a list
of "-accel" options. Since now "-machine accel" and "-accel"
became incompatible, update the iotests to the new format.

Error reported here:
https://gitlab.com/qemu-project/qemu/-/jobs/385801004#L3400

Reported-by: GitLab CI
Fixes: 6f6e1698a6 (vl: configure accelerators from -accel options)
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200106130951.29873-1-philmd@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
2.24.1


