Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD53C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605DB206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605DB206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8je-0000Vm-HE
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kD87c-0000DU-8y; Tue, 01 Sep 2020 11:22:56 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kD87Z-0006pa-OD; Tue, 01 Sep 2020 11:22:55 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.102])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 79AE15CD8B20;
 Tue,  1 Sep 2020 17:22:49 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 17:22:48 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0069242b285-85de-407e-95a5-f3cc2276aada,
 38EE1E9FF4E34D4C85F4190D418CEE501B878519) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 1/2] m25p80: Add basic support for the SFDP command
To: Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20200827091130.3525790-1-clg@kaod.org>
 <20200827091130.3525790-2-clg@kaod.org>
 <20200901133606.tytctenwwbnzlgl4@fralle-msi>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <76571443-8408-4fe9-9a7d-77059b44b792@kaod.org>
Date: Tue, 1 Sep 2020 17:22:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901133606.tytctenwwbnzlgl4@fralle-msi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: dab219aa-2790-4689-9c7a-0dd21cadf68b
X-Ovh-Tracer-Id: 7442479862205025129
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehfrhgrshhsvgdrihhglhgvshhirghssehgmhgrihhlrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 11:22:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:36 PM, Francisco Iglesias wrote:
> Hi Cedric,
> 
> On [2020 Aug 27] Thu 11:11:29, Cédric Le Goater wrote:
>> JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
>> provides a mean to describe the features of a serial flash device
>> using a set of internal parameter tables.
>>
>> This is the initial framework for the RDSFDP command giving access to
>> a private SFDP area under the flash. This area now needs to be
>> populated with the flash device characteristics, using a new 'sfdp'
>> pointer under FlashPartInfo.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  hw/block/m25p80_sfdp.h | 15 +++++++++++++++
>>  hw/block/m25p80.c      | 33 +++++++++++++++++++++++++++++++++
>>  hw/block/trace-events  |  1 +
>>  3 files changed, 49 insertions(+)
>>  create mode 100644 hw/block/m25p80_sfdp.h
>>
>> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
>> new file mode 100644
>> index 000000000000..b75fd0b0c13f
>> --- /dev/null
>> +++ b/hw/block/m25p80_sfdp.h
>> @@ -0,0 +1,15 @@
>> +/*
>> + * M25P80 SFDP
>> + *
>> + * Copyright (c) 2020, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef HW_M25P80_SFDP_H
>> +#define HW_M25P80_SFDP_H
>> +
>> +#define M25P80_SFDP_AREA_SIZE 0x100
>> +
>> +#endif
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 82270884416e..32925589ec7a 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -33,6 +33,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>>  #include "trace.h"
>> +#include "m25p80_sfdp.h"
>>  
>>  /* Fields for FlashPartInfo->flags */
>>  
>> @@ -72,6 +73,7 @@ typedef struct FlashPartInfo {
>>       * This field inform how many die is in the chip.
>>       */
>>      uint8_t die_cnt;
>> +    const uint8_t *sfdp;
>>  } FlashPartInfo;
>>  
>>  /* adapted from linux */
>> @@ -333,6 +335,7 @@ typedef enum {
>>      BULK_ERASE = 0xc7,
>>      READ_FSR = 0x70,
>>      RDCR = 0x15,
>> +    RDSFDP = 0x5a,
>>  
>>      READ = 0x03,
>>      READ4 = 0x13,
>> @@ -398,6 +401,7 @@ typedef enum {
>>      STATE_COLLECTING_DATA,
>>      STATE_COLLECTING_VAR_LEN_DATA,
>>      STATE_READING_DATA,
>> +    STATE_READING_SFDP,
>>  } CMDState;
>>  
>>  typedef enum {
>> @@ -619,6 +623,8 @@ static inline int get_addr_length(Flash *s)
>>      }
>>  
>>     switch (s->cmd_in_progress) {
>> +   case RDSFDP:
>> +       return 3;
>>     case PP4:
>>     case PP4_4:
>>     case QPP_4:
>> @@ -744,6 +750,17 @@ static void complete_collecting_data(Flash *s)
>>                            " by device\n");
>>          }
>>          break;
>> +
>> +    case RDSFDP:
>> +        if (s->cur_addr < M25P80_SFDP_AREA_SIZE) {
> 
> Is perhaps M25P80_SFDP_AREA_SIZE a limit for the micron flashes in patch
> 2 (and not sfdp)? 

No. It's a common limit of the chips available on the systems I have 
access to. Nothing is said in the specs on a maximum size and only 
one table is required. But, theoretically, we have a 24bits address 
space.  

> An option might be to change .sfdp to a '.sfdp_read' function decoding 
> the address internally (for the micron flashes it could just return the 
> array value in case the address is less than M25P80_SFDP_AREA_SIZE 

Yes. This is one way to make the SFDP table size depend on the chip 
model. 

> or 0xFF else). 

Some flash seems to wrap around when the max size is reached. See 
the mx25l25635e in my git tree. But I have only read 0x100 bytes.

> It might become easier
> to add flashes containing parameter tables in higher addresses (the
> function could then decode the address into a specific table/area).

yes. Something like that.

>> +            s->state = STATE_READING_SFDP;
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "M25P80: Invalid SFDP address %#" PRIx32 "\n",
>> +                          s->cur_addr);
>> +        }
>> +        break;
>> +
>>      default:
>>          break;
>>      }
>> @@ -1160,6 +1177,16 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>      case RSTQIO:
>>          s->quad_enable = false;
>>          break;
>> +    case RDSFDP:
>> +        if (s->pi->sfdp) {
>> +            s->needed_bytes = get_addr_length(s) + 1 ; /* SFDP addr + dummy */
> 
> Should above be changed to:
> 
> s->needed_bytes = get_addr_length(s) + 8;  /* SFDP addr + dummy */

oops. I have been lucky. I need to change the Aspeed SMC snooping 
routine to compute the number of dummies for the RDSFDP command.

> (I think it might fail else when the flashes are operating in 2 lines and
> 4 lines and are generating 8 dummy cycles for the RDSFDP)

The specs say that the requirement are independent of the I/O mode.

    4.5 Instruction Input Modes
    
    The Read SFDP instruction can be used with device supported modes
    of (1-1-1), (2-2-2), or (4-4-4), but the opcode (0x5A), address
    (24 bits), eight dummy clocks (8 wait states), and 50 MHz
    requirements remain the same.

Thanks,

C. 


> Best regards,
> Francisco Iglesias
> 
>> +            s->pos = 0;
>> +            s->len = 0;
>> +            s->state = STATE_COLLECTING_DATA;
>> +            break;
>> +        }
>> +        /* Fallthrough */
>> +
>>      default:
>>          s->pos = 0;
>>          s->len = 1;
>> @@ -1256,6 +1283,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>>              }
>>          }
>>          break;
>> +    case STATE_READING_SFDP:
>> +        assert(s->pi->sfdp);
>> +        r = s->pi->sfdp[s->cur_addr];
>> +        trace_m25p80_read_sfdp(s, s->cur_addr, (uint8_t)r);
>> +        s->cur_addr = (s->cur_addr + 1) & (M25P80_SFDP_AREA_SIZE - 1);
>> +        break;
>>  
>>      default:
>>      case STATE_IDLE:
>> diff --git a/hw/block/trace-events b/hw/block/trace-events
>> index 958fcc5508d1..53d377ca2b46 100644
>> --- a/hw/block/trace-events
>> +++ b/hw/block/trace-events
>> @@ -152,5 +152,6 @@ m25p80_page_program(void *s, uint32_t addr, uint8_t tx) "[%p] page program cur_a
>>  m25p80_transfer(void *s, uint8_t state, uint32_t len, uint8_t needed, uint32_t pos, uint32_t cur_addr, uint8_t t) "[%p] Transfer state 0x%"PRIx8" len 0x%"PRIx32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PRIx8
>>  m25p80_read_byte(void *s, uint32_t addr, uint8_t v) "[%p] Read byte 0x%"PRIx32"=0x%"PRIx8
>>  m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0x%"PRIx8
>> +m25p80_read_sfdp(void *s, uint32_t addr, uint8_t v) "[%p] Read SFDP 0x%"PRIx32"=0x%"PRIx8
>>  m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
>>  m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
>> -- 
>> 2.25.4
>>


