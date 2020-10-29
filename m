Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C47CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BEC214DB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS7CUfy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BEC214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY1qZ-00043T-MY
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 02:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kY1ov-0003XG-27; Thu, 29 Oct 2020 02:54:01 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:36312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kY1ot-0006nW-1Y; Thu, 29 Oct 2020 02:54:00 -0400
Received: by mail-ed1-x533.google.com with SMTP id l16so1985875eds.3;
 Wed, 28 Oct 2020 23:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6StLWyAqEzAMjKtpEOcnKw5mFVIeCeKVeKR/dL5dzQc=;
 b=oS7CUfy41lbUDyCHCNmdd/WZp6T07GlUzoH0BDubko+YBAlEIIBbO2UJgROR2iw7wi
 duvuGpXT5OYUtn77QcPt8EHM8+Xi1wLjSR9FduAeO4btAGkNPv3AEKpZgzpHVyIig6f8
 yKIrgYnT/WAIX2AQu7hL0MsXrVvNZz1gtcjRQ2km0MJ1s4ruyoiC1UQYTI3LQt7sTxJa
 GscEV9Q3sOBDQuo8hA3mjCQ4X5L3S2TaOYTfGcxzslLd6bT6sctPMU4CNGaDUI6cshkv
 n9QsM+L2gipmka5R3vdDFqINHBEyEB0+eaBiE8vEa1FhYhkLaX/lxCBYDzH2SANbeSpU
 SYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6StLWyAqEzAMjKtpEOcnKw5mFVIeCeKVeKR/dL5dzQc=;
 b=SAahVad92pFIzEPfUJ8Ebk3cQLdoFcD1Fe12N6G9bXDTSM+bPIH5C6vynJpovGlT5l
 EkfQ9zVZ+GD74EQpsTgBayTCVhlLPiNu7H93luQe4/OAA8/B0PcM6t1q/yS0gzCSI5hc
 BVIiZXgwBskgK0+12cl0CFY3kQdcpm6QrWX2LUkUDHDUAsWYB/1FdxbTk11t1qBugoUY
 utc6ZDQQ7doUU4HkyxWLcNyWDZy2a+QlQfAFOgkyWCnUdJAebZtofDK0ACJQHbfwySPC
 GjBiIXEHDbv8snDfTiwrr6/6K9Ds1eV9fT8vnDhYxZxlTM2bYe2ifBz1jvGWX7JKhyXM
 1V3w==
X-Gm-Message-State: AOAM530MteiJcdjUqm/R8k5gG3GCpljK8yc48IwXg8QOXIal6aX3sb3Z
 U8pHoFCPMLpKFnFQW4q7srM=
X-Google-Smtp-Source: ABdhPJzi5kxLMles3UYCAQbdLueYCVGQV1eWkNrqlO0hY9WRx5nZQ+ZI5AeB2XcGBjJp2B1ZseGOCA==
X-Received: by 2002:a50:8f61:: with SMTP id 88mr2546599edy.175.1603954437180; 
 Wed, 28 Oct 2020 23:53:57 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t8sm909032ejc.45.2020.10.28.23.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 23:53:56 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] hw/block/m25p80: Fix Numonyx fast read dummy cycle
 count
To: Joe Komlodi <komlodi@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1603842220-215321-1-git-send-email-komlodi@xilinx.com>
 <1603842220-215321-2-git-send-email-komlodi@xilinx.com>
 <453e55d5-3433-0865-a902-8851ca563e48@amsat.org>
 <BY5PR02MB603372466CB0B05638D270FFD0170@BY5PR02MB6033.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0212c532-880e-c0d9-cbfe-3f8e0b8a2c8e@amsat.org>
Date: Thu, 29 Oct 2020 07:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB603372466CB0B05638D270FFD0170@BY5PR02MB6033.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 12:15 AM, Joe Komlodi wrote:
> Hi Philippe,
> 
> Comments marked inline with [Joe]
> 
> -----Original Message-----
> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> On Behalf Of Philippe Mathieu-Daudé
> Sent: Wednesday, October 28, 2020 2:27 AM
> To: Joe Komlodi <komlodi@xilinx.com>; qemu-devel@nongnu.org
> Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>; kwolf@redhat.com; alistair@alistair23.me; qemu-block@nongnu.org; mreitz@redhat.com
> Subject: Re: [PATCH v2 1/1] hw/block/m25p80: Fix Numonyx fast read dummy cycle count
> 
> Hi Joe,
> 
> On 10/28/20 12:43 AM, Joe Komlodi wrote:
>> Numonyx chips determine the number of cycles to wait based on bits 7:4 
>> in the volatile configuration register.
>>
>> However, if these bits are 0x0 or 0xF, the number of dummy cycles to 
>> wait is
>> 10 on a QIOR or QIOR4 command, or 8 on any other currently supported 
>> fast read command. [1]
>>
>> [1] 
>> https://www.micron.com/-/media/client/global/documents/products/data-s
>> heet/ nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_02g_cbb_0.pdf
>> ?rev=9b167fbf2b3645efba6385949a72e453
> 
> Please use single line for URL (even longer than 80 characters):
> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_02g_cbb_0.pdf
> 
> Or use
> 
> Datasheet: "MT25QU02GCBB Rev. H 05/19 EN"
> 
> [Joe] Ah, sorry about that, I'll put it all on one line in v3.
> 
>> Page 34, page 39 note 5
> 
> The note 5 is not restricted to QIOR/QIOR4 commands, so your patch seems incomplete.
> 
> [Joe] Right. Right now it's only checking QIOR/QIOR4 because we don't have a way to put Numonyx chips in QIO mode (s->quad_enable == true), and we don't model DDR commands.
> Because of those restrictions, all the read commands need 8 cycles, except for QIOR/QIOR4.
> 
>>
>> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
>> ---
>>  hw/block/m25p80.c | 26 +++++++++++++++++++++++---
>>  1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c index 
>> 483925f..302ed9d 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -820,6 +820,26 @@ static void reset_memory(Flash *s)
>>      trace_m25p80_reset_done(s);
>>  }
>>  
>> +static uint8_t numonyx_extract_cfg_num_dummies(Flash *s) {
>> +    uint8_t cycle_count;
>> +    uint8_t num_dummies;
>> +    assert(get_man(s) == MAN_NUMONYX);
>> +
>> +    cycle_count = extract32(s->volatile_cfg, 4, 4);
> 
> Could be easier to review as:
> 
>        num_dummies = extract32(s->volatile_cfg, 4, 4);
> 
>        switch (s->cmd_in_progress) {
>        /* note 5 comment ... */
>        case FAST_READ:
>        case ...
>            /* field erased or reset in NVRAM */
>            if (cycle_count == 0x0 || cycle_count == 0xf) {
>                switch (s->cmd_in_progress) {
>                case FAST_READ:
>                case ...:
>                    num_dummies = 10;
>                    break;
>                case ...:
>                case ...:
>                    /* assert(s->quad_enable); */
>                    num_dummies = 8;
>                    break;
>                default:
>                    qemu_log_mask(GUEST_ERROR, ...);
>                    break;
>                }
>            }
>            break;
>        default:
>            break;
>        }
> 
>        return num_dummies;
> 
>> +    if (cycle_count == 0x0 || cycle_count == 0x0F) {
>> +        if (s->cmd_in_progress == QIOR || s->cmd_in_progress == QIOR4) {
>> +            num_dummies = 10;
>> +        } else {
>> +            num_dummies = 8;
> 
> Note, this is only true if s->quad_enable.
> 
> Maybe clever to use the dumbest approach and copy the table...
> 
> static uint8_t numonyx_extract_cfg_num_dummies(Flash *s) {
>     static const unsigned dummy_clock_cycles[0x100][3] = {
>       [FAST_READ] = {8, 8, 10},
>       ...
>     };
>     uint8_t num_dummies = extract32(s->volatile_cfg, 4, 4);
> 
>     if (cycle_count == 0x0 || cycle_count == 0xf) {
>         num_dummies = dummy_clock_cycles[s->cmd_in_progress][mode];
>     }
> 
>     return num_dummies;
> }
> 
> [Joe] I think either this or the switch statement would work fine, it just depends if we want to add a way to set s->quad_enable and s->dual_enable (doesn't exist in the model) for Numonyx chips.
> To be the most accurate, it probably would be best to add a way to enable/disable QIO and DIO mode for Numonyx chips, then change the cycles needed accordingly.
> 
> Let me know what you think.

It is OK to not implement unused registers/fields, but please
use qemu_log_mask(LOG_UNIMP,...) there, so we can:
- notice the guest is accessing unimplemented registers at runtime
- easily find the missing place in the code.

