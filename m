Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68469C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340E52146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KboSgGoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340E52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44187 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyTZ-0003UG-RK
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ihySD-0002Mh-8u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ihyS9-0001cu-Pn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:15:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ihyS9-0001ZV-J6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576772104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+bGGSfDG4BXgbPwGORThGyXrz3Cw31EQTo7i1ymPrE=;
 b=KboSgGoai26IsVLbpCPsnzfotPzlMp7WWwOkgZbWKWlaAtXCYa7ct/oVuajbX6lcC5eWTa
 540WEf3ogbe6jhk3Wr8oTX9kxkvSCMA4n7Re6+0/bxlIG9Uk9TKw2QoI+xXyiV/MzTnejB
 o4D2UtO9Pn4vxADPuDGComIY5os5W0M=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-DLZgbtT6P3W5QrzW5r637w-1; Thu, 19 Dec 2019 11:15:02 -0500
Received: by mail-oi1-f198.google.com with SMTP id m7so3008387oim.14
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 08:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PC+km+KrYjCiOegQvZeOGv2pUZ8zFieculUSdFYM98I=;
 b=uGZ9pwG27W5KZqyO4ORyM7M4QzmTfk3D9pdkZDGxClIa8mBvc4LEYDaj2zKo7mb2IR
 /1y/YnEAkUtFIuCVYZB2HuIelxUYRGUUzT/DTbt9aZYSsJA7uQw50/JSCX8WRz8Ka8Wh
 Oa9Gn0kISiahb4B8Kan16Jb9QJbwliw8wrUnVm3kM+Q+EeKATF4o/gdDhJ5xKZPJr5e9
 MsAqleshZVJwN9cqYkBpgdvCYisOg8Ad7HXUc1LLnvGzXMTz57q1KoVMBv9NeRKX6X3H
 67fR6N1qgmzqdyAq6w+Nnf/fZq0XUa5zPJdAY3lamCDghoZUu4NeIE/jR552jfsO0COv
 R5CA==
X-Gm-Message-State: APjAAAUlZXHoTuuJHfhaJlPLogTZrwqzWM8w/05FMPwBl/njGrmMrn+U
 xNIllTCF0EW5IGD9vxjI3oukHgWWn31wJzJK1TqEpUYY1LRlgUnwRLilhLW5FEMn1MDf/5nzQ3V
 k78pWl4pILwb2FIp/q+HouirA0n1wE2E=
X-Received: by 2002:a9d:5885:: with SMTP id x5mr9380326otg.132.1576772100104; 
 Thu, 19 Dec 2019 08:15:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwV9yAPvdpePCpprHpOA055cuQSnjBdP593totXfNTNZi2tzEFmQL68KN+WYJjjaEg3sys8LJ+MCd/vA70xN8=
X-Received: by 2002:a9d:5885:: with SMTP id x5mr9380283otg.132.1576772099592; 
 Thu, 19 Dec 2019 08:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
 <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
 <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
 <0d6ea2fe-2f4f-00d4-2f13-20591b56310d@virtuozzo.com>
In-Reply-To: <0d6ea2fe-2f4f-00d4-2f13-20591b56310d@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 19 Dec 2019 18:14:43 +0200
Message-ID: <CAMRbyys6na7S4q00VR81LNhfNvtEXUAFQV=2R1O506+p_U+VKA@mail.gmail.com>
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-MC-Unique: DLZgbtT6P3W5QrzW5r637w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 5:25 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 19.12.2019 18:08, Nir Soffer wrote:
> > On Thu, Dec 19, 2019 at 5:00 PM Vladimir Sementsov-Ogievskiy
> > <vsementsov@virtuozzo.com> wrote:
> >>
> >> 19.12.2019 17:42, Nir Soffer wrote:
> >>> On Thu, Dec 19, 2019 at 4:34 PM Vladimir Sementsov-Ogievskiy
> >>> <vsementsov@virtuozzo.com> wrote:
> >>>>
> >>>> "NAME" here may be interpreted like it should match @name, which is
> >>>> export name. But it was never mentioned in such way. Make it obvious=
,
> >>>> that actual "<dirty-bitmap-export-name>" (see docs/interop/nbd.txt)
> >>>> will match @bitmap parameter.
> >>>
> >>> But this is wrong, dirty-bitmap-export-name does not mean the actual =
bitmap
> >>> name but the name exposed to the NBD client, which can be anything.
> >>
> >> Yes. What is wrong? It can be enything. Currently by default it is bit=
map name.
> >> It purely documented (okay, even confusingly documented), but it was s=
o since
> >> 4.0. And existing users obviously knows how it work (otherwise, they c=
an't use
> >> the feature)
> >>
> >> So, I think it's OK to fix spec to directly show implementation, that =
was here
> >> since feature introducing.
> >>
> >>>
> >>>> Fixes: 5fcbeb06812685a2
> >>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
> >>>> ---
> >>>>
> >>>> Hi all.
> >>>>
> >>>> This patch follows discussion on Nir's patch
> >>>>    [PATCH] block: nbd: Fix dirty bitmap context name
> >>>>    ( https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04309.=
html )
> >>>>
> >>>> Let's just fix qapi spec now.
> >>>
> >>> But qapi documents a better behavior for users. We should fix the cod=
e instead
> >>> to mach the docs.
> >>
> >> 1. Using disk name as a bitmap name is a bad behavior, as they are com=
pletely
> >> different concepts. Especially keeping in mind that user already knows=
 disk name anyway
> >> and no reason to write this export name inside metadata context of thi=
s export.
> >
> > The different concept is expressed by the "qemu:dirty-bitmap:" prefix.
> > "qemu:dirty-bitmap:export-name" means the dirty bitmap for this export.
>
> Why do you think so? Did you read NBD specification?

Yes - the name of the bitmap does not have any meaning.
But for nbd_server_add we allow only single bitmap for export.

> Metadata context is always owned by some export.

Of course.

> Do you mean that there will bemetadata contexts
>
> qemu:dirty-bitmap:export-A
> qemu:dirty-bitmap:export-B
>
> both defined for export-A?

It does not make sense, but it is valid.

> >> 2. It's not directly documented. You assume that NAME =3D=3D @name. I =
understand that
> >> it may be assumed.. But it's not documented.
> >
> > But NAME is likely to be understood as the name argument, and unlikely =
to be the
> > bitmap name.
>
> Yes likely. But it's still bad specification, which should be fixed.

If we cannot change the current behavior since it will break current users,
I agree fixing the spec to describe the current behavior is a good idea.




> >
> >> 3. It's never worked like you write. So if we change the behavior, we'=
ll break
> >> existing users.
> >
> > Do we have existing users? isn't this new feature in 4.2?
>
> No, it's since 4.0
>
> >
> > Before we had experimental x-block-dirty-bitmap APIs, which are stable,=
 so users
> > could not depend on them.
> >
> >>> With this we still have the issue of leaking internal bitmap name to
> >>> users who do not
> >>> control the name, and do not care about it.
> >>>
> >>>>    qapi/block.json | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/qapi/block.json b/qapi/block.json
> >>>> index 145c268bb6..8042ef78f0 100644
> >>>> --- a/qapi/block.json
> >>>> +++ b/qapi/block.json
> >>>> @@ -255,7 +255,8 @@
> >>>>
> >>>>    # @bitmap: Also export the dirty bitmap reachable from @device, s=
o the
> >>>>    #          NBD client can use NBD_OPT_SET_META_CONTEXT with
> >>>> -#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4=
.0)
> >>>> +#          "qemu:dirty-bitmap:BITMAP" to inspect the bitmap (BITMAP=
 here
> >>>> +#          matches @bitmap parameter). (since 4.0)
> >>>>    #
> >>>>    # Returns: error if the server is not running, or export with the=
 same name
> >>>>    #          already exists.
> >>>> --
> >>>> 2.21.0
> >>>>
> >>>
> >>
> >>
> >> --
> >> Best regards,
> >> Vladimir
> >
>
>
> --
> Best regards,
> Vladimir


