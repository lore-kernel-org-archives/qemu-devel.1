Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3A920674
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJXM4ane"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3A920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBXT-0002r8-5O
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqBWr-0002S8-O8
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:22:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqBWp-0004do-Av
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:22:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id b6so19150536wrs.11
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BMLaRU3s8UQTTUhwcnZoSYdgZA2xp5dIWtP45k393v0=;
 b=uJXM4anerfDCNqtTQmLbBFfyMw7SxYY5QUSIZSuTqDSooGg9OdUN2uHQUAEdSb02gY
 1OSTdaT6hjVJBEbHyHxjRdCaKRH8OXdpoAN4HVO0PzKkEcIcIk1NRxj3+fvUAc9mnbUq
 fV9ACExlz5pjiI40sy4gUqaH6vgVx2wzLnlWjn/WhRWpUH5UJTCwF5EM6SmcKJBHtiyR
 R/yWyddJJvFH/+gDMLXYGattniXtoECUsX8gibfMaLorE5xK10B8oWAvuZQaDVtZIIQY
 dd3uaJgMgOC+3hTsv/u9bjwpq2TeuSfV5WU7s9wJZXkaDd/6UTJok4uI/oyvHMe6TtRW
 9qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BMLaRU3s8UQTTUhwcnZoSYdgZA2xp5dIWtP45k393v0=;
 b=Ketv7m5FClVsFgR29UVt5QLlFdnQuxL00ZGsY0pozpdqH4JZKd0ruDw7q4IoRRhBJn
 71YFQQ0gzwQe6QrYvbuJdpUNelCjl+oP5xzECnjqikXXMluG4rS1uOhtqcDL+8dxYwd/
 87gbGNq+1SOwMN9MKMFnoSdpFKdLVyjaeqd4FQM4W6XtBz9i8RuNC/+xqyFoE7tRRo7s
 lddFHl96ItDOs5uWnQLk5x4vmdN8bh9bDcWqfr69a6p6jsut+YgfUFylniFPw+AxjKrG
 B4JmTQg4bISe7HInrTHXA/E3zLIzPWyIFKGmQbrbPPq45lOkIaZDI8RWyLh8YWDy0d+d
 FN/A==
X-Gm-Message-State: AOAM5328JZPR3zhMyustAx3vMVizo33J4uESXNFmSgIeULy9VKdQM+6T
 N/K2NPQeAN0ZUR1XizaEX/5APD7bJ92WBHdgOBA=
X-Google-Smtp-Source: ABdhPJzn1h/fJzqb7Prez2xQRdicIhozOtC4g3BY2zl7Hwa1DkowPODnq2FUi0qYRK0SqxBJuQtnxaOno9f24X7bBT0=
X-Received: by 2002:adf:f885:: with SMTP id u5mr20325805wrp.402.1593505325479; 
 Tue, 30 Jun 2020 01:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <CAE2XoE-dOHGtJO5f0xXA7r4hEeL5LDOPB1TDNPjWNC+hf9Qyew@mail.gmail.com>
 <CALTWKrVwRhQEEjMEq444fNgBp1Dv_XyJAV7suXCEmeS40raaEQ@mail.gmail.com>
In-Reply-To: <CALTWKrVwRhQEEjMEq444fNgBp1Dv_XyJAV7suXCEmeS40raaEQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 10:21:52 +0200
Message-ID: <CAHiYmc5Em7zaVZzBZdp-13Mw2MnM_-nxZ=g+_ePnDCcBiwJrRg@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, luoyonggang@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 09:30 Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Tue, Jun 30, 2020 at 7:59 AM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 <luoyonggang@gmail.com> wrote:
> >
> > Wonderful work, May I reproduce the work on my local machine?
> >
> > On Mon, Jun 29, 2020 at 6:26 PM Ahmed Karaman <ahmedkhaledkaraman@gmail=
.com> wrote:
> >>
> >> Hi,
> >>
> >> The second report of the TCG Continuous Benchmarking series builds
> >> upon the QEMU performance metrics calculated in the previous report.
> >> This report presents a method to dissect the number of instructions
> >> executed by a QEMU invocation into three main phases:
> >> - Code Generation
> >> - JIT Execution
> >> - Helpers Execution
> >> It devises a Python script that automates this process.
> >>
> >> After that, the report presents an experiment for comparing the
> >> output of running the script on 17 different targets. Many conclusions
> >> can be drawn from the results and two of them are discussed in the
> >> analysis section.
> >>
> >> Report link:
> >> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEM=
U-Into-Three-Main-Parts/
> >>
> >> Previous reports:
> >> Report 1 - Measuring Basic Performance Metrics of QEMU:
> >> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> >>
> >> Best regards,
> >> Ahmed Karaman
> >
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>
> Thanks Mr. Yonggang. Yes of course, go ahead.
> Please let me know if you have any further questions.
>

Yes, Ahmed, you said Mr. Yonggang can go ahaed - but you didn't say how. :)

As far as I know, this is how Ahmed test bed is setup:

1) Fresh installation on Ubuntu 18.04 on an Inter 64-bit host.
2) Install QEMU build prerequisite packages.
3) Install perf (this step is not necessary for Report 2, but it is
for Report 1).
4) Install vallgrind.
5) Install 16 gcc cross-compilers. (which, together with native
comipler, will sum up to the 17 possible QEMU targets)

That is all fine if Mr. Yongang is able to do the above, or if he
already have similar system.

I am fairly convinced that the setup for any Debian-based Linux
distribution will be almost identical as described above

However, let's say Mr.Yongang system is Suse-bases distribution (SUSE
Linux Enterprise, openSUSE Leap, openSUSE Tumbleweed, Gecko). He could
do steps 2), 3), 4) in a fairly similar manner. But, step 5) will be
difficult. I know that support for cross-compilers is relatively poor
for Suse-based distributions. I think Mr. Yongang could run experiment
from the second part of Report 2 only for 5 or 6 targets, rather than
17 as you did.

The bottom line for Report 2:

I think there should be an "Appendix" note on installing
cross-compilers. And some general note on your test bed, as well as
some guideline for all people like Mr. Yongang who wish to repro the
results on their own systems.

Sincerely,
Aleksandar









2)


> Best Regards,
> Ahmed Karaman

