Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF94C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB09320657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwpIKnzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB09320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSZe-0000R7-EP
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfSY8-00086H-B0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfSY7-0004Rf-Br
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:14:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfSY7-0004OQ-0u
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:14:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id h19so426568wme.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=60GxJC+l6Iw724nQiXtKbIOyOSc1pwA9F4SQ0LmdI8M=;
 b=RwpIKnzq9hoRTcTJaXLqMSQ2TOrx0NVa/Hbdn6Ln0bYp5TZQ0K1Ox6wBoiGbmDJ8jb
 puGOlyjbreSLPFfS284wVc9SPS9CDu3L23gJTcWFJn4AzX/+M6vTGXkB8xXz8z2d0+jM
 nAAompGxv8YLImHcZRp++dqDwI/tFE4wVWGcRQz7tolrpH338QLq57YWWV1qqT7xRhMz
 LPrditqywc6r4R+Kv5NIQD5pK/r/kOkRshpyyfVQ2dai5Bc80tCOvwUKuxh6P0AzpTcM
 RYGQBz2EMrSWRGkDJaXycD+8hsCEGEqnCgqEcwbN+QCO6CM/5l2vHG0gJ+5IWoU0EJVN
 CO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=60GxJC+l6Iw724nQiXtKbIOyOSc1pwA9F4SQ0LmdI8M=;
 b=k4ftMMa9ci7O523imH4sE9g9n5edwUve98OTkL0UfwCqgzvCekYauBNVXjjHVkPzAI
 mNO55dgKhzm82MyK2uXBieeyf58MPMiJ7kdqr7CcT3yg5UGUz67L1OO0CJRVt+tPGRyx
 2rhB84ug6OpE2pJt52itMvXA9Ul997Y+TxcWVY4io+ZgnNLHOlAw2uGF5WEYc31Pb7po
 M38UxaI8Kh2PyVpBYrpw9a198sQzPerYw2ol631zfOYSNGhSprp0GasZyjtERDnTJABV
 K+uB6COnQnbPZKQXKPRTh48zkQ/aBII4eq8ppEFOGRt8/M0KFe/b/45ramyyvEFM/d9O
 XoCg==
X-Gm-Message-State: APjAAAWCmcxNy0dxluK9VNQdrm7pafPNobArd+uat+ROC+3hrHYynzvi
 Sq4CgsvLX2O7Zntq8urEsSHJLbEH
X-Google-Smtp-Source: APXvYqz9p3rZmLp8Rwq8Ln/nx8jO2WhaFVdJ8dskbTYCOYYwG/1Bb/5pfec2S0m0LwAGK5Bbsm5vfg==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr16419062wmf.45.1561396472654; 
 Mon, 24 Jun 2019 10:14:32 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t63sm120411wmt.6.2019.06.24.10.14.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 10:14:31 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190612112747.16374-1-armbru@redhat.com>
 <20190612112747.16374-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <1553aaa3-aae1-074c-a885-f7d185fcfb58@amsat.org>
Date: Mon, 24 Jun 2019 19:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612112747.16374-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: Re: [Qemu-devel] [PULL v3 03/12] Include qemu/module.h where needed,
 drop it from qemu-common.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 6/12/19 1:27 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20190523143508.25387-4-armbru@redhat.com>
> [Rebased with conflicts resolved automatically, except for
> hw/usb/dev-hub.c hw/misc/exynos4210_rng.c hw/misc/bcm2835_rng.c
> hw/misc/aspeed_scu.c hw/display/virtio-vga.c hw/arm/stm32f205_soc.c;
> ui/cocoa.m fixed up]
> ---
[...]
>  hw/core/empty_slot.c                       | 1 +
[...]
> diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
> index 239f78e2a7..c694532046 100644
> --- a/hw/core/empty_slot.c
> +++ b/hw/core/empty_slot.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
> +#include "qemu/module.h"
>  #include "hw/empty_slot.h"
>  
>  //#define DEBUG_EMPTY_SLOT

Why is this include required in this file?
I think I'm missing how modules are used.

Thanks,

Phil.

