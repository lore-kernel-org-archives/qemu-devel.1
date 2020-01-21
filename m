Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64061C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6F0207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvmHKJEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6F0207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituyX-0000pj-AC
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1itufS-0005A0-Nz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1itufR-0005t6-7k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:38:10 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:45395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1itufR-0005st-32
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:38:09 -0500
Received: by mail-oi1-x235.google.com with SMTP id n16so2690322oie.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 06:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IRHS2RpIewZLZkK2/L/UIJowK8LK8qc93HfYLr9iNVI=;
 b=rvmHKJEvYW03ZzfM6YNoXnKUG3UEuCXyMg9RFII4SeTQr2qr9BdxvVpxJP4lI8zHgO
 KwWiKxnRvBKUPlMwpzXbCotA4ujhkU4lq9cG314sBdUl+Yd6ohCT6lQ4phNAeuQ1RlbM
 8SdlY2qP/4SVBSDKzvBMXw3s0gO+dknk1txqfZ42vacyxKJl4NI7XwaJppuj14RwI0rP
 +3NZ7icVqGtLpp7KN/v+zeszsVoJcIDJaDNKZVqOK9Xi2djOCCpb7lIWVHXY22cQC4bY
 HUUkGPtZEUgLcZQaW5cPgCt0v9R7EHs7WyqWlvM3aRvq0oxTfYc7N9zkVVVWxMzBCrQM
 E8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IRHS2RpIewZLZkK2/L/UIJowK8LK8qc93HfYLr9iNVI=;
 b=omKB8/NDV1AB+Fj19uX96vo4i5l20vOS1xOTHO04IaIVCzcOGBvBKU8NgjY6tZbp8d
 wqcjVN3f5YR9A77c/4rnYwaTJLQAsyRpZQwqs7ehnW08kSeZILZkF0Xj7w3yp4Jc5JnG
 NU55iNSWWcfG5kPy0+ZsJyXin+kLLHB8Qh3OwGL65JlcVzcHokFwlqU1MmXsN1Bcq4UQ
 GtZnZZqmOvPKD7bLt6FdkBcFVt+CnZFnyO637CeMRnR0geE/UcjmqPJAm9aSYJ09UogJ
 HeRVjug1C2e9o/XCCxMW7bc4+NImazbsz9aK41CdMPDLlKahJBx1lfOGRwcMRkeIkmet
 rYSw==
X-Gm-Message-State: APjAAAX2ViB+MpExc7DJTK+3vqSlZaLcYHUCz23c7hFA4DdQqQ/0GjoA
 J9I8BIxrZavPBpH2yrqOAAo5kjXHo0HgK+P9CMvWyunPFFU=
X-Google-Smtp-Source: APXvYqxf7PQ3dhpM7XRVvqu1zA2JKttTrpuS2vce1+b4MOdB6n2vUSTsUB+AxcyMtGbYi99DRlEGTrtvCneftl+Mqkg=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr3133489oih.106.1579617488067; 
 Tue, 21 Jan 2020 06:38:08 -0800 (PST)
MIME-Version: 1.0
References: <324a-5e231180-7-6946d180@169257031>
 <a752c621-1c72-e43a-51d8-6b586a2a229b@redhat.com>
In-Reply-To: <a752c621-1c72-e43a-51d8-6b586a2a229b@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 21 Jan 2020 15:37:57 +0100
Message-ID: <CAL1e-=gUMRAZop5_9swhXXMw3E1QDVwXXcGLynRXScVi5xPmTw@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 9:08 AM Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=
 wrote:
>
> Dne 18. 01. 20 v 15:08 Aleksandar Markovic napsal(a):
> > Hi, everybody.
> >
> > I am going to propose several ideas for QEMU participation in GSoC/Outr=
eachy in next few days. This is the first one. Please feel free to give an =
honest feedback.
> >
> > Yours,
> > Aleksandar
> >
>
> Hello Aleksandr,
>
> sounds like a good plan, I'd like to be involved as well.
>

Sure, I am glad to heard this.

> Why? At Rad Hat I'm exploring a way to monitor qemu performance. At this =
point it's x86_64 whole system only, but it should be flexible enough to wo=
rk on various setups. Good news is we're in a process of upstreamizing our =
setup so it might actually serve for the part II of your proposal. It's not=
 ready yet as it contains many ugly and downstream parts, but I'm replacing=
 the custom modules with Ansible and cleaning things from internal parts as=
 having it upstream is a high priority at this point. Our motivation is to =
allow public upstream testing (again, starting with x86, but more will hope=
fully come).
>
> Your proposal is fairly generic, I'm wondering which way it will turn. I =
like the part I, it might catch low-level changes and should lower the vari=
ability of results. In part II I'm a bit scared of how the scope will grow =
(based on what I saw in my experiment). You have host, host kernel, host sy=
stem, qemu, guest kernel, guest system and than the tested app, which might=
 result in a great jitter. Additionally qemu contains many features that ne=
ed to be utilized, you have various disk formats, block devices, various pa=
ssthrough options, ... as well as host/guest tune settings. It's gonna be h=
ard to not to get lost in the depth and to deliver something useful while e=
xtendable for the future...
>

My first impression is that your work and this proposal could be
viewed much more as complementary, rather than largely overlapping.

Yes, I am quite aware of the problem of data explosion, and I already
explore different possibilities of dealing with it.

Also, a student realistically can't do aweful lot of difficult work
for 3 or 4 months, so I plan to focus on simplicity, and the community
could further develop something more complex, if needed.

> Anyway, please keep me in the loop and good luck with leading this into t=
he right direction...
>

Definitely, and thanks!

Best regards,
Aleksandar

> Regards,
> Luk=C3=A1=C5=A1
>
> >
> >
> > *Measure and Analyze Performance of
> > QEMU User and System Mode Emulation*
> >
> >
> > _/PLANNED ACTIVITIES/_
> >
> > PART I: (user mode)
> >
> >    a) select around a dozen test programs (resembling components of SPE=
C benchmark, but must be open source, and preferably license compatible wit=
h QEMU); test programs should be distributed like this: 4-5 FPU CPU-intensi=
ve, 4-5 non-FPU CPU intensive, 1-2 I/O intensive;
> >    b) measure execution time and other performance data in user mode ac=
ross all platforms for ToT:
> >        - try to improve performance if there is an obvious bottleneck (=
but this is unlikely);
> >        - develop tests that will be protection against performance regr=
essions in future.
> >    c) measure execution time in user-mode for selected platforms for al=
l QEMU versions in last 5 years:
> >        - confirm performance improvements and/or detect performance deg=
radations.
> >    d) summarize all results in a comprehensive form, using also graphic=
s/data visualization.
> >
> > PART II: (system mode)
> >
> >    a) measure execution time and other performance data for boot/shutdo=
wn cycle for selected machines for ToT:
> >        - try to improve performance if there is an obvious bottleneck;
> >        - develop tests that will be protection against performance regr=
essions in future.
> >    b) summarize all results in a comprehensive form.
> >
> >
> > /_DELIVERABLES_/
> >
> > 1) Each maintainer for target will be given a list of top 25 functions =
in terms of spent host time for each benchmark described in the previous se=
ction. Additional information and observations will be also provided, if th=
e judgment is they are useful and relevant.
> >
> > 2) Each maintainer for machine (that has successful boot/shutdown cycle=
) will be given a list of top 25 functions in terms of spent host time duri=
ng boot/shutdown cycle. Additional information and observations will be als=
o provided, if the judgment is they are useful and relevant.
> >
> > 3) The community will be given all devised performance measurement meth=
ods in the form of easily reproducible step-by-step setup and execution pro=
cedures.
> >
> > (parts 1) and 2) will be, of course, published to everybody, maintainer=
s are simply singled out as main recipients and decision-makers on possible=
 next action items)
> >
> > Deliverable will be distributed over wide time interval (in other words=
, they will not be presented just at the end of project, but gradually duri=
ng project execution).
> >
> >
> > /Mentor:/ Aleksandar Markovic (myself) (but, I am perfectly fine if som=
ebody else wants to mentor the project, if interested)
> >
> > /Student:/ open
> >
> >
> > That would be all, feel free to ask for additional info and/or clarific=
ation.
> >
>
>

