Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA381C10F27
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABCE206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCMrkPbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABCE206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADiQ-0006Tj-U1
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jADg5-0004EI-D1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jADg3-000583-Ly
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:10:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jADg3-0004wh-Ft
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583503810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6wTx/SThJXVQqxA5FUIUhCEZEZq2CCcCIE0lZF8yY8=;
 b=JCMrkPbEp6wqRU3SPTNihbyvz4LxZGPE1p5ngy2Bs4fZHcemPlDXgRC/1exX53gRfj1uKC
 RREEwO2mlFI70w2jIUiJwyKvF7EDZyafkT/ZfM8O7X+lWWPGyfFBAsbRBYk25mKb0XQBcz
 dsJe0AN8PC6aN8YUV6lnuRn4fLbmaa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-mK25w3lrM1WsPDmkI3O1BQ-1; Fri, 06 Mar 2020 09:10:08 -0500
X-MC-Unique: mK25w3lrM1WsPDmkI3O1BQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 612351403;
 Fri,  6 Mar 2020 14:10:07 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2426060C80;
 Fri,  6 Mar 2020 14:10:05 +0000 (UTC)
Date: Fri, 6 Mar 2020 15:10:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 2/2] block: bdrv_reopen() with backing file in different
 AioContext
Message-ID: <20200306141003.GD7240@linux.fritz.box>
References: <20200227181804.15299-1-kwolf@redhat.com>
 <20200227181804.15299-3-kwolf@redhat.com>
 <w51h7z27q68.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51h7z27q68.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.03.2020 um 16:54 hat Alberto Garcia geschrieben:
> On Thu 27 Feb 2020 07:18:04 PM CET, Kevin Wolf wrote:
> >      /*
> > -     * TODO: before removing the x- prefix from x-blockdev-reopen we
> > -     * should move the new backing file into the right AioContext
> > -     * instead of returning an error.
> > +     * Check AioContext compatibility so that the bdrv_set_backing_hd(=
) call in
> > +     * bdrv_reopen_commit() won't fail.
> >       */
> > -    if (new_backing_bs) {
> > -        if (bdrv_get_aio_context(new_backing_bs) !=3D bdrv_get_aio_con=
text(bs)) {
> > -            error_setg(errp, "Cannot use a new backing file "
> > -                       "with a different AioContext");
> > -            return -EINVAL;
> > -        }
> > +    if (!bdrv_reopen_can_attach(bs->backing, bs, new_backing_bs, errp)=
) {
> > +        return -EINVAL;
> >      }
>=20
> What happens here now if 'new_backing_bs' is NULL ?
>=20
> It seems that you would be calling bdrv_can_set_aio_context(NULL, ...),
> and it looks like that would crash.

Not sure why I thought that this check isn't needed any more...

It actually works as long as everything runs in the main loop context
(because bdrv_get_aio_context(NULL) return the main context, so there is
nothing to do), which is why the test cases didn't fail. But as soon as
you move things to a different AioContext, they will fail.

Maybe even worse, the argument order for bdrv_reopen_can_attach() is
wrong.

Thanks for catching this, I'll send a v2.

Kevin


