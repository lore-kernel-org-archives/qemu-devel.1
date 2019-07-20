Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C10AC76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 09:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249382084D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 09:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249382084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hom0V-0001lq-De
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 05:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34148)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hom0K-0001LO-GD
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hom0J-0000lB-BN
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:50:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hom0J-0000j1-3q
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:50:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so31030093wme.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 02:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NBvvIds/Inv1c8yRvQ7ogbqHxT3QbeRbtueGqhCyP5E=;
 b=F1SpnyCeBmlovDL/rpg/+fCwB0ZAwk/et0zBULTiiVpzbBAGSpUXFAeTrDCGZuHvyu
 IThwixQsRJbwQclFKnnFWF7WwrywVPz0v/8Zlk9qEfVAO7f061cfRMeQ2ntfnSwup/oW
 42uLvJUJv6qB47ASujk2sLzrG7XnWQfjCoUcuL3DYjJS811qmcnWQz5IHmfJ2217MQGs
 bBPHDzKKpFM87kyOGgDNGGd/x82SyU8ElOANB/L7BjXeUJiP9TqBK5cEJQVb1WDsPZhS
 JDrqYYx/EH/XrU7JmSrvuGwnNOMnLc58097bE3F5pZxsVjOk2pKM0EPifjFJhvZqM5AL
 pERg==
X-Gm-Message-State: APjAAAWZBh5STqKbz2py4b8RFtsoU2MluZt7onpNSPhniAY8usg3GnDm
 ktWlJ2QMg+LZoIes4q82AWA+vQ==
X-Google-Smtp-Source: APXvYqzMOQvveAK9wTAklGUsxeXLKzTVp8p1UpdEokqR9f8a6LHe6vbd4OLFED1Jb8LZUYmdCbhYSg==
X-Received: by 2002:a1c:acc8:: with SMTP id
 v191mr54335691wme.177.1563616209999; 
 Sat, 20 Jul 2019 02:50:09 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o26sm56631152wro.53.2019.07.20.02.50.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 02:50:09 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1563603512-5914-1-git-send-email-frederic.konrad@adacore.com>
 <70060fbc-b79f-6385-2b1e-0cebb45ca03e@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1f427dc9-deb9-f900-470a-84b79ab32a2a@redhat.com>
Date: Sat, 20 Jul 2019 11:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <70060fbc-b79f-6385-2b1e-0cebb45ca03e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] riscv: htif: use qemu_log_mask instead of
 qemu_log
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
Cc: kbastian@mail.uni-paderborn.de, palmer@sifive.com, Alistair.Francis@wdc.com,
 Stefan Hajnoczi <stefanha@redhat.com>, sagark@eecs.berkeley.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Stefan

On 7/20/19 11:44 AM, Philippe Mathieu-Daudé wrote:
> Hi Frederic,
> 
> On 7/20/19 8:18 AM, KONRAD Frederic wrote:
>> There are some debug trace appearing when using GDB with the HTIF mapped @0:
>>  Invalid htif read: address 0000000000000002
>>  Invalid htif read: address 0000000000000006
>>  Invalid htif read: address 000000000000000a
>>  Invalid htif read: address 000000000000000e
>>
>> So don't show them unconditionally.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>  hw/riscv/riscv_htif.c | 21 ++++++++++++---------
>>  1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
>> index 4f7b11d..6a8f0c2 100644
>> --- a/hw/riscv/riscv_htif.c
>> +++ b/hw/riscv/riscv_htif.c
>> @@ -119,7 +119,8 @@ static void htif_handle_tohost_write(HTIFState *htifstate, uint64_t val_written)
>>      int resp = 0;
>>  
>>      HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
>> -        " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF, payload);
>> +               " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF,
>> +               payload);
>>  
>>      /*
>>       * Currently, there is a fixed mapping of devices:
>> @@ -137,7 +138,7 @@ static void htif_handle_tohost_write(HTIFState *htifstate, uint64_t val_written)
>>                  qemu_log_mask(LOG_UNIMP, "pk syscall proxy not supported\n");
>>              }
>>          } else {
>> -            qemu_log("HTIF device %d: unknown command\n", device);
>> +            HTIF_DEBUG("HTIF device %d: unknown command\n", device);
> 
> Generally, please don't go back to using DPRINTF() but use trace-events
> instead.

Oh, now I see that HTIF_DEBUG() is just an obscure way to report
crippled log trace-events, not portable to all trace backends.

It is only used in 2 files:

- hw/riscv/riscv_htif.c
- target/riscv/pmp.c as PMP_DEBUG()

I'd rather remove these macros and use trace-events the same way the
rest of the codebase use them, usable by all backends.

> However in this calls it seems using qemu_log_mask(LOG_UNIMP) or
> qemu_log_mask(LOG_GUEST_ERROR) is appropriate.
> 
>>          }
>>      } else if (likely(device == 0x1)) {
>>          /* HTIF Console */
>> @@ -150,12 +151,13 @@ static void htif_handle_tohost_write(HTIFState *htifstate, uint64_t val_written)
>>              qemu_chr_fe_write(&htifstate->chr, (uint8_t *)&payload, 1);
>>              resp = 0x100 | (uint8_t)payload;
>>          } else {
>> -            qemu_log("HTIF device %d: unknown command\n", device);
>> +            HTIF_DEBUG("HTIF device %d: unknown command\n", device);
>>          }
>>      } else {
>> -        qemu_log("HTIF unknown device or command\n");
>> +        HTIF_DEBUG("HTIF unknown device or command\n");
>>          HTIF_DEBUG("device: %d cmd: %d what: %02" PRIx64
>> -            " payload: %016" PRIx64, device, cmd, payload & 0xFF, payload);
>> +                   " payload: %016" PRIx64, device, cmd, payload & 0xFF,
>> +                   payload);
>>      }
>>      /*
>>       * - latest bbl does not set fromhost to 0 if there is a value in tohost
>> @@ -180,6 +182,7 @@ static void htif_handle_tohost_write(HTIFState *htifstate, uint64_t val_written)
>>  static uint64_t htif_mm_read(void *opaque, hwaddr addr, unsigned size)
>>  {
>>      HTIFState *htifstate = opaque;
>> +
>>      if (addr == TOHOST_OFFSET1) {
>>          return htifstate->env->mtohost & 0xFFFFFFFF;
>>      } else if (addr == TOHOST_OFFSET2) {
>> @@ -189,8 +192,8 @@ static uint64_t htif_mm_read(void *opaque, hwaddr addr, unsigned size)
>>      } else if (addr == FROMHOST_OFFSET2) {
>>          return (htifstate->env->mfromhost >> 32) & 0xFFFFFFFF;
>>      } else {
>> -        qemu_log("Invalid htif read: address %016" PRIx64 "\n",
>> -            (uint64_t)addr);
>> +        HTIF_DEBUG("Invalid htif read: address %016" PRIx64 "\n",
>> +                   (uint64_t)addr);
>>          return 0;
>>      }
>>  }
>> @@ -219,8 +222,8 @@ static void htif_mm_write(void *opaque, hwaddr addr,
>>          htifstate->env->mfromhost |= value << 32;
>>          htifstate->fromhost_inprogress = 0;
>>      } else {
>> -        qemu_log("Invalid htif write: address %016" PRIx64 "\n",
>> -            (uint64_t)addr);
>> +        HTIF_DEBUG("Invalid htif write: address %016" PRIx64 "\n",
>> +                   (uint64_t)addr);
>>      }
>>  }
>>  
>>

