Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910CCC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A98E21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMB223gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A98E21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahFa-0002bG-Iw
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iagGt-0001qF-5o
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iagGm-00030m-Pl
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:25:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iagGm-0002rt-L8
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575033910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpxFHVC8E91nqUnfcfwRGjky6likEvIkzcRJZv0IuRo=;
 b=QMB223gC60bfrTOW+1ISBBMOxONVTtrs9hvDmVQWvCkm5X3Q87QoEbT4xiW5poeC/0CBAi
 fiQ87YzAQnKZWwytB88pVoO3nc6wGYHB1+paa595Imi+ckgLwRzRdb8pP+IsXx992P7OaM
 Lup3HR81X8qaYHG70W5WC4B5O7q/BvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-yBz22K3hNc6TRX-cTCKgfw-1; Fri, 29 Nov 2019 08:25:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D807107ACC7;
 Fri, 29 Nov 2019 13:25:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B1585C297;
 Fri, 29 Nov 2019 13:25:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CBCC1138606; Fri, 29 Nov 2019 14:25:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
References: <20191127190840.15773-1-vsementsov@virtuozzo.com>
Date: Fri, 29 Nov 2019 14:25:06 +0100
In-Reply-To: <20191127190840.15773-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 27 Nov 2019 22:08:40 +0300")
Message-ID: <878snyu85p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: yBz22K3hNc6TRX-cTCKgfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Make nbd_iter_channel_error errp handler well formed:
> rename local_err to errp_in, as it is IN-parameter here (which is
> unusual for Error**).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>
> v6: fix commit message
>     add Eric's r-b
>
>  block/nbd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/block/nbd.c b/block/nbd.c
> index 5f18f78a94..345bf902e3 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -864,18 +864,18 @@ typedef struct NBDReplyChunkIter {
>  } NBDReplyChunkIter;
> =20
>  static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
> -                                   int ret, Error **local_err)
> +                                   int ret, Error **errp_in)
>  {
> -    assert(ret < 0);
> +    assert(ret < 0 && errp_in && *errp_in);
> =20
>      if (!iter->ret) {
>          iter->ret =3D ret;
> -        error_propagate(&iter->err, *local_err);
> +        error_propagate(&iter->err, *errp_in);
>      } else {
> -        error_free(*local_err);
> +        error_free(*errp_in);
>      }
> =20
> -    *local_err =3D NULL;
> +    *errp_in =3D NULL;

This one is actually in/out.

If we use the convention

    Any Error ** parameter meant for passing an error to the caller must
    be named @errp.  No other Error ** parameter may be named @errp.

then the old name is as good as the new one.  But the new one's "in"
suggestion is misleading.

>  }
> =20
>  static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)


