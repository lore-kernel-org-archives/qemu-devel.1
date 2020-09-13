Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7637217BA
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh0P/doY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7637217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHQQf-0003hW-Kc
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 07:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHQMd-0000zo-Bn
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 07:40:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHQMb-0003Sg-GY
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 07:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599997207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XFpVjO3AiIDze94+9+s5OyYW44SA+zoE/6Tc7U2v+lQ=;
 b=Xh0P/doYB77Nu7s1vjVJbp2FcM4rXrYLR/vOO8m467we7Rp6tweaQMye89dbubUsVeFqNR
 vE917GiwAGsZUHjz/38UGYW1ftifkwTEq9o+itGLGykhq/VZOIHXjNvP2nuGp+HqBH2mQW
 bPwEM6V8x097TTg3+m4gd19ds4DPOuc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-VQ8Zq3XUNDSI7xrlIyGSIQ-1; Sun, 13 Sep 2020 07:40:06 -0400
X-MC-Unique: VQ8Zq3XUNDSI7xrlIyGSIQ-1
Received: by mail-wr1-f69.google.com with SMTP id r16so5454453wrm.18
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 04:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XFpVjO3AiIDze94+9+s5OyYW44SA+zoE/6Tc7U2v+lQ=;
 b=t4MCiyqCHtIGDLNYtQkt5lkRsD/v+AHxKu6UkPyuLau4mam/rNwZxhFO13IZXMMqvn
 FW+6IM2k2srZZrpQ75OF1gzZLJ3rv1BB9abM5EgkAOMJm2uZY/gTVcFt+/6OOh6+fYhb
 M1RD0x3ui02zpk5MjzzZWzlQmTQZ/lBY7f8SbTE6aVWXHIq0xAcei0KmpTmNYGRfIoa2
 cMClsLskqUDReq9PxcnIFmNOzBBoWFKBGhe/V9lg0Vbh392VDHguRISppLG9xndbhEYc
 yR61nQ8bw57KzAuan83O5Ro18FH11VrEb9JHPD4a8konAYUMfcLWBcuS0ux5ajk80Rbo
 xoSQ==
X-Gm-Message-State: AOAM531/DCLHmnlLALbV7q2wY+mLSRuszr0jf7SCYKJUilGxcVNUIZtB
 t+tasBS6oJ7QtqFfmYp+OUYP1opBTbNJzDrj8VAfNvdqeNThmR3RmeuXSagjXrroN7b2CwvQMk6
 r27EcUndsNH0/gB0=
X-Received: by 2002:adf:de8b:: with SMTP id w11mr10707034wrl.401.1599997204765; 
 Sun, 13 Sep 2020 04:40:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz1MsC/Hbj92MoCQ2s7sVH+9Uqay1x506J31bjSs8mX0me8cyGITSrAZxD74WHq1ZKX/KSJQ==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr10707013wrl.401.1599997204582; 
 Sun, 13 Sep 2020 04:40:04 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s124sm14493641wme.29.2020.09.13.04.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 04:40:04 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hw/timer/hpet: Fix DPRINTF format string
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200910135852.516809-1-philmd@redhat.com>
 <20200910135852.516809-3-philmd@redhat.com>
 <9db297fa-02c0-aadb-e0c7-555d3578b7b3@linux.vnet.ibm.com>
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
Message-ID: <3dbac311-dc90-0eda-10c2-13ab28407a6a@redhat.com>
Date: Sun, 13 Sep 2020 13:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9db297fa-02c0-aadb-e0c7-555d3578b7b3@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 07:31:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 7:40 PM, Dov Murik wrote:
> Hi Phil,
> 
> On 10/09/2020 16:58, Philippe Mathieu-Daudé wrote:
>> Fix building with HPET_DEBUG enabled:
>>
>>    hw/timer/hpet.c:512:73: error: format specifies type 'unsigned int'
>> but the argument has type 'uint64_t' (aka 'unsigned long')
>> [-Werror,-Wformat]
>>        DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n",
>> addr, value);
>>                                                             
>> ~~~           ^~~~~
>>                                                              %#lx
>>    hw/timer/hpet.c:655:21: error: format specifies type 'unsigned int'
>> but the argument has type 'uint64_t' (aka 'unsigned long')
>> [-Werror,-Wformat]
>>                        value, s->hpet_counter);
>>                        ^~~~~
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   hw/timer/hpet.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
>> index b683f64f1d3..20bd0388740 100644
>> --- a/hw/timer/hpet.c
>> +++ b/hw/timer/hpet.c
>> @@ -495,7 +495,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>>       HPETState *s = opaque;
>>       uint64_t old_val, new_val, val, index;
>>
>> -    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n",
>> addr, value);
>> +    DPRINTF("qemu: Enter hpet_ram_writel at %#" HWADDR_PRIx " =
>> %#"PRIx64"\n",
>> +            addr, value);
> 
> You still use "#" in the format string; but qemu's CODING_STYLE.rst says:
> 
> //////////////
> 
> '#' printf flag
> ---------------
> 
> Do not use printf flag '#', like '%#x'.
> 
> Rationale: there are two ways to add a '0x' prefix to printed number:
> '0x%...'
> and '%#...'. For consistency the only one way should be used. Arguments for
> '0x%' are:
> 
> * it is more popular
> * '%#' omits the 0x for the value 0 which makes output inconsistent

Yes you are right, I missed that.

Do you mind adding that check to ./checkpatch?

> 
> //////////////
> 
> 
> 
> According to that, I think the better solution would be:
> 
> DPRINTF("qemu: Enter hpet_ram_writel at 0x%" HWADDR_PRIx
>         " = 0x%" PRIx64 "\n", addr, value);
> 
> 
> 
> 
>>       index = addr;
>>       old_val = hpet_ram_read(opaque, addr, 4);
>>       new_val = value;
>> @@ -637,7 +638,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>>               }
>>               s->hpet_counter =
>>                   (s->hpet_counter & 0xffffffff00000000ULL) | value;
>> -            DPRINTF("qemu: HPET counter written. ctr = %#x -> %"
>> PRIx64 "\n",
>> +            DPRINTF("qemu: HPET counter written. ctr = %#"
>> +                    PRIx64 " -> %#" PRIx64 "\n",
> 
> ditto.
> 
>>                       value, s->hpet_counter);
>>               break;
>>           case HPET_COUNTER + 4:
>> @@ -646,7 +648,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>>               }
>>               s->hpet_counter =
>>                   (s->hpet_counter & 0xffffffffULL) |
>> (((uint64_t)value) << 32);
>> -            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %"
>> PRIx64 "\n",
>> +            DPRINTF("qemu: HPET counter + 4 written. ctr = %#"
>> +                    PRIx64 " -> %#" PRIx64 "\n",
> 
> ditto.
> 
>>                       value, s->hpet_counter);
>>               break;
>>           default:
>>
> 
> -Dov
> 


