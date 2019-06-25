Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315B0C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3407215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEG5W47q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3407215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiIk-0004mS-SQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58248)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfiFM-000485-Vm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfiFH-00088d-HJ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:00:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfiFH-00087q-A2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:00:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id p11so17115921wre.7
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GDD319ZPcmRZ+EH12gIoMUsvxFL+Tnlhk45osYnMz+Y=;
 b=UEG5W47qDqlXYBCBHTvlZrRHORuvFRO0CSBnTRDp9o0E3KTQjmaz+8k6fA8gPXGiqI
 qxdMu/RbvWulM/H7mb/Dl+Pvzx5DgsNyUqSNbEP/0jSaFjQ1Yzlh5OQtA3HFin0KRaRK
 sP4NKLUxUNfYaoAuByHmRTGmMZG5TfZcARPZoAwj4iTH6fAvu6KZuQxQP4HfxtrL/Y8n
 MocBhN7iJcFluALJQG5XGsVxExND5RkHbt76ZRcXcZuyr4Cyrl9+8XAcMB5aPWO/MLAJ
 xnLCstFSRLO7pP/FYqsWM0KWW96jPrkXri8VTTsyCdId8+3GJCxEmct+qFogE+rGSoai
 1fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GDD319ZPcmRZ+EH12gIoMUsvxFL+Tnlhk45osYnMz+Y=;
 b=M3B3NGs6b+0fEkypy+SKcOxoZRIHJT4PNyQjHToRS6Ryc8EjQm2KUHdCfR5eMiEAsZ
 PjJHqLqnjSfSu6jAUpcjPOiPbd9QkAxzi+bVLCu4riroVzrzDvMzB1VGutap/m17wzcQ
 eiktdf3e1RMxP614pIaiun+H4dhRRPCNRP4MDRlqIXcaeHoZAMEfKk3u6XKP54RgqSYf
 jb5PuUkDqICdXabV9ORws5CsuoNaQy2SDp+jJgWkZ52Th8Gq6j1f6LYOljEsPAj26Diz
 8NBi5Tnuo9r9+lkqW2IMwkhdt9rQ54TTlm5w4Rcq0PVcA1BLQvTXQI6yxsj/8zV+MyDY
 oWJw==
X-Gm-Message-State: APjAAAXeFGRQ/LLE9X/FKeWG6stFFJ8Vnlh0X1lM8e0ZU9aD6Mtr6uix
 9fbes5Gk0+WZknOl3HNM5ic=
X-Google-Smtp-Source: APXvYqyp1ZdthmqFS6orUP5+fFORVmsVCdAiTJ/C+jm2xGYJ1ykyt4PWopFXFWaLiJwCt0FR+u6AXw==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr21011417wrs.1.1561456809932;
 Tue, 25 Jun 2019 03:00:09 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id u25sm1700693wmc.3.2019.06.25.03.00.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 03:00:08 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-7-f4bug@amsat.org>
 <CAL1e-=jSPHmeSjK1UA=bzghZo4Yn83Vi6QWqN0_76ACtz0SZJg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <998ea490-5a3b-679d-0949-97f42953435c@amsat.org>
Date: Tue, 25 Jun 2019 12:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jSPHmeSjK1UA=bzghZo4Yn83Vi6QWqN0_76ACtz0SZJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 06/10] hw/mips/gt64xxx_pci: Convert debug
 printf()s to trace events
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 6/25/19 2:40 AM, Aleksandar Markovic wrote:
> 
> Philippe, can you hust clarify (explain) what is the criterium when to
> use log message, and when to use trace event, which are bith present in
> gt64xxx implementation.

The criterium is rather generic.

All those log/events are meant for developpers, and are disabled by default.

- DPRINTF()

  This is the older printf() method, flooding the stdout (confuse when
  the serial console is displayed on stdio).
  It is deprecated because you have to edit the source and recompile to
  be able to use it, and once enabled you can not disable it.
  Since it is compile-time disabled, it tends to bitrot (string formats
  are not updated).
  Not recommended for new design.

- qemu_log_mask(loglevel_bits, ...)

  These calls are filtered with the global qemu_loglevel.
  The log is output to the 'log_file' file if set, or to stderr.

  You can set the global loglevel from command line with '-d bits,...'
  and the global logfile with the '-D file.log' command line option.

  You can also set those globals at runtime using the HMP 'log' and
  'logfile' commands:

  (qemu) log help
  Log items (comma separated):
  none       remove all logs
  out_asm    show generated host assembly code for each compiled TB
  in_asm     show target assembly code for each compiled TB
  op         show micro ops for each compiled TB
  op_opt     show micro ops after optimization
  op_ind     show micro ops before indirect lowering
  [...]
  (qemu) log in_asm
  [...]
  (qemu) log none

  Note that this logging doesn't have precise timing information.

- qemu_log_mask(LOG_GUEST_ERROR, ...)

  You select this level with '-d guest_errors' or via HMP.
  This reports invalid hardware accesses from the guest (buggy firmware,
  code running on an incorrect machine).
  This is useful for developpers of bootloader, who might want to fix
  their incorrect accesses before trying the fw on real hardware.
  Hardware not always generate exception for these incorrect accesses.

  Error reported come from the guest, and QEMU is not responsible, nor
  need modification in its models.

- qemu_log_mask(LOG_UNIMP, ...)

  You select this one with '-d unimp' or via HMP.
  This reports accesses to devices QEMU is not modeling.
  Having the missing device correctly modeled is likely to change the
  guest code flow (device/driver initialization).
  This also log accesses to not-yet-implemented registers within a
  partially implemented device.
  The common case is an OS driver added new functionalities. The model
  was developped with a limited driver, newer drivers expect to set
  more features up.
  I don't use it with guests image I know are already working, but I
  often use it when trying an image with a newer/older kernel for
  example.

- trace events

  Tracing is more powerful than the previous items, but usually requires
  post-processing effort. It is usually targetting live/post-mortem
  debugging. You can use various trace backends. It has precise timing,
  is not invasite, thus is suitable for enterprise grade products.
  You tipically want to use the 'nop' backend which totally disable
  tracing when building a production release binary.

  Trace events are useful to debug the guest but also the QEMU code.
  They are better to debug asynchrone issues than log_mask.
  They are also very useful to measure timings.
  <Many more features to add here...>

  Some backends allow easy parsing of events for further (graphical)
  analysis.

  You can enable/disable traces at runtime with the HMP
  'trace-event NAME on|off' command:

  (qemu) info trace-events
  [...]
  memory_region_ops_write : state 0
  memory_region_ops_read : state 0
  ram_block_discard_range : state 0
  find_ram_offset_loop : state 0
  find_ram_offset : state 0
  dma_map_wait : state 0
  dma_blk_cb : state 0
  [...]
  (qemu) trace-event find* on
  (qemu) info trace-events
  [...]
  memory_region_ops_write : state 0
  memory_region_ops_read : state 0
  ram_block_discard_range : state 0
  find_ram_offset_loop : state 1
  find_ram_offset : state 1
  dma_map_wait : state 0
  dma_blk_cb : state 0
  [...]

  You can also use a file with filtered events.
  Example tracing how YAMON access the flash and setup the
  PCI bars:

  $ cat yamon.trace
  # all flash i/o, no data
  pflash*
  -pflash_data
  pci*
  gt64120*

  $ qemu-system-mipsel -M malta \
    -serial vc \
    -pflash dump.bin \
    -trace events=yamon.trace
  11281@1561456612.571933:gt64120_isd_remap ISD: 0x00000000@0x00000000
-> 0x00001000@0x14000000
  11284@1561456612.576392:gt64120_isd_remap ISD: 0x00001000@0x14000000
-> 0x00001000@0x1be00000
  11284@1561456612.627574:pci_cfg_write gt64120_pci 00:0 @0x20 <- 0x1be00000
  11284@1561456614.825315:gt64120_write gt64120 write INTRCAUSE
value:0xfff3ffff
  ...
  11284@1561456615.176261:pci_cfg_write cirrus-vga 18:0 @0x4 <- 0x2
  11284@1561456615.176275:pci_update_mappings_add d=0x564efb01dd50
00:12.0 0,0x10000000+0x2000000
  11284@1561456615.176672:pci_update_mappings_add d=0x564efb01dd50
00:12.0 1,0x12050000+0x1000
  ...

Hope that help!

Regards,

Phil.

>>  Makefile.objs         |  1 +
>>  hw/mips/gt64xxx_pci.c | 29 ++++++++++-------------------
>>  hw/mips/trace-events  |  4 ++++
>>  3 files changed, 15 insertions(+), 19 deletions(-)
>>  create mode 100644 hw/mips/trace-events
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 658cfc9d9f..3b83621f32 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -163,6 +163,7 @@ trace-events-subdirs += hw/input
>>  trace-events-subdirs += hw/intc
>>  trace-events-subdirs += hw/isa
>>  trace-events-subdirs += hw/mem
>> +trace-events-subdirs += hw/mips
>>  trace-events-subdirs += hw/misc
>>  trace-events-subdirs += hw/misc/macio
>>  trace-events-subdirs += hw/net
>> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
>> index f44326f14f..815ef0711d 100644
>> --- a/hw/mips/gt64xxx_pci.c
>> +++ b/hw/mips/gt64xxx_pci.c
>> @@ -30,14 +30,7 @@
>>  #include "hw/pci/pci_host.h"
>>  #include "hw/i386/pc.h"
>>  #include "exec/address-spaces.h"
>> -
>> -//#define DEBUG
>> -
>> -#ifdef DEBUG
>> -#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__,
> ##__VA_ARGS__)
>> -#else
>> -#define DPRINTF(fmt, ...)
>> -#endif
>> +#include "trace.h"
>>
>>  #define GT_REGS                 (0x1000 >> 2)
>>
>> @@ -294,9 +287,7 @@ static void gt64120_isd_mapping(GT64120State *s)
>>      check_reserved_space(&start, &length);
>>      length = 0x1000;
>>      /* Map new address */
>> -    DPRINTF("ISD: "TARGET_FMT_plx"@"TARGET_FMT_plx
>> -        " -> "TARGET_FMT_plx"@"TARGET_FMT_plx"\n",
>> -        s->ISD_length, s->ISD_start, length, start);
>> +    trace_gt64120_isd_remap(s->ISD_length, s->ISD_start, length, start);
[...]

