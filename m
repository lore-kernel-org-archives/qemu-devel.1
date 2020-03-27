Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544AEC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B23F206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtHEKBip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B23F206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHoQJ-0001iW-6d
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 08:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHoOU-0000N7-FO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHoOS-0000zk-FK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:47:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jHoOQ-0000vG-F3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:47:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id d198so11303016wmd.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VZ5x7/HUCsJaY8iSrLgpGeTwK3FkLxpzO7RxG0oinms=;
 b=rtHEKBipFIJChyFlK0GMcE4fy13RxL4utkDSbN+7PYOKEsCdidDZgea2leIlhRVCYt
 1XN0kXUcCCjoCdlPEezFC/abBx1bDq4Ex/cT82w2ms3O1AXsda3V9gj7wX3sRCGWk8KK
 Zge8gs1xoarYWMllkxYdsIC76QFrriwQk4cMYQfdSXVZkgyNfdHnSq/Gloopc7oNiJcj
 yS9cC78E6U648RmHDI9T0pDSLrxvFE3JSKWljITFaPoZc16V6/GgiVT7xvoNcWvH0E7b
 Cp5fIzTEjABD7ZYrlhCP4eg7uQt/3VgOP8XhXzE8OeimGGMVdCV3dbdsMGE4UIJc3fe/
 S+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VZ5x7/HUCsJaY8iSrLgpGeTwK3FkLxpzO7RxG0oinms=;
 b=Gz6Fs+/+T9GuZjXrVNPGWXmMqTletJqho9eVK4ynIzY8Ij2MQ0RNE1Conogl9vZYRG
 33JDa1QMi0Je9UYPW4y31mQsWFzdEW+7UTwbDaKHpc2+pp0Dut97f9F9+J4y4pqX0ZKu
 inw/69N68UlwN/NHLsPU42X1yKJmkqZ9C5nbOFiLtpEgbvAW0AtnZY6AvJjSlRs02UU5
 tMORvH9lBcjVnSiwATJZduqqrPioOBLkP8F4nhJ3KyHB/1W9UbEDVzOJx35yO3ztvZng
 /gg6c8w9U/l+mF/xuCwbQeozEJWA819euYApw8xSTe0aopMFdiHpQiMTfmqsq8CD61xL
 3ueQ==
X-Gm-Message-State: ANhLgQ3r6M5eD981jk6qKbn4xc49y93awcuArgt2SsHFK7bSZc9b0Y4D
 zwu8mwBOlCajqPDi3e2tE0VpdGnUCabHgcs2nb0=
X-Google-Smtp-Source: ADFU+vsouPRlRj4xFwvNsxExe19NJGVr5OV4PpV2zejqufEpcxmEu3yodDjl9dP1pJ+rcKFfC178o84t9wQXPSlUK3E=
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr4965274wmj.129.1585313235499; 
 Fri, 27 Mar 2020 05:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
 <aa622b1d-e28a-c3f1-d18a-73e8a67c8ccf@linaro.org>
 <CAHiYmc7R_Y7s5DaVHf=0rkxf7N2qTSLXdTdL_vy6mH+hVdwLqA@mail.gmail.com>
 <ef2899be-3abf-4f15-1d7c-796994e1ecdd@linaro.org>
In-Reply-To: <ef2899be-3abf-4f15-1d7c-796994e1ecdd@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 27 Mar 2020 14:46:56 +0200
Message-ID: <CAHiYmc6f4eJqxDnSY1X7tn0WqYAzsBmEq76ADtEKh8Jmub46hA@mail.gmail.com>
Subject: Re: [PATCH for-5.0,
 v1] target/mips: Fix loongson multimedia condition instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000042807a05a1d5803d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: aurelien@aurel32.net, aleksandar.rikalo@rt-rk.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000042807a05a1d5803d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

03:30 =C4=8Cet, 26.03.2020. Richard Henderson <richard.henderson@linaro.org=
> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 3/25/20 3:44 AM, Aleksandar Markovic wrote:
> > May I ask you, Richard, to select this patch for your next TCG-for-5.0
queue,
> > so that I don't go through a MIPS queue process for just a single patch=
?
> >
>
> I suppose I could, but at present I have nothing in the tcg queue, so it
would
> be just the single patch.
>

Yes, Richard, even if it is just a single pending patch to you at the
moment, I would prefer you sending the pull request - in a way it
represents the final completion touch of LMI module that was authored by
you, but unclear docs prevented us from getting these last bits and pieces.
Please go ahead with the pull request at any time convenient to you - at
least it symbolically belongs to you (and I am sure you are glad about the
patch).

Yours, Aleksansar

>
> r~

--00000000000042807a05a1d5803d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">03:30 =C4=8Cet, 26.03.2020. Richard Henderson &lt;<a href=3D=
"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; =
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 3/25/20 3:44 AM, Aleksandar Markovic wrote:<br>
&gt; &gt; May I ask you, Richard, to select this patch for your next TCG-fo=
r-5.0 queue,<br>
&gt; &gt; so that I don&#39;t go through a MIPS queue process for just a si=
ngle patch?<br>
&gt; &gt; <br>
&gt;<br>
&gt; I suppose I could, but at present I have nothing in the tcg queue, so =
it would<br>
&gt; be just the single patch.<br>
&gt;</p>
<p dir=3D"ltr">Yes, Richard, even if it is just a single pending patch to y=
ou at the moment, I would prefer you sending the pull request - in a way it=
 represents the final completion touch of LMI module that was authored by y=
ou, but unclear docs prevented us from getting these last bits and pieces. =
Please go ahead with the pull request at any time convenient to you - at le=
ast it symbolically belongs to you (and I am sure you are glad about the pa=
tch).</p>
<p dir=3D"ltr">Yours, Aleksansar</p>
<p dir=3D"ltr">&gt;<br>
&gt; r~<br>
</p>

--00000000000042807a05a1d5803d--

