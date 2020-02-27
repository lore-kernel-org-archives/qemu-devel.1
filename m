Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865D7C3F2C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547852468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev0nVowv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547852468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QHO-0001Tt-H7
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7QGk-0000xD-1i
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7QGj-0001Ll-29
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:00:29 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:35724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j7QGi-0001LW-TN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:00:29 -0500
Received: by mail-oi1-x22a.google.com with SMTP id b18so694625oie.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 13:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=xQmwWJC8yugrH/zfwAc4ldQJa4xwLe8s9p/CzI/8Qys=;
 b=Ev0nVowv6lGqPOBPVvHPOlFzeAcBVv08Uc5vUT6xi5AGOYtEXkNSMyX8Odds0HQTmS
 CIgz3yJtsMKj5809WmiG48WbvoBAm2Lz1wBqSPbGeIoKxGUJVvMaXoURbGsaO8J/0/5P
 DNyfjClf1OYQ7JAZMX+oO73aquKi5BLM/1fgeacLKhlXBQMxGf+ijRFgKUXP2sZq3wSF
 fPxaWQvSliJDMsKXCfTxcIfDLrC3sYH7qGlW34RS8IH/lJ6wwGGn6kLqxL6TV8LCXeZn
 xdr25bFyWMGzDiaYuoURzuNIg2+qRFpCjG/XjMoVaBKXxqHXDOW3PS6DTQ6kOPuk1Qa8
 vvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=xQmwWJC8yugrH/zfwAc4ldQJa4xwLe8s9p/CzI/8Qys=;
 b=FaX2P0pvrwpK0XL4QCnFHSlHKSwKIUK849LxQJo/GiJw/W3kTo86iecxzlU2qSqiQj
 Xq4YD2Z9LeY8OJgTZ1Uh9tyvY17o5geo4EAOUomI/RC419/j6vW9+3NIrwBSkZ8jfLhQ
 Tcf5X05Kn6mzsiavDS0Wd+Ql7pKHRS9MPpAmuA/Zv2/Ng459AY9W9bEnut41EoNk62fp
 2NeBzugLW4yDkltOz0Xe7npNc9IliWUa8cVQvUX2eYk69wdNmiAL3nSHSLdFQOa/l2nL
 zMZR2F3bZfS66bVMAmMHEBpGtbHyzeuSq0+SfhsM7zqpKxL9tvUEVTejjGfPr7sFOZiu
 aetQ==
X-Gm-Message-State: APjAAAVBpawzCYReU1AtHBHwkWAtlDm8UwqW1G5VCigyuuak2RPlXJns
 h8/7MSdsctozSZoJVVfKdeWiKigMVAUVbmWkUf0=
X-Google-Smtp-Source: APXvYqyfSOSHmtoCFEXyfHKTC5ssQ2rIIiZ4JLdJ9lf3fnXVbGvQ9kIwfNzzYA255cudC22w2PKJ0X8HQ87ac5nkwU8=
X-Received: by 2002:aca:5711:: with SMTP id l17mr718100oib.53.1582837227895;
 Thu, 27 Feb 2020 13:00:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 27 Feb 2020 13:00:27 -0800 (PST)
In-Reply-To: <87r1yfc1q1.fsf@secure.laptop>
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-4-marcandre.lureau@redhat.com>
 <8736cqi07g.fsf@secure.laptop>
 <CAJ+F1CLgg6Yz=2V8_eCVtsJ1zPm=1-piz-Nw05KGXkSqWytLgA@mail.gmail.com>
 <87r1yfc1q1.fsf@secure.laptop>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 27 Feb 2020 22:00:27 +0100
Message-ID: <CAL1e-=h+SkEPy1VVvdNeo9T1mAT5-dA7orsj0TFtfDsTofwzFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] savevm: check RAM is pagesize aligned
To: "quintela@redhat.com" <quintela@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b4bf02059f9502fb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: QEMU <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b4bf02059f9502fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, February 27, 2020, Juan Quintela <quintela@redhat.com> wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > Hi Juan
> >
> > On Wed, Jan 8, 2020 at 2:08 PM Juan Quintela <quintela@redhat.com>
> wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >> n> Check the host pointer is correctly aligned, otherwise we may fail
> >> > during migration in ram_block_discard_range().
> >> >
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Reviewed-by: Juan Quintela <quintela@redhat.com>
> >>
> >> queued
> >>
> >
> > Did it get lost? thanks
>
> I dropped it in the past, because it made "make check" for mips fail.
> (I put it on my ToDo list to investigate and forgot about it)
>
>
Thank you for caring for mips.

Do you perhaps remember what was tgevtest and environment for the failing
test?

Regards,
Aleksandar


> But now it pass, go figure.
>
> Included again.  Sorry.
>
> Later, Juan.
>
>
>

--000000000000b4bf02059f9502fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, February 27, 2020, Juan Quintela &lt;<a href=3D"mailto=
:quintela@redhat.com">quintela@redhat.com</a>&gt; wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lure=
au@gmail.com">marcandre.lureau@gmail.com</a>&gt; wrote:<br>
&gt; Hi Juan<br>
&gt;<br>
&gt; On Wed, Jan 8, 2020 at 2:08 PM Juan Quintela &lt;<a href=3D"mailto:qui=
ntela@redhat.com">quintela@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redh=
at.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>
&gt;&gt; n&gt; Check the host pointer is correctly aligned, otherwise we ma=
y fail<br>
&gt;&gt; &gt; during migration in ram_block_discard_range().<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:m=
arcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Reviewed-by: Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.c=
om">quintela@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; queued<br>
&gt;&gt;<br>
&gt;<br>
&gt; Did it get lost? thanks<br>
<br>
I dropped it in the past, because it made &quot;make check&quot; for mips f=
ail.<br>
(I put it on my ToDo list to investigate and forgot about it)<br>
<br></blockquote><div><br></div><div>Thank you for caring for mips.</div><d=
iv><br></div><div>Do you perhaps remember what was tgevtest and environment=
 for the failing test?</div><div><br></div><div>Regards,</div><div>Aleksand=
ar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
But now it pass, go figure.<br>
<br>
Included again.=C2=A0 Sorry.<br>
<br>
Later, Juan.<br>
<br>
<br>
</blockquote>

--000000000000b4bf02059f9502fb--

