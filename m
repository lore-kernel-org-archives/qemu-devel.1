Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA5BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D6D206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWQ6kI/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D6D206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxQW-0001uY-DN
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ihxPr-00018x-7x
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ihxPo-0002MY-7Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:08:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ihxPn-0002Fv-VZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576768114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFE1NLbr/yW0QlmRdLLTBbEPPw0z+39eA1pSAp9s23w=;
 b=jWQ6kI/4LSvnVlm2zo3ctnYljXBDyleg2pOC+punM0UFDN9bE7ne+VnhrlHqbqxS+n/E01
 OP5roV3mm+hA1FFp7DNNSNvkRqZlOXe8cLgMleSfYGRlAJ+1wJ0MrtgkALRgluXgcu00VQ
 rAj8qU8sCyTxpkbPuAc+TL8F3N6ixn8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-579ulRiQPsmc8pvdSu_c2g-1; Thu, 19 Dec 2019 10:08:33 -0500
Received: by mail-oi1-f198.google.com with SMTP id x75so2920333oix.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 07:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GpKUoEzcf97P/ek8Eg9U/eqNNqN5DTx+niP51PTxDWQ=;
 b=Mis2Q7e2YGZsUf0pe4Ej5Ul65ljcEir0qnuNGwKU8Ue5qSm+hJrFOvvH1wbngzll+z
 UyNiD/C3y8HXbA0bo6iwMPHhcoLHxIkFmHLDU1cjHy11UjvhrItfHVCGfy8hpKVJMJwJ
 QkVEvNunBzmhZQub38dUn+cWdO5ZDBvn+6z3wQIHFRAfvabg2s6ZTkPtCGxc2WuDeKN7
 FU83jbPP83GE15vsVJEJhg476rmnfz1I2y+VE0yDxphIY2Px+GMV4IDu8vXimO+PovCK
 0D/VDhfx74ga1cZPcBItexkg5PnK2bCJDepPKUo0N3pdE5uuHhHGwigmodFHGJiBADE1
 SY+g==
X-Gm-Message-State: APjAAAUIPwkUMLflGUAIIbauVIBNjmpNm8E1buJOm2NdjbGsVDdT0z7a
 FdxOs6xaXuBDR01XvDYumN0+vxl1de7lNd26Mo8/hEi8quyxCxjEMHw82A8iXE4fowCjD3djsVB
 AVbenD6W8OylPPdLW0vKyX1NVFEtsjzs=
X-Received: by 2002:a05:6830:68b:: with SMTP id
 q11mr9529587otr.81.1576768111959; 
 Thu, 19 Dec 2019 07:08:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLkRZzj693h+feck7w2+7fSe4ITQAEl8y8TTG5ftqnaI84s0guBimqcPSTseZf+Dg10TIUvEbzus1Bm2D3DBk=
X-Received: by 2002:a05:6830:68b:: with SMTP id
 q11mr9529457otr.81.1576768110648; 
 Thu, 19 Dec 2019 07:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
 <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
In-Reply-To: <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 19 Dec 2019 17:08:14 +0200
Message-ID: <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-MC-Unique: 579ulRiQPsmc8pvdSu_c2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 5:00 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 19.12.2019 17:42, Nir Soffer wrote:
> > On Thu, Dec 19, 2019 at 4:34 PM Vladimir Sementsov-Ogievskiy
> > <vsementsov@virtuozzo.com> wrote:
> >>
> >> "NAME" here may be interpreted like it should match @name, which is
> >> export name. But it was never mentioned in such way. Make it obvious,
> >> that actual "<dirty-bitmap-export-name>" (see docs/interop/nbd.txt)
> >> will match @bitmap parameter.
> >
> > But this is wrong, dirty-bitmap-export-name does not mean the actual bi=
tmap
> > name but the name exposed to the NBD client, which can be anything.
>
> Yes. What is wrong? It can be enything. Currently by default it is bitmap=
 name.
> It purely documented (okay, even confusingly documented), but it was so s=
ince
> 4.0. And existing users obviously knows how it work (otherwise, they can'=
t use
> the feature)
>
> So, I think it's OK to fix spec to directly show implementation, that was=
 here
> since feature introducing.
>
> >
> >> Fixes: 5fcbeb06812685a2
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>
> >> Hi all.
> >>
> >> This patch follows discussion on Nir's patch
> >>   [PATCH] block: nbd: Fix dirty bitmap context name
> >>   ( https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04309.htm=
l )
> >>
> >> Let's just fix qapi spec now.
> >
> > But qapi documents a better behavior for users. We should fix the code =
instead
> > to mach the docs.
>
> 1. Using disk name as a bitmap name is a bad behavior, as they are comple=
tely
> different concepts. Especially keeping in mind that user already knows di=
sk name anyway
> and no reason to write this export name inside metadata context of this e=
xport.

The different concept is expressed by the "qemu:dirty-bitmap:" prefix.
"qemu:dirty-bitmap:export-name" means the dirty bitmap for this export.

> 2. It's not directly documented. You assume that NAME =3D=3D @name. I und=
erstand that
> it may be assumed.. But it's not documented.

But NAME is likely to be understood as the name argument, and unlikely to b=
e the
bitmap name.

> 3. It's never worked like you write. So if we change the behavior, we'll =
break
> existing users.

Do we have existing users? isn't this new feature in 4.2?

Before we had experimental x-block-dirty-bitmap APIs, which are stable, so =
users
could not depend on them.

> > With this we still have the issue of leaking internal bitmap name to
> > users who do not
> > control the name, and do not care about it.
> >
> >>   qapi/block.json | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/qapi/block.json b/qapi/block.json
> >> index 145c268bb6..8042ef78f0 100644
> >> --- a/qapi/block.json
> >> +++ b/qapi/block.json
> >> @@ -255,7 +255,8 @@
> >>
> >>   # @bitmap: Also export the dirty bitmap reachable from @device, so t=
he
> >>   #          NBD client can use NBD_OPT_SET_META_CONTEXT with
> >> -#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0=
)
> >> +#          "qemu:dirty-bitmap:BITMAP" to inspect the bitmap (BITMAP h=
ere
> >> +#          matches @bitmap parameter). (since 4.0)
> >>   #
> >>   # Returns: error if the server is not running, or export with the sa=
me name
> >>   #          already exists.
> >> --
> >> 2.21.0
> >>
> >
>
>
> --
> Best regards,
> Vladimir


