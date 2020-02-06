Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E493BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A5D21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAAIhqc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A5D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgix-0007Sx-R3
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npes87184@gmail.com>) id 1izgch-0001M8-4n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npes87184@gmail.com>) id 1izgcf-0006Qo-SU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:10 -0500
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:46732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npes87184@gmail.com>)
 id 1izgcf-0006Ox-Nl; Thu, 06 Feb 2020 07:51:09 -0500
Received: by mail-ua1-x943.google.com with SMTP id l6so2175806uap.13;
 Thu, 06 Feb 2020 04:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4wbbT3sDiLt6K5vAjXkCNh/p1shP+NEI/m2Db4svv6k=;
 b=VAAIhqc4P2DvAm+t7GmvXQpTd6MmMittXl+j67LzqyQg9voDbwzO6RXK4bTEwNnQ2A
 ggTvpLaSchwKf5LgkH1G4ZAN6A6dg28VQSaax5d8LFwFWjhWTSw24LS1Zae0ntHYrKlt
 zu/2Ypx9J2FQ1uQmK5hGzfMZXA7hxG1YeQw+agpsFynQ9egbruJTxMPXQc9dWR7L83F4
 39tbEimQufNq8NWWo5bHSdMD8eyqJHwGsiP4DqveZxpVze3HDqwWS7LGp8KIY61rjoj/
 L+P36vhdSdq0nVHYSZeI3aa3lOZxrCtE7v7gd6RjkwrtvEVDlqzLy0JLk0ELvxcR3En1
 ekLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4wbbT3sDiLt6K5vAjXkCNh/p1shP+NEI/m2Db4svv6k=;
 b=k47esAR48PwdHrhsaVe9/ls9dk3KqW76F5G1ey5LS24u/ANLziOLBMJ8RPxmBsAKnx
 urqsJlF1CI9WRl3jG6smxph2/KkZ94ChZkeT2C8r990+9fM82AGcUsyj/36D6dfbvk9p
 Yd2rbpxHYMVF7/hI4JFODRpjtz4/DkTl+W2P5EKHRrdRPMGR/nRAYsCouNJ7Q5hNJc2f
 P2+qeZUInh+7Uv+W3o7o22k6uCqDwQU989l7x0T1wQ73brB52eCwlF5HIYzdVPHLRYP4
 COgzKbdOw8BVVq3v6AKvgvI8n1mhSeZQV/8qrrKoUJQZA3TYUPEUVEnvhZfHZtk4RBHH
 +F2g==
X-Gm-Message-State: APjAAAUdponhMe4aJvXFqhwLl4E1XIq/jdynPr70MqTAkStKdLVZ88u/
 Z5PlTzoNY+3It6qfiRPd5gObVXiyeR6MEED8rGQ=
X-Google-Smtp-Source: APXvYqyyZxV4WmRhj7hZQBlw17yWJWeUQOJue5UMteQhUYmWLJlaPX1e16njSoUSkHc1J1eXMejrXmjEwYnZh63g6hY=
X-Received: by 2002:ab0:48cf:: with SMTP id y15mr1469784uac.26.1580993468739; 
 Thu, 06 Feb 2020 04:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20191206140931.14133-1-npes87184@gmail.com>
 <bd91caac-86c5-54a6-080d-37909b91a656@redhat.com>
 <548b2024-f34e-f4cd-f3b9-c4575c918cbe@redhat.com>
In-Reply-To: <548b2024-f34e-f4cd-f3b9-c4575c918cbe@redhat.com>
From: Yu-Chen Lin <npes87184@gmail.com>
Date: Thu, 6 Feb 2020 20:50:32 +0800
Message-ID: <CAPTqjH2bd4z_fgHt243Nx9CyMPO57aJY_BT8_eB3mAJ2D=avOQ@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Add entry about me
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000018b506059de7ba18"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000018b506059de7ba18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for your suggestion, I will send v2 with new subject. Also, I
will ack in v2 mail by my Synology account.

Thanks.

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E6=96=BC 2020=E5=B9=B42=E6=
=9C=886=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:08=E5=AF=AB=E9=81=
=93=EF=BC=9A

> Hello,
>
> I suggest changing the subject to:
> "mailmap: Add entry for Yu-Chen Lin"
>
> On 12/6/19 3:15 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Cc'ing qemu-trivial@
> >
> > On 12/6/19 3:09 PM, Yu-Chen Lin wrote:
> >> I have two mail address, add entries for
> >> showing author and email correctly.
> >>
> >> Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
> >> ---
> >>   .mailmap | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/.mailmap b/.mailmap
> >> index 3816e4effe..3fbf3902a3 100644
> >> --- a/.mailmap
> >> +++ b/.mailmap
> >> @@ -151,7 +151,8 @@ Xiaoqiang Zhao <zxq_yx_007@163.com>
> >>   Xinhua Cao <caoxinhua@huawei.com>
> >>   Xiong Zhang <xiong.y.zhang@intel.com>
> >>   Yin Yin <yin.yin@cs2c.com.cn>
> >> -yuchenlin <npes87184@gmail.com>
> >> +Yu-Chen Lin <npes87184@gmail.com>
> >> +Yu-Chen Lin <npes87184@gmail.com> <yuchenlin@synology.com>
>
> Apparently the mailmap process is getting stricter,
> can you Ack-by this patch from your Synology account?
>
> >
> > Thanks for updating your entry in .mailmap!
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> >>   YunQiang Su <syq@debian.org>
> >>   YunQiang Su <ysu@wavecomp.com>
> >>   Yuri Pudgorodskiy <yur@virtuozzo.com>
> >>
>
>

--00000000000018b506059de7ba18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
dir=3D"ltr">Thank you for your suggestion, I will send v2 with new subject.=
 Also, I will ack in v2 mail by my=C2=A0Synology account.</div><div dir=3D"=
ltr"><br></div><div dir=3D"ltr">Thanks.</div><div dir=3D"ltr"><br></div><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Philippe Math=
ieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</=
a>&gt; =E6=96=BC 2020=E5=B9=B42=E6=9C=886=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=
=B8=8B=E5=8D=887:08=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hello,<br>
<br>
I suggest changing the subject to:<br>
&quot;mailmap: Add entry for Yu-Chen Lin&quot;<br>
<br>
On 12/6/19 3:15 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Cc&#39;ing qemu-trivial@<br>
&gt; <br>
&gt; On 12/6/19 3:09 PM, Yu-Chen Lin wrote:<br>
&gt;&gt; I have two mail address, add entries for<br>
&gt;&gt; showing author and email correctly.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Yu-Chen Lin &lt;<a href=3D"mailto:npes87184@gmail.c=
om" target=3D"_blank">npes87184@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 .mailmap | 3 ++-<br>
&gt;&gt; =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/.mailmap b/.mailmap<br>
&gt;&gt; index 3816e4effe..3fbf3902a3 100644<br>
&gt;&gt; --- a/.mailmap<br>
&gt;&gt; +++ b/.mailmap<br>
&gt;&gt; @@ -151,7 +151,8 @@ Xiaoqiang Zhao &lt;<a href=3D"mailto:zxq_yx_00=
7@163.com" target=3D"_blank">zxq_yx_007@163.com</a>&gt;<br>
&gt;&gt; =C2=A0 Xinhua Cao &lt;<a href=3D"mailto:caoxinhua@huawei.com" targ=
et=3D"_blank">caoxinhua@huawei.com</a>&gt;<br>
&gt;&gt; =C2=A0 Xiong Zhang &lt;<a href=3D"mailto:xiong.y.zhang@intel.com" =
target=3D"_blank">xiong.y.zhang@intel.com</a>&gt;<br>
&gt;&gt; =C2=A0 Yin Yin &lt;<a href=3D"mailto:yin.yin@cs2c.com.cn" target=
=3D"_blank">yin.yin@cs2c.com.cn</a>&gt;<br>
&gt;&gt; -yuchenlin &lt;<a href=3D"mailto:npes87184@gmail.com" target=3D"_b=
lank">npes87184@gmail.com</a>&gt;<br>
&gt;&gt; +Yu-Chen Lin &lt;<a href=3D"mailto:npes87184@gmail.com" target=3D"=
_blank">npes87184@gmail.com</a>&gt;<br>
&gt;&gt; +Yu-Chen Lin &lt;<a href=3D"mailto:npes87184@gmail.com" target=3D"=
_blank">npes87184@gmail.com</a>&gt; &lt;<a href=3D"mailto:yuchenlin@synolog=
y.com" target=3D"_blank">yuchenlin@synology.com</a>&gt;<br>
<br>
Apparently the mailmap process is getting stricter,<br>
can you Ack-by this patch from your Synology account?<br>
<br>
&gt; <br>
&gt; Thanks for updating your entry in .mailmap!<br>
&gt; <br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; <br>
&gt;&gt; =C2=A0 YunQiang Su &lt;<a href=3D"mailto:syq@debian.org" target=3D=
"_blank">syq@debian.org</a>&gt;<br>
&gt;&gt; =C2=A0 YunQiang Su &lt;<a href=3D"mailto:ysu@wavecomp.com" target=
=3D"_blank">ysu@wavecomp.com</a>&gt;<br>
&gt;&gt; =C2=A0 Yuri Pudgorodskiy &lt;<a href=3D"mailto:yur@virtuozzo.com" =
target=3D"_blank">yur@virtuozzo.com</a>&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--00000000000018b506059de7ba18--

