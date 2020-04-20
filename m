Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFEAC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF17206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0kSH/DT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF17206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYRF-00022p-BS
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35130 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQYPR-0000z8-Ib
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:32:35 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQYPO-0006wI-Ti
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:32:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21210
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jQYPO-0006vl-Fl
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587396748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkYoJLMhFe831WaPmjs/tZKs9zrGbs6bmQbrWP7cnAc=;
 b=d0kSH/DTGgFLAdBcgF1CH2ELCldOmMP2Wtd7L9o7tUN8KvZy6/uvNhektkBarL0pSso3Cj
 xi4msy1K2RMeuA3tuJeS4a8OCDdGQxB03tKS0aF/z+rbpBFemoH3VEIzZF8b1jZ3tCXhFT
 JWUmdCwnMkxwBnFcimRjeyxBmzUeI8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-dsUcebXdMR-dwrtNmK1qpQ-1; Mon, 20 Apr 2020 11:32:26 -0400
X-MC-Unique: dsUcebXdMR-dwrtNmK1qpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 870D1113784A;
 Mon, 20 Apr 2020 15:32:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38B9FA188B;
 Mon, 20 Apr 2020 15:32:19 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:32:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 5/9] raw-format: Support BDRV_REQ_ZERO_WRITE for
 truncate
Message-ID: <20200420153217.GA29316@linux.fritz.box>
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-6-kwolf@redhat.com>
 <b30bde4c-1ac1-f7cf-0c1f-1e8f52c4c821@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b30bde4c-1ac1-f7cf-0c1f-1e8f52c4c821@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.04.2020 um 17:14 hat Eric Blake geschrieben:
> On 4/20/20 8:32 AM, Kevin Wolf wrote:
> > The raw format driver can simply forward the flag and let its bs->file
> > child take care of actually providing the zeros.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/raw-format.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/block/raw-format.c b/block/raw-format.c
> > index 3465c9a865..ab69ac46d3 100644
> > --- a/block/raw-format.c
> > +++ b/block/raw-format.c
> > @@ -387,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriver=
State *bs, int64_t offset,
> >       s->size =3D offset;
> >       offset +=3D s->offset;
> > -    return bdrv_co_truncate(bs->file, offset, exact, prealloc, 0, errp=
);
> > +    return bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, =
errp);
> >   }
> >   static void raw_eject(BlockDriverState *bs, bool eject_flag)
> > @@ -445,6 +445,7 @@ static int raw_open(BlockDriverState *bs, QDict *op=
tions, int flags,
> >       bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
> >           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
> >               bs->file->bs->supported_zero_flags);
> > +    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
>=20
> Shouldn't this be:
>=20
> bs->supported_truncate_flags =3D (bs->file->bs->supported_truncate_flags =
&
>                                 BDRV_REQ_ZERO_WRITE);
>=20
> rather than unconditionally advertising something that the underlying lay=
er
> may lack?

Maybe that makes more sense, yes.

I think in practice it wouldn't make a difference because the nested
bdrv_co_truncate() would still fail rather than silently ignoring the
flag. It would behave the same as filter drivers, which also recursively
call bdrv_co_truncate() without checking the flag first (which is, of
course, because I don't want to modify each filter driver).

Kevin


