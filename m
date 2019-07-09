Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD125C73C42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2A920844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2A920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkp0D-0003sO-Io
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 08:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkowy-0002xJ-Sk
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkowv-00068z-6L
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:10:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkowv-000650-0S
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:10:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so10610933wrr.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 05:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8JQUSvCxgUt0Zcu2VBjbCtR+wnHkSCBgdtHjjyiw7QE=;
 b=uM0E9saNaborbfwfL7tZB4eQqLx6nUaIyqu0JosueFVyYcUtmuBm0BZqFuJwAGPxuK
 XQFgAo86miYD2cxGZA6DfPen+7dj8/J08NfzLJJaNmp+BLQVdLlQU/0bpjYvdUe+sSEv
 DEUKqqMSNgO9uPFAue4eHLp0BdfsN47iTmJdgTmnGrnM8nFeWd6EUjArexmtMd8sY1GZ
 pbmMIpXMQYefq+VXT/vBqAh5BQRkLWBfhsqerHfungvUBvwirHtUDTkhZ/9JPdV3FuGn
 3YiT0IduIwn7/S70H5hE2NqjywXRm+eziey2sMYzwu3XiMgZOphTc25Iu0OpMJ3fZdQL
 IYcw==
X-Gm-Message-State: APjAAAWyCXVVhfdDTKGhouNZZlarfoH+lsn9TFC9eFywlxTTbBO6PO6M
 km4lDaXuJUk6uQVACG0WgY7yaw==
X-Google-Smtp-Source: APXvYqwAsuTJodqZBZF5iza+qgMbNOF4NE7nYJqGUuxZ7d0lhC02c6TkRrbDyq+XnGCxN46TDlvPBA==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr23868472wrx.300.1562674215836; 
 Tue, 09 Jul 2019 05:10:15 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id b8sm3508363wmh.46.2019.07.09.05.10.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 05:10:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190708104750.1071-1-philmd@redhat.com>
 <20190708104750.1071-2-philmd@redhat.com>
 <CAFEAcA_NnBYWKs89B5apxmXFBUcA5oh3QShRM-1CkWu4Rp6aug@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <86758a18-b117-a2f0-cb62-1977a6507a6c@redhat.com>
Date: Tue, 9 Jul 2019 14:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NnBYWKs89B5apxmXFBUcA5oh3QShRM-1CkWu4Rp6aug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v5 1/3] hw/ssi/xilinx_spips:
 Convert lqspi_read() to read_with_attrs
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
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 1:11 PM, Peter Maydell wrote:
> On Mon, 8 Jul 2019 at 11:48, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> In the next commit we will implement the write_with_attrs()
>> handler. To avoid using different APIs, convert the read()
>> handler first.
>>
>> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v4: Do not ignore lqspi_read() return value (Francisco)
>> ---
>>  hw/ssi/xilinx_spips.c | 23 +++++++++++------------
>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index 8115bb6d46..b7c7275dbe 100644
>> --- a/hw/ssi/xilinx_spips.c
>> +++ b/hw/ssi/xilinx_spips.c
>> @@ -1202,27 +1202,26 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>>      }
>>  }
>>
>> -static uint64_t
>> -lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>> +static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value,
>> +                              unsigned size, MemTxAttrs attrs)
>>  {
>> -    XilinxQSPIPS *q = opaque;
>> -    uint32_t ret;
>> +    XilinxQSPIPS *q = XILINX_QSPIPS(opaque);
>>
>>      if (addr >= q->lqspi_cached_addr &&
>>              addr <= q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
>>          uint8_t *retp = &q->lqspi_buf[addr - q->lqspi_cached_addr];
>> -        ret = cpu_to_le32(*(uint32_t *)retp);
>> -        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
>> -                   (unsigned)ret);
>> -        return ret;
>> -    } else {
>> -        lqspi_load_cache(opaque, addr);
>> -        return lqspi_read(opaque, addr, size);
>> +        *value = cpu_to_le32(*(uint32_t *)retp);
> 
> If you find yourself casting a uint8_t* to uint32_t* in
> order to pass it to cpu_to_le32(), it's a sign that you
> should instead be using one of the "load/store value in
> appropriate endianness" operations. In this case I think
> you want
>     *value = ldl_le_p(retp);
> 
> That looks like it was an issue already present in this code,
> though, (we do it several times in various places in the source file)
> so we can fix it later.

Well, other places check GQSPI_CFG.ENDIAN bit for switching endianess,
here we don't... Dubious code? Per the code DMA accesses seems
little-endian. However tx_data_bytes() handles endian swaping, while
rx_data_bytes() doesn't.

It seems wise to postpone this after the current release, indeed.

Thanks,

Phil.

