Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BD5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 01:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CED020771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 01:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv/qyXsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CED020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPcX7-0001gp-AE
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 21:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leoluan@gmail.com>) id 1jPcVw-00016Y-6B
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 21:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leoluan@gmail.com>) id 1jPcVq-0004ZQ-Rc
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 21:43:23 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c]:46843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leoluan@gmail.com>)
 id 1jPcVq-0004Ok-HI; Fri, 17 Apr 2020 21:43:18 -0400
Received: by mail-io1-xd2c.google.com with SMTP id i3so4479539ioo.13;
 Fri, 17 Apr 2020 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B/cbYPE1RUHOtHpFJFzp53I1sb7fzCwvrxrjqIIOWmM=;
 b=Lv/qyXsCR9V0nTnK15nGOfcjKWoHvLGND3kL5I46tDr6r5ebhjgtlsKBNZtsIyDFEy
 rH67yJ6CokYbFYjEU+twsYvhBQUH+vr7Uu8sU2yQhfUi1pEEOtIe4b6/1Np3/EC3BZAq
 MyAb7dY7Lfk5YS4fO2vpxnP8DyeQzM7yAGa0eewWDomGLsulzKRhYlVoSkkjK6bY0vhc
 E4VKh8cRWQ4pi/rDeLXPA7+R0Q8r7EHdelr/VEdcJoo2VBbZ8+NiAK8UD/uE3xoxoogs
 xRMPzIbGwwk/75G0xsyERwdB38zEj31ij9/bXG8HG0RrpGTJGd9rkh3jmOXRpijxNzh/
 49OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B/cbYPE1RUHOtHpFJFzp53I1sb7fzCwvrxrjqIIOWmM=;
 b=KDZVqRo1b7t39Rbe+ljoaaQt00VL+y1OG1teYPiTxOYYKdvwqhVAaRw31KEyeAyzR5
 RQi0u1Omp6ruj1VsfgfzB3xaEgfsV71ZyBWjXP+FIJMNOUErJWNq+T6ShhRoJVH9sNwf
 ifo6oSQ3wdbsEpRCoipmOH6nM/fyxW/Hp07gOfxT2IXhqH+OrzvucpsBOtNY58gK4YH8
 Ak6xYZYGzgfOjTxQMvD+WyNpW/hy4ZPRXZfi0bSwKQuXK8qlr3CaJeLlBTZT63zKKiYe
 l7YwHVMxl9BEYFSQzkBKr4WiiN/2lCtch8baXBDZeNqrQIILvUWVMmYnTVJyOVzDOeri
 AlHA==
X-Gm-Message-State: AGi0PuacU/YEOA7GVZd2jcW2aWLwCnSiiJV4dKGQmYY7oCeB4ZqsC23a
 uS1U/3dR4CMojgXIYwOCl8lg+AFXtRbvNnI2Ayw=
X-Google-Smtp-Source: APiQypLf1mQIV+qDIuJKb4/bfjxjLfiwC1+oCNmUZLxxQcQbiFMje1izMHhQn/WUsXOj1mwcbmNBDCRUEpkuroxiksQ=
X-Received: by 2002:a6b:dd16:: with SMTP id f22mr5931953ioc.178.1587174196079; 
 Fri, 17 Apr 2020 18:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
 <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
 <CAD_3s9KuB7QaXCTygRfOsscXbrhm0kHbHRpUjb51EiwRpEM5MA@mail.gmail.com>
 <93052f9b-6539-0d4a-c922-fff7618c542d@redhat.com>
In-Reply-To: <93052f9b-6539-0d4a-c922-fff7618c542d@redhat.com>
From: Leo Luan <leoluan@gmail.com>
Date: Fri, 17 Apr 2020 18:43:04 -0700
Message-ID: <CAD_3s9+pSepV76-wp_AQTB-EQGwmga1FS+fT-Cb4n0Z48Zhxpg@mail.gmail.com>
Subject: Re: Avoid copying unallocated clusters during full backup
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000027709005a386ca32"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2c
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
 qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000027709005a386ca32
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 17, 2020 at 5:34 PM John Snow <jsnow@redhat.com> wrote:

>
>
> On 4/17/20 6:57 PM, Leo Luan wrote:
> > On Fri, Apr 17, 2020 at 1:24 PM Eric Blake <eblake@redhat.com
> > <mailto:eblake@redhat.com>> wrote:
> >
> >     On 4/17/20 3:11 PM, John Snow wrote:
> >
> >     >> +
> >     >> +    if (s->sync_mode == MIRROR_SYNC_MODE_FULL &&
> >     >> +       s->bcs->target->bs->drv != NULL &&
> >     >> +       strncmp(s->bcs->target->bs->drv->format_name, "qcow2", 5)
> >     == 0 &&
> >     >> +       s->bcs->source->bs->backing_file[0] == '\0')
> >     >
> >     > This isn't going to suffice upstream; the backup job can't be
> >     performing
> >     > format introspection to determine behavior on the fly.
> >
> >     Agreed.  The idea is right (we NEED to make backup operations smarter
> >     based on knowledge about both source and destination block status),
> but
> >     the implementation is not (a check for strcncmp("qcow2") is not
> ideal).
> >
> >
> > I see/agree that using strncmp("qcow2") is not general enough for the
> > upstream.  Would changing it to bdrv_unallocated_blocks_are_zero()
> suffice?
> >
>
> I don't know, to be really honest with you. Vladimir reworked the backup
> code recently and Virtuozzo et al have shown a very aggressive interest
> in optimizing the backup loop. I haven't really worked on that code
> since their rewrite.
>
> Dropping unallocated regions from the backup manifest is one strategy,
> but I think there will be cases where we won't be able to treat it like
> "TOP", but may still have unallocated regions we don't want to copy (We
> have a backing file which is itself unallocated.)
>
> I'm interested in a more general purpose mechanism for efficient
> copying. I think that instead of the backup job itself doing this in
> backup.c by populating the copy manifest, that it's also appropriate to
> try to copy every last block and have the backup loop implementation
> decide it doesn't actually need to copy that block.
>
> That way, the copy optimizations can be shared by any implementation
> that needs to do efficient copying, and we can avoid special format and
> graph-inspection code in the backup job main interface code.
>
> To be clear, I see these as identical amounts of work:
>
> - backup job runs a loop to inspect every cluster to see if it is
> allocated or not, and modifies its cluster backup manifest accordingly
>

This inspection can detect more than 1GB of unallocated (64KB) clusters per
loop and it's a shallower path.

>
> - backup job loops through the entire block and calls a smart_copy()
> function that might degrade into a no-op if the right conditions are met
> (source is unallocated, explicit zeroes are not needed on the destination)
>

If I am not mistaken, the copy loop does one cluster per iteration using a
twice deeper call path (trying to copy and eventually finding unallocated
clusters).  So with 64KB cluster size, it's 2 * 1G/64K ~= 32 million times
less efficient with the CPU cycles for large sparse virtual disks.

>
> Either way, you're looping and interrogating the disk, but in one case
> the efficiencies go deeper than *just* the backup code.
>

I think the early stop of inefficiency can help minimize the CPU impact of
the backup job on the VM instance.


> I think Vladimir has put a lot of work into making the backup code
> highly optimized, so I would consult with him to find out where the best
> place to put new optimizations are, if any -- he'll know!
>

Yes, hope that he will chime in.

Thanks!

>
> --js
>
>
> >
> >     >
> >     > I think what you're really after is something like
> >     > bdrv_unallocated_blocks_are_zero().
> >
> >     The fact that qemu-img already has a lot of optimizations makes me
> >     wonder what we can salvage from there into reusable code that both
> >     qemu-img and block backup can share, so that we're not reimplementing
> >     block status handling in multiple places.
> >
> >
> > A general fix reusing some existing code would be great.  When will it
> > appear in the upstream?  We are hoping to avoid needing to use a private
> > branch if possible.
> >
> >
> >     > So the basic premise is that if you are copying a qcow2 file and
> the
> >     > unallocated portions as defined by the qcow2 metadata are zero,
> it's
> >     > safe to skip those, so you can treat it like SYNC_MODE_TOP.
> >     >
> >     > I think you *also* have to know if the *source* needs those regions
> >     > explicitly zeroed, and it's not always safe to just skip them at
> the
> >     > manifest level.
> >     >
> >     > I thought there was code that handled this to some extent already,
> >     but I
> >     > don't know. I think Vladimir has worked on it recently and can
> >     probably
> >     > let you know where I am mistaken :)
> >
> >     Yes, I'm hoping Vladimir (or his other buddies at Virtuozzo) can
> chime
> >     in.  Meanwhile, I've working on v2 of some patches that will improve
> >     qemu's ability to tell if a destination qcow2 file already reads as
> all
> >     zeroes, and we already have bdrv_block_status() for telling which
> >     portions of a source image already read as all zeroes (whether or
> >     not it
> >     is due to not being allocated, the goal here is that we should NOT
> have
> >     to copy anything that reads as zero on the source over to the
> >     destination if the destination already starts life as reading all
> zero).
> >
> >
> > Can the eventual/optimal solution allow unallocated clusters to be
> > skipped entirely in the backup loop and make the detection of allocated
> > zeroes an option, not forcing the backup thread to loop through a
> > potentially huge empty virtual disk?
> >
>
> I mean, using the TOP code is doing the same thing, really: it's looking
> at allocation status and marking those blocks as "already copied", more
> or less.
>
> >
> >     And if nothing else, qemu 5.0 just added 'qemu-img convert
> >     --target-is-zero' as a last-ditch means of telling qemu to assume the
> >     destination reads as all zeroes, even if it cannot quickly prove it;
> we
> >     probably want to add a similar knob into the QMP commands for
> >     initiating
> >     block backup, for the same reasons.
> >
> >
> > This seems a good way of assuring the status of the target file.
> >
> > Thanks!
> >
>
>

--00000000000027709005a386ca32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 17, 2020 at 5:34 PM John Snow=
 &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 4/17/20 6:57 PM, Leo Luan wrote:<br>
&gt; On Fri, Apr 17, 2020 at 1:24 PM Eric Blake &lt;<a href=3D"mailto:eblak=
e@redhat.com" target=3D"_blank">eblake@redhat.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:eblake@redhat.com" target=3D"_blank">ebla=
ke@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 4/17/20 3:11 PM, John Snow wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; + =C2=A0 =C2=A0if (s-&gt;sync_mode =3D=3D =
MIRROR_SYNC_MODE_FULL &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 s-&gt;bcs-&gt;targe=
t-&gt;bs-&gt;drv !=3D NULL &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 strncmp(s-&gt;bcs-&=
gt;target-&gt;bs-&gt;drv-&gt;format_name, &quot;qcow2&quot;, 5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=3D=3D 0 &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 s-&gt;bcs-&gt;sourc=
e-&gt;bs-&gt;backing_file[0] =3D=3D &#39;\0&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This isn&#39;t going to suffice upstream; the =
backup job can&#39;t be<br>
&gt;=C2=A0 =C2=A0 =C2=A0performing<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; format introspection to determine behavior on =
the fly.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Agreed.=C2=A0 The idea is right (we NEED to make ba=
ckup operations smarter<br>
&gt;=C2=A0 =C2=A0 =C2=A0based on knowledge about both source and destinatio=
n block status), but<br>
&gt;=C2=A0 =C2=A0 =C2=A0the implementation is not (a check for strcncmp(&qu=
ot;qcow2&quot;) is not ideal).<br>
&gt; <br>
&gt; <br>
&gt; I see/agree that using strncmp(&quot;qcow2&quot;) is not general enoug=
h for the<br>
&gt; upstream.=C2=A0 Would changing it to bdrv_unallocated_blocks_are_zero(=
) suffice?<br>
&gt; <br>
<br>
I don&#39;t know, to be really honest with you. Vladimir reworked the backu=
p<br>
code recently and Virtuozzo et al have shown a very aggressive interest<br>
in optimizing the backup loop. I haven&#39;t really worked on that code<br>
since their rewrite.<br>
<br>
Dropping unallocated regions from the backup manifest is one strategy,<br>
but I think there will be cases where we won&#39;t be able to treat it like=
<br>
&quot;TOP&quot;, but may still have unallocated regions we don&#39;t want t=
o copy (We<br>
have a backing file which is itself unallocated.)<br>
<br>
I&#39;m interested in a more general purpose mechanism for efficient<br>
copying. I think that instead of the backup job itself doing this in<br>
backup.c by populating the copy manifest, that it&#39;s also appropriate to=
<br>
try to copy every last block and have the backup loop implementation<br>
decide it doesn&#39;t actually need to copy that block.<br>
<br>
That way, the copy optimizations can be shared by any implementation<br>
that needs to do efficient copying, and we can avoid special format and<br>
graph-inspection code in the backup job main interface code.<br>
<br>
To be clear, I see these as identical amounts of work:<br>
<br>
- backup job runs a loop to inspect every cluster to see if it is<br>
allocated or not, and modifies its cluster backup manifest accordingly<br><=
/blockquote><div><br></div><div>This inspection can detect more than 1GB of=
 unallocated (64KB) clusters per loop and it&#39;s a shallower path.=C2=A0<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
- backup job loops through the entire block and calls a smart_copy()<br>
function that might degrade into a no-op if the right conditions are met<br=
>
(source is unallocated, explicit zeroes are not needed on the destination)<=
br></blockquote><div><br></div><div>If I am not mistaken, the copy loop doe=
s one cluster per iteration using a twice deeper call path (trying to copy =
and eventually finding unallocated clusters).=C2=A0 So with 64KB cluster=C2=
=A0size, it&#39;s 2 * 1G/64K ~=3D 32 million times less efficient with the =
CPU cycles for large sparse virtual disks.<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
Either way, you&#39;re looping and interrogating the disk, but in one case<=
br>
the efficiencies go deeper than *just* the backup code.<br></blockquote><di=
v><br></div><div>I think the early stop of inefficiency can help minimize t=
he CPU impact of the backup job on the VM instance.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
I think Vladimir has put a lot of work into making the backup code<br>
highly optimized, so I would consult with him to find out where the best<br=
>
place to put new optimizations are, if any -- he&#39;ll know!<br></blockquo=
te><div><br></div><div>Yes, hope that he will chime in.=C2=A0=C2=A0</div><d=
iv><br></div><div>Thanks!=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
--js<br>
<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I think what you&#39;re really after is someth=
ing like<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; bdrv_unallocated_blocks_are_zero().<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The fact that qemu-img already has a lot of optimiz=
ations makes me<br>
&gt;=C2=A0 =C2=A0 =C2=A0wonder what we can salvage from there into reusable=
 code that both<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-img and block backup can share, so that we&#39=
;re not reimplementing<br>
&gt;=C2=A0 =C2=A0 =C2=A0block status handling in multiple places.<br>
&gt; <br>
&gt; <br>
&gt; A general fix reusing some existing code would be great.=C2=A0 When wi=
ll it<br>
&gt; appear in the upstream?=C2=A0 We are hoping to avoid needing to use a =
private<br>
&gt; branch if possible.=C2=A0=C2=A0<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So the basic premise is that if you are copyin=
g a qcow2 file and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; unallocated portions as defined by the qcow2 m=
etadata are zero, it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; safe to skip those, so you can treat it like S=
YNC_MODE_TOP.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I think you *also* have to know if the *source=
* needs those regions<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; explicitly zeroed, and it&#39;s not always saf=
e to just skip them at the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; manifest level.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I thought there was code that handled this to =
some extent already,<br>
&gt;=C2=A0 =C2=A0 =C2=A0but I<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; don&#39;t know. I think Vladimir has worked on=
 it recently and can<br>
&gt;=C2=A0 =C2=A0 =C2=A0probably<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; let you know where I am mistaken :)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, I&#39;m hoping Vladimir (or his other buddies =
at Virtuozzo) can chime<br>
&gt;=C2=A0 =C2=A0 =C2=A0in.=C2=A0 Meanwhile, I&#39;ve working on v2 of some=
 patches that will improve<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu&#39;s ability to tell if a destination qcow2 f=
ile already reads as all<br>
&gt;=C2=A0 =C2=A0 =C2=A0zeroes, and we already have bdrv_block_status() for=
 telling which<br>
&gt;=C2=A0 =C2=A0 =C2=A0portions of a source image already read as all zero=
es (whether or<br>
&gt;=C2=A0 =C2=A0 =C2=A0not it<br>
&gt;=C2=A0 =C2=A0 =C2=A0is due to not being allocated, the goal here is tha=
t we should NOT have<br>
&gt;=C2=A0 =C2=A0 =C2=A0to copy anything that reads as zero on the source o=
ver to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0destination if the destination already starts life =
as reading all zero).<br>
&gt; <br>
&gt; <br>
&gt; Can the eventual/optimal solution allow unallocated clusters to be<br>
&gt; skipped entirely in the backup loop and make the detection of allocate=
d<br>
&gt; zeroes an option,=C2=A0not forcing the backup thread to loop through a=
<br>
&gt; potentially=C2=A0huge empty virtual disk?<br>
&gt; <br>
<br>
I mean, using the TOP code is doing the same thing, really: it&#39;s lookin=
g<br>
at allocation status and marking those blocks as &quot;already copied&quot;=
, more<br>
or less.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0And if nothing else, qemu 5.0 just added &#39;qemu-=
img convert<br>
&gt;=C2=A0 =C2=A0 =C2=A0--target-is-zero&#39; as a last-ditch means of tell=
ing qemu to assume the<br>
&gt;=C2=A0 =C2=A0 =C2=A0destination reads as all zeroes, even if it cannot =
quickly prove it; we<br>
&gt;=C2=A0 =C2=A0 =C2=A0probably want to add a similar knob into the QMP co=
mmands for<br>
&gt;=C2=A0 =C2=A0 =C2=A0initiating<br>
&gt;=C2=A0 =C2=A0 =C2=A0block backup, for the same reasons.<br>
&gt; <br>
&gt; <br>
&gt; This seems a good way of assuring the=C2=A0status of the target file.<=
br>
&gt; <br>
&gt; Thanks!<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000027709005a386ca32--

