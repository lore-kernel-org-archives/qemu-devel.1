Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D966CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E558620650
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv5QpqkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E558620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQD8A-0002nS-HW
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iQCpO-0000ZA-F9
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iQCpF-0006PD-V5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:57:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iQCp9-00069o-9F
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572537441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+NM7HWVHxJZ+ttHkoCdCSjlCRrEoF0BTh7WTKEIwrs=;
 b=Sv5QpqkYlImwzUXN+kYBGFrrcZjPPu5gNoSWWNxtUXdrVsg+A42pcQonaWN9+BHEEbfEcW
 I09mncETiGVsw73zaGKi8LNVYJPDogeOYTQANJPjoQHXMUUSDJyVsIvyj1UxZejCLPVLJs
 V6dA0CaSEbpOezYmWFfSNzKEZRaHUqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-9IgWykr5Oe2kaeCZITMCVA-1; Thu, 31 Oct 2019 11:57:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB9526A6;
 Thu, 31 Oct 2019 15:57:16 +0000 (UTC)
Received: from probe.redhat.com (ovpn-126-19.rdu2.redhat.com [10.10.126.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EDA2600CE;
 Thu, 31 Oct 2019 15:56:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 1/9] IDE: deprecate ide-drive
Date: Thu, 31 Oct 2019 11:56:28 -0400
Message-Id: <20191031155636.18589-2-jsnow@redhat.com>
In-Reply-To: <20191031155636.18589-1-jsnow@redhat.com>
References: <20191031155636.18589-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9IgWykr5Oe2kaeCZITMCVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's an old compatibility shim that just delegates to ide-cd or ide-hd.
I'd like to refactor these some day, and getting rid of the super-object
will make that easier.

Either way, we don't need this.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
ACKed-by: Peter Krempa <pkrempa@redhat.com>
Message-id: 20191009224303.10232-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-deprecated.texi          | 5 +++++
 hw/ide/qdev.c                 | 3 +++
 tests/qemu-iotests/051.pc.out | 6 ++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index f727bd3932..296bfc93a3 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -254,6 +254,11 @@ quite a bit. It will be removed without replacement un=
less some users speaks
 up at the @email{qemu-devel@@nongnu.org} mailing list with information abo=
ut
 their usecases.
=20
+@subsection ide-drive (since 4.2)
+
+The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
+'ide-cd' as appropriate to get an IDE hard disk or CD-ROM as needed.
+
 @section System emulator machines
=20
 @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b8..3666e59721 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -279,6 +279,9 @@ static void ide_drive_realize(IDEDevice *dev, Error **e=
rrp)
 {
     DriveInfo *dinfo =3D NULL;
=20
+    warn_report("'ide-drive' is deprecated, "
+                "please use 'ide-hd' or 'ide-cd' instead");
+
     if (dev->conf.blk) {
         dinfo =3D blk_legacy_dinfo(dev->conf.blk);
     }
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 000557c7c8..34849dd172 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -158,7 +158,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device ide-drive,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: Device needs media, but =
drive is empty
+(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: warning: 'ide-drive' is =
deprecated, please use 'ide-hd' or 'ide-cd' instead
+QEMU_PROG: -device ide-drive,drive=3Ddisk: Device needs media, but drive i=
s empty
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device ide-hd,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -228,7 +229,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddisk,readonly=3Don =
-device ide-drive,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: Block node is read-only
+(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: warning: 'ide-drive' is =
deprecated, please use 'ide-hd' or 'ide-cd' instead
+QEMU_PROG: -device ide-drive,drive=3Ddisk: Block node is read-only
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddisk,readonly=3Don =
-device ide-hd,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
--=20
2.21.0


