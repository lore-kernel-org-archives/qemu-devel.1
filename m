Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FFDC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B732070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QY7oqpfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B732070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBui-00029R-5o
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdBt7-0001El-Ok
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdBt6-0002Jp-Mk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:02:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdBt4-0002FO-OK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:02:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id l15so4168797otn.9
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f8CQP83j89Nl2Th36p57uvmIreOMxHar8aEoN+/+jnk=;
 b=QY7oqpfBouT7I8sXtlFZqQNHjDlf0ox8T21AeQT935VRHML4Svm5VdxlJP6Nwpmf9Z
 fD0VGxuFDvl6/2l4i5E5KYWsJZsItp4mXDrv8cL7vGlssZDar72HcnsGWYLdQcX7HTQ7
 BOBUFpFsGWI7JtGBRa9NPuGr5MZZ3hyje9tTDRa9nYaHqTAahLWmg3HCtj0DhOXb0G/e
 kqRspsafbB9qtZpmX8vacW1Zz9obWMsBAiK5I6Lnkl98w+I7hw5elv1g25ipyu4jhYYb
 4ucfqKAOvVHVFI4Y7xJnJqJatJW9asp+tN9wdjyhPg7SZJmAC+lX3MZF/EyUsUQhZ603
 iWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f8CQP83j89Nl2Th36p57uvmIreOMxHar8aEoN+/+jnk=;
 b=C0L3rP5W0XYoKo6utfejNxzeAp8c8LD8FvZIY7vCIkla3sTWXyxDjme3LfycXwMIVO
 t5BW21VdbVGMi/mhv4sJ+W4chAbgD4dT+BnMLc0PM9FeLpjpaEX+5JK9lc8o669EH94O
 w0WQKSLsTY/BL5MnZogfh79L9ZM/3+7uvayiyAEZmFqnQtATrgC3ziUaaf032rrTAiWO
 mYRATXICy44P+QjSDVExoXNiPtDa5B9ZJCE9G7IO4JcSA4rrYwYDfzBfaj729dnEUFU9
 F0BwI9SlURLvzbnUiHNaUwCnsGAz5d90qsrQMxfjXQDbi12EUq+4kjzcfycQSaVwi2w8
 o5cQ==
X-Gm-Message-State: APjAAAUiuIBQKP7l1zzfCi7DA+NPYz3cgHNzDbGkVDO6bz1shDzdER0C
 PziwitvtiErsFIv4HX8Eq2FGn5TFAA7pNhPojY0jpg==
X-Google-Smtp-Source: APXvYqy/VkfZMGHkrlLbmf3pKpsMrJCNimcIXNdtOZOgYQDmaeix8C59Y5PLPz2AiOP4GXpdHpguSnEMfoAqopL/fFg=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr3991972otj.97.1560855768349; 
 Tue, 18 Jun 2019 04:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190618083442.10407-1-drjones@redhat.com>
In-Reply-To: <20190618083442.10407-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 12:02:37 +0100
Message-ID: <CAFEAcA9bwbev3efZ=LJPGgObBCbW-WX19fySMusLyMNC5ZExvA@mail.gmail.com>
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: fix direct kernel boot setup
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 09:34, Andrew Jones <drjones@redhat.com> wrote:
>
> We need to check ram_end, not ram_size.
>
> Fixes: 852dc64d665f ("hw/arm/boot: Diagnose layouts that put initrd or
> DTB off the end of RAM")
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index b2f93f6beff6..8a280ab3ed49 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -1109,7 +1109,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>                               info->initrd_filename);
>                  exit(1);
>              }
> -            if (info->initrd_start + initrd_size > info->ram_size) {
> +            if (info->initrd_start + initrd_size > ram_end) {
>                  error_report("could not load initrd '%s': "
>                               "too big to fit into RAM after the kernel",
>                               info->initrd_filename);
> --
> 2.20.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I think I missed this because my test case doesn't have an
initrd -- direct kernel boot works fine if all you're
passing to QEMU is the kernel... I think we could clarify
the commit message a little:

hw/arm/boot: fix direct kernel boot with initrd

Fix the condition used to check whether the initrd fits
into RAM; this meant we were spuriously refusing to do
a direct boot of a kernel in some cases if an initrd
was also passed on the command line.

?

(if you agree I can just fix up the commit message when I apply it.)

thanks
-- PMM

