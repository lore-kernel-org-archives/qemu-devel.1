Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6DDC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023E520719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADjJJwxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023E520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGibv-0000sw-6V
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGiYN-0004EI-0F
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGiYL-0007w0-S8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGiYL-0007vd-Nb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585052465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llLnMhmoG5TK4ynfnTg6oU3Z5gaat0F1SGVz2j1BGnI=;
 b=ADjJJwxlHaDYsZU6RTV8+GcLZLB8vQ45PzT6dvnCizxksLCI+xeE6aWZiPRkejJ1kclIiC
 144CssLcFgjRN05B5DuY0XifuNiZ8gOyNJwQ9sVuMpkCBguOPzS5cHN8wDiHDEvZapJ82i
 yO37zt4u98a+ad45sJZpYyoGQZz5tAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-JYgGq_RtMy2TOqkX2CgoiA-1; Tue, 24 Mar 2020 08:21:00 -0400
X-MC-Unique: JYgGq_RtMy2TOqkX2CgoiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2FC718A8C86;
 Tue, 24 Mar 2020 12:20:59 +0000 (UTC)
Received: from localhost (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C6DE6EFB4;
 Tue, 24 Mar 2020 12:20:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/6] block/qcow2: zero data_file child after free
Date: Tue, 24 Mar 2020 13:20:42 +0100
Message-Id: <20200324122044.1131326-5-mreitz@redhat.com>
In-Reply-To: <20200324122044.1131326-1-mreitz@redhat.com>
References: <20200324122044.1131326-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

data_file being NULL doesn't seem to be a correct state, but it's
better than dead pointer and simpler to debug.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200316060631.30052-3-vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index e08917ed84..d1da3d91db 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1758,6 +1758,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
     g_free(s->image_data_file);
     if (has_data_file(bs)) {
         bdrv_unref_child(bs, s->data_file);
+        s->data_file =3D NULL;
     }
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
@@ -2621,6 +2622,7 @@ static void qcow2_close(BlockDriverState *bs)
=20
     if (has_data_file(bs)) {
         bdrv_unref_child(bs, s->data_file);
+        s->data_file =3D NULL;
     }
=20
     qcow2_refcount_close(bs);
--=20
2.25.1


