Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7077DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397F220671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij58N6vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397F220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLwB-0007zv-F8
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLva-0007Iw-3A
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:26:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbLvZ-0000Nv-1E
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WqekJu921czZs4WghQfQg3RGUfTEcR4yw7P7OzZTiE=;
 b=Ij58N6vN9D6SRHTUJIrqOll3x6GAQEbxGfpF6e2wieJHzl0YTPbAKrPg7axOOc0Y/i9Unk
 pkN66yfBHnjumT8M0hx07SqW3jR6da9gngn7S6aTJu8pkCPisk7WdFq3Tkxp6SSPTmJUfU
 jleUut7LhroY8vo/RyL0xRJQxg4KtD4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-9xeDWfQJMVWlVdCPtzKixw-1; Wed, 20 May 2020 06:26:16 -0400
X-MC-Unique: 9xeDWfQJMVWlVdCPtzKixw-1
Received: by mail-wm1-f71.google.com with SMTP id 23so1044150wma.8
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1WqekJu921czZs4WghQfQg3RGUfTEcR4yw7P7OzZTiE=;
 b=sHv8NQsqHzu1ZUg/gLSwaLrNkS+EUmZwhaiwIdO1tgmOTJ/7bTnN+JJGSKoeyUuJYu
 F5ksALWxD16JzuqnW7gL/Ds92V0U89NJ88nbaGuQ6umFBB5LwmxdZ+J+bEeLaEZN9wAs
 7GQN9JsqcVD4EkWr6it/RofLPyWJN/RihhkCZtp2yXO9kOAaYOF4kSAT3iRBw2mBoThv
 LCNK1bqWWDZeRHCItOu8XRWTW2pk8CJSCNp0W746ptS4FgzrH/yKQR19bw32hxV1uWjD
 EXU0qh2O5sWBRGHmoK8dIZzVXW5kR8YvR2MLN6fbqGZ0U9X3w0oYxOfl6DbCovDm9bbf
 ekbQ==
X-Gm-Message-State: AOAM5326TaPdh8eAZYKKqMzYMA4Nzl5fw5h1u4aplfbEnjCtCktzNxhw
 SDZZkMtnTrHkYEj2NtlkVWglGTNxHaoyvx/oQOK/gdCR3Zjg5OZgwuBK8AiVHvy8kUa1m+xlQV1
 Or3GPN1OdcttqTMw=
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr3924007wmj.164.1589970375106; 
 Wed, 20 May 2020 03:26:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU0kzx9ie/b6LJ3lmwCOBIligp5EHg8DrBSx/bwI9MUprTcUZ6Jbc6Xx020WRvdn9NL/GLAg==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr3923985wmj.164.1589970374906; 
 Wed, 20 May 2020 03:26:14 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v20sm2695069wrd.9.2020.05.20.03.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 03:26:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
To: "Justin Terry (VM)" <juterry@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
 <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
Date: Wed, 20 May 2020 12:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 1879672@bugs.launchpad.net,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+launchpad ticket

On 9/20/19 6:53 PM, Justin Terry (VM) wrote:
> Hey Phil,
> 
> I have contacted our legal department for guidance on this specific use case and will update you when I hear back. Thank you for your patience.
> 
> Justin Terry
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Sent: Friday, September 20, 2019 8:18 AM
>> To: qemu-devel@nongnu.org; Justin Terry (VM) <juterry@microsoft.com>
>> Cc: Daniel P . Berrangé <berrange@redhat.com>; Fam Zheng
>> <fam@euphon.net>; Thomas Huth <thuth@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Alex Bennée <alex.bennee@linaro.org>; Richard
>> Henderson <rth@twiddle.net>; Eduardo Habkost <ehabkost@redhat.com>;
>> Stefan Weil <sw@weilnetz.de>
>> Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
>>
>> On 9/20/19 1:33 PM, Philippe Mathieu-Daudé wrote:
>>> Add a job to cross-build QEMU with WHPX enabled.
>>>
>>> Since the WHPX is currently broken, include the patch required to have
>>> successful Shippable build.
>>>
>>> I previously included the WHPX headers shared by the Android project,
>>> and Daniel asked me to check the EULA. While trying to manually
>>> install the Windows SDK, I noticed the installer fetches archives
>>> directly, kindly asking where they are stored via the /fwlink API.
>>> Do the same, fetch the required archives and extract them. No need to
>>> accept EULA...
>>>
>>> Docker build the image first, then build QEMU in a instance of this
>>> image. The image is internal to Shippable, the instances are not
>>> reachable and are thrown once the build is finished. What we collect
>>> from Shippable is the console output of QEMU build process, and if the
>>> build process succeed or failed. So far we do not redistribute the
>>> image or built binaries.
>>>
>>> Philippe Mathieu-Daudé (3):
>>>    target/i386: Fix broken build with WHPX enabled
>>>    tests/docker: Add fedora-win10sdk-cross image
>>>    .shippable.yml: Build WHPX enabled binaries
>>
>> FWIW here is the result of this series:
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fapp.
>> shippable.com%2Fgithub%2Fphilmd%2Fqemu%2Fruns%2F516%2F11%2Fcon
>> sole&amp;data=02%7C01%7Cjuterry%40microsoft.com%7C733a566f3233427
>> 8ae6f08d73dddb39f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6
>> 37045894733463150&amp;sdata=55URgDII5r74QMUpLOD%2FWT5%2B5jbzyv
>> nfCSdv%2FNaWDAw%3D&amp;reserved=0
>> Duration 17 minutes (1076 seconds)
>>
>> 4m49s building the qemu:fedora-win10sdk-cross docker image, 11m10s
>> building WHPX QEMU.


