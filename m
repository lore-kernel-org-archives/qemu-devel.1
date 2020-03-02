Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BEFC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF112084E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofITedib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF112084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8n4A-0007Oe-CN
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8n3U-0006pP-Mv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8n3T-0005VU-Iq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:32:28 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8n3T-0005VF-D6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:32:27 -0500
Received: by mail-oi1-x242.google.com with SMTP id l12so10637032oil.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 07:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l3lNOdCR3iLHNZzGzLWGwLb5L8dH5qv03+MdBD0/6nw=;
 b=ofITedibZY/xsjFJtyM5mVfXxW/IQyg/JxgzXirwvHYom0pnGiFz2hk/gfJAvaUeZR
 Wn8Kplgg3n1grmVyBzSAndWX2K7XdeKIh5E62jgxhrisdnsg98kqeZ1r14UR+K1srWfn
 aF71HdHV2qwoF19/szgYotRV4UkKP8GO/4gVU0+zYKSWDFYK/mVpQPMVX+hkYtbLr7oQ
 GSdmGY6LqR/2owcfJNbulPe9F/Dbh9PPMlI1Gz3tjBbAtb6UZ524wvr1dVytsOFCh/hA
 GKz80vJKHF0loQf863DZ5MOZlkXiv51OS6J2AUQF2S8u8Fgvkek2KAPEvNSfiEroGTe1
 vo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l3lNOdCR3iLHNZzGzLWGwLb5L8dH5qv03+MdBD0/6nw=;
 b=K7uyhc435eDK4ZF399xaS9CBonuzPKROJW5QpXq+LZ7DJ81yEvcdXHp4ndzNLE2JB9
 kAyjxt+Kmu9j0DrzuTvj9kLU5+/+jDnwRvnYHO1F3mO0zGBLjNieNjCbOzV1TnuqN9fz
 F1Lku44KUIPeEDbpm7QGhg8pbgZbwM/VCx+YKkphrDRkIFQGxdphCG3fnkIBf9RA7fMY
 F+QwKPrecwH5yzaxC6lkO5griVTHJcp6NaE8mJn7Ddkcp9tWHJFZrZpkQqEGyYVJPVlj
 OUaxEObLoPNYxsbA9McxafcJrYHbyX4uh2EhKK2Ea7Y0QUEDFooRk/zIQez6nCFytCif
 tdbA==
X-Gm-Message-State: ANhLgQ24mbFEGvfvCk3YywWsPd06Sd4klAZC1VE6u66Bxn5TSLT+iK4H
 VAyZTSJ79KZ2SyGyzoM2D7BfDr3sOLuqzJ4d8ndDWA==
X-Google-Smtp-Source: ADFU+vv7ecW7ra2sUJMenxFnFbWkE5HqAMVJ94k3He5HxqKYAVw0Ztg7FQvViiAfXN7QwjDjV6mpBnIzoWGIsSXl5uA=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr50981oid.98.1583163146469;
 Mon, 02 Mar 2020 07:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
 <20200227220149.6845-2-nieklinnenbank@gmail.com>
In-Reply-To: <20200227220149.6845-2-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 15:32:15 +0000
Message-ID: <CAFEAcA_xB_dMfcALk6sirmRJyJ0rw7_JPK6aqBoZMxh=wH+d-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] hw/arm/cubieboard: use ARM Cortex-A8 as the
 default CPU in machine definition
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 22:01, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> The Cubieboard is a singleboard computer with an Allwinner A10 System-on-Chip [1].
> As documented in the Allwinner A10 User Manual V1.5 [2], the SoC has an ARM
> Cortex-A8 processor. Currently the Cubieboard machine definition specifies the
> ARM Cortex-A9 in its description and as the default CPU.
>
> This patch corrects the Cubieboard machine definition to use the ARM Cortex-A8.
>
>  [1] http://docs.cubieboard.org/products/start#cubieboard1
>  [2] https://linux-sunxi.org/File:Allwinner_A10_User_manual_V1.5.pdf
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  hw/arm/cubieboard.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index 089f9a30c1..0195925c73 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -68,8 +68,8 @@ static void cubieboard_init(MachineState *machine)
>
>  static void cubieboard_machine_init(MachineClass *mc)
>  {
> -    mc->desc = "cubietech cubieboard (Cortex-A9)";
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
> +    mc->desc = "cubietech cubieboard (Cortex-A8)";
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
>      mc->init = cubieboard_init;
>      mc->block_default_type = IF_IDE;
>      mc->units_per_default_bus = 1;

This is worth fixing, but I'm pretty sure it doesn't have
any user-visible effects, because the CPU is created by
hw/arm/allwinner-a10.c:aw_a10_init(), which always uses
cortex-a8 regardless of what the user specified on the command
line or what the mc->default_cpu_type is.

Fixes: 8a863c8120994981a099

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
if you tweak the commit message to mention that it
wasn't a user-visible bug (but I'll do that myself if there
isn't anything else in the series that means it needs a respin).

thanks
-- PMM

