Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BCBC2BA15
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 17:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E49620659
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 17:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMf8B80J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E49620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL8nn-0006os-Nc
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 13:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jL8n7-0006G9-DW
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jL8n5-00035S-Nv
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:10:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jL8n5-00034d-FA
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:10:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id j19so13294687wmi.2
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2020 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bCL+sx99ILg0CrNhirkPWl0kGMJL39PXYo6C+M6PQQc=;
 b=mMf8B80JZm2l2iYBdLZ3rWRjKDBi6ryfcaWVRCd06Oen2lkGFsV0a3+EXa8Gm8QLOD
 591JjkScIexZpb3Pc6ucciANW0KxzJEwridMCp7p5jymvPa52ke+p2MQp5vLpssNAM2k
 b/xJ09ZJL7phlNWw7Kzxf+NfwdXJfRrPMznZVALqPdRA4et8LWU13swAraZbU0Dgc8U6
 rYpYD4jy0OcB21drDw4GnAgbV5obozClYjCYkZw1+RquIIucW1dNOW9lCUZzQ3r7jI3+
 fzrBqnH40tEdCFDM1VXtg5tfcd40i/K0U7a3Cw2p4AjMM3rME1QCoB3asHSOxBu0ET+O
 Y03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bCL+sx99ILg0CrNhirkPWl0kGMJL39PXYo6C+M6PQQc=;
 b=KTcmZqpsEzsY+jaESIm2gxKTCFqQZhvixMfMW6ovYrhfyUEiO2Go3PQGlYS5uM856T
 enyi0dn4aaU91MPhh1Alawd/nIeMqEG89s+kNF6Knap8dnox4AcoORbi1UAgolR96QQX
 nFJ1t6ZI/lJ+zfm70h3ZMTN2kaoRqAqSjDl+HzPp2erg5rPY3DC6BVDhgOP3GHUgNoq+
 TyYcJ5iVxdjy1hF/xgl0mMf3lr+nXqvniC0u6fGbAAsiXtg+cEpaDW9FGN0YIWiAXaGU
 V+mhDskVAyY0Jc9GvUJ5YYkypKt2D0jFRWbhNH84xWWEhWkRLU5LXJRPxPxEwQg88vFB
 nt2g==
X-Gm-Message-State: AGi0PuYPgCIUtHqkwEQeST008xCvETJEvOdrgcDa4IWnLaszpp01S8f8
 KkhnVCtQZL517MUbG52l3jCsbOZFSAptRqKvg2g=
X-Google-Smtp-Source: APiQypLSvSbxRGFDDZrr7hsnv3kr3uPigOlIhi12RQrihIgWmf2JEhoWmvnLOALqhBzhodSgY1jMQhHZL4IWph9+nzE=
X-Received: by 2002:a1c:f407:: with SMTP id z7mr17899679wma.36.1586106634217; 
 Sun, 05 Apr 2020 10:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200403135306.665493-1-berrange@redhat.com>
 <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
 <813a6453-0cc1-2ee7-20fb-3ba624aad57a@redhat.com>
 <CAHiYmc4Sb0c3pqbOfD=tJf9xvC6rJcOH4kxB=1KZ64Cp-ty58g@mail.gmail.com>
 <CAFEAcA8Othn-Tp3+EKu0HcyszHxUyVukX+NfAKc997+o5ZY7mw@mail.gmail.com>
In-Reply-To: <CAFEAcA8Othn-Tp3+EKu0HcyszHxUyVukX+NfAKc997+o5ZY7mw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 5 Apr 2020 19:10:18 +0200
Message-ID: <CAHiYmc551i1nk8Tyck0FCk3-4qXoNvMurVowOEdCjqgGCSE57g@mail.gmail.com>
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000822bfc05a28e3a00"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000822bfc05a28e3a00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

11:14 Sub, 04.04.2020. Peter Maydell <peter.maydell@linaro.org> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Fri, 3 Apr 2020 at 23:35, Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> > But, Eric, while, to some extent I understand your motivation and the
idea, there are still features working in in-tree builds only (some
coccinele scenarios, and some gcov-related scenarios - and perhaps others
that nobody seems to care to try to find out at all), and not in out-of
tree builds. And, now, if I understand well your proposal, and supposing
that I use gcov in-tree build (since I have to), this will stop me from
doing out-of-tree builds in this QEMU directory, since my in-tree gcov
build will be destroyed.
>
> To repeat from the last thread: we are *not going* to remove in-tree
> builds before we fix whatever we need to to allow people to
> use out-of-tree for whatever they are currently doing with in-tree
> builds.

I am with you, Peter, and I truly appreciate your repeating that for the
second time.

But, what made me upset, obviously not everybody is reading your
statements. If you really carefully read responses to the original thread
started by you and also subsequent threads, you'll see that a number of
suggestions either cripple or outrightly effectively remove in-tree builds!
And all that not in 4 months, not in 8 months, but now, in the same patch
that was discussed (maybe the authors meant "later", but certainly did not
write that).

(on closer examination, perhaps Eric's proposal does not belong to this
catehory, so my apologies to Eric)

> The reason for putting in deprecation warnings etc now
> is timescales: releases are every four months or so, so if we
> want to warn users about something we need to put in that warning
> well in advance. Bug fixes on the other hand can go into the tree
> very quickly, so we can without any problems have a timeline that
> goes deprecation-notice --- fix bugs with out-of-tree builds -- remove
> or convert in-tree builds to automatically out-of-tree.
>
> Plus the only way we find out about problems we're going to need
> to fix is if we tell people "in-tree is going away" and they then tell
> us "er, XYZ doesn't seem to work out-of-tree".
>

Understood.

> The reason people are currently focusing on the warning bit
> is that we have about one week to do that if we want to get
> it into this release. After that we have months to investigate
> and fix the problems with out-of-tree builds.
>
> Can you provide repro instructions for your gcov issue?
>

I unfortunately can't, because I am working from home, and having
difficulties accessing my dev system with said behavior, that I left at the
company. If and when these difficulties disappear, I will gladly and
certainly send a bug report.

> What is the "coccinelle scenario" you mention?
>

I meant to say the scenario you mention in your original thread on the same
topic from the other day, and perhaps you said "Coverity", and not
"coccinele" - and I mixed up the two.

So, in other words, nothing new, I was just echoing what you said before,
the other day, in a response to one of my messages.

Regards,
Aleksandar

> thanks
> -- PMM

--000000000000822bfc05a28e3a00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">11:14 Sub, 04.04.2020. Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Fri, 3 Apr 2020 at 23:35, Aleksandar Markovic<br>
&gt; &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu=
.devel@gmail.com</a>&gt; wrote:<br>
&gt; &gt; But, Eric, while, to some extent I understand your motivation and=
 the idea, there are still features working in in-tree builds only (some co=
ccinele scenarios, and some gcov-related scenarios - and perhaps others tha=
t nobody seems to care to try to find out at all), and not in out-of tree b=
uilds. And, now, if I understand well your proposal, and supposing that I u=
se gcov in-tree build (since I have to), this will stop me from doing out-o=
f-tree builds in this QEMU directory, since my in-tree gcov build will be d=
estroyed.<br>
&gt;<br>
&gt; To repeat from the last thread: we are *not going* to remove in-tree<b=
r>
&gt; builds before we fix whatever we need to to allow people to<br>
&gt; use out-of-tree for whatever they are currently doing with in-tree<br>
&gt; builds.</p>
<p dir=3D"ltr">I am with you, Peter, and I truly appreciate your repeating =
that for the second time.</p>
<p dir=3D"ltr">But, what made me upset, obviously not everybody is reading =
your statements. If you really carefully read responses to the original thr=
ead started by you and also subsequent threads, you&#39;ll see that a numbe=
r of suggestions either cripple or outrightly effectively remove in-tree bu=
ilds! And all that not in 4 months, not in 8 months, but now, in the same p=
atch that was discussed (maybe the authors meant &quot;later&quot;, but cer=
tainly did not write that).</p>
<p dir=3D"ltr">(on closer examination, perhaps Eric&#39;s proposal does not=
 belong to this catehory, so my apologies to Eric)</p>
<p dir=3D"ltr">&gt; The reason for putting in deprecation warnings etc now<=
br>
&gt; is timescales: releases are every four months or so, so if we<br>
&gt; want to warn users about something we need to put in that warning<br>
&gt; well in advance. Bug fixes on the other hand can go into the tree<br>
&gt; very quickly, so we can without any problems have a timeline that<br>
&gt; goes deprecation-notice --- fix bugs with out-of-tree builds -- remove=
<br>
&gt; or convert in-tree builds to automatically out-of-tree.<br>
&gt;<br>
&gt; Plus the only way we find out about problems we&#39;re going to need<b=
r>
&gt; to fix is if we tell people &quot;in-tree is going away&quot; and they=
 then tell<br>
&gt; us &quot;er, XYZ doesn&#39;t seem to work out-of-tree&quot;.<br>
&gt;</p>
<p dir=3D"ltr">Understood.</p>
<p dir=3D"ltr">&gt; The reason people are currently focusing on the warning=
 bit<br>
&gt; is that we have about one week to do that if we want to get<br>
&gt; it into this release. After that we have months to investigate<br>
&gt; and fix the problems with out-of-tree builds.<br>
&gt;<br>
&gt; Can you provide repro instructions for your gcov issue?<br>
&gt;</p>
<p dir=3D"ltr">I unfortunately can&#39;t, because I am working from home, a=
nd having difficulties accessing my dev system with said behavior, that I l=
eft at the company. If and when these difficulties disappear, I will gladly=
 and certainly send a bug report.</p>
<p dir=3D"ltr">&gt; What is the &quot;coccinelle scenario&quot; you mention=
?<br>
&gt;</p>
<p dir=3D"ltr">I meant to say the scenario you mention in your original thr=
ead on the same topic from the other day, and perhaps you said &quot;Coveri=
ty&quot;, and not &quot;coccinele&quot; - and I mixed up the two.</p>
<p dir=3D"ltr">So, in other words, nothing new, I was just echoing what you=
 said before, the other day, in a response to one of my messages.</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; thanks<br>
&gt; -- PMM<br>
</p>

--000000000000822bfc05a28e3a00--

