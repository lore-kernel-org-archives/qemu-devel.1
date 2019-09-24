Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CE5C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9012146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhWA8wh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9012146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChuG-0002HJ-H3
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iChtO-0001n6-PD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iChtM-0006n8-FT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:17:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iChtK-0006mf-Rp
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:17:55 -0400
Received: by mail-oi1-x243.google.com with SMTP id x3so1145478oig.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMxtvy0rw2lyWXDK5oniU3gJXXXxaKgUBTxBrFjsHa4=;
 b=vhWA8wh5C+JmrRJAAKgUkQN7lUSxfOxyyINRHnxZuiNGqqaZEsyzwYNEeZIMAxuiCw
 aVLZ6fIjrxakBbc0QWDvbXSG0uilLlr7cZHrdmdscJSM/bpmMtjWz3re+ZbfXrZkAhvD
 ueZzqnilBMaHGysYziwS5jhEIOL1DTortcZ/qkw559Ds6f4dQ1AueeV3ubrysnymux4g
 X448BVnjOLfzA6RrRI5XyVmgQziCtrCwiw4gObHsxGlY+HBsgaFq5M9MSjHmRLtUyiOi
 xRG7bqCmYf0lR9TuO/jfjoy0GBiYaaO/hfaUEJtMhEFFJ2jCkNqeBSb3JbEk2YUh8axd
 uGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMxtvy0rw2lyWXDK5oniU3gJXXXxaKgUBTxBrFjsHa4=;
 b=GbviR+SCTnPi9VujhHn2kMvNr7gfjr4bambRIhuAZo1UNoSXDlMKz29eV09gwP7fOh
 ES1NFXnaME4wY6+D/x2lb6fJ4RGxFyv+DttlScr/cLS2WoPPFiRSAcvaHx+gKiHSQ8Ab
 ZZ9hP83Fetb5JE06gtLG4yXS9HfZ93zTGSfjf7uwTVUPC+DtH4d/WSd3ogYm39UNZVFB
 HzY0aaMKc2BUZxF2a27ipo0k7edozPe33wUJwaSbOX3KlRDNGAnzJDK4fGsOGnc4oPcv
 Wvj4trgpbkE2/aUMtdy6+cjHKOdMSf1Yx+5dnrjUyOFf5rXxtsVtAbcP7V2oR9g2H/oQ
 92kQ==
X-Gm-Message-State: APjAAAX6sERSXO8Nh4zZJ41MHCwTz+VpAWqvzl5XABgw+gExB4wifCO2
 nVlWEp/iIosQItDaSHL4IHLafVFgRpsPdn73X2xcrQ==
X-Google-Smtp-Source: APXvYqy9d6peXmtJfnXkc98WUviS8PSVNb2emDbZdbo8/pvkKpMLvh9VbQ0lfr4hkg4ExRTYlPilhpdt46/xjppt3Ow=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr1350159oib.146.1569320273846; 
 Tue, 24 Sep 2019 03:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190918145640.17349-1-palmer@sifive.com>
 <20190918145640.17349-12-palmer@sifive.com>
In-Reply-To: <20190918145640.17349-12-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Sep 2019 11:17:42 +0100
Message-ID: <CAFEAcA_6AuqCvbvHVS9Vdwd3AOrp16Fy7Xj29497-xGMw+aXkQ@mail.gmail.com>
Subject: Re: [PULL 11/48] riscv: Resolve full path of the given bios image
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Sep 2019 at 16:35, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> From: Bin Meng <bmeng.cn@gmail.com>
>
> At present when "-bios image" is supplied, we just use the straight
> path without searching for the configured data directories. Like
> "-bios default", we add the same logic so that "-L" actually works.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  hw/riscv/boot.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 10f7991490..2e92fb0680 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -72,14 +72,14 @@ void riscv_find_and_load_firmware(MachineState *machine,
>          firmware_filename = riscv_find_firmware(default_machine_firmware);
>      } else {
>          firmware_filename = machine->firmware;
> +        if (strcmp(firmware_filename, "none")) {
> +            firmware_filename = riscv_find_firmware(firmware_filename);
> +        }
>      }
>
>      if (strcmp(firmware_filename, "none")) {
>          /* If not "none" load the firmware */
>          riscv_load_firmware(firmware_filename, firmware_load_addr);
> -    }
> -
> -    if (!strcmp(machine->firmware, "default")) {
>          g_free(firmware_filename);
>      }
>  }

Hi; Coverity (CID 1405786) thinks this introduces a possible
memory leak, because it's not sure that memory allocated
and returned by the call to riscv_find_firmware() is
guaranteed to be freed before the end of the function.
I think it might be a false positive, but I wasn't entirely
sure, so maybe this code could be rephrased to be clearer?
I think the root of the problem is that we have a local
variable 'firmware_filename' which might point to memory
allocated-and-to-be-freed, or might point to memory which
must not be freed (machine->firmware), and then you have
to check the flow of logic through the code quite carefully
to figure out whether the condition under which we choose
to call g_free() is exactly equivalent to the condition
where we set firmware_filename to point to allocated memory...

thanks
-- PMM

