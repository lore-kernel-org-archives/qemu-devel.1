Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34277C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E8B20714
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF93VCYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E8B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTsO-0000aC-E1
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 07:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQTrN-00008x-0c
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:13:21 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:38580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQTrL-0002ys-8H
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:13:20 -0400
Received: by mail-yb1-xb42.google.com with SMTP id b138so1923367yba.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tKiePFVCzROxpS2jDOzhB2Nc2wU71w2Ur0mvDIAylNY=;
 b=PF93VCYPPUQe6tvhgaHEP50ZbksOtHF2J9Kwc3+mAwlaj78yfOB8zap1AeC6kjkJ6t
 fyeEzP4srorLdsU/5eoFQ4q7iGrGJgQ3HF/7Y3iBlARiqHm34vJqtyKsIO2idiHvfM6j
 B9E2TUszLKRjtYeqDLeuLb7TtXxy1WGXNKbIedAKrluZhZAnuhtmjYzGVxgENDPr55W1
 tY+rWSK02NJGyxQaCB6lKNM4As1RjhZB2qj/xObNtFjv196NVwZcHBrq+ikNFMOkecNW
 5f0O0USMQ88X0lB0L9bCFji3+ayQPAtZPDIfVo3pOgTkAHJqzFEoPrJc+tu6x2wmzaZI
 00wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tKiePFVCzROxpS2jDOzhB2Nc2wU71w2Ur0mvDIAylNY=;
 b=DJkp3IqCSQEvB4Xkah4ajZ3vbqxew6E92IELh3IKubkCEg3NN9aKv6Pf+sQIKXFfyh
 FEwYVIFvwEWb/Q8n63nxPVrFZToMUWjWVZJLh85tEZLyACBsVLwAdmEhszKvv3CMs5pe
 s5XWjGTIq28kB/WC3p5UwtEH/boMFEGlWKX909SuKYjOKqsxiIHi2lZRMLgih6T42Bxz
 CybjNURHveCewUV7hmGZND50VJ3teKGWGe5Py2czPoBwGplJwUBfm2Jn4xJkAr4TQGpA
 4HXIckaK6BBGibFBNbg09iVRuH0GFZqH54CBxUsuPUm+jDy3CkTLIFJ2+YGxzKf3kI7T
 9vtw==
X-Gm-Message-State: AOAM530s1kOZCK/rklMcqRJheKXmW4w0aRoCMztC12H3pq75et92cgvM
 CMX2vdthls/agOaxeZbTxbJZHovCwp4+KUjmHzY=
X-Google-Smtp-Source: ABdhPJyOig6EH7xhU17U46YWjXSPVkpYUggtRR1XtKzCZUEzW+KjFDZfJ7vWLQ+q5/6tb4ksNXL5UMOvA62XyhGkfsg=
X-Received: by 2002:a25:b78d:: with SMTP id n13mr10104115ybh.152.1602155597706; 
 Thu, 08 Oct 2020 04:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-19-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-19-f4bug@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Oct 2020 19:13:06 +0800
Message-ID: <CAEUhbmVEmpU1kLMXrS9ZRiw607E49+tYgb_12-zfkPnWEfxR4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 18/21] contrib/gitdm: Add Wind River to the domain map
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Jim Somerville <Jim.Somerville@windriver.com>,
 Bill Paul <wpaul@windriver.com>, Vlad Lungu <vlad.lungu@windriver.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Tiejun Chen <tiejun.chen@windriver.com>,
 Yiting Wang <yiting.wang@windriver.com>,
 Jason Wessel <jason.wessel@windriver.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Mon, Oct 5, 2020 at 2:05 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>
> Cc: Bill Paul <wpaul@windriver.com>
> Cc: Bin Meng <bin.meng@windriver.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Jim Somerville <Jim.Somerville@windriver.com>
> Cc: Tiejun Chen <tiejun.chen@windriver.com>
> Cc: Vlad Lungu <vlad.lungu@windriver.com>
> Cc: Yiting Wang <yiting.wang@windriver.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
>
> Ben, can you confirm your bmeng.cn@gmail.com address?
> Should it be considered 'individual contribution' instead?

Yes, I think so. Thanks for the patch.

Otherwise,

Acked-by: Bin Meng <bin.meng@windriver.com>

> ---
>  contrib/gitdm/domain-map          | 1 +
>  contrib/gitdm/group-map-windriver | 1 +
>  gitdm.config                      | 1 +
>  3 files changed, 3 insertions(+)
>  create mode 100644 contrib/gitdm/group-map-windriver
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 9642fd44fc..6b3a2c3b4e 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -39,4 +39,5 @@ suse.de         SUSE
>  virtuozzo.com   Virtuozzo
>  wavecomp.com    Wavecomp
>  wdc.com         Western Digital
> +windriver.com   Wind River
>  xilinx.com      Xilinx
> diff --git a/contrib/gitdm/group-map-windriver b/contrib/gitdm/group-map-=
windriver
> new file mode 100644
> index 0000000000..8b4662daa9
> --- /dev/null
> +++ b/contrib/gitdm/group-map-windriver
> @@ -0,0 +1 @@
> +bmeng.cn@gmail.com
> diff --git a/gitdm.config b/gitdm.config
> index 6db72da339..c384d0f4ab 100644
> --- a/gitdm.config
> +++ b/gitdm.config
> @@ -40,6 +40,7 @@ GroupMap contrib/gitdm/group-map-janustech Janus Techno=
logies
>  GroupMap contrib/gitdm/group-map-nutanix Nutanix
>  GroupMap contrib/gitdm/group-map-oracle Oracle
>  GroupMap contrib/gitdm/group-map-renesas Renesas
> +GroupMap contrib/gitdm/group-map-windriver Wind River
>
>  # Also group together our prolific individual contributors
>  # and those working under academic auspices
> --

Regards,
Bin

