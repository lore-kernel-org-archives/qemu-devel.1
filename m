Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED9920674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2IxrUID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED9920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz2m-0004dB-KW
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iyz1n-0003ly-EG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iyz1l-0007Vx-Pi
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:18:11 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iyz1h-0006ib-VQ; Tue, 04 Feb 2020 09:18:06 -0500
Received: by mail-pf1-x442.google.com with SMTP id j9so6453172pfa.8;
 Tue, 04 Feb 2020 06:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VPj2fBA0gaqfwZZEe582XPW7SbdH8PJcN7m323RHOnw=;
 b=O2IxrUIDDN+J/JmuIB8TLi55ZN547ntN9QSje/lmtXsLLcqSWBSqxlykIiAufI+kBj
 vQ0LVFhqL3tCZcu5JbGNCtB3pUt0kMz5R3+d4ie96GeMIuEG8e7+ZC3hS87EI4rB3RjT
 cxjPrPbuwWM18tXIv9lue5LNgFxYMPyaYDD5dtD8nG4pLM6MmTH4V4qJsNprwLb5PJ9J
 9p6VD/EPKaZUvABIfT30WduWaD5zj2qk0opE5f/nHa35vH/89ti2qvMUFiJJv+KGtNYo
 swscotV4Fv9AYReIxezrAFJhu6XMEKsCtRnH3G7rsu7eDjOai9Dl4ODaYeSa8Zx8MXCS
 niZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VPj2fBA0gaqfwZZEe582XPW7SbdH8PJcN7m323RHOnw=;
 b=teEG8MSfHANkwUZhP5OA8lCRexxAY8w/+xDxwzT0J1vRfCBniRgm6YVzxHQnBPYvZp
 m/NgJfdnbIgQjqIIeEnIQxZcEjHf0ALgEDDVCdDVQreIVR5aHP5YKjxRThLGleHtLL8V
 5XXATo2Y45my0kLOAUuaA2Ork0n69ym+vmmpLxYIHPBU8HNZ4jKmupymKeIXmaatmlrA
 3WfugUfoCfznqDEADiA94DOcyp43jpNCcB8ZI0ozKtIi6MkkhIhK1W5Cj3ecHlHVYn2X
 xoTdg8I97kRJYEzviHd4WGiV4PeGjPiX8vur/a+mjPuNwP4NpQ/uJZ9weEfrMUOBmU98
 FFtw==
X-Gm-Message-State: APjAAAUD7z77w2qgdVqQkbbF7pIfqdmPsZVbSiLxBzc0nAuwPDZPQzMN
 XCSB24pJx0vLMj9syUK8ZK8=
X-Google-Smtp-Source: APXvYqzpaAL1os4lSiX34XBbfTWn/67EiA51C7t9Jlb8fFrnENOZKhdmx4JbgEuZC9Cru93pTE6dwQ==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr31703590pga.223.1580825883741; 
 Tue, 04 Feb 2020 06:18:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 5sm24858904pfx.163.2020.02.04.06.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 06:18:01 -0800 (PST)
Subject: Re: [PATCH 1/3] m25p80: Convert to support tracing
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <2dfe10d0-2e67-b83c-92a6-b503ed55ebd7@kaod.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <13b23907-b472-d81f-b88a-4f58ea8299b1@roeck-us.net>
Date: Tue, 4 Feb 2020 06:18:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2dfe10d0-2e67-b83c-92a6-b503ed55ebd7@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 11:16 PM, Cédric Le Goater wrote:
> On 2/3/20 7:09 PM, Guenter Roeck wrote:
>> While at it, add some trace messages to help debug problems
>> seen when running the latest Linux kernel.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> We have been chasing a bug for years on the witherspoon-bmc machine
> using UBIfs. It will be useful.
> 
> What kind of issue are you looking at ?
> 

aspeed-ast2500-evb no longer boots from flash with the current mainline kernel.
The problem is fixed with the 3rd patch of the series.

Guenter

> Thanks,
> 
> C.
> 
>> ---
>>   hw/block/m25p80.c     | 48 ++++++++++++++++++++-----------------------
>>   hw/block/trace-events | 16 +++++++++++++++
>>   2 files changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 11ff5b9ad7..63e050d7d3 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -32,17 +32,7 @@
>>   #include "qemu/module.h"
>>   #include "qemu/error-report.h"
>>   #include "qapi/error.h"
>> -
>> -#ifndef M25P80_ERR_DEBUG
>> -#define M25P80_ERR_DEBUG 0
>> -#endif
>> -
>> -#define DB_PRINT_L(level, ...) do { \
>> -    if (M25P80_ERR_DEBUG > (level)) { \
>> -        fprintf(stderr,  ": %s: ", __func__); \
>> -        fprintf(stderr, ## __VA_ARGS__); \
>> -    } \
>> -} while (0)
>> +#include "trace.h"
>>   
>>   /* Fields for FlashPartInfo->flags */
>>   
>> @@ -574,7 +564,8 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>>           abort();
>>       }
>>   
>> -    DB_PRINT_L(0, "offset = %#x, len = %d\n", offset, len);
>> +    trace_m25p80_flash_erase(offset, len);
>> +
>>       if ((s->pi->flags & capa_to_assert) != capa_to_assert) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: %d erase size not supported by"
>>                         " device\n", len);
>> @@ -607,8 +598,7 @@ void flash_write8(Flash *s, uint32_t addr, uint8_t data)
>>       }
>>   
>>       if ((prev ^ data) & data) {
>> -        DB_PRINT_L(1, "programming zero to one! addr=%" PRIx32 "  %" PRIx8
>> -                   " -> %" PRIx8 "\n", addr, prev, data);
>> +        trace_m25p80_programming_zero_to_one(addr, prev, data);
>>       }
>>   
>>       if (s->pi->flags & EEPROM) {
>> @@ -662,6 +652,9 @@ static void complete_collecting_data(Flash *s)
>>   
>>       s->state = STATE_IDLE;
>>   
>> +    trace_m25p80_complete_collecting(s->cmd_in_progress, n, s->ear,
>> +                                     s->cur_addr);
>> +
>>       switch (s->cmd_in_progress) {
>>       case DPP:
>>       case QPP:
>> @@ -825,7 +818,7 @@ static void reset_memory(Flash *s)
>>           break;
>>       }
>>   
>> -    DB_PRINT_L(0, "Reset done.\n");
>> +    trace_m25p80_reset_done();
>>   }
>>   
>>   static void decode_fast_read_cmd(Flash *s)
>> @@ -941,9 +934,10 @@ static void decode_qio_read_cmd(Flash *s)
>>   
>>   static void decode_new_cmd(Flash *s, uint32_t value)
>>   {
>> -    s->cmd_in_progress = value;
>>       int i;
>> -    DB_PRINT_L(0, "decoded new command:%x\n", value);
>> +
>> +    s->cmd_in_progress = value;
>> +    trace_m25p80_command_decoded(value);
>>   
>>       if (value != RESET_MEMORY) {
>>           s->reset_enable = false;
>> @@ -1042,7 +1036,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>           break;
>>   
>>       case JEDEC_READ:
>> -        DB_PRINT_L(0, "populated jedec code\n");
>> +        trace_m25p80_populated_jedec();
>>           for (i = 0; i < s->pi->id_len; i++) {
>>               s->data[i] = s->pi->id[i];
>>           }
>> @@ -1063,7 +1057,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>       case BULK_ERASE_60:
>>       case BULK_ERASE:
>>           if (s->write_enable) {
>> -            DB_PRINT_L(0, "chip erase\n");
>> +            trace_m25p80_chip_erase();
>>               flash_erase(s, 0, BULK_ERASE);
>>           } else {
>>               qemu_log_mask(LOG_GUEST_ERROR, "M25P80: chip erase with write "
>> @@ -1184,7 +1178,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>>           s->data_read_loop = false;
>>       }
>>   
>> -    DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
>> +    trace_m25p80_select(select ? "de" : "");
>>   
>>       return 0;
>>   }
>> @@ -1194,19 +1188,20 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>>       Flash *s = M25P80(ss);
>>       uint32_t r = 0;
>>   
>> +    trace_m25p80_transfer(s->state, s->len, s->needed_bytes, s->pos,
>> +                          s->cur_addr, (uint8_t)tx);
>> +
>>       switch (s->state) {
>>   
>>       case STATE_PAGE_PROGRAM:
>> -        DB_PRINT_L(1, "page program cur_addr=%#" PRIx32 " data=%" PRIx8 "\n",
>> -                   s->cur_addr, (uint8_t)tx);
>> +        trace_m25p80_page_program(s->cur_addr, (uint8_t)tx);
>>           flash_write8(s, s->cur_addr, (uint8_t)tx);
>>           s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
>>           break;
>>   
>>       case STATE_READ:
>>           r = s->storage[s->cur_addr];
>> -        DB_PRINT_L(1, "READ 0x%" PRIx32 "=%" PRIx8 "\n", s->cur_addr,
>> -                   (uint8_t)r);
>> +        trace_m25p80_read_byte(s->cur_addr, (uint8_t)r);
>>           s->cur_addr = (s->cur_addr + 1) & (s->size - 1);
>>           break;
>>   
>> @@ -1244,6 +1239,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>>           }
>>   
>>           r = s->data[s->pos];
>> +        trace_m25p80_read_data(s->pos, (uint8_t)r);
>>           s->pos++;
>>           if (s->pos == s->len) {
>>               s->pos = 0;
>> @@ -1281,7 +1277,7 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
>>               return;
>>           }
>>   
>> -        DB_PRINT_L(0, "Binding to IF_MTD drive\n");
>> +        trace_m25p80_binding();
>>           s->storage = blk_blockalign(s->blk, s->size);
>>   
>>           if (blk_pread(s->blk, 0, s->storage, s->size) != s->size) {
>> @@ -1289,7 +1285,7 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
>>               return;
>>           }
>>       } else {
>> -        DB_PRINT_L(0, "No BDRV - binding to RAM\n");
>> +        trace_m25p80_binding_no_bdrv();
>>           s->storage = blk_blockalign(NULL, s->size);
>>           memset(s->storage, 0xFF, s->size);
>>       }
>> diff --git a/hw/block/trace-events b/hw/block/trace-events
>> index c03e80c2c9..d052f7578c 100644
>> --- a/hw/block/trace-events
>> +++ b/hw/block/trace-events
>> @@ -134,3 +134,19 @@ xen_block_blockdev_add(char *str) "%s"
>>   xen_block_blockdev_del(const char *node_name) "%s"
>>   xen_block_device_create(unsigned int number) "%u"
>>   xen_block_device_destroy(unsigned int number) "%u"
>> +
>> +# m25p80.c
>> +m25p80_flash_erase(int offset, uint32_t len) "offset = 0x%"PRIx32", len = %u"
>> +m25p80_programming_zero_to_one(uint32_t addr, uint8_t prev, uint8_t data) "programming zero to one! addr=0x%"PRIx32"  0x%"PRIx8" -> 0x%"PRIx8
>> +m25p80_reset_done(void) "Reset done."
>> +m25p80_command_decoded(uint32_t cmd) "new command:0x%"PRIx32
>> +m25p80_complete_collecting(uint32_t cmd, int n, uint8_t ear, uint32_t cur_addr) "decode cmd: 0x%"PRIx32" len %d ear 0x%"PRIx8" addr 0x%"PRIx32
>> +m25p80_populated_jedec(void) "populated jedec code"
>> +m25p80_chip_erase(void) "chip erase"
>> +m25p80_select(const char *what) "%sselect"
>> +m25p80_page_program(uint32_t addr, uint8_t tx) "page program cur_addr=0x%"PRIx32" data=0x%"PRIx8
>> +m25p80_transfer(uint8_t state, uint32_t len, uint8_t needed, uint32_t pos, uint32_t cur_addr, uint8_t t) "Transfer state 0x%"PRIx8" len 0x%"PRIx32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PRIx8
>> +m25p80_read_byte(uint32_t addr, uint8_t v) "Read byte 0x%"PRIx32"=0x%"PRIx8
>> +m25p80_read_data(uint32_t pos, uint8_t v) "Read data 0x%"PRIx32"=0x%"PRIx8
>> +m25p80_binding(void) "Binding to IF_MTD drive"
>> +m25p80_binding_no_bdrv(void) "No BDRV - binding to RAM"
>>
> 


