Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7AFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C2120738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMoGkQuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C2120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoV8-0006Fn-KQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgoUR-0005Pc-V3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:56:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgoUQ-0007Bo-3Z
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591271813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L68ZOgxYF24Mo4tJqNrWm+C5uJcC2quok+ttWaTA+B8=;
 b=EMoGkQuho+clV66ftdPY3mIucuduW9p3qNEVpecAzIhHij0OHIcJ9gfVo05tiDqcPEioQD
 Kyy9etErSg2xwYYNxmfeXAAz52V7/XvAcARciaUOd5msefg81zCuKnYZlE2jQEqkny/Ju4
 7MAaKwsDlxV4n00uRblD4reEYr5mLVU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-dPNHx0vbMbeznexzT_qLIA-1; Thu, 04 Jun 2020 07:56:50 -0400
X-MC-Unique: dPNHx0vbMbeznexzT_qLIA-1
Received: by mail-wr1-f71.google.com with SMTP id o1so2320987wrm.17
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=L68ZOgxYF24Mo4tJqNrWm+C5uJcC2quok+ttWaTA+B8=;
 b=YDX1F5rpBRz+tN2dvjOl6z0ALUiCynOMUWJEAZID4KrrOlmz6U/HT2AytkXkIpMxYU
 /A+H4vyt87sScqGIehqp2iA2AbXJasD98qig9UJXIukaxQZpPqo7PzdYH9Unpx+baATB
 pzN59zm+/KXkjpRMuWoMl/CmWWDvpbXt1wq86sKFy52DszaBqewZt0TXt4IbPzYKsrxn
 YvHgW4G561OniVczXIMw8ZJwCJG91C/JhQx/uBqwv0jJYKPjc7sKzeDk5C1viAs59JR6
 LNE9+woJ3pKWNYhbs+sbIT65j0uxpPx2n0/e3+sSuaDBhbc0y5HnMHbka5HwOIQfwJng
 TawA==
X-Gm-Message-State: AOAM5330SBj08gF76GyzIKEVWGDgpV9B0FrOmna5ZP8/WQZ0wzVe5N1d
 rF50fbd4uMKTD/4hRS85zBFdjBqGfbECBH8Bur5XifPPH17e1WhMy8kUMjQb7D+7OfDvO2IGvuJ
 bHKMLx/JxWkJ29Bw=
X-Received: by 2002:a5d:5261:: with SMTP id l1mr4228655wrc.246.1591271808874; 
 Thu, 04 Jun 2020 04:56:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0HMyuCilnVOXF5tI+iUUGWdQirMQ0nSVFEE61yv3Qm47eA4PAlaRcBXop1GMm4S+b8cMW3w==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr4228636wrc.246.1591271808602; 
 Thu, 04 Jun 2020 04:56:48 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 5sm10447353wrr.5.2020.06.04.04.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 04:56:47 -0700 (PDT)
Subject: Re: [PATCH v3] ati-vga: check address before reading configuration
 bytes (CVE-2020-13791)
To: "Michael S. Tsirkin" <mst@redhat.com>, P J P <ppandit@redhat.com>
References: <20200604105524.46158-1-ppandit@redhat.com>
 <20200604074539-mutt-send-email-mst@kernel.org>
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
Message-ID: <88d6e41e-c486-4a35-af43-84018491071f@redhat.com>
Date: Thu, 4 Jun 2020 13:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200604074539-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>, pbonzini@redhat.com,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 1:49 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 04, 2020 at 04:25:24PM +0530, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While reading PCI configuration bytes, a guest may send an
>> address towards the end of the configuration space. It may lead
>> to an OOB access issue. Add check to ensure 'address + size' is
>> within PCI configuration space.
>>
>> Reported-by: Ren Ding <rding@gatech.edu>
>> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
>> Reported-by: Yi Ren <c4tren@gmail.com>
>> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> 
> BTW, this only happens on unaligned accesses.
> And the IO memory region in question does not set valid.unaligned
> or .impl.unaligned.
> 
> And the documentation says:
> 
> - .valid.unaligned specifies that the *device being modelled* supports
>   unaligned accesses; if false, unaligned accesses will invoke the
>   appropriate bus or CPU specific behaviour.
> 
> and
> 
> - .impl.unaligned specifies that the *implementation* supports unaligned
>   accesses; if false, unaligned accesses will be emulated by two aligned
>   accesses.
> 
> Is this then another case of a memory core bug which should have either
> failed the access or split it?

Related:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg695362.html
earlier comment:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg694805.html

> 
>> ---
>>  hw/display/ati.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Update v3: avoid modifying 'addr' variable
>>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00834.html
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 67604e68de..b4d0fd88b7 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -387,7 +387,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>>          val = s->regs.crtc_pitch;
>>          break;
>>      case 0xf00 ... 0xfff:
>> -        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
>> +        if ((addr - 0xf00) + size <= pci_config_size(&s->dev)) {
>> +            val = pci_default_read_config(&s->dev, addr - 0xf00, size);
>> +        }
>>          break;
>>      case CUR_OFFSET:
>>          val = s->regs.cur_offset;
>> -- 
>> 2.26.2
> 


