Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C880CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D4D222CD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj+9rnRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D4D222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYL8-0004Ei-6c
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRYHJ-0007MT-Px
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRYHF-0002y6-AE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRYHD-0002uu-Dc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572858233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsInyKxAekr/73cu9ypbm4mQK5co9xxqt+ZM3Emg74g=;
 b=Qj+9rnRjuZhZeSTHJ1KTvmEn3anWjE0vMvR51uyVGg2oi3Kwr/Wx1/qBnlUYU6jBtTK7XG
 UCCcDHCcsz88jJUqsKVzNFh3/wrBeeJsmKi+3hArgz5csFXXTXiL1oZzRN1bomDwbxjQgL
 Gp+G/TMT12OqKaQs3pxJNNh8/lZ1qik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-wC-yCm-TMY-w6f8cdh27DA-1; Mon, 04 Nov 2019 04:03:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A9278017E0;
 Mon,  4 Nov 2019 09:03:51 +0000 (UTC)
Received: from localhost (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F160A60BF1;
 Mon,  4 Nov 2019 09:03:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/5] nvme: fix NSSRS offset in CAP register
Date: Mon,  4 Nov 2019 10:03:43 +0100
Message-Id: <20191104090347.27278-2-mreitz@redhat.com>
In-Reply-To: <20191104090347.27278-1-mreitz@redhat.com>
References: <20191104090347.27278-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wC-yCm-TMY-w6f8cdh27DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

From: Klaus Jensen <its@irrelevant.dk>

Fix the offset of the NSSRS field the CAP register.

From NVME 1.4, section 3 ("Controller Registers"), subsection 3.1.1
("Offset 0h: CAP =E2=80=93 Controller Capabilities") CAP_NSSRS_SHIFT is bit=
 36,
not 33.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reported-by: Javier Gonzalez <javier.gonz@samsung.com>
Message-id: 20191023073315.446534-1-its@irrelevant.dk
Reviewed-by: John Snow <jsnow@redhat.com>
[mreitz: Added John's note on the location in the specification where
         this information can be found]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index ab5943b90a..8fb941c653 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -23,7 +23,7 @@ enum NvmeCapShift {
     CAP_AMS_SHIFT      =3D 17,
     CAP_TO_SHIFT       =3D 24,
     CAP_DSTRD_SHIFT    =3D 32,
-    CAP_NSSRS_SHIFT    =3D 33,
+    CAP_NSSRS_SHIFT    =3D 36,
     CAP_CSS_SHIFT      =3D 37,
     CAP_MPSMIN_SHIFT   =3D 48,
     CAP_MPSMAX_SHIFT   =3D 52,
--=20
2.21.0


