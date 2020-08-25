Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F08C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C3A206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPGRb1Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C3A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATjU-0002Ei-H7
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATiw-0001jg-S6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATiv-00047h-1H
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598341827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDzspAHVJh/pb6D1UPvSxrfAPscL+1ZpzG2DdAEyJD0=;
 b=CPGRb1OgQaeBCHA77Xvs4s4PQ84bWuUguWUEeB6L2ntWppWv2Q+uOXXjek1T48ZOa1Fc6u
 GisS3uKl8uxvaCGFnFww6icILnDNolvJ9/lXmtFyPSz70x2B0DW7peEuxlADSQInwdCk0z
 Z94w/cTb8kPbwxyyrdfnc7e0x163sgo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-ZXkLX2-DM5Sk-Po1d_OqtQ-1; Tue, 25 Aug 2020 03:50:23 -0400
X-MC-Unique: ZXkLX2-DM5Sk-Po1d_OqtQ-1
Received: by mail-ej1-f69.google.com with SMTP id i21so210371ejj.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pDzspAHVJh/pb6D1UPvSxrfAPscL+1ZpzG2DdAEyJD0=;
 b=hqx1RO8RzLCNHXw0HJagXsGkki3y6UMWxfLd7c8mCQr7E/rG11uOzPB6AJS4YxJdrM
 /zXbPoUTMWrNbeHnSydSsR9+yAKGNo4OvnijsqT8tVzVJ/KDYfj2FFckaVdE7W0VS6XE
 DiRF6Oh5gJYMePgAsPjR+PvX/fqOX+fhzFRdMWuqJivmkvlahdY75TsU+F4d8mIVlS1y
 yAS29Afy97AFAEK6xA9xv8WV4CwqGVYUbNDV4n7qFNVrg0mT+hZBMZ1FqnMexXXq0Rug
 eXgvB8hKVAQjKiRhM9WBAc0/cQSpqoaRhwV/a/2EzFf3lTHJlgGGty9w2Ql2JOLvqm8W
 YzNQ==
X-Gm-Message-State: AOAM5313+jeB0hcBcnPeFD25gz44hsImGDYRebVZgckPHIlyvfbRKK8H
 Ulgz7k1fh1pSvTpxthFk9vCMrzd+fOSrJmc1hjsJxUdYjjVafA+kmgwQ/0ESHuS8B/sFz97kc46
 rQUbjtzOkyr99r6qYnDACZqfGQAN1yXE=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr8423676ejr.543.1598341821819; 
 Tue, 25 Aug 2020 00:50:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuhc0TrX+2Vrc+pHh5WU+0Rx6x/gLTrfD2meQSvivd88Vgcwsh6sZsxelGCpsl1xpUUszdhFQAkDQvRb/9Obw=
X-Received: by 2002:a17:906:57d9:: with SMTP id
 u25mr8423660ejr.543.1598341821622; 
 Tue, 25 Aug 2020 00:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200824163109.96938-1-berrange@redhat.com>
In-Reply-To: <20200824163109.96938-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:50:10 +0200
Message-ID: <CABgObfYmRLJuv+_C6Wfe2g6Cf1Oq7WbM=Y3WtMd4Et1E9DgAeQ@mail.gmail.com>
Subject: Re: [PATCH] configure: default to PIE disabled on Windows platforms
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000008202a205adaef472"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008202a205adaef472
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Paolo

Il lun 24 ago 2020, 18:31 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> If Windows EXE files are built with -pie/-fpie they will fail to
> launch. Historically QEMU defaulted to disabling PIE for Windows,
> but this setting was accidentally lost when the configure summary
> text was removed in
>
>   commit f9332757898a764d85e19d339ec421236e885b68
>   Author: Paolo Bonzini <pbonzini@redhat.com>
>   Date:   Mon Feb 3 13:28:38 2020 +0100
>
>     meson: move summary to meson.build
>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Fixes: f9332757898a764d85e19d339ec421236e885b68
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure b/configure
> index 67832e3bab..b6f3b6e191 100755
> --- a/configure
> +++ b/configure
> @@ -857,6 +857,7 @@ MINGW32*)
>      audio_drv_list=3D""
>    fi
>    supported_os=3D"yes"
> +  pie=3D"no"
>  ;;
>  GNU/kFreeBSD)
>    bsd=3D"yes"
> --
> 2.26.2
>
>

--0000000000008202a205adaef472
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Queued, thanks.<div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Il lun 24 ago 2020, 18:31 Daniel P. Berrang=C3=A9 &lt;<a hr=
ef=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; ha scritto:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">If Windows EXE files are built with =
-pie/-fpie they will fail to<br>
launch. Historically QEMU defaulted to disabling PIE for Windows,<br>
but this setting was accidentally lost when the configure summary<br>
text was removed in<br>
<br>
=C2=A0 commit f9332757898a764d85e19d339ec421236e885b68<br>
=C2=A0 Author: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
=C2=A0 Date:=C2=A0 =C2=A0Mon Feb 3 13:28:38 2020 +0100<br>
<br>
=C2=A0 =C2=A0 meson: move summary to meson.build<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@r=
edhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;=
<br>
<br>
Fixes: f9332757898a764d85e19d339ec421236e885b68<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0configure | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/configure b/configure<br>
index 67832e3bab..b6f3b6e191 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -857,6 +857,7 @@ MINGW32*)<br>
=C2=A0 =C2=A0 =C2=A0audio_drv_list=3D&quot;&quot;<br>
=C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0supported_os=3D&quot;yes&quot;<br>
+=C2=A0 pie=3D&quot;no&quot;<br>
=C2=A0;;<br>
=C2=A0GNU/kFreeBSD)<br>
=C2=A0 =C2=A0bsd=3D&quot;yes&quot;<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div>

--0000000000008202a205adaef472--


