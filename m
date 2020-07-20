Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1182C433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4D820684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEdpoYD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4D820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYV8-0002tP-SJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxYUX-0002Ts-GJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:18:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxYUT-00045e-8N
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595261887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1iwkwlXVDGVTXJtczAXYtIaJjYeuENE7MNG3Mzr5Vro=;
 b=HEdpoYD22RMmJRtQzA9+Nl+p+M6RCctfUxHqr511p/xJR5Kn6A/RBcRsuQZgJUFTBf8M7X
 zrAnsV3QwwLhaVWrl7nUbZ4hYwLwRkuliWpRJYWK2TYUQwxBZDLXy9Wh5WppIPM3w4EVmE
 uaNAzDnKGggoGGUBmv1XibRhC+WVHtg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-cJlj66TdO2aVzMa_swastw-1; Mon, 20 Jul 2020 12:18:01 -0400
X-MC-Unique: cJlj66TdO2aVzMa_swastw-1
Received: by mail-wm1-f71.google.com with SMTP id e15so17666wme.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 09:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1iwkwlXVDGVTXJtczAXYtIaJjYeuENE7MNG3Mzr5Vro=;
 b=koG/3h+5pNy5EpWbbTArytO82PAVvy8pn/KurelXW/FUkIBZNakBYU1Wqoz8OFrA0w
 CMItHbpwrOI3LH411pbjA48wNeSU/orkih7YPffEuS/n4mWoUQpPSeoB6/tqC2SNWE57
 iDCcoROU1ezVcHfG2eoa41s4Ig7fIoHtLgWIJ/zggOpnGxRaGgmbkqbXLIqAOal/wZYd
 O9j2mFUSeOa6SzEJNoLMY1uHB7euoDP5dB/nCz7xEn4pqC6qMC19utsjhHZE6J9WMIq5
 t3D+HCuPjgux02kRWRimD/wKXk8WIHGSAfLX1hkgFfiEeZIHmWHNnPT51ZUPoRt+gjvw
 ujGw==
X-Gm-Message-State: AOAM530qEJTpOilEyIr/8R2dH6JppYrxyHNTO8n3JHld4+XkTf4ttip3
 fB9P8L8xD6ZYaqVPkZqcEGoMRcaqzw1TY1+OwSv8jRAFi/mEtSqLrW3y/UBu48NnBImpkyn4uB5
 E7QaJxcW9Saz/8do=
X-Received: by 2002:a1c:4086:: with SMTP id n128mr135638wma.118.1595261879980; 
 Mon, 20 Jul 2020 09:17:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJkDgjXgiE3+Ih419sdjLgOr0VcHg7WMmm8xuGGGGJsQYqFTfKyy8oTkuuUfxz3Rfuw7w/Qg==
X-Received: by 2002:a1c:4086:: with SMTP id n128mr135619wma.118.1595261879711; 
 Mon, 20 Jul 2020 09:17:59 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f186sm42768wmf.29.2020.07.20.09.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 09:17:59 -0700 (PDT)
Subject: Re: [PATCH for-5.1] acpi: allow accessing acpi-cnt register by byte
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20200720153915.12267-1-mjt@msgid.tls.msk.ru>
 <20200720115730-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <3ea5f395-9248-c0d8-ec4d-d8161d9b8ba3@redhat.com>
Date: Mon, 20 Jul 2020 18:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200720115730-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 5:58 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 20, 2020 at 06:39:15PM +0300, Michael Tokarev wrote:
>> >From the ACPI spec (4.8.3.2.1 PM1 Control Registers):
>>
>> Register Location: <PM1a_CNT_BLK / PM1b_CNT_BLK> System I/O or Memory Space
>> Default Value:     00h
>> Attribute:         Read/Write
>> Size:              PM1_CNT_LEN (2 bytes)
>> The PM1 control registers contain the fixed hardware feature control bits.
>> These bits can be split between two registers: PM1a_CNT or PM1b_CNT.
>> Each register grouping can be at a different 32-bit aligned address
>> and is pointed to by the PM1a_CNT_BLK or PM1b_CNT_BLK. The values
>> for these pointers to the register space are found in the FADT.
>> Accesses to PM1 control registers are accessed through byte
>> and word accesses.
>>
>> So allow 1-byte access too, not only 2-byte.
>>
>> Fixes: afafe4bbe0cf7d3318e1ac7b40925561f86a6bd4
>> Fixes: 5d971f9e672507210e77d020d89e0e89165c8fc9
> 
> Fixes links are a bit off. Should be:
> Fixes: <short sha> ("commit subject")

This is indeed documented:
https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

You can use the git-alias suggested here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg711059.html

> 
>> Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
>> Buglink: https://bugs.debian.org/964793
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>  hw/acpi/core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>> index f6d9ec4f13..2c1199d9dc 100644
>> --- a/hw/acpi/core.c
>> +++ b/hw/acpi/core.c
>> @@ -599,7 +599,8 @@ static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>>  static const MemoryRegionOps acpi_pm_cnt_ops = {
>>      .read = acpi_pm_cnt_read,
>>      .write = acpi_pm_cnt_write,
>> -    .valid.min_access_size = 2,
>> +    .impl.min_access_size = 2,
>> +    .valid.min_access_size = 1,
>>      .valid.max_access_size = 2,
>>      .endianness = DEVICE_LITTLE_ENDIAN,
>>  };
>> -- 
>> 2.20.1
> 
> 


