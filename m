Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EF5C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74BF20714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYK7/Auh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74BF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmBB-0002WX-U7
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHmAL-0001yA-9W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHmAJ-0000uo-TT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:24:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jHmAJ-0000t7-Ap
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:24:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id w10so10775287wrm.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VkkM0qiKPSOvwBfbjfXUZPxEE0rAzdWeVzFN57TXWAo=;
 b=pYK7/AuhiWadoMrHGC4ZUpPAZ1vA853VWR7t2UbSqV5yGA3x/J+p2L3nFPVtEnCv+s
 itUfGm4XTSkvVsiUS9Yw/8WXTTC1/9cPq9hmVHVxE7i9YWPKAMZODI6FRcnFFiR9jksk
 jrVq6f984g0PraWDRPWnLA9lgB/i6NmdIo7Vm72eYc46yYfSkEtEChWnCZq3MX2405Lh
 SAHtFPfGYs3ZTM6W4fUIMnFhZabtya7v7923EdeEcXu6gelorrpVsgllTPMTMH38pJsm
 16Pd1xgyc/2eE5Lt41ZpgEc+xzui+nkK5uKedEGl+MWFGw338WEtK7OF0J7MlMQ/DsLy
 HEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VkkM0qiKPSOvwBfbjfXUZPxEE0rAzdWeVzFN57TXWAo=;
 b=B800VEcDZc6eYpCAu+vSHozD0SjFgWvCiiV3vqop6AVbyx3y6hhFnDJljji5zDrhvR
 7Fg1c2E+rxSQGiNBRlZtXSgr01I6I13R3LETcQXNRuB+DlJEUpSvGRuHjqtgSHaHaoIR
 i3BtdqTLOvGHXVJbNyZv8KwLL8SqGkaB8XDVfuB9UwWxuHXqC/gHaeb/HvlzIHD2yVnx
 oF16icL049HGRvkWFaDjqNhuFOEFS4hiW7iZAbtO/1btYraSIEF7h0a+PgOzkx93H4mk
 Bq/u3z8NbvTtQTrbpIu6Elq07flt8zcMDNTxiVCoDuQXR3vuQedE/8pDgbME6//1Kf1I
 JxrA==
X-Gm-Message-State: ANhLgQ1OkSb5WTtNN6oaF9zdufUO8IVtMb8v8lpvuckB9JRMxu1rnEzi
 P9s6a9uP+mlA/F9jy2mI4vvus4GLlNTqs4NfRQE=
X-Google-Smtp-Source: ADFU+vvH5FsXcLTOAcmnmo4VuQeZzpZj7GY8wS5Pwuiahi0wL8VJe66aZ4yBLq/cW886C9tBZEZaQtpI3h87julvhL8=
X-Received: by 2002:adf:f24c:: with SMTP id b12mr13963068wrp.162.1585304677537; 
 Fri, 27 Mar 2020 03:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <CAHiYmc476rMd71t5ZSdz-pgVZ-i_3RBY=U3bO0aYEOOt5P3V_w@mail.gmail.com>
 <871rpennlp.fsf@linaro.org>
 <CAHiYmc5zTyUtm570NxKS8crJKWgNmEhMk-FcvnkMHf928=9CdQ@mail.gmail.com>
In-Reply-To: <CAHiYmc5zTyUtm570NxKS8crJKWgNmEhMk-FcvnkMHf928=9CdQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 27 Mar 2020 12:24:18 +0200
Message-ID: <CAHiYmc7ZZi784vOQre=_40bf0dgJUGoBupD_zFE2jw-_EcxR+Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/74] per-CPU locks
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002a5d7f05a1d382cd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: "peter.puhov@linaro.org" <peter.puhov@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002a5d7f05a1d382cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

11:50 Pet, 27.03.2020. Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
>
> =D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 27. =D0=BC=D0=B0=D1=80=D1=82 2020., Alex =
Benn=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>>
>> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:
>>
>> > 21:37 =C4=8Cet, 26.03.2020. Robert Foley <robert.foley@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>> >>
>> >> V7:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00786.html
>> >>
>> >> This is a continuation of the series created by Emilio Cota.
>> >> We are picking up this patch set with the goal to apply
>> >> any fixes or updates needed to get this accepted.
>> >>
>> >
>> > Thank for this work, Robert.
>> >
>> > However, I just hope you don't intend to request integrating the
series in
>> > 5.0. The right timing for such wide-influencing patch is at the
begining of
>> > dev cycle, not really at the end of (5.0) cycle, IMHO.
>>
>> It's not marked for 5.0 - I don't think all patch activity on the list
>> has to stop during softfreeze. I don't think there is any danger of it
>> getting merged and early visibility has already generated useful
>> feedback and discussion.
>
>
> OK, nobody ever said we can

Obviously, I meant here "cannot", not "can". Everbody is allowed to do any
experimentation and evaluation of the series at any time - of course. :)

> examine, discuss and test the series, but I remain thinking that this
series arrives too late for considering for 5.0.
>
> Aleksandar
>
>
>>
>> --
>> Alex Benn=C3=A9e

--0000000000002a5d7f05a1d382cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">11:50 Pet, 27.03.2020. Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&g=
t; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br=
>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =D0=BF=D0=B5=D1=82=D0=B0=D0=BA, 27. =D0=BC=D0=B0=D1=80=D1=82 2020., Al=
ex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@li=
naro.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gm=
ail.com">aleksandar.qemu.devel@gmail.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; 21:37 =C4=8Cet, 26.03.2020. Robert Foley &lt;<a href=3D"mailt=
o:robert.foley@linaro.org">robert.foley@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; V7: <a href=3D"https://lists.gnu.org/archive/html/qemu-de=
vel/2019-03/msg00786.html">https://lists.gnu.org/archive/html/qemu-devel/20=
19-03/msg00786.html</a><br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; This is a continuation of the series created by Emilio Co=
ta.<br>
&gt;&gt; &gt;&gt; We are picking up this patch set with the goal to apply<b=
r>
&gt;&gt; &gt;&gt; any fixes or updates needed to get this accepted.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thank for this work, Robert.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; However, I just hope you don&#39;t intend to request integrat=
ing the series in<br>
&gt;&gt; &gt; 5.0. The right timing for such wide-influencing patch is at t=
he begining of<br>
&gt;&gt; &gt; dev cycle, not really at the end of (5.0) cycle, IMHO.<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s not marked for 5.0 - I don&#39;t think all patch activity=
 on the list<br>
&gt;&gt; has to stop during softfreeze. I don&#39;t think there is any dang=
er of it<br>
&gt;&gt; getting merged and early visibility has already generated useful<b=
r>
&gt;&gt; feedback and discussion.<br>
&gt;<br>
&gt;<br>
&gt; OK, nobody ever said we can</p>
<p dir=3D"ltr">Obviously, I meant here &quot;cannot&quot;, not &quot;can&qu=
ot;. Everbody is allowed to do any experimentation and evaluation of the se=
ries at any time - of course. :)</p>
<p dir=3D"ltr">&gt; examine, discuss and test the series, but I remain thin=
king that this series arrives too late for considering for 5.0.<br>
&gt;<br>
&gt; Aleksandar<br>
&gt;<br>
&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; -- <br>
&gt;&gt; Alex Benn=C3=A9e<br>
</p>

--0000000000002a5d7f05a1d382cd--

