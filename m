Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DE12073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhnaNQQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DE12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nxS-0000Yv-P6
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9nwY-0007tZ-NX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9nwX-000540-OU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:41:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9nwX-00053l-Ku
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmLC4b12XTxzP57sXHDVgOgViZpcGvkmxbLtZBK6IdQ=;
 b=GhnaNQQaqXxL1Rr8p/o/+/X/AWAmLHL5+qivRtLHPL9/qLUCxIZKDbHOjGKARA/jWp0wqL
 tyGRssyvLKKNM3jiH79H0ZxjzO7tlQXBDFzaHGBlxVPx7xVoKhIZSLbCfTwl/CeMz8Oy2u
 WVub1hLQdEu9uuscI0bZ8BTIpnFc1G8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-bRhZNWLMOTyEuj7LwkLoIw-1; Thu, 05 Mar 2020 05:41:27 -0500
X-MC-Unique: bRhZNWLMOTyEuj7LwkLoIw-1
Received: by mail-ed1-f70.google.com with SMTP id ck15so4042864edb.6
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AmLC4b12XTxzP57sXHDVgOgViZpcGvkmxbLtZBK6IdQ=;
 b=CmWOjnYKvParG5aKC+NA/Uv125937zVF5HJybUy318HKKx3iNncjOMd2XCz6vqB7qT
 5JmBBVIx9nlGNs9+XQ8wtfxAh6aAV5qPm8u6b3cf6PE7HKPskWyr+x9SgCtr7ti6frKg
 zMtzhNCVVj0I2ij0RsRGEKZj3yEGyYg2cXcawWrEPObW8DBPbC1XCQDV2S8MHphQFCck
 rSTbM3p0chvyMTY6TBeWR8mv80wQHYeX9rlHn/s68VeccnfptAOymHgJvK8+M1MYNe7S
 O9LjiTAXGr7yzNDvYCtT3OIWWDLSdt8u//S2Sn721JWmmWw33lQG7KOoCMxIUWHQddDP
 Ab7w==
X-Gm-Message-State: ANhLgQ0/HeDq4Rn3GRks5LMxPLtbI0/JL/mZlnZNOgfJibOkzuoh1ENO
 3ZvQFUziiSKH14FRAPdXEsaF0/ZgExfj634GjnbhKxVa91Mctz3WzQZTLJih6QxvL5i6VtgZKmh
 +uSlmOHRUyDk6PVs=
X-Received: by 2002:a17:906:5ad4:: with SMTP id
 x20mr6608841ejs.293.1583404886259; 
 Thu, 05 Mar 2020 02:41:26 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsV7I3mvBTwte234Ehaj4XE0ujfKMtQ2wTgDI9rm7V6mebm8h1ZiQAiH925GE/qw14otJ4T0w==
X-Received: by 2002:a17:906:5ad4:: with SMTP id
 x20mr6608823ejs.293.1583404885963; 
 Thu, 05 Mar 2020 02:41:25 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id 18sm1278254ejj.63.2020.03.05.02.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 02:41:25 -0800 (PST)
Subject: Re: [PATCH 3/6] hw/usb/quirks: Use smaller types to reduce .rodata by
 10KiB
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
 <20200304221807.25212-4-philmd@redhat.com>
 <20200305080237.j2a7waokxominirn@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5b6cddf-5887-be27-db76-2e515daa2c11@redhat.com>
Date: Thu, 5 Mar 2020 11:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305080237.j2a7waokxominirn@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 9:02 AM, Gerd Hoffmann wrote:
>>   struct usb_device_id {
>> -    int vendor_id;
>> -    int product_id;
>> -    int interface_class;
>> -    int interface_subclass;
>> -    int interface_protocol;
>> +    int16_t vendor_id;
>> +    int16_t product_id;
>> +    int8_t interface_class;
>> +    int8_t interface_subclass;
>> +    int8_t interface_protocol;
> 
> I guess we should better use the uint variants here ...

I tried it first but I got:

   CC      hw/usb/quirks.o
hw/usb/quirks.c:25:34: error: result of comparison of constant -1 with 
expression of type 'const uint16_t' (aka 'const unsigned short') is 
always true [-Werror,-Wtautological-constant-out-of-range-compare]
     for (i = 0; ids[i].vendor_id != -1; i++) {
                 ~~~~~~~~~~~~~~~~ ^  ~~
hw/usb/quirks.c:28:37: error: result of comparison of constant -1 with 
expression of type 'const uint8_t' (aka 'const unsigned char') is always 
false [-Werror,-Wtautological-constant-out-of-range-compare]
             (ids[i].interface_class == -1 ||
              ~~~~~~~~~~~~~~~~~~~~~~ ^  ~~

And went this less intrusive way.

I'll respin with s/-1/UINT8_MAX/.


