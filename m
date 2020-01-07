Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC880C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58EC2075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlh0T7G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58EC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojEF-0004Lp-FY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioj9t-0003Yq-SB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioj9s-0001VG-4C
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:20:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioj9r-0001Ui-WE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578381607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjX6KlHAkdnNkoETzfW7ZqODsUdl2Y5RGvU6Ospl6JE=;
 b=dlh0T7G7IWHj01BZpppw8lwBZCyImeaUXX48stQuk56nLDltEUUNKZu8+g3CnqQk7KP8HE
 14yCaybj/clF5gEt1/Rca2G+sBs99oeOAFQaq7pDdjKqre+Xj5eHl9dlT22WNiVG37fDd0
 ENPM6XMyC3JOS6IXO+XCsRA98yDjFNU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-f-W_6owEMD2_VvC2Gz6dGQ-1; Tue, 07 Jan 2020 02:20:04 -0500
Received: by mail-wm1-f71.google.com with SMTP id t17so1643533wmi.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xjX6KlHAkdnNkoETzfW7ZqODsUdl2Y5RGvU6Ospl6JE=;
 b=ifMVaFoJ6YOEVAz2N2gJ5MqTNyR1OKDPf7ngB6xh001fsePffozo8W2zgtSymatrvq
 gPp+9oPj3lFDBRxC9lMDtcjA3otXhZKwpSTN+wjh9rTEGFGC8/sG7qjtM7RHGvgDeuZk
 L5KTxnk+QnZ8tTr05XyRF0nPC3M0d0nWgKOT2TMZyOi8IudciUPBVP57+i6fx3VYV1++
 UMFcThPro/HRC9JmdIsumAGvHkbPILEcVCUq+AslWbZ1DwwXq/RJyemcArZdhvOnzOTi
 bTKe7kMpSUVNatn2TWzj1yqevq1Q39OBY5a5wIQ0Gv5qpBtVLYleuqeXIFB2jf268ThM
 BioA==
X-Gm-Message-State: APjAAAWxgnksUHDwuS4K8lmOmnnhRPUyPHxb6jsYhgUQ2jfnRNsqw0IM
 6NKN7A6Pe8W5/s+J7apBGkqMs+ZVUkOHrvKxYOCwjN2R6exCKQHTCE4SAEhvPsvNWToFcgBJx7M
 n1YhJJIOGH/Rn2Z4=
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr38724944wmc.21.1578381602872; 
 Mon, 06 Jan 2020 23:20:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdwvQme61iFSo1RrvmdUnIlEafASy5U1Ieh52vuPw8RKHvLdTLffAsD2V4f7MF1iI/XxMwJA==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr38724914wmc.21.1578381602601; 
 Mon, 06 Jan 2020 23:20:02 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f1sm74722257wro.85.2020.01.06.23.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 23:20:01 -0800 (PST)
Subject: Re: [PATCH v2 02/13] dp8393x: Clean up endianness hacks
To: Finn Thain <fthain@telegraphics.com.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <cover.1576815466.git.fthain@telegraphics.com.au>
 <e44d136b8b71414e17200bb1b7edfd94fe866705.1576815466.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1.2001061953150.65@nippy.intranet>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <46e5c684-6fbb-fca2-82e5-d6c39a530c68@redhat.com>
Date: Tue, 7 Jan 2020 08:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1.2001061953150.65@nippy.intranet>
Content-Language: en-US
X-MC-Unique: f-W_6owEMD2_VvC2Gz6dGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 11:19 PM, Finn Thain wrote:
> On Fri, 20 Dec 2019, Finn Thain wrote:
> 
>> The in_use field is no different to the other words handled using
>> dp8393x_put() and dp8393x_get(). Use the same technique for in_use
>> that is used everywhere else.
>>
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>> ---
>> Changed since v1:
>>   - Use existing 'address' variable rather than declare a new one.
>>
>> Laurent tells me that this clean-up has been tried before. He referred
>> me to commit c744cf7879 ("dp8393x: fix dp8393x_receive()") and
>> commit 409b52bfe1 ("net/dp8393x: correctly reset in_use field").
>>
>> Both of those patches look wrong to me because they both pass the wrong
>> byte count to address_space_rw(). It's possible that those patches were
>> needed to work around some kind of bug elsewhere, for example, an
>> off-by-one result from dp8393x_crda(). The preceding patch in this series
>> might help there.
> 
> Unfortunately this patch really does break NetBSD/arc 5.1, just as
> Laurent said it would, just as commit c744cf7879 did.
> 
> Yet these patches are correct. What gives?
> 
> I found that one more change can make guests work (for both m68k q800 and
> mips64el magnum machines) --
> 
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -246,8 +246,10 @@ static void dp8393x_put(dp8393xState *s, int width,
> int offset,
>                           uint16_t val)
>   {
>       if (s->big_endian) {
> +        s->data[offset * width] = 0;
>           s->data[offset * width + width - 1] = cpu_to_be16(val);
>       } else {
> +        s->data[offset * width + width - 1] = 0;
>           s->data[offset * width] = cpu_to_le16(val);
>       }
>   }
> 
> For a wide bus interface, this forces the Most Significant Word (MSW) to
> zero. Yet another endianness hack, but it makes NetBSD 5.1 'sn' driver
> happy.

Can you write a list of real word addresses/values/result expected for 
each endianess, so we can add a qtest for this?

> There is a similar issue with the Linux jazzsonic driver. This driver uses
> long-word-sized loads with word-sized MMIO registers --
> 
> #define SONIC_READ(reg) (*((volatile unsigned int *)dev->base_addr+reg))
> 
> This driver also expects the MSW to be zero. But the MSW actually equals
> the LSW, and the driver fails to probe:
> 
> SONIC ethernet controller not found (0x40004)
> 
> This seems to indicate that qemu-system-mips64el -M magnum is doing word
> smearing on the processor bus. Does anyone know how to prevent that?

I remember a similar issue with another MIPS board because QEMU doesn't 
model the bus controller, which might do such magic.

> 
>> ---
>>   hw/net/dp8393x.c | 17 ++++++-----------
>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index 1957bd391e..b2cc768d9b 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -765,8 +765,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>>           return -1;
>>       }
>>   
>> -    /* XXX: Check byte ordering */
>> -
>>       /* Check for EOL */
>>       if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
>>           /* Are we still in resource exhaustion? */
>> @@ -836,15 +834,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>>           /* EOL detected */
>>           s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
>>       } else {
>> -        /* Clear in_use, but it is always 16bit wide */
>> -        int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
>> -        if (s->big_endian && width == 2) {
>> -            /* we need to adjust the offset of the 16bit field */
>> -            offset += sizeof(uint16_t);
>> -        }
>> -        s->data[0] = 0;
>> -        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
>> -                         (uint8_t *)s->data, sizeof(uint16_t), 1);
>> +        /* Clear in_use */
>> +        address = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
>> +        size = sizeof(uint16_t) * width;
>> +        dp8393x_put(s, width, 0, 0);
>> +        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>> +                         (uint8_t *)s->data, size, 1);
>>           s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
>>           s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
>>           s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
>>
> 


