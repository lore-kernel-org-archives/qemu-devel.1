Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F89C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DC4206F9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uequgNr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DC4206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZwS-0007LG-D0
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leoluan@gmail.com>) id 1jPZvc-0006ra-1y
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leoluan@gmail.com>) id 1jPZva-000483-Ew
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:57:43 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:40201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leoluan@gmail.com>)
 id 1jPZva-00047E-9T; Fri, 17 Apr 2020 18:57:42 -0400
Received: by mail-io1-xd2e.google.com with SMTP id w1so4148225iot.7;
 Fri, 17 Apr 2020 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wqeoBvxzVE/gLiTN82WIlJKXePdNjOBBZJ136zbXSyg=;
 b=uequgNr1KmDQv/DOq17jWz1/yBSqBlAEBKE0yYDoxrQeHecLRd/OVtJSYLGhRhABTy
 uUv+aMK4YPnem0ICulIPpZ23hecF+oZTE3G5iUIcR43lnlhJrBNc2uGeiEt4KbPUCZAm
 10VUllKuxKuuVP4so5jtP09Z2WlDmye0SMxXW/fuosW1PR1hAB8fV1T1Y//1VBStUZ24
 2a4bFcYMZs1knsN+/03JP6/ooLV6wdyw25yiW/6Fai+ibAJUl2ynFQy2C2LhQpABxCxe
 NqiFqhagMNkjkqdDjFM4IhH9F6eBRC67Sq7CKoMbYtmIE/CNPIDIRSvzPkwNH56n015V
 HOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wqeoBvxzVE/gLiTN82WIlJKXePdNjOBBZJ136zbXSyg=;
 b=p7cTYv6HnF9YWSybN4CP1zRx8LyidzlbkdYgZe4Iwl/u4Dzz6pmYPGiRHU7frHgLLc
 PJlsF/Gp7xgjhUEdBcyBo+9zoVKRAz8TTtWHlVI5P5uH5O5EBa7lHKUV0yNXdd1ilz8/
 sprBWWbyEuPDOjjPEBHRiY5iBmBMIocvrIsSnZkrS04R4x8FQbI6l+UKYs2+u6uHyLju
 BuRN7llLMuAJ5xo8mRq7legKb5tZxozKBPRHEBzKv7LYrD0lOEajx4XLkekfLFp/j+ox
 W+k357UBKqqJDO8UK5zacqNQkGAAh1hjGW8+OVcNp1o4QSTNHpwwehAV5sKgpl77t0QC
 KlNQ==
X-Gm-Message-State: AGi0PuZ1nxmR+nbGOrIsIkTwuy92Wz5XwvucQ3XLI01OvlPyfPClDt+t
 5i3j+oH7MLqt8jwkyNVMhsUSbLW5oJiWLG9KjOc=
X-Google-Smtp-Source: APiQypKlPMYWaHoZj3tKe4XLX7DQGSJRE0pZYcTyF8CVha2RzQ0UHYTSzJ/1UXxrnCfSxPahvmFgmRYf9ZXeNtJQGSg=
X-Received: by 2002:a02:2944:: with SMTP id p65mr5404339jap.89.1587164261496; 
 Fri, 17 Apr 2020 15:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
 <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
In-Reply-To: <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
From: Leo Luan <leoluan@gmail.com>
Date: Fri, 17 Apr 2020 15:57:30 -0700
Message-ID: <CAD_3s9KuB7QaXCTygRfOsscXbrhm0kHbHRpUjb51EiwRpEM5MA@mail.gmail.com>
Subject: Re: Avoid copying unallocated clusters during full backup
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001bdc905a3847a77"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2e
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000001bdc905a3847a77
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 17, 2020 at 1:24 PM Eric Blake <eblake@redhat.com> wrote:

> On 4/17/20 3:11 PM, John Snow wrote:
>
> >> +
> >> +    if (s->sync_mode == MIRROR_SYNC_MODE_FULL &&
> >> +       s->bcs->target->bs->drv != NULL &&
> >> +       strncmp(s->bcs->target->bs->drv->format_name, "qcow2", 5) == 0
> &&
> >> +       s->bcs->source->bs->backing_file[0] == '\0')
> >
> > This isn't going to suffice upstream; the backup job can't be performing
> > format introspection to determine behavior on the fly.
>
> Agreed.  The idea is right (we NEED to make backup operations smarter
> based on knowledge about both source and destination block status), but
> the implementation is not (a check for strcncmp("qcow2") is not ideal).
>

I see/agree that using strncmp("qcow2") is not general enough for the
upstream.  Would changing it to bdrv_unallocated_blocks_are_zero() suffice?


> >
> > I think what you're really after is something like
> > bdrv_unallocated_blocks_are_zero().
>
> The fact that qemu-img already has a lot of optimizations makes me
> wonder what we can salvage from there into reusable code that both
> qemu-img and block backup can share, so that we're not reimplementing
> block status handling in multiple places.
>

A general fix reusing some existing code would be great.  When will it
appear in the upstream?  We are hoping to avoid needing to use a private
branch if possible.

>
> > So the basic premise is that if you are copying a qcow2 file and the
> > unallocated portions as defined by the qcow2 metadata are zero, it's
> > safe to skip those, so you can treat it like SYNC_MODE_TOP.
> >
> > I think you *also* have to know if the *source* needs those regions
> > explicitly zeroed, and it's not always safe to just skip them at the
> > manifest level.
> >
> > I thought there was code that handled this to some extent already, but I
> > don't know. I think Vladimir has worked on it recently and can probably
> > let you know where I am mistaken :)
>
> Yes, I'm hoping Vladimir (or his other buddies at Virtuozzo) can chime
> in.  Meanwhile, I've working on v2 of some patches that will improve
> qemu's ability to tell if a destination qcow2 file already reads as all
> zeroes, and we already have bdrv_block_status() for telling which
> portions of a source image already read as all zeroes (whether or not it
> is due to not being allocated, the goal here is that we should NOT have
> to copy anything that reads as zero on the source over to the
> destination if the destination already starts life as reading all zero).
>

Can the eventual/optimal solution allow unallocated clusters to be skipped
entirely in the backup loop and make the detection of allocated zeroes an
option, not forcing the backup thread to loop through a potentially huge
empty virtual disk?

>
> And if nothing else, qemu 5.0 just added 'qemu-img convert
> --target-is-zero' as a last-ditch means of telling qemu to assume the
> destination reads as all zeroes, even if it cannot quickly prove it; we
> probably want to add a similar knob into the QMP commands for initiating
> block backup, for the same reasons.
>

This seems a good way of assuring the status of the target file.

Thanks!

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--00000000000001bdc905a3847a77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Apr 17, 2020 at 1:24 PM Eric Blak=
e &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wrote:=
<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 4/17/20 3:11 PM, John Snow wrote:<br>
<br>
&gt;&gt; +<br>
&gt;&gt; + =C2=A0 =C2=A0if (s-&gt;sync_mode =3D=3D MIRROR_SYNC_MODE_FULL &a=
mp;&amp;<br>
&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 s-&gt;bcs-&gt;target-&gt;bs-&gt;drv !=3D NU=
LL &amp;&amp;<br>
&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 strncmp(s-&gt;bcs-&gt;target-&gt;bs-&gt;drv=
-&gt;format_name, &quot;qcow2&quot;, 5) =3D=3D 0 &amp;&amp;<br>
&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 s-&gt;bcs-&gt;source-&gt;bs-&gt;backing_fil=
e[0] =3D=3D &#39;\0&#39;)<br>
&gt; <br>
&gt; This isn&#39;t going to suffice upstream; the backup job can&#39;t be =
performing<br>
&gt; format introspection to determine behavior on the fly.<br>
<br>
Agreed.=C2=A0 The idea is right (we NEED to make backup operations smarter =
<br>
based on knowledge about both source and destination block status), but <br=
>
the implementation is not (a check for strcncmp(&quot;qcow2&quot;) is not i=
deal).<br></blockquote><div><br></div><div>I see/agree that using strncmp(&=
quot;qcow2&quot;) is not general enough for the upstream.=C2=A0 Would chang=
ing it to bdrv_unallocated_blocks_are_zero() suffice?</div><div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; I think what you&#39;re really after is something like<br>
&gt; bdrv_unallocated_blocks_are_zero().<br>
<br>
The fact that qemu-img already has a lot of optimizations makes me <br>
wonder what we can salvage from there into reusable code that both <br>
qemu-img and block backup can share, so that we&#39;re not reimplementing <=
br>
block status handling in multiple places.<br></blockquote><div><br></div><d=
iv>A general fix reusing some existing code would be great.=C2=A0 When will=
 it appear in the upstream?=C2=A0 We are hoping to avoid needing to use a p=
rivate branch if possible.=C2=A0=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt; So the basic premise is that if you are copying a qcow2 file and the<b=
r>
&gt; unallocated portions as defined by the qcow2 metadata are zero, it&#39=
;s<br>
&gt; safe to skip those, so you can treat it like SYNC_MODE_TOP.<br>
&gt; <br>
&gt; I think you *also* have to know if the *source* needs those regions<br=
>
&gt; explicitly zeroed, and it&#39;s not always safe to just skip them at t=
he<br>
&gt; manifest level.<br>
&gt; <br>
&gt; I thought there was code that handled this to some extent already, but=
 I<br>
&gt; don&#39;t know. I think Vladimir has worked on it recently and can pro=
bably<br>
&gt; let you know where I am mistaken :)<br>
<br>
Yes, I&#39;m hoping Vladimir (or his other buddies at Virtuozzo) can chime =
<br>
in.=C2=A0 Meanwhile, I&#39;ve working on v2 of some patches that will impro=
ve <br>
qemu&#39;s ability to tell if a destination qcow2 file already reads as all=
 <br>
zeroes, and we already have bdrv_block_status() for telling which <br>
portions of a source image already read as all zeroes (whether or not it <b=
r>
is due to not being allocated, the goal here is that we should NOT have <br=
>
to copy anything that reads as zero on the source over to the <br>
destination if the destination already starts life as reading all zero).<br=
></blockquote><div><br></div><div>Can the eventual/optimal solution allow u=
nallocated clusters to be skipped entirely in the backup loop and make the =
detection of allocated zeroes an option,=C2=A0not forcing the backup thread=
 to loop through a potentially=C2=A0huge empty virtual disk?</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
And if nothing else, qemu 5.0 just added &#39;qemu-img convert <br>
--target-is-zero&#39; as a last-ditch means of telling qemu to assume the <=
br>
destination reads as all zeroes, even if it cannot quickly prove it; we <br=
>
probably want to add a similar knob into the QMP commands for initiating <b=
r>
block backup, for the same reasons.<br></blockquote><div><br></div><div>Thi=
s seems a good way of assuring the=C2=A0status of the target file.</div><di=
v><br></div><div>Thanks!</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div></div>

--00000000000001bdc905a3847a77--

