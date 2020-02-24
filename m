Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B511BC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811D620828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcE8gqPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811D620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6EpZ-0001Su-Kv
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Eis-0006qT-AH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Eir-0000kA-4C
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:28:38 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Eiq-0000jy-Tw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:28:37 -0500
Received: by mail-oi1-x244.google.com with SMTP id r137so9081291oie.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dw3CxszVkLAu2ZRX8gCPmNiiUMcSwj7RzrSUwqQhNQo=;
 b=dcE8gqPZfcp2iDlczUiUGK8sJv1mZ9KiS7FKuBGRODzinEJeUs2kHF0ndeJa/vV7hl
 vsROW3Q5Ji8LJvVtAWEoCJJSZUkmzW/OCjQqgPXRAs9//tNvzAl4/crD1AO4c1MNL7nW
 4Mijki9uLNnCAWBdU6Dg8qjiHQExGdXT6000zMwVnpYfP8gJgj0b4Yj1rzxoEsBSm2bF
 AzhN6TZhtukwkRIEByW+PiHdoVRDuJ06bDlVyo4Og6lm6bqgEGWhq9PQ/k8Ob2rVKqIc
 O1b9W9KN8TXCAwjpFwt9zBq8dAyArZvtI14mOmiIHqvJ8iYkP1Oz2/NEKXFIXirjqi+t
 Km6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dw3CxszVkLAu2ZRX8gCPmNiiUMcSwj7RzrSUwqQhNQo=;
 b=Y8I9TlATZN/QWlZ7KOIpvFENkevMtIiCOf595qGNVGR31HlIo3rHqpIue5uppNGiSr
 MATp3xN75+ErRnjqzP28cPU6rx/PjnwyTqn7Ve04HBYwM13vZbNiUZNi/QglyW8+ykA8
 KThc1b+QJHS+Lv0kMNGyccaiQVTWhZwwGpFR36VQ8EEPcBCL4XU/t8K47UxS5xnwpcV0
 4cl53XU6ZEo5tkUML9nrZTN/sNOoR41DNG/hBrN9EuJ4DtLZ2IXjX8GyCt0/WPxiVCfz
 +Vnu/WkKMHVs/XQyktj4/rxpXANxAGiAXmAgW+y5lBPeyeonxGOt3TdprUpaPMA6RAii
 +VCA==
X-Gm-Message-State: APjAAAXTidqP9wz575Gs/fNQY1bbY1bc/GYKfN/Co8FqcaMyb/wAIzse
 tVyQC+5aHqoxvDnJw70JeiBbBfU8Aq0SjtnW1VcTZQ==
X-Google-Smtp-Source: APXvYqzM1pRKh4uZqEbVm5r+fsJ+YQmtA3NZlVAuk8O1EF2zHZGIqNBt66qeVcvO8H/yxMYOM4OOGi3Sndsc7MmQYag=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr12346948oie.146.1582554515826; 
 Mon, 24 Feb 2020 06:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20200223132750.69480-1-ysato@users.sourceforge.jp>
 <20200223132750.69480-24-ysato@users.sourceforge.jp>
In-Reply-To: <20200223132750.69480-24-ysato@users.sourceforge.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2020 14:28:24 +0000
Message-ID: <CAFEAcA-1Uu2EAHt7d7bhRQC5o9wqmX_DNg6B6S5wsqSA9joTVQ@mail.gmail.com>
Subject: Re: [PATCH v31 23/23] fix warning.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Feb 2020 at 13:33, Yoshinori Sato <ysato@users.sourceforge.jp> wrote:
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  hw/rx/rx-virt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
> index 6cf7936201..4ee6647728 100644
> --- a/hw/rx/rx-virt.c
> +++ b/hw/rx/rx-virt.c
> @@ -90,8 +90,10 @@ static void rxvirt_init(MachineState *machine)
>
>      /* Load kernel and dtb */
>      if (kernel_filename) {
> -        /* The kernel image is loaded into
> -           the latter half of the SDRAM space. */
> +        /*
> +          The kernel image is loaded into
> +          the latter half of the SDRAM space.
> +        */

The comment format we prefer is described in CODING_STYLE.rst;
for block comments, and it looks like this:
    /*
     * Leading and closing slash-star and star-slash
     * on their own line; each other line has a star
     * in the left column.
     */

thanks
-- PMM

