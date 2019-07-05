Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C27BC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE67B20828
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyL3hlik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE67B20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjP1W-0000Ye-6m
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hjOv9-0003JD-1i
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hjOv8-0008Mv-0Q
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:10:38 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:41514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1hjOv7-0007hn-Ml; Fri, 05 Jul 2019 10:10:37 -0400
Received: by mail-io1-xd43.google.com with SMTP id j5so19070ioj.8;
 Fri, 05 Jul 2019 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jc8T6B1sYMgE8KUu3r8iCtOxhFzftBC0DO27E9t5POg=;
 b=tyL3hlikgB7h11DqJBXwuvH1+JMnWTh2xDiNBC/IEwBdd1G6UxmyHfDcWRclCr4OPL
 WGlaPixlePBhQzKgbBNrMvj+a3PtJlAvyOisdABzL1cqS+ZjhhJwsEHMipfeAUzH+6fW
 EpIj8DZL74u/8uKgoI3ZKhpQrdk1YBZwe4sba8xlIkOxiz4phnwIp6nTSyM55dRV9W2Q
 Wv2svVhyMFggrQ0a9BLg9zVx8BJ07DQ48muqSckgK0s+vmqjK0g+Ndp29yBQ1t8s/2hl
 0O7HiiMSABZLCveKMDOq+0mNSd0voyx+MdyPd6MEMaY/vAu31+5YtK7Bp7yrfqcnehhU
 UOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jc8T6B1sYMgE8KUu3r8iCtOxhFzftBC0DO27E9t5POg=;
 b=X86y5N9flKx5B645lIqoXsOLwvZEc5YxLJpdd5MbJWaQfILYnOGWSQH4sc+hO/O3bv
 2IZUC5mOx2srdtbb2hcD3dZHvFQhmxp5j7hOyQIx2gVjfzBMEnjTaN0qbaqk+WX3yeSd
 KjCSdfQeYwH9E9LkEPEBAAVylqHw5vWwyMNGCjOYkJ4TBd35F19X4Q1cc3b9R+0Ki3xg
 GZXnb5u6K8VkHJHpyeMwJhFqOgWsCVsvZKPHt68Re0yuoRZzk08FV+A40A4bBwJkM5Kb
 iRzFR0laJVXYyYmHCVNeoKEAiEorm3/GpwGkZXf4vfjjC7i/wWKRxo/O2c3p7cLkxqVw
 tk5Q==
X-Gm-Message-State: APjAAAXIylSBLuwZmNGiJhH17DoUGN/oSmBznfuwzQC5sdbCxW8hi5mY
 7XR7AtI+RIHk5T62hsc9vumJ9Nfvu7mtjYc329s=
X-Google-Smtp-Source: APXvYqw498Icl14jRiBkwlADDXenfHTPtE0s9hLvZO1diJiBgjG12GHUUUc/aR3ZyCJaFgHxH5+1DSeq2xvT9WUbiHw=
X-Received: by 2002:a02:ab83:: with SMTP id t3mr4830212jan.133.1562335828673; 
 Fri, 05 Jul 2019 07:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190705124318.1075-1-philmd@redhat.com>
In-Reply-To: <20190705124318.1075-1-philmd@redhat.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 5 Jul 2019 16:10:27 +0200
Message-ID: <CABoDooNn3HzrgDd3sreGDogFE=_L26=si-ddkeZ6paeoMF+v6w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH] target/arm/vfp_helper: Call
 set_fpscr_to_host before updating to FPSCR
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 5, 2019 at 2:43 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> In commit e9d652824b0 we extracted the vfp_set_fpscr_to_host()
> function but failed at calling it in the correct place, we call
> it after xregs[ARM_VFP_FPSCR] is modified.
>
> Fix by calling this function before we update FPSCR.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/vfp_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 46041e3294..9710ef1c3e 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -197,6 +197,8 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t=
 val)
>          val &=3D 0xf7c0009f;
>      }
>
> +    vfp_set_fpscr_to_host(env, val);
> +
>      /*
>       * We don't implement trapped exception handling, so the
>       * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES=
0!)
> @@ -217,8 +219,6 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t=
 val)
>      env->vfp.qc[1] =3D 0;
>      env->vfp.qc[2] =3D 0;
>      env->vfp.qc[3] =3D 0;
> -
> -    vfp_set_fpscr_to_host(env, val);
>  }
>
>  void vfp_set_fpscr(CPUARMState *env, uint32_t val)
> --
> 2.20.1
>

