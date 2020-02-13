Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E5AC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C8020675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsSCEMlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C8020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NYf-00011A-Mh
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2NSU-0000xt-QI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2NSP-0000bz-Vh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:59:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2NSP-0000Ye-NC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:59:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id g3so8744371wrs.12
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gnbfP123bOlfuWGFHiru2y/CQB4O6W6QkUlwpsgaSb0=;
 b=GsSCEMlNzwDG34jZsb8XFQwZ57dwO66TYskAoFke3BOvlGQ45v0KJ+9lFx+nwGN2vN
 3FNZUge9TgXxcev97+ck6Z/Xb4YvCRRzYPc+CdWk2KwTFzqUWGkIQJUovduLQ/X54kb2
 iQ4vkIbx/iynPkV7Eck7qjmnRlEojKRxETeb6sc8zeFhp4awLFp3o+HBoWNbeSVSuINK
 pejRzAJmJHM0UPsIBHqNMGQhHlXP7f+5pDZpBVlDFaaz7WzB0Vtu9olDwQxXOUzFRAnl
 oPK38ZJHCvMmcOvLRFuH3ZUaB/pA9G04PSsxTcI41vSTDhOccMtbtB/9tK6DE78ow8zv
 LJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gnbfP123bOlfuWGFHiru2y/CQB4O6W6QkUlwpsgaSb0=;
 b=jKQ+NwoFQr483W3QmidlX3z0zUI8T64zhFB5qlMJuCSgBNZ3aBtb/oVkDV6yh5I4qz
 h8/VtxJUNimWvCsdeCy/g8V2pHoN0U0BElcXw9OHX/EtJv6lNj64PxcWxMTys69nAPOO
 7FvI0utkoYu793Ni7jfswMPHKGmpDHtwHQXOMBL7iIDtfq9gCbK8SHVOLnr+lXe/IB2m
 X7SO4df0G5/nXxj4ohtTjhpVdnjavwbHf2a+oCVFSL7B2gdzJtRb4aJm67xyEl2ek9SD
 bDS3IdKgKFrBRLLW+LBzHfl6FfvvinGieR1bPJoBJCpEfldueKkYnsGq4lHuAr0yAeMa
 TGdQ==
X-Gm-Message-State: APjAAAWQyMb+oAuHyw0vMQ33uHsaZTp3+hi8cvRlxlQ4j2aj7/PIEfSc
 7KFwNxL+OebktQJuoC/qUFGAcuBnRCc=
X-Google-Smtp-Source: APXvYqzV1+O+1D7y4LnJNbVQcAxOu7Cc1PPUzxtmrfUE1hStCtzGxS0/Y/55c2ICOjvzkqPS62yzPQ==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr23513448wre.404.1581634779506; 
 Thu, 13 Feb 2020 14:59:39 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j65sm4876362wmb.21.2020.02.13.14.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 14:59:38 -0800 (PST)
Subject: Re: [PATCH v5 1/6] hw/hppa/dino.c: Improve emulation of Dino PCI chip
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-2-svens@stackframe.org>
 <779e7a6e-00e1-1f51-7132-1cd389bbd921@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <c5713f6c-7a47-64be-0b46-909bc67cfa43@amsat.org>
Date: Thu, 13 Feb 2020 23:59:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <779e7a6e-00e1-1f51-7132-1cd389bbd921@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 12:37 AM, Philippe Mathieu-Daudé wrote:
> Hi Sven, Helge.
> 
> On 12/20/19 10:15 PM, Sven Schnelle wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> The tests of the dino chip with the Online-diagnostics CD
>> ("ODE DINOTEST") now succeeds.
>> Additionally add some qemu trace events.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   MAINTAINERS          |  2 +-
>>   hw/hppa/dino.c       | 97 +++++++++++++++++++++++++++++++++++++-------
>>   hw/hppa/trace-events |  5 +++
>>   3 files changed, 89 insertions(+), 15 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 387879aebc..e333bc67a4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -876,7 +876,7 @@ F: hw/*/etraxfs_*.c
>>     HP-PARISC Machines
>>   ------------------
>> -Dino
>> +HP B160L
>>   M: Richard Henderson <rth@twiddle.net>
>>   R: Helge Deller <deller@gmx.de>
>>   S: Odd Fixes
>> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
>> index ab6969b45f..9797a7f0d9 100644
>> --- a/hw/hppa/dino.c
>> +++ b/hw/hppa/dino.c
>> @@ -1,7 +1,7 @@
>>   /*
>> - * HP-PARISC Dino PCI chipset emulation.
>> + * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar
>> machines
>>    *
>> - * (C) 2017 by Helge Deller <deller@gmx.de>
>> + * (C) 2017-2019 by Helge Deller <deller@gmx.de>
>>    *
>>    * This work is licensed under the GNU GPL license version 2 or later.
>>    *
>> @@ -21,6 +21,7 @@
>>   #include "migration/vmstate.h"
>>   #include "hppa_sys.h"
>>   #include "exec/address-spaces.h"
>> +#include "trace.h"
>>       #define TYPE_DINO_PCI_HOST_BRIDGE "dino-pcihost"
>> @@ -82,11 +83,28 @@
>>   #define DINO_PCI_HOST_BRIDGE(obj) \
>>       OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
>>   +#define DINO800_REGS ((DINO_TLTIM - DINO_GMASK) / 4)
> 
> Coverity noticed (CID 1419394) this should be '(1 + (DINO_TLTIM -
> DINO_GMASK) / 4)' (13 registers).
> 
>> +static const uint32_t reg800_keep_bits[DINO800_REGS] = {
>> +            MAKE_64BIT_MASK(0, 1),
>> +            MAKE_64BIT_MASK(0, 7),
>> +            MAKE_64BIT_MASK(0, 7),
>> +            MAKE_64BIT_MASK(0, 8),
>> +            MAKE_64BIT_MASK(0, 7),
>> +            MAKE_64BIT_MASK(0, 9),
>> +            MAKE_64BIT_MASK(0, 32),
> 
> Looking at the datasheet pp. 30, this register is 'Undefined'.
> We should report GUEST_ERROR if it is accessed.
> 
>> +            MAKE_64BIT_MASK(0, 8),
>> +            MAKE_64BIT_MASK(0, 30),
>> +            MAKE_64BIT_MASK(0, 25),
> 
> Still looking at the datasheet (pp. 37) PCIROR is 24-bit (not 25).
> 
>> +            MAKE_64BIT_MASK(0, 22),
> 
> Here you are missing register 0x82c...
> 
>> +            MAKE_64BIT_MASK(0, 9),
>> +};
>> +
> 
> Altogether:
> 
> static const uint32_t reg800_keep_bits[DINO800_REGS] = {
>     MAKE_64BIT_MASK(0, 1),  /* GMASK */
>     MAKE_64BIT_MASK(0, 7),  /* PAMR */
>     MAKE_64BIT_MASK(0, 7),  /* PAPR */
>     MAKE_64BIT_MASK(0, 8),  /* DAMODE */
>     MAKE_64BIT_MASK(0, 7),  /* PCICMD */
>     MAKE_64BIT_MASK(0, 9),  /* PCISTS */
>     MAKE_64BIT_MASK(0, 0),  /* Undefined */
>     MAKE_64BIT_MASK(0, 8),  /* MLTIM */
>     MAKE_64BIT_MASK(0, 30), /* BRDG_FEAT */
>     MAKE_64BIT_MASK(0, 24), /* PCIROR */
>     MAKE_64BIT_MASK(0, 22), /* PCIWOR */
>     MAKE_64BIT_MASK(0, 0),  /* Undocumented */
>     MAKE_64BIT_MASK(0, 9),  /* TLTIM */
> };
> 
>>   typedef struct DinoState {
>>       PCIHostState parent_obj;
>>         /* PCI_CONFIG_ADDR is parent_obj.config_reg, via
>> pci_host_conf_be_ops,
>>          so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.  */
>> +    uint32_t config_reg_dino; /* keep original copy, including 2
>> lowest bits */
>>         uint32_t iar0;
>>       uint32_t iar1;
>> @@ -94,8 +112,12 @@ typedef struct DinoState {
>>       uint32_t ipr;
>>       uint32_t icr;
>>       uint32_t ilr;
>> +    uint32_t io_fbb_en;
>>       uint32_t io_addr_en;
>>       uint32_t io_control;
>> +    uint32_t toc_addr;
>> +
>> +    uint32_t reg800[DINO800_REGS];
>>         MemoryRegion this_mem;
>>       MemoryRegion pci_mem;
>> @@ -106,8 +128,6 @@ typedef struct DinoState {
>>       MemoryRegion bm_ram_alias;
>>       MemoryRegion bm_pci_alias;
>>       MemoryRegion bm_cpu_alias;
>> -
>> -    MemoryRegion cpu0_eir_mem;
>>   } DinoState;
>>     /*
>> @@ -122,6 +142,8 @@ static void gsc_to_pci_forwarding(DinoState *s)
>>       tmp = extract32(s->io_control, 7, 2);
>>       enabled = (tmp == 0x01);
>>       io_addr_en = s->io_addr_en;
>> +    /* Mask out first (=firmware) and last (=Dino) areas. */
>> +    io_addr_en &= ~(BIT(31) | BIT(0));
>>         memory_region_transaction_begin();
>>       for (i = 1; i < 31; i++) {
>> @@ -142,6 +164,8 @@ static bool dino_chip_mem_valid(void *opaque,
>> hwaddr addr,
>>                                   unsigned size, bool is_write,
>>                                   MemTxAttrs attrs)
>>   {
>> +    bool ret = false;
>> +
>>       switch (addr) {
>>       case DINO_IAR0:
>>       case DINO_IAR1:
>> @@ -152,16 +176,22 @@ static bool dino_chip_mem_valid(void *opaque,
>> hwaddr addr,
>>       case DINO_ICR:
>>       case DINO_ILR:
>>       case DINO_IO_CONTROL:
>> +    case DINO_IO_FBB_EN:
>>       case DINO_IO_ADDR_EN:
>>       case DINO_PCI_IO_DATA:
>> -        return true;
>> +    case DINO_TOC_ADDR:
>> +    case DINO_GMASK ... DINO_TLTIM:
>> +        ret = true;
>> +        break;
>>       case DINO_PCI_IO_DATA + 2:
>> -        return size <= 2;
>> +        ret = (size <= 2);
>> +        break;
>>       case DINO_PCI_IO_DATA + 1:
>>       case DINO_PCI_IO_DATA + 3:
>> -        return size == 1;
>> +        ret = (size == 1);
>>       }
>> -    return false;
>> +    trace_dino_chip_mem_valid(addr, ret);
>> +    return ret;
>>   }
>>     static MemTxResult dino_chip_read_with_attrs(void *opaque, hwaddr
>> addr,
>> @@ -194,6 +224,9 @@ static MemTxResult dino_chip_read_with_attrs(void
>> *opaque, hwaddr addr,
>>           }
>>           break;
>>   +    case DINO_IO_FBB_EN:
>> +        val = s->io_fbb_en;
>> +        break;
>>       case DINO_IO_ADDR_EN:
>>           val = s->io_addr_en;
>>           break;
>> @@ -227,12 +260,28 @@ static MemTxResult
>> dino_chip_read_with_attrs(void *opaque, hwaddr addr,
>>       case DINO_IRR1:
>>           val = s->ilr & s->imr & s->icr;
>>           break;
>> +    case DINO_TOC_ADDR:
>> +        val = s->toc_addr;
>> +        break;
>> +    case DINO_GMASK ... DINO_TLTIM:
>> +        val = s->reg800[(addr - DINO_GMASK) / 4];
>> +        if (addr == DINO_PAMR) {
>> +            val &= ~0x01;  /* LSB is hardwired to 0 */
>> +        }
>> +        if (addr == DINO_MLTIM) {
>> +            val &= ~0x07;  /* 3 LSB are hardwired to 0 */
>> +        }
>> +        if (addr == DINO_BRDG_FEAT) {
>> +            val &= ~(0x10710E0ul | 8); /* bits 5-7, 24 & 15 reserved */
>> +        }
>> +        break;
>>         default:
>>           /* Controlled by dino_chip_mem_valid above.  */
>>           g_assert_not_reached();
>>       }
>>   +    trace_dino_chip_read(addr, val);
>>       *data = val;
>>       return ret;
>>   }
>> @@ -245,6 +294,9 @@ static MemTxResult dino_chip_write_with_attrs(void
>> *opaque, hwaddr addr,
>>       AddressSpace *io;
>>       MemTxResult ret;
>>       uint16_t ioaddr;
>> +    int i;
>> +
>> +    trace_dino_chip_write(addr, val);
>>         switch (addr) {
>>       case DINO_IO_DATA ... DINO_PCI_IO_DATA + 3:
>> @@ -266,9 +318,11 @@ static MemTxResult
>> dino_chip_write_with_attrs(void *opaque, hwaddr addr,
>>           }
>>           return ret;
>>   +    case DINO_IO_FBB_EN:
>> +        s->io_fbb_en = val & 0x03;
>> +        break;
>>       case DINO_IO_ADDR_EN:
>> -        /* Never allow first (=firmware) and last (=Dino) areas.  */
>> -        s->io_addr_en = val & 0x7ffffffe;
>> +        s->io_addr_en = val;
>>           gsc_to_pci_forwarding(s);
>>           break;
>>       case DINO_IO_CONTROL:
>> @@ -292,6 +346,10 @@ static MemTxResult
>> dino_chip_write_with_attrs(void *opaque, hwaddr addr,
>>           /* Any write to IPR clears the register.  */
>>           s->ipr = 0;
>>           break;
>> +    case DINO_TOC_ADDR:
>> +        /* IO_COMMAND of CPU with client_id bits */
>> +        s->toc_addr = 0xFFFA0030 | (val & 0x1e000);
>> +        break;
>>         case DINO_ILR:
>>       case DINO_IRR0:
>> @@ -299,6 +357,12 @@ static MemTxResult
>> dino_chip_write_with_attrs(void *opaque, hwaddr addr,
>>           /* These registers are read-only.  */
>>           break;
>>   +    case DINO_GMASK ... DINO_TLTIM:
>> +        i = (addr - DINO_GMASK) / 4;
>> +        val &= reg800_keep_bits[i];
> 
> Due to the missing register, Coverity reports:
> 
>>>>     CID 1419394:  Memory - illegal accesses  (OVERRUN)
>>>>     Overrunning array "reg800_keep_bits" of 12 4-byte elements at
> element index 12 (byte offset 48) using index "i" (which evaluates to 12).
> 
>> +        s->reg800[i] = val;
>> +        break; > +
>>       default:
>>           /* Controlled by dino_chip_mem_valid above.  */
>>           g_assert_not_reached();

Easy reproducer:

$ echo writeb 0xfff80830 0x69 \
  | hppa-softmmu/qemu-system-hppa -S -accel qtest -qtest stdio -display
none
[I 1581634452.654113] OPENED
[R +4.105415] writeb 0xfff80830 0x69
qemu/hw/hppa/dino.c:362:16: runtime error: index 12 out of bounds for
type 'const uint32_t [12]'
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
qemu/hw/hppa/dino.c:362:16 in
=================================================================
==29607==ERROR: AddressSanitizer: global-buffer-overflow on address
0x5577dae32f30 at pc 0x5577d93f2463 bp 0x7ffd97ea11b0 sp 0x7ffd97ea11a8
READ of size 4 at 0x5577dae32f30 thread T0
    #0 0x5577d93f2462 in dino_chip_write_with_attrs
qemu/hw/hppa/dino.c:362:16
    #1 0x5577d9025664 in memory_region_write_with_attrs_accessor
qemu/memory.c:503:12
    #2 0x5577d9024920 in access_with_adjusted_size qemu/memory.c:539:18
    #3 0x5577d9023608 in memory_region_dispatch_write qemu/memory.c:1482:13
    #4 0x5577d8e3177a in flatview_write_continue qemu/exec.c:3166:23
    #5 0x5577d8e20357 in flatview_write qemu/exec.c:3206:14
    #6 0x5577d8e1fef4 in address_space_write qemu/exec.c:3296:18
    #7 0x5577d8e20693 in address_space_rw qemu/exec.c:3306:16
    #8 0x5577d9011595 in qtest_process_command qemu/qtest.c:432:13
    #9 0x5577d900d19f in qtest_process_inbuf qemu/qtest.c:705:9
    #10 0x5577d900ca22 in qtest_read qemu/qtest.c:717:5
    #11 0x5577da8c4254 in qemu_chr_be_write_impl qemu/chardev/char.c:183:9
    #12 0x5577da8c430c in qemu_chr_be_write qemu/chardev/char.c:195:9
    #13 0x5577da8cf587 in fd_chr_read qemu/chardev/char-fd.c:68:9
    #14 0x5577da9836cd in qio_channel_fd_source_dispatch
qemu/io/channel-watch.c:84:12
    #15 0x7faf44509ecc in g_main_context_dispatch
(/lib64/libglib-2.0.so.0+0x4fecc)
    #16 0x5577dab75f96 in glib_pollfds_poll qemu/util/main-loop.c:219:9
    #17 0x5577dab74797 in os_host_main_loop_wait qemu/util/main-loop.c:242:5
    #18 0x5577dab7435a in main_loop_wait qemu/util/main-loop.c:518:11
    #19 0x5577d9514eb3 in main_loop qemu/vl.c:1682:9
    #20 0x5577d950699d in main qemu/vl.c:4450:5
    #21 0x7faf41a87f42 in __libc_start_main (/lib64/libc.so.6+0x23f42)
    #22 0x5577d8cd4d4d in _start
(qemu/build/sanitizer/hppa-softmmu/qemu-system-hppa+0x1256d4d)

0x5577dae32f30 is located 0 bytes to the right of global variable
'reg800_keep_bits' defined in 'qemu/hw/hppa/dino.c:87:23'
(0x5577dae32f00) of size 48
SUMMARY: AddressSanitizer: global-buffer-overflow
qemu/hw/hppa/dino.c:362:16 in dino_chip_write_with_attrs
Shadow bytes around the buggy address:
  0x0aaf7b5be590: 00 f9 f9 f9 f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9
  0x0aaf7b5be5a0: 07 f9 f9 f9 f9 f9 f9 f9 07 f9 f9 f9 f9 f9 f9 f9
  0x0aaf7b5be5b0: 07 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
  0x0aaf7b5be5c0: 00 00 00 02 f9 f9 f9 f9 00 00 00 00 00 00 00 00
  0x0aaf7b5be5d0: 00 00 00 00 00 00 00 00 00 00 00 03 f9 f9 f9 f9
=>0x0aaf7b5be5e0: 00 00 00 00 00 00[f9]f9 f9 f9 f9 f9 00 00 00 00
  0x0aaf7b5be5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0aaf7b5be600: 00 00 01 f9 f9 f9 f9 f9 00 00 00 00 07 f9 f9 f9
  0x0aaf7b5be610: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
  0x0aaf7b5be620: 00 00 00 05 f9 f9 f9 f9 00 00 00 00 07 f9 f9 f9
  0x0aaf7b5be630: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 07 f9 f9 f9
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==29607==ABORTING

