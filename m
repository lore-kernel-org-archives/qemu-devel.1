Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AF320665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="1V4lTIB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AF320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPL7q-0007Zu-2l
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kPL6S-0006aC-3M
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:40:13 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjiachen.jaycee@bytedance.com>)
 id 1kPL6I-0001XF-LS
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:40:09 -0400
Received: by mail-qk1-x742.google.com with SMTP id b69so4298239qkg.8
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+v6SnGFXAurzhqMimeFgzWxfOnlEGFn19Zbd54mEouw=;
 b=1V4lTIB+fCZHzJfH+bzg0ARH1pbl1xW+sMH4EiM3UAEEBkDcqL0WOGr1gvp3p1bXuz
 MPpt8g4dikMuGOFUeP7fjQCWmKknz2nP+4O/enhwfQQtiSy/gIS27yeTOV9DalOfX/Rn
 iCWDPpWXW+1D0T30tja2/bRrwWX0MAoD+avx7HnUg06RWASxnxJsrx3pQ6HD58jcOADy
 Byi1RbdFd75Q7oYr4AJ3sNVlN99NJwAMKT3U4s+Q0XZfC7veEE+ORaFtFuqx41MuW52r
 T9tJH/1ddwnpjRnwYJNgOBU8JT2tPHk1qL2SFIq7ry66C0H0+h6cF+AojgSgw1SBOa1P
 oMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+v6SnGFXAurzhqMimeFgzWxfOnlEGFn19Zbd54mEouw=;
 b=qd/ItH0tQXnqOku7duaRFnmDhxqoptwSSJlI650A6sdfDWK0+u73VIc/6ULOuqkqm+
 9ToMguRkePJ1ffajPhXRas5qjyl6mxEcNpsCbChoERnk17LWncnKF6QBFG1q828o3pyc
 r5HlAPzeU2JxqYG6Mbbrdp3KVrxebsaB1ZEH6w14JIIFSYBGjy+j1u7yB/nGmi7eNvVl
 7TupobgNdjAnMwllDxG11wh8aSCuam2T7Ig4gyvKKZzh1WpEt33IQtWFdl6qQWLFiIuD
 l5xhCSAa2ok1JgwQ5AXGViKtXJnwHBauGqdke7eOn/pFmzGRNvpa82zZQmedrS4pL/Gx
 FvJg==
X-Gm-Message-State: AOAM533EIB8Y+GJCpj6Jgrj5aouVqH8Wg/4xtrvwbHHPo1hBpBH+U+bv
 a/fzqLL+pC721OKfPRKIbIAPnpj7woxyBOBI8TFhuA==
X-Google-Smtp-Source: ABdhPJw+50PDQGil/7RSj2BL44DTonjJxmC3AMtNZmsUFkOqRDOj+5K+Tr7s2RagcrkZwVrm6zFgkqGW7W2xZuyVwsI=
X-Received: by 2002:a05:620a:1ef:: with SMTP id
 x15mr12769063qkn.182.1601883600545; 
 Mon, 05 Oct 2020 00:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-5-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-5-f4bug@amsat.org>
From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date: Mon, 5 Oct 2020 15:39:49 +0800
Message-ID: <CAFQAk7jGfCqwSwDyJUYnA=JpvywTgxeqPR4KY4UB1zcUd+j0Og@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] [RFC PATCH 04/21] contrib/gitdm: Add
 ByteDance to the domain map
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000fb866f05b0e796df"
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=zhangjiachen.jaycee@bytedance.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Zhenwei Pi <pizhenwei@bytedance.com>, Xie Yongji <xieyongji@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fb866f05b0e796df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2020 at 2:04 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>
> Cc: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>
> Cc: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Cc: Zhenwei Pi <pizhenwei@bytedance.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 0eaa4ec051..7fd20b1bb0 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -9,6 +9,7 @@ amazon.com      Amazon
>  amazon.de       Amazon
>  amd.com         AMD
>  baidu.com       Baidu
> +bytedance.com   ByteDance
>  cmss.chinamobile.com China Mobile
>  citrix.com      Citrix
>  greensocs.com   GreenSocs
> --
> 2.26.2
>
>
Acked-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Thanks!
Jiachen

--000000000000fb866f05b0e796df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 5, 2020 at 2:04 AM Philippe M=
athieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The=
re is a number of contributors from this domain,<br>
add its own entry to the gitdm domain map.<br>
<br>
Cc: Guoqing Zhang &lt;<a href=3D"mailto:zhangguoqing.kernel@bytedance.com" =
target=3D"_blank">zhangguoqing.kernel@bytedance.com</a>&gt;<br>
Cc: Jiachen Zhang &lt;<a href=3D"mailto:zhangjiachen.jaycee@bytedance.com" =
target=3D"_blank">zhangjiachen.jaycee@bytedance.com</a>&gt;<br>
Cc: Xie Yongji &lt;<a href=3D"mailto:xieyongji@bytedance.com" target=3D"_bl=
ank">xieyongji@bytedance.com</a>&gt;<br>
Cc: Zhenwei Pi &lt;<a href=3D"mailto:pizhenwei@bytedance.com" target=3D"_bl=
ank">pizhenwei@bytedance.com</a>&gt;<br>
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
index 0eaa4ec051..7fd20b1bb0 100644<br>
--- a/contrib/gitdm/domain-map<br>
+++ b/contrib/gitdm/domain-map<br>
@@ -9,6 +9,7 @@ <a href=3D"http://amazon.com" rel=3D"noreferrer" target=3D"=
_blank">amazon.com</a>=C2=A0 =C2=A0 =C2=A0 Amazon<br>
=C2=A0<a href=3D"http://amazon.de" rel=3D"noreferrer" target=3D"_blank">ama=
zon.de</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0Amazon<br>
=C2=A0<a href=3D"http://amd.com" rel=3D"noreferrer" target=3D"_blank">amd.c=
om</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD<br>
=C2=A0<a href=3D"http://baidu.com" rel=3D"noreferrer" target=3D"_blank">bai=
du.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0Baidu<br>
+<a href=3D"http://bytedance.com" rel=3D"noreferrer" target=3D"_blank">byte=
dance.com</a>=C2=A0 =C2=A0ByteDance<br>
=C2=A0<a href=3D"http://cmss.chinamobile.com" rel=3D"noreferrer" target=3D"=
_blank">cmss.chinamobile.com</a> China Mobile<br>
=C2=A0<a href=3D"http://citrix.com" rel=3D"noreferrer" target=3D"_blank">ci=
trix.com</a>=C2=A0 =C2=A0 =C2=A0 Citrix<br>
=C2=A0<a href=3D"http://greensocs.com" rel=3D"noreferrer" target=3D"_blank"=
>greensocs.com</a>=C2=A0 =C2=A0GreenSocs<br>
-- <br>
2.26.2<br>
<br></blockquote><div><br></div><div>Acked-by: Jiachen Zhang &lt;<a href=3D=
"mailto:zhangjiachen.jaycee@bytedance.com">zhangjiachen.jaycee@bytedance.co=
m</a>&gt;</div><div><br></div><div>Thanks!</div><div>Jiachen=C2=A0</div></d=
iv></div>

--000000000000fb866f05b0e796df--

