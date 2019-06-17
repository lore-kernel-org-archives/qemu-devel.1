Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB11C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C82208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfaSkP9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C82208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvRL-00078d-4z
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hcvE9-0004Hg-C3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hcvE6-0003op-Lb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:15:29 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hcvDy-0003aB-QO; Mon, 17 Jun 2019 13:15:20 -0400
Received: by mail-lf1-x143.google.com with SMTP id b11so7091278lfa.5;
 Mon, 17 Jun 2019 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K+x7AQu53uygU1oaBt5GPKty0iv5sR5jknseIKEMUgo=;
 b=lfaSkP9lF0xySR+QRe6Cy4HF3eBmqfEWYcmscpBLsuQUh/oGvb/8f9nyhwh8OmL8TT
 CUpTGwdh3xctcUEhNRSumMACJyByacE3gVhf3/rZ7OffkjXVMcJtBQMzdQ+6/n1A1ADZ
 YMlPwxWIqF8RsTRXoxpTK8w3YS58VGBpZJEjSCQx6Bw/TFqahBcbzgPlB2YDRPIlktgC
 2SAYljEdMx2tJ8eqGqV1VKQ8Ael5Rq2myypB92eAgxP/n6FjzXmh/Fvs/w7wLUHf5hDZ
 Gz5rwv8jJ8u+HeSvIs0PUhLrPGOB2UDCevCYXVqLWYID0wYmPBuSQVKdeqAOo9xx952+
 2SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K+x7AQu53uygU1oaBt5GPKty0iv5sR5jknseIKEMUgo=;
 b=PaGXLTt6PnByOfMoccE91Xdzqpf/f0EHJr2hnx/7t0g53wE8k0YcbC+C4w3PuDYEoJ
 ZcilBoZbnGwsETXBQM5/VZIYAlD23AHRwPOklG6S3hEg25/iqzSRpMRwxEvaFSMumELx
 lz1bdyhZlG48BI26VUzDqhmE9eqOE4REbKw1XMyaphcxjucaj1NHf/9OFwM4OJ+fNgBz
 BFGdJpB8CGIzfZEzInppv2XVhJCrrJINmbqmDbZdJE1UjI6hN02p8wrxdxLSPlLKchNY
 lO3pzzV+E1ZxPCwmda+HoE7h9R6ieS5QluBYgfwdQccE72qTNCF/lF9Az0ERYV5bnCEd
 9zXQ==
X-Gm-Message-State: APjAAAUpm0I1lELi0oy7d8y+mB+VAux4CQsP//rpMVBVqQZED/Cxjncd
 1mGYYeEeYzam4NydiuohKlw83pFWCiXn72fMKT4=
X-Google-Smtp-Source: APXvYqwY5Ttazos/3DeMn1o9pS//LL00uOECszMPL+61NaE3JDRZHfGxXROPowXbnhklPU+flsNpQxAUM39Ft3LYRmc=
X-Received: by 2002:a19:bec1:: with SMTP id o184mr26124571lff.86.1560791717179; 
 Mon, 17 Jun 2019 10:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <1560525351-590-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1560525351-590-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Jun 2019 10:12:30 -0700
Message-ID: <CAKmqyKMVH9MCPRD3DYm9-O59H2=DVXA8L9Sa3pNsYs=wbZRiug@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] riscv: sifive_test: Add reset functionality
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 8:30 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> This adds a reset opcode for sifive_test device to trigger a system
> reset for testing purpose.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_test.c         | 4 ++++
>  include/hw/riscv/sifive_test.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> index 24a04d7..cd86831 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/riscv/sifive_test.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
> +#include "sysemu/sysemu.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/sifive_test.h"
>
> @@ -40,6 +41,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
>              exit(code);
>          case FINISHER_PASS:
>              exit(0);
> +        case FINISHER_RESET:
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            return;
>          default:
>              break;
>          }
> diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
> index 71d4c9f..c186a31 100644
> --- a/include/hw/riscv/sifive_test.h
> +++ b/include/hw/riscv/sifive_test.h
> @@ -34,7 +34,8 @@ typedef struct SiFiveTestState {
>
>  enum {
>      FINISHER_FAIL = 0x3333,
> -    FINISHER_PASS = 0x5555
> +    FINISHER_PASS = 0x5555,
> +    FINISHER_RESET = 0x7777

Do you mind sharing where you got this value from? I can't find
details on this device in the SiFive manuals.

Alistair

>  };
>
>  DeviceState *sifive_test_create(hwaddr addr);
> --
> 2.7.4
>
>

