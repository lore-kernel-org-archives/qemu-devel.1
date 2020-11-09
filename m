Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6FBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC682068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyqirJa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC682068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7ed-0007C6-O2
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7Wb-0005A2-ON
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:48:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7WY-0003SR-8t
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ehrv2dRgfGnIMLeK88/H5ro/z9sHenUsml0kOHdSzc=;
 b=KyqirJa1emfPyCXl1hoJb0KepIV+lhUPZ2I7CRiN5NFVc4jkyGSDC4O+EZA1oYxKEr4E0W
 sPn6alEU5XOjmqUzeOLoQRkfpNmykac3k4ik7e1mYeIiyGQ5bKGVQksF9y5CY2j+kcwU6m
 aj8w5/U4KvkEScGnNqotyVfYcnWh9O8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-3qFcI8QnP-CW0n2J2o7_Ug-1; Mon, 09 Nov 2020 08:47:55 -0500
X-MC-Unique: 3qFcI8QnP-CW0n2J2o7_Ug-1
Received: by mail-wr1-f69.google.com with SMTP id h11so4330799wrq.20
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Ehrv2dRgfGnIMLeK88/H5ro/z9sHenUsml0kOHdSzc=;
 b=nOjX3Wo1NnoE0BF2TQDi5dBTjAX85cvdZktEOAGbIRG9SAWzEb69p4XljATS7gyvSL
 czHR8x1VMJTp3miPlbyux5yi9sL2ccKAiRM12UnYIFv83DRH4bvCETo7gTFWvk+b2kVV
 YXDe/Hy3AM1O5rpXQBREiZtBx+Gkq0Es/CMiVz24Hws2xhi5BOWXNp5hWFmPrVhY3THC
 PKBiJtCrhJP9W05NpdmMzdTs5p9vaGWU5GgEbL9RDnOvx9JW0o830hd3QIt4rMr7Ss2/
 fOGrdx6xuN/+iPuWEWn/pWgdf8rmS3norO89Dv/vMSWXL7aPYuN9HK46xWTiM/FsCnUr
 E96A==
X-Gm-Message-State: AOAM531OksaY07oUgc90YkIB6wQVZUTW8ooGmqsgCq/GFFKB+3T3C+NW
 lHub4J2qUJGoLCcvHWtAf6wcAMM0PxnqTANgftY8rklSX2+e7YwxElt3yvRQ822wC8P5kfAS9Ww
 YZ+2DJ84uH42bdww=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr15444835wmb.121.1604929673427; 
 Mon, 09 Nov 2020 05:47:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcfJpahjy39LL+h35lTtfhDGK35ZtWn1KAoZtgVqztX8c5JvIbu4IgJdGYP0qAnjgUBREH1Q==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr15444819wmb.121.1604929673202; 
 Mon, 09 Nov 2020 05:47:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id a15sm13638914wrn.75.2020.11.09.05.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 05:47:52 -0800 (PST)
Subject: Re: [External] [PATCH 1/1] pvpanic: Advertise the PVPANIC_CRASHLOADED
 event support
To: zhenwei pi <pizhenwei@bytedance.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
References: <1604346639-27090-1-git-send-email-alejandro.j.jimenez@oracle.com>
 <a595f137-b1d2-56b6-9391-f1c5c80beabf@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab669f03-195a-b2fa-bc04-ac35ea7b6452@redhat.com>
Date: Mon, 9 Nov 2020 14:47:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a595f137-b1d2-56b6-9391-f1c5c80beabf@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 12:40, zhenwei pi wrote:
> Hi, Paolo
> 
> This patch seems getting ignored. Because no maintainers found for 
> hw/misc/pvpanic.c, I also send this to you(hope it doesn't disturb you).
> 
> 
> About this patch:
> Looks good. And also test it, works fine.
> 
> Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
> 
> On 11/3/20 3:50 AM, Alejandro Jimenez wrote:
>> Advertise both types of events supported when the guest OS
>> queries the pvpanic device. Currently only PVPANIC_PANICKED is
>> exposed; PVPANIC_CRASHLOADED must also be advertised.
>>
>> Fixes: 7dc58deea79a ("pvpanic: implement crashloaded event handling")
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> Acked-by: Mark Kanda <mark.kanda@oracle.com>
>> ---
>>   hw/misc/pvpanic.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
>> index 598d547..a55ce8e 100644
>> --- a/hw/misc/pvpanic.c
>> +++ b/hw/misc/pvpanic.c
>> @@ -66,7 +66,7 @@ struct PVPanicState {
>>   /* return supported events on read */
>>   static uint64_t pvpanic_ioport_read(void *opaque, hwaddr addr, 
>> unsigned size)
>>   {
>> -    return PVPANIC_PANICKED;
>> +    return PVPANIC_PANICKED | PVPANIC_CRASHLOADED;
>>   }
>>   static void pvpanic_ioport_write(void *opaque, hwaddr addr, uint64_t 
>> val,
>>
> 

Queued now, thanks Zhenwei.

Paolo


