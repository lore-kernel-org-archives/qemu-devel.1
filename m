Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6130C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A50A2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 17:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A50A2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksUC-0004jS-Iq
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jksT7-0003qv-K0
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:00:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jksT4-0005Nr-MN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 13:00:20 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4CF04746331;
 Mon, 15 Jun 2020 19:00:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 23167746307; Mon, 15 Jun 2020 19:00:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 21612745702;
 Mon, 15 Jun 2020 19:00:15 +0200 (CEST)
Date: Mon, 15 Jun 2020 19:00:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] sm501: Optimise 1 pixel 2d ops
In-Reply-To: <CAFEAcA-QBJ2CTRzjD=KY7WPHXaK=Qw514KTKvb8psRPrEAGyXA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2006151841300.51837@zero.eik.bme.hu>
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <9fab4fe6513fe8b921ce86a57f4ff7e0d5a3c3f9.1591471056.git.balaton@eik.bme.hu>
 <CAFEAcA-QBJ2CTRzjD=KY7WPHXaK=Qw514KTKvb8psRPrEAGyXA@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 11:14:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020, Peter Maydell wrote:
> On Sat, 6 Jun 2020 at 20:22, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Some guests do 1x1 blits which is faster to do directly than calling a
>> function for it so avoid overhead in this case.
>
> How much does the performance improve by ?

I haven't actually measured due to lack of time experimenting with it and 
those who I've asked to check it only reported it felt a bit faster but no 
numerical measurements so that does not prove anything. Anyway these 
special cases should not hurt and simple enough to have it here even if 
may not improve performance very much. The biggest loss is probably 
converting 16 bit screen on every display update to 32 bit because the 
guest driver does not allow higher bit depth than 16 for some reason. But 
I don't plan to spend more time with improving sm501, only done it because 
I had to touch it anyway. Longer term plan is to finish ati-vga which 
should have better guest drivers and better performance.

>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c | 40 +++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 3397ca9fbf..59693fbb5c 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -793,6 +793,25 @@ static void sm501_2d_operation(SM501State *s)
>>                  src_x == dst_x && src_y == dst_y) {
>>                  break;
>>              }
>> +            /* Some clients also do 1 pixel blits, avoid overhead for these */
>> +            if (width == 1 && height == 1) {
>> +                unsigned int si = (src_x + src_y * src_pitch) * (1 << format);
>> +                unsigned int di = (dst_x + dst_y * dst_pitch) * (1 << format);
>> +                switch (format) {
>> +                case 0:
>> +                    s->local_mem[dst_base + di] = s->local_mem[src_base + si];
>> +                    break;
>> +                case 1:
>> +                    *(uint16_t *)&s->local_mem[dst_base + di] =
>> +                                    *(uint16_t *)&s->local_mem[src_base + si];
>> +                    break;
>> +                case 2:
>> +                    *(uint32_t *)&s->local_mem[dst_base + di] =
>> +                                    *(uint32_t *)&s->local_mem[src_base + si];
>> +                    break;
>> +                }
>
> You could write this more compactly as
>                   stn_he_p(&s->local_mem[dst_base + di], 1 << format,
>                            ldn_he_p(&s->local_mem[src_base + si], 1
> << format));
>
> (which handles the length-cases for you and also doesn't rely on
> casting a uint8_t* giving you something correctly aligned for a
> wider access).

OK, I never know these and they are a bit hard to find because they are 
defined as glued together macros so grepping for it does not show the 
definition. Maybe adding a comment with the names where these are defined 
in bswap.h might help. stn_he_p seems to ultimately call __builtin_memcpy 
that probably does the same direct assignment for short values. I wonder 
how much overhead that has going through all the function calls but 
hopefully those are inlined.

Regards,
BALATON Zoltan

>> +                break;
>> +            }
>>              /* Check for overlaps, this could be made more exact */
>>              uint32_t sb, se, db, de;
>>              sb = src_base + src_x + src_y * (width + src_pitch);
>> @@ -841,9 +860,24 @@ static void sm501_2d_operation(SM501State *s)
>>              color = cpu_to_le16(color);
>>          }
>>
>> -        pixman_fill((uint32_t *)&s->local_mem[dst_base],
>> -                    dst_pitch * (1 << format) / sizeof(uint32_t),
>> -                    8 * (1 << format), dst_x, dst_y, width, height, color);
>> +        if (width == 1 && height == 1) {
>> +            unsigned int i = (dst_x + dst_y * dst_pitch) * (1 << format);
>> +            switch (format) {
>> +            case 0:
>> +                s->local_mem[dst_base + i] = color & 0xff;
>> +                break;
>> +            case 1:
>> +                *(uint16_t *)&s->local_mem[dst_base + i] = color & 0xffff;
>> +                break;
>> +            case 2:
>> +                *(uint32_t *)&s->local_mem[dst_base + i] = color;
>> +                break;
>> +            }
>
>               stn_he_p(&s->local_mem[dst_base + i], 1 << format, color);

