Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60293C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F8921848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX1GpYrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F8921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Dd9-0001L4-Ni
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i1Dad-0008KO-3h
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i1Dab-0001Ui-Cc
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:43:06 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i1Dab-0001UD-5G; Fri, 23 Aug 2019 13:43:05 -0400
Received: by mail-lf1-x141.google.com with SMTP id r5so2209659lfc.3;
 Fri, 23 Aug 2019 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JGRtwdEuODlISTqiQofikO4Kc3OFbKjsPFpQ7j7TPXk=;
 b=rX1GpYrXufeHrpKqiQjDTyr1zih7ayolTMO+Lx1tZOhUpIzOZpNttzByIYa7JV/Rgi
 3z4R3gjmTLUVFdbVHkMQRo4em4CoRkHVC9nBpPfy4eF4/HI+J55clr70xfPcXhopqu3h
 paJ+etEVjocn37uGvRjSyn6p03+nnpycrzbsx1J58DrDBY1H6e1+vNEquYDj3I2okF3f
 tvFK1Db+qqAy0cJW5BwQNnMxsYOx71oQPDQGDZw5VHRL9A7ioyN3Zho1qwZlHpJ4HtvY
 KY0OFPmUuk9BCwScSyUGk9NoHD63KSqzQzxb6q3DD2rcAMLSXa4eBv5GqbzHSa9mhEB3
 MtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JGRtwdEuODlISTqiQofikO4Kc3OFbKjsPFpQ7j7TPXk=;
 b=eGqpeDHkqeG7x4hnbc6GWD1OmZ48iyNljG9pBqmu+BLy8d0wxWIdtuxeGr1nJ92WxZ
 2Fx7zTslwFYv+QWyIByvggNOkqS5HKvZ7s37Z1SJBlXYQpuh/gx7I4i4A4+uoJpycjMR
 IZxeaqvaO9/KYptY1cJoQaTrD77gzr11r2jmXTPPok7dyg0XiAEPGODiRZLcnc9bj1qi
 eEz/qOEh97AQ+tu26QbmACpMwDU97n6LDraM4Q9sV3O2b6zJsDVI/QeYBtwnYhEE0Y4Y
 qZpop/fpDKQomr40QLGoKFp2kRcMFF0DGItcCNTESUPeWz5AtlJMDOQCxtUW6m6uS8OS
 QUWw==
X-Gm-Message-State: APjAAAXeV56pTGmWL4gNK09twQt9aUt0/rFZQbfrYgDJvl2KNTlBqMKZ
 usMLjRykKg0HqapzjpOBXI3OcOPTsejOOxyppdo=
X-Google-Smtp-Source: APXvYqycoqQnVtaCdQNmGQ3gNT5SlRdttPr+JXJlwW85TejPZbbSLdukP5LNwKseNXAsONuwJy3HMZlicHal5EVV4Qc=
X-Received: by 2002:a19:7709:: with SMTP id s9mr3390932lfc.86.1566582183836;
 Fri, 23 Aug 2019 10:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
 <1566537069-22741-6-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566537069-22741-6-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Aug 2019 10:38:57 -0700
Message-ID: <CAKmqyKObGXxscyxpy70JxZNAmCFvafCrHbHaA9dUs3TcHEwYhQ@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v5 05/30] riscv: hw: Change to use
 qemu_log_mask(LOG_GUEST_ERROR, ...) instead
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 10:21 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Replace the call to hw_error() with qemu_log_mask(LOG_GUEST_ERROR,...)
> in various sifive models.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Thanks for this cleanup!

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v5:
> - new patch to change to use qemu_log_mask(LOG_GUEST_ERROR,...) instead
>   in various sifive models
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/sifive_prci.c | 8 +++++---
>  hw/riscv/sifive_test.c | 5 +++--
>  hw/riscv/sifive_uart.c | 9 +++++----
>  3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
> index f406682..1ab98d4 100644
> --- a/hw/riscv/sifive_prci.c
> +++ b/hw/riscv/sifive_prci.c
> @@ -20,6 +20,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> +#include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/sifive_prci.h"
> @@ -37,7 +38,8 @@ static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
>      case SIFIVE_PRCI_PLLOUTDIV:
>          return s->plloutdiv;
>      }
> -    hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%x\n",
> +                  __func__, (int)addr);
>      return 0;
>  }
>
> @@ -65,8 +67,8 @@ static void sifive_prci_write(void *opaque, hwaddr addr,
>          s->plloutdiv = (uint32_t) val64;
>          break;
>      default:
> -        hw_error("%s: bad write: addr=0x%x v=0x%x\n",
> -                 __func__, (int)addr, (int)val64);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
> +                      __func__, (int)addr, (int)val64);
>      }
>  }
>
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> index cd86831..655a3d7 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/riscv/sifive_test.c
> @@ -20,6 +20,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> +#include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "sysemu/sysemu.h"
>  #include "target/riscv/cpu.h"
> @@ -48,8 +49,8 @@ static void sifive_test_write(void *opaque, hwaddr addr,
>              break;
>          }
>      }
> -    hw_error("%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
> -        __func__, (int)addr, val64);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
> +                  __func__, (int)addr, val64);
>  }
>
>  static const MemoryRegionOps sifive_test_ops = {
> diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
> index 3b3f94f..cd74043 100644
> --- a/hw/riscv/sifive_uart.c
> +++ b/hw/riscv/sifive_uart.c
> @@ -18,6 +18,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/log.h"
>  #include "hw/sysbus.h"
>  #include "chardev/char.h"
>  #include "chardev/char-fe.h"
> @@ -93,8 +94,8 @@ uart_read(void *opaque, hwaddr addr, unsigned int size)
>          return s->div;
>      }
>
> -    hw_error("%s: bad read: addr=0x%x\n",
> -        __func__, (int)addr);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr=0x%x\n",
> +                  __func__, (int)addr);
>      return 0;
>  }
>
> @@ -125,8 +126,8 @@ uart_write(void *opaque, hwaddr addr,
>          s->div = val64;
>          return;
>      }
> -    hw_error("%s: bad write: addr=0x%x v=0x%x\n",
> -        __func__, (int)addr, (int)value);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
> +                  __func__, (int)addr, (int)value);
>  }
>
>  static const MemoryRegionOps uart_ops = {
> --
> 2.7.4
>
>

