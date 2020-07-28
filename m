Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3732AC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D5120714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRqUuFEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D5120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Ltp-0005L7-BT
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0LtI-0004v2-K5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:27:20 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0LtG-0001Ay-Ob
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:27:20 -0400
Received: by mail-oi1-x242.google.com with SMTP id w17so16885784oie.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0jlqF1vNQDLT4jtpLs7LnhRZhztTYxX9+FwYb5e1cXw=;
 b=eRqUuFEncWn7FuFUnXBers8AJ9XN0eRqhILUyjbnliu64xB8yyByOZvCMI8cIVmplA
 ym5Oxrcg+dSpxd2RBRjREgyV/ymKJDz8B4vMzGuXGq3h5dIOW0dUitokRqDa9tEBn+Sj
 Zag69kqe1yR3RsBzVRNoHcGdu9bU7JANw0ruGcMwpI7Z0oL0IEXLyGn+XzCt2qEFHn9t
 MOmppHvcvytbbG3ruItt/Tone39XjHwj5rIRgK+PHa+G0cjBsGDrx57lgtIob0Zr/z+m
 k2T5DMBv0uxS2s1jdwvMvoC90YECmFkKNcebLbdwSdUuA7PrFdI6hOhdbPO3KdnlCFxJ
 y8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0jlqF1vNQDLT4jtpLs7LnhRZhztTYxX9+FwYb5e1cXw=;
 b=VyqsusKKsSzQxSq6PF2zkmpeJqNrM7peBvX2EDodJ9IoZ9tcFHAkJ4iIdMYdy8ReZT
 4Jg34ZY6MRUKlWtxAzHOtMAthUyPLYGz02kWh2D1ssm/S6TE4G/7+aQz0uCExe3kzHNS
 H4EeLSjO3mNlpZD6mujKFwZ8ywWt+893L3CiCOGTvZW1UKd5+qAoKBgSn2lQl8dd6jbE
 UWHMQMCFe+3dxmtaV1goikQDSdUbgqmuP9gf/Yt6Az/qJ5f+PRb48qzo5263vCVcNNWT
 QtBE0VWwiOW+YzZ1X64yaFFY06FuYcreZbGUOYvYl+eI+prFSsaLRpuQCJuN6Xup8n0V
 Fsaw==
X-Gm-Message-State: AOAM5318kfKcfn9e6H8mFR2VzhzZtEtJcgbQwf9Lb6TqVd1hC2mJJZdA
 EpjC4aGhynf1XtEihiG3dj4aj0AAKviQapRk9yfDtQ==
X-Google-Smtp-Source: ABdhPJx7pJQRRKQTwke8VyQeZ02E0pIOiXvGYB2MeLNmSe8kmmcIflbUUPw95KHqQOILTAurpITPfgKIJUh6zSV6dIo=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr2689821oia.163.1595928437503; 
 Tue, 28 Jul 2020 02:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200728091828.21702-1-paul@xen.org>
In-Reply-To: <20200728091828.21702-1-paul@xen.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 10:27:06 +0100
Message-ID: <CAFEAcA_wKTFWk9Uk5HMabqfa6QkkTAdzBotmnrA_EH1BR4XjYg@mail.gmail.com>
Subject: Re: [PATCH] configure: define CONFIG_XEN when Xen is enabled
To: Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <pdurrant@amazon.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 10:19, Paul Durrant <paul@xen.org> wrote:
>
> From: Paul Durrant <pdurrant@amazon.com>
>
> The recent commit da278d58a092 "accel: Move Xen accelerator code under
> accel/xen/" introduced a subtle semantic change, making xen_enabled() alw=
ays
> return false unless CONFIG_XEN is defined prior to inclusion of sysemu/xe=
n.h,
> which appears to be the normal case. This causes various use-cases of QEM=
U
> with Xen to break.
>
> This patch makes sure that CONFIG_XEN is defined if --enable-xen is passe=
d
> to configure.
>
> Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/")
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> ---
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure b/configure
> index 2acc4d1465..f1b9d129fd 100755
> --- a/configure
> +++ b/configure
> @@ -7434,6 +7434,7 @@ if test "$virglrenderer" =3D "yes" ; then
>    echo "VIRGL_LIBS=3D$virgl_libs" >> $config_host_mak
>  fi
>  if test "$xen" =3D "yes" ; then
> +  echo "CONFIG_XEN=3Dy" >> $config_host_mak
>    echo "CONFIG_XEN_BACKEND=3Dy" >> $config_host_mak
>    echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=3D$xen_ctrl_version" >> $confi=
g_host_mak
>  fi

Configure already defines CONFIG_XEN as a target-specific
config define in config-target.mak for the specific targets
that Xen will work for (ie if you build --enable-xen for
x86_64-softmmu and ppc64-softmmu then CONFIG_XEN is set for
the former and not the latter). This patch makes it a
build-wide config setting by putting it in config-host.mak.

We should figure out which of those two is correct and do
just one of them, not do both at the same time.

Since CONFIG_HAX, CONFIG_KVM and other accelerator-type
config defines are also per-target, I suspect that the
correct fix for this bug is not in configure but elsewhere.

thanks
-- PMM

