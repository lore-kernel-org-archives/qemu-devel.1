Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF983C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F072072D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP6sCS4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F072072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTACw-0001KJ-Hc
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 16:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTABj-00007V-Mj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTABj-00005p-5r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:17:11 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTABi-0008QF-NK; Mon, 27 Apr 2020 16:17:10 -0400
Received: by mail-il1-x143.google.com with SMTP id c18so2782894ile.5;
 Mon, 27 Apr 2020 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Coyf2FtT8xJGe7dQak7YvdPIn882vu160FqkJpe4Gjk=;
 b=nP6sCS4I3BtkZAwk0sA8b5sxf+o8opG0I3qIST120ewhCNoYkZdwS7M8XGBGdvNhYd
 GOlJKtJm4J2uYrIaYRa4im2zrSnksVWeZJGd8t2pzzhWRF2AaQvxCRm+nQl9ruFIlVxI
 pfSiiUlh25+LdSmGAYDuvpfZeacJM/MrdKfNBsZvHcMh2UvxBvwVHxurcldE7z1cpvGm
 PpOUOiC9z2afW+piwl6W032L1yVhvI2SBqnmIBllR8ByzCV6K2/89P9vhZbYBy4r/Ntj
 d/SaSVm2HxMiyOTNPOeaXnzBmel6f72Ub/XofWQJqXXzj6vcF8yCYCrhYcERImXj8TNZ
 K3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Coyf2FtT8xJGe7dQak7YvdPIn882vu160FqkJpe4Gjk=;
 b=mLbnevHd4aE3OEYBvczBUHbLRd9Z+9IgWKVjVYXwGyr9wk8dpWgN5UmI1QQaYiEIJp
 Ioz0IYMPu5gU9BM5EaUUrSfsQTKLYLXAoVYc7SMGaKhQfaKmfeVuowHfeELJOw/DhHn+
 7y13hNYge7atmIgJxmicAiUy+THlBWxKTJlAWAJLbZBOQ3h7xnMyIrvGmoRex/yUJOJP
 ARyIplony6ZBxFPl0f0kLUF0LLKjeakbWvNJJt2XVrAzMiGQA+8W1CKtylE4DSNPGQXH
 /LAhiJo6dtj/Cu3xwIHNe2FhrJLUWU7WLcPrCDVp+5o9xVeh3lVQHLt+Azo0hYKqZWm3
 xikA==
X-Gm-Message-State: AGi0PuaWBr+zRwxWj+zxTMTHfP0G3MIcVXuMwc2MHaPgQbdXpr5QXKpZ
 m67tqnMED4xKexAEE5KI8qxITLVQB1+qU1LJpwY=
X-Google-Smtp-Source: APiQypJiQMA0nj+vve70ID5Wc7PBGptpslYR7Y1LfVsiljVtQ+efwJnhSSOzz8L0OWsuKd/a/z7Y8KjNpNJ6AHPV5pA=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr3750609ili.40.1588018628827;
 Mon, 27 Apr 2020 13:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 13:08:30 -0700
Message-ID: <CAKmqyKNEH6vYoRxaM1SGEYjK9Lv6hxm09zHSgGPt1da8+sRYkg@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] hw/arm: versal: Remove inclusion of
 arm_gicv3_common.h
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:17 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Remove inclusion of arm_gicv3_common.h, this already gets
> included via xlnx-versal.h.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 94460f2343..c73b2fe755 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -20,7 +20,6 @@
>  #include "hw/arm/boot.h"
>  #include "kvm_arm.h"
>  #include "hw/misc/unimp.h"
> -#include "hw/intc/arm_gicv3_common.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "hw/char/pl011.h"
>
> --
> 2.20.1
>
>

