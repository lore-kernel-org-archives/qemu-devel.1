Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B2C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E0C20684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3LQOkgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E0C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJ7n-0006Xb-FK
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 06:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKJ6a-0005b8-Ko
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKJ6Y-0001x3-5M
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600684286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TEM88enFX2voiccY6zpI3NfTeIIeYgXwBhE9tiiwQL8=;
 b=M3LQOkgzA3gUyOMEIMa2mhyfC5gm36YjgH2uVMzcnqWU76YfC3Cvuy8x4VW6nY+Mj443WC
 3UmP8eeccFCD1/B1ZZEZlmrjvFbYNgdp71Y1GX5e1pRS7LAgvJhVrBSf2BjoXVeYXs7N1x
 +FbRoS3TGJYRz6mnJaoBv6220GFXUoM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-JfGX2I4HPxaBfAshkJJfzQ-1; Mon, 21 Sep 2020 06:31:25 -0400
X-MC-Unique: JfGX2I4HPxaBfAshkJJfzQ-1
Received: by mail-wr1-f71.google.com with SMTP id v5so5630067wrs.17
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 03:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TEM88enFX2voiccY6zpI3NfTeIIeYgXwBhE9tiiwQL8=;
 b=H3hQ7xHKSZhDPuac2eJHJQvisgPXUo7Cmdxk6ItD6qmk99OAhVk9VI0lNXuh08hRwh
 84A1ffcKGCM05YO9OJQEZkUeeGys++TvcmFtaoVZuFnvPTGaEuw/hZCGz7R4ShafYlf6
 T6qEMm154HN3c9Kt7+d0/cBqzzHFHaAKme1Zww0vZTW1v7tn8d+qBfpYSvGGuR3sJui8
 Zz5r/AIR6vnjsNXBVxGv1VlbR/EF2jRV/a6dkfG7CkQ7gaY+EbYwH/Iin+x4FXpwqsUS
 ZvJMPFY9gIUlwS8Vm0nVOFiifBDt0UPp/eJZdQX/HINQjr66iK9i7ihVttcOuv7P+Q3o
 Adeg==
X-Gm-Message-State: AOAM532g2hZGZE5diEh1KHrXtG5jbbZcAtiDVnPCqWsRmnapTpRoRky5
 zBr6kg3yY6sAWe7Ud6us0Y0c9MPSsR6wQo3FSUXP0q11jvyd86BQuoiOKgu2AhNr2HsQP5G1AFb
 LUdYYLuErsQPCOCk=
X-Received: by 2002:a1c:8f:: with SMTP id 137mr29420093wma.158.1600684283821; 
 Mon, 21 Sep 2020 03:31:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuZX1poJltfjeR877qumJvBSamPFeVNhb+klQahvfppFdTNWcUcJ5ydTJlqAJv9SvpY1d0mA==
X-Received: by 2002:a1c:8f:: with SMTP id 137mr29420070wma.158.1600684283602; 
 Mon, 21 Sep 2020 03:31:23 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t188sm19883075wmf.41.2020.09.21.03.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 03:31:23 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
To: Markus Armbruster <armbru@redhat.com>
References: <20200918174117.180057-1-f4bug@amsat.org>
 <20200918174117.180057-4-f4bug@amsat.org> <874knra5fk.fsf@dusky.pond.sub.org>
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
Message-ID: <6384105c-65ca-60f8-4fa0-afd2e46b144a@redhat.com>
Date: Mon, 21 Sep 2020 12:31:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <874knra5fk.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Kevin O'Connor <kevin@koconnor.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Paolo & Kevin.

On 9/21/20 10:40 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> As it is legal to WRITE/ERASE the address/block 0,
>> change the value of this definition to an illegal
>> address: UINT32_MAX.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>>
>> Same problem I had with the pflash device last year...
>> This break migration :(
>> What is the best way to do this?
> 
> Remind me: did we solve the problem with pflash, and if yes, how?

No we can't. The best I could do is add a comment and as this
is not fixable. See commit aba53a12bd5: ("hw/block/pflash_cfi01:
Document use of non-CFI compliant command '0x00'").

I now consider the device in maintenance-only
mode and won't add any new features.

I started working on a new implementation, hoping it can be a
drop in replacement. Laszlo still has hope that QEMU pflash
device will support sector locking so firmware developers could
test upgrading fw in VMs.

Back to the SDcard, it might be less critical, so a migration
breaking change might be acceptable. I'm only aware of Paolo
and Kevin using this device for testing. Not sure of its
importance in production.

> 
>> ---
>>  hw/sd/sd.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 30ae435d669..4c05152f189 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -53,7 +53,7 @@
>>  
>>  #define SDSC_MAX_CAPACITY   (2 * GiB)
>>  
>> -#define INVALID_ADDRESS     0
>> +#define INVALID_ADDRESS     UINT32_MAX
>>  
>>  typedef enum {
>>      sd_r0 = 0,    /* no response */
>> @@ -666,8 +666,8 @@ static int sd_vmstate_pre_load(void *opaque)
>>  
>>  static const VMStateDescription sd_vmstate = {
>>      .name = "sd-card",
>> -    .version_id = 1,
>> -    .minimum_version_id = 1,
>> +    .version_id = 2,
>> +    .minimum_version_id = 2,
>>      .pre_load = sd_vmstate_pre_load,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(mode, SDState),
> 
> 


