Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0F322525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4KaXaDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0F322525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itbmA-0005Cl-N9
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 13:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casantos@redhat.com>) id 1itblY-0004mQ-Qm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casantos@redhat.com>) id 1itblW-0002FC-IW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:27:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casantos@redhat.com>) id 1itblW-0002Ea-F5
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579544829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFDWd1hMM7dq/m9RKyvQmhqfGJFBaWSC3T5JliV1Bo4=;
 b=K4KaXaDMTUsU0aWnf2MHUQP09Zj8m/SqZGA5G9GAUjv4YXP2RHVxMv/xNoq8rah+6b1ZA1
 wSTc4pKQGgJFgedIQT0qZck0c439yOBd+lNdcMyQove53t3MZSlxmRu8S6NBK8BL2Im/Cu
 FlB55Q/Dn8zrYbJUymxqZJfy5kj3VFE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-_Gyptq5rPWiBPZutPwX9Kg-1; Mon, 20 Jan 2020 13:27:05 -0500
Received: by mail-il1-f200.google.com with SMTP id h87so311539ild.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fI4OzxrzT/3iyJf6v/VMJP4PCHF4RPi/iEC58/3GhIU=;
 b=rh/J/pS/fx3XA0pRjWu0q0QBO6U8zOeDC6v26ydNiSnfO5XAdweEOCCoakOtelUGcm
 kCv1MOTplIMs73athISobnwRW11rW3UQ3wvJrR8v96gDvSlRKMZeP4wEbvMl19ar0xpa
 nWX3nzQY+Z+BlCHpAUnRLZ2yCEt+lrlcTPzjCdqZb7FtJ1csJ7FQ2g8haL5vQPaK6cSC
 zo6051l+OvP5cYlCvsfJTDSQWaoHVxyW5OfjMC9AYFjYJXVbVk4OZx5Hywd2GLUElnRq
 7EX0aWD3KFgtclalWrQLz2S+mrklDyEbBTfJRvd8D+XmoQqRWde0TwNIeLHHwbHZ5dYG
 vqTQ==
X-Gm-Message-State: APjAAAW8MzndmjqHkPdQxKwfjdGrNwR4DiDSfLgHngrJSNkBUToLIsC3
 OpKfDhqwLAMPHZPY0yS+hlNsKvX9l4pppeB0WswcgaziHzs+jMdI74JeL5LbM+RPsMISohZKIua
 q4lCwOa0rzxX3cawLoA43lVBFL4Fnb00=
X-Received: by 2002:a02:c646:: with SMTP id k6mr299630jan.34.1579544825219;
 Mon, 20 Jan 2020 10:27:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxha+n6sUxcsPcuhSgrnoHVmo7N2BsWwJUVfMs15Bw18DtsPz5fKf/LrTppTclrTRdC0MUoMiV1XeWnaNK5PpA=
X-Received: by 2002:a02:c646:: with SMTP id k6mr299619jan.34.1579544824961;
 Mon, 20 Jan 2020 10:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20191017123713.30192-1-casantos@redhat.com>
 <CAFEAcA9dMRBtDs6QSXGVv_bNhtu5wnGKLvMxr2YuoWM=yomGDg@mail.gmail.com>
 <CAC1VKkNr8jN_0qVLtX5-YVH1dgN0fGAvnVZJXUpa+UfG_34ooQ@mail.gmail.com>
 <CAC1VKkPfacdLkXfHVNm-josjtds3Xsj=9NhRfNaQTyRv4XxEfQ@mail.gmail.com>
 <48f341e2-5844-2929-1c38-4ecd26ed8546@linaro.org>
In-Reply-To: <48f341e2-5844-2929-1c38-4ecd26ed8546@linaro.org>
From: Carlos Santos <casantos@redhat.com>
Date: Mon, 20 Jan 2020 15:26:54 -0300
Message-ID: <CAC1VKkMVTWq+xsKRXmsA-U7Uwwq_6iXrFuDP9zdJEoFthg374A@mail.gmail.com>
Subject: Re: [PATCH] util/cacheinfo: fix crash when compiling with uClibc
To: Richard Henderson <richard.henderson@linaro.org>
X-MC-Unique: _Gyptq5rPWiBPZutPwX9Kg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 9:04 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/16/19 1:18 AM, Carlos Santos wrote:
> > On Thu, Oct 17, 2019 at 8:06 PM Carlos Santos <casantos@redhat.com> wro=
te:
> >>
> >> On Thu, Oct 17, 2019 at 9:47 AM Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> >>>
> >>> On Thu, 17 Oct 2019 at 13:39, <casantos@redhat.com> wrote:
> >>>>
> >>>> From: Carlos Santos <casantos@redhat.com>
> >>>>
> >>>> uClibc defines _SC_LEVEL1_ICACHE_LINESIZE and _SC_LEVEL1_DCACHE_LINE=
SIZE
> >>>> but the corresponding sysconf calls returns -1, which is a valid res=
ult,
> >>>> meaning that the limit is indeterminate.
> >>>>
> >>>> Handle this situation using the fallback values instead of crashing =
due
> >>>> to an assertion failure.
> >>>>
> >>>> Signed-off-by: Carlos Santos <casantos@redhat.com>
> >>>> ---
> >>>>  util/cacheinfo.c | 10 ++++++++--
> >>>>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> >>>> index ea6f3e99bf..d94dc6adc8 100644
> >>>> --- a/util/cacheinfo.c
> >>>> +++ b/util/cacheinfo.c
> >>>> @@ -93,10 +93,16 @@ static void sys_cache_info(int *isize, int *dsiz=
e)
> >>>>  static void sys_cache_info(int *isize, int *dsize)
> >>>>  {
> >>>>  # ifdef _SC_LEVEL1_ICACHE_LINESIZE
> >>>> -    *isize =3D sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
> >>>> +    int tmp_isize =3D (int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
> >>>
> >>> Do we need the cast here ?
> >>
> >> It's there to remind the reader that a type coercion may occur, since
> >> sysconf() returns a long and isize is an int.
> >>
> >>>> +    if (tmp_isize > 0) {
> >>>> +        *isize =3D tmp_isize;
> >>>> +    }
> >>>>  # endif
> >>>>  # ifdef _SC_LEVEL1_DCACHE_LINESIZE
> >>>> -    *dsize =3D sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> >>>> +    int tmp_dsize =3D (int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
> >>>> +    if (tmp_dsize > 0) {
> >>>> +        *dsize =3D tmp_dsize;
> >>>> +    }
> >>>>  # endif
> >>>>  }
> >>>>  #endif /* sys_cache_info */
> >>>> --
> >>>
> >>> thanks
> >>> -- PMM
> >>
> >> --
> >> Carlos Santos
> >> Senior Software Maintenance Engineer
> >> Red Hat
> >> casantos@redhat.com    T: +55-11-3534-6186
> >
> > Hi,
> >
> > Any chance to have this merged for Christmas? :-)
>
> No, but it's queued now.  ;-)
>
>
> r~
>

Ah, Easter, perhaps. :-)

--=20
Carlos Santos
Senior Software Maintenance Engineer
Red Hat
casantos@redhat.com    T: +55-11-3534-6186


