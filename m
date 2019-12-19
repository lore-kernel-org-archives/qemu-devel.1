Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13B2227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFHopo5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13B2227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzip-00027O-NR
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzYA-0006gu-IY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzY8-0007Eb-VR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31163)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzY8-0007Bn-DY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLYtGlFVP6cijOFdOLP8wtUjEOb634rB639PnlrYs2w=;
 b=XFHopo5LYQopp4zYdn9a8JqbcxHf2oe7br+AEHH/9Kq7wEdK10fyzSrDqEcm1Z2ExNlJgc
 Q5Gif4tRE4YyN1BH/nYqRVC3Nh9e4N33Z0PLK1HD0R17CI1snKEP3qlTaUklY8ExmYuY1q
 2qG2ASlVanuDyNQ5URqjGqz29q0EKyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-d61iplFHMViCSKIShih1fg-1; Thu, 19 Dec 2019 12:25:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A05B4801E72;
 Thu, 19 Dec 2019 17:25:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3DD620C0;
 Thu, 19 Dec 2019 17:25:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/30] qcow2: Move error check of local_err near its assignment
Date: Thu, 19 Dec 2019 18:24:28 +0100
Message-Id: <20191219172441.7289-18-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: d61iplFHMViCSKIShih1fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tuguoyi <tu.guoyi@h3c.com>

The local_err check outside of the if block was necessary
when it was introduced in commit d1258dd0c87 because it needed to be
executed even if qcow2_load_autoloading_dirty_bitmaps() returned false.

After some modifications that all required the error check to remain
where it is, commit 9c98f145dfb finally moved the
qcow2_load_dirty_bitmaps() call into the if block, so now the error
check should be there, too.

Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 375bbd0ad3..7fbaac8457 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1705,14 +1705,14 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
     if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
         /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer.=
 */
         bool header_updated =3D qcow2_load_dirty_bitmaps(bs, &local_err);
+        if (local_err !=3D NULL) {
+            error_propagate(errp, local_err);
+            ret =3D -EINVAL;
+            goto fail;
+        }
=20
         update_header =3D update_header && !header_updated;
     }
-    if (local_err !=3D NULL) {
-        error_propagate(errp, local_err);
-        ret =3D -EINVAL;
-        goto fail;
-    }
=20
     if (update_header) {
         ret =3D qcow2_update_header(bs);
--=20
2.20.1


