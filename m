Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B5C04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78535217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="XVjrAxaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78535217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQSSh-0007Gd-3y
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kQSRc-0006pn-WF
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:42:41 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kQSRZ-0007IS-Q6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:42:40 -0400
Received: by mail-oi1-x243.google.com with SMTP id m128so5650948oig.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8GN7+cdYk33PLrYsEQEPt4rSBPGM09/eN++7G3MmTfc=;
 b=XVjrAxawGkgy2RI45h6fkJg4aQ9DvlgUkuKkSwQkcfMtC3cP5dNBu/HMV/vdrmXTHU
 5wptBv+mtM9v9Olib/grpZW2n/kAzf+FF1/5Jco7RByukBuGWLmpvBbH45jA3dbfERam
 w9gChotNM3N/KxGQHLhb82Eq0N11+ngyTI4ftHnga6kfE3Ys8JuQtcGGvevJ079ogiar
 ZSMg6z43BfBf1lJfhp/5nTzHk78Mnn/RnL0+BCz0lGElUTBwLWES4ozeCvHO9890wmI4
 j8aSw6qM7076+4pUKm1PKQ9t6XxE/HvNk+x22c3WXkcPLzU2tFXrrGYh7SJxs0jf5aSp
 gatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8GN7+cdYk33PLrYsEQEPt4rSBPGM09/eN++7G3MmTfc=;
 b=XuJuJc+R2/E4d64Bb6gpAPPG8HXp0dJz396YWRu5cUhyAUV2kx1jS6ofgiBvmSXGrV
 C6FwNEf2zLlFHi55RyrFCv6qvGdxZyPAsXrI8YucPV6xuqMCSFswx4JUQXcKHWhHGz6k
 8D4pcwwKxl7+4KYwR9YWpgnEL7v4E24P/xR0ZLfNVa+CHNA+BwZiGTWnBXKSd1MHO2b6
 0URBzwdQ4obeLBqVYk6GPSQfO5zPgNWASGdfUVys/dat4Wtevi5wrnEnMtRzQ3nIdMhn
 YQrJlDykuPwuq1NsHzHCqlhSbPeCTTC+ClsYQBVvkasq5K3ZzipWlV8/AJhkASfUNiaM
 bzEQ==
X-Gm-Message-State: AOAM532V/w9TgsXXEOQ8sbOlH35wVj4mN04ToUjYkM1lRXPHKjZllBIk
 Iilb8HrkkzxQfw9dzD2V65xjHpPgK4k7GgdnB94gBQ==
X-Google-Smtp-Source: ABdhPJxHgzVWHoTeETW6GbwTVhTDrPcpSzMubA6dq6RecXy0rYTv3GXUi+ZekgZNFDrfhmFUhHNsvChag1ADPEHNjP4=
X-Received: by 2002:aca:b206:: with SMTP id b6mr4633547oif.54.1602150156205;
 Thu, 08 Oct 2020 02:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-6-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-6-f4bug@amsat.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 8 Oct 2020 12:42:25 +0300
Message-ID: <CAOEp5OdVOp0DkORY2rLms3sGLCKrmspy27PhBFi=WE6Ntcoa8A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] contrib/gitdm: Add Daynix to the domain map
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000f010cf05b125a673"
Received-SPF: none client-ip=2607:f8b0:4864:20::243;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Yan Vugenfirer <yan@daynix.com>, Basil Salman <basil@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f010cf05b125a673
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ACK
Thanks,
Yuri Benditovich @Daynix


On Sun, Oct 4, 2020 at 9:04 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>
> Cc: Andrew Melnychenko <andrew@daynix.com>
> Cc: Basil Salman <basil@daynix.com>
> Cc: Bishara AbuHattoum <bishara@daynix.com>
> Cc: Daniel Rempel <daniel@daynix.com>
> Cc: Dmitry Fleytman <dmitry@daynix.com>
> Cc: Joseph Hindin <jhindin@daynix.com>
> Cc: Leonid Bloch <leonid@daynix.com>
> Cc: Sameeh Jubran <sameeh@daynix.com>
> Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
> Cc: Yan Vugenfirer <yan@daynix.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 7fd20b1bb0..a27dca6b44 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -12,6 +12,7 @@ baidu.com       Baidu
>  bytedance.com   ByteDance
>  cmss.chinamobile.com China Mobile
>  citrix.com      Citrix
> +daynix.com      Daynix
>  greensocs.com   GreenSocs
>  fujitsu.com     Fujitsu
>  huawei.com      Huawei
> --
> 2.26.2
>
>

--000000000000f010cf05b125a673
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ACK<div>Thanks,</div><div>Yuri Benditovich=C2=A0@Daynix</d=
iv><div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Sun, Oct 4, 2020 at 9:04 PM Philippe Mathieu-Daud=C3=A9 &lt;=
<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">There i=
s a number of contributors from this domain,<br>
add its own entry to the gitdm domain map.<br>
<br>
Cc: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_=
blank">andrew@daynix.com</a>&gt;<br>
Cc: Basil Salman &lt;<a href=3D"mailto:basil@daynix.com" target=3D"_blank">=
basil@daynix.com</a>&gt;<br>
Cc: Bishara AbuHattoum &lt;<a href=3D"mailto:bishara@daynix.com" target=3D"=
_blank">bishara@daynix.com</a>&gt;<br>
Cc: Daniel Rempel &lt;<a href=3D"mailto:daniel@daynix.com" target=3D"_blank=
">daniel@daynix.com</a>&gt;<br>
Cc: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry@daynix.com" target=3D"_bla=
nk">dmitry@daynix.com</a>&gt;<br>
Cc: Joseph Hindin &lt;<a href=3D"mailto:jhindin@daynix.com" target=3D"_blan=
k">jhindin@daynix.com</a>&gt;<br>
Cc: Leonid Bloch &lt;<a href=3D"mailto:leonid@daynix.com" target=3D"_blank"=
>leonid@daynix.com</a>&gt;<br>
Cc: Sameeh Jubran &lt;<a href=3D"mailto:sameeh@daynix.com" target=3D"_blank=
">sameeh@daynix.com</a>&gt;<br>
Cc: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich@daynix.com" tar=
get=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
Cc: Yan Vugenfirer &lt;<a href=3D"mailto:yan@daynix.com" target=3D"_blank">=
yan@daynix.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
One Reviewed-by/Ack-by from someone from this domain<br>
should be sufficient to get this patch merged.<br>
---<br>
=C2=A0contrib/gitdm/domain-map | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map<br>
index 7fd20b1bb0..a27dca6b44 100644<br>
--- a/contrib/gitdm/domain-map<br>
+++ b/contrib/gitdm/domain-map<br>
@@ -12,6 +12,7 @@ <a href=3D"http://baidu.com" rel=3D"noreferrer" target=3D=
"_blank">baidu.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0Baidu<br>
=C2=A0<a href=3D"http://bytedance.com" rel=3D"noreferrer" target=3D"_blank"=
>bytedance.com</a>=C2=A0 =C2=A0ByteDance<br>
=C2=A0<a href=3D"http://cmss.chinamobile.com" rel=3D"noreferrer" target=3D"=
_blank">cmss.chinamobile.com</a> China Mobile<br>
=C2=A0<a href=3D"http://citrix.com" rel=3D"noreferrer" target=3D"_blank">ci=
trix.com</a>=C2=A0 =C2=A0 =C2=A0 Citrix<br>
+<a href=3D"http://daynix.com" rel=3D"noreferrer" target=3D"_blank">daynix.=
com</a>=C2=A0 =C2=A0 =C2=A0 Daynix<br>
=C2=A0<a href=3D"http://greensocs.com" rel=3D"noreferrer" target=3D"_blank"=
>greensocs.com</a>=C2=A0 =C2=A0GreenSocs<br>
=C2=A0<a href=3D"http://fujitsu.com" rel=3D"noreferrer" target=3D"_blank">f=
ujitsu.com</a>=C2=A0 =C2=A0 =C2=A0Fujitsu<br>
=C2=A0<a href=3D"http://huawei.com" rel=3D"noreferrer" target=3D"_blank">hu=
awei.com</a>=C2=A0 =C2=A0 =C2=A0 Huawei<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div>

--000000000000f010cf05b125a673--

