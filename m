Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9FCC2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519AD2074F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBjOtcEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519AD2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpE6-0005yN-II
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLpBf-0000UY-Kf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLpBe-00070T-Dz
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLpBe-000708-Av
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586269606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEOR6aQu29iz80z013fDsdrq8dMvIXpmYtmMVT/1Fck=;
 b=jBjOtcEehXvHLkZcmDxbUO09DM1QMuzQjJij3irEwq73pozQfOMBE94XK1F0Nmx6Aq/P1D
 FC/kw/46Uk6vhIXKUlWCV2oUYXf/KMsZWio/JcWwxxDnKlSHD5Jy54VGWVqQEoSjcFoRXm
 3gUCt/xWD1lTc9XJXNN4KxWiixX3NTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-8mrXYvuROfWlQofSeD2t8g-1; Tue, 07 Apr 2020 10:26:40 -0400
X-MC-Unique: 8mrXYvuROfWlQofSeD2t8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 293438017F4;
 Tue,  7 Apr 2020 14:26:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AEA25DA7B;
 Tue,  7 Apr 2020 14:26:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 7/7] vpc: Don't round up already aligned BAT sizes
Date: Tue,  7 Apr 2020 16:26:16 +0200
Message-Id: <20200407142616.7961-8-kwolf@redhat.com>
In-Reply-To: <20200407142616.7961-1-kwolf@redhat.com>
References: <20200407142616.7961-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As reported on Launchpad, Azure apparently doesn't accept images for
upload that are not both aligned to 1 MB blocks and have a BAT size that
matches the image size exactly.

As far as I can tell, there is no real reason why we create a BAT that
is one entry longer than necessary for aligned image sizes, so change
that.

(Even though the condition is only mentioned as "should" in the spec and
previous products accepted larger BATs - but we'll try to maintain
compatibility with as many of Microsoft's ever-changing interpretations
of the VHD spec as possible.)

Fixes: https://bugs.launchpad.net/bugs/1870098
Reported-by: Tobias Witek
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200402093603.2369-1-kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vpc.c b/block/vpc.c
index 6df75e22dc..d8141b52da 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -835,7 +835,7 @@ static int create_dynamic_disk(BlockBackend *blk, uint8=
_t *buf,
=20
     /* Write the footer (twice: at the beginning and at the end) */
     block_size =3D 0x200000;
-    num_bat_entries =3D (total_sectors + block_size / 512) / (block_size /=
 512);
+    num_bat_entries =3D DIV_ROUND_UP(total_sectors, block_size / 512);
=20
     ret =3D blk_pwrite(blk, offset, buf, HEADER_SIZE, 0);
     if (ret < 0) {
--=20
2.20.1


