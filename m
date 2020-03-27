Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75596C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC42206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf0FOyM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC42206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqoS-0001r5-B6
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHqmH-0006qR-My
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHqmG-00050P-Ic
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHqmG-0004zi-Es
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585322408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yUy2od8jmlo+ij62SPFyh2R7CK8Hv7caNbM0yYSL4M=;
 b=Yf0FOyM197E5OVdsNRoanUIyGVittRZink23Rj1bxKZV/SB0XaKgoKu0DN/barU4jeLCpA
 Tw9Hk2rh0uU+IasgPHeOTPiWrx7gxRR0PuqBb3F6VjvB0uDWp408SXHwLaN/RNtENb1dtR
 LSER3IJQjaWBFCSjRrn63fTs4zhxPyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-FKllr7WSNGih7SbO-mS-Zw-1; Fri, 27 Mar 2020 11:20:06 -0400
X-MC-Unique: FKllr7WSNGih7SbO-mS-Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE40A800D50;
 Fri, 27 Mar 2020 15:20:04 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AE83177E5;
 Fri, 27 Mar 2020 15:20:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/6] block/iscsi:use the flags in iscsi_open() prevent Clang
 warning
Date: Fri, 27 Mar 2020 16:19:45 +0100
Message-Id: <20200327151950.11820-2-kwolf@redhat.com>
In-Reply-To: <20200327151950.11820-1-kwolf@redhat.com>
References: <20200327151950.11820-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
  block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
        flags &=3D ~BDRV_O_RDWR;
        ^        ~~~~~~~~~~~~

In iscsi_allocmap_init() only checks BDRV_O_NOCACHE, which
is the same in both of flags and bs->open_flags.
We can use the flags instead bs->open_flags to prevent Clang warning.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 14680a436a..4e216bd8aa 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2002,7 +2002,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *op=
tions, int flags,
         iscsilun->cluster_size =3D iscsilun->bl.opt_unmap_gran *
             iscsilun->block_size;
         if (iscsilun->lbprz) {
-            ret =3D iscsi_allocmap_init(iscsilun, bs->open_flags);
+            ret =3D iscsi_allocmap_init(iscsilun, flags);
         }
     }
=20
--=20
2.20.1


