Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A679BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A3320874
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Egj8dgGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A3320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblrK-0008NF-MZ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblqV-0007Pq-GJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:06:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblqU-0003bu-Md
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVZddmF3fUbjRXKaEGjrc1Zp7pi7sVsSrIhZQSYQK9Y=;
 b=Egj8dgGqld3i+Ftfp5HJ03vIr8wAY9F8SdeCnK0jHM4FdQFXT340vpFLMVO/g7DI1gbvlT
 96HUdURZkFsK6vj5bkigw133FYcv0tJdWpxF5NQochLoIgKbne0u0CfrJzEd8sEFV4nD5c
 ZqQ5iDCnFIqeEeGQTnGM7dLYHew1UGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-lHqgNHSuPUG3Cb9KwClgVA-1; Thu, 21 May 2020 10:06:48 -0400
X-MC-Unique: lHqgNHSuPUG3Cb9KwClgVA-1
Received: by mail-wm1-f69.google.com with SMTP id q6so1900524wme.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mVZddmF3fUbjRXKaEGjrc1Zp7pi7sVsSrIhZQSYQK9Y=;
 b=tH8BEbkfE/M3HceGZ8dbECrdkA2qKcyfYS0V2nTBPHWDO+L7FSEaPj4s2sEbVjOjem
 E+fPSHcIs+5JSlv4Q96xbTGGpioj3GBv7nr2T6Pxt7a6RB9bxuXZvIJP7NBvq8d/xvNg
 xdUC5I2AGmYSTo9jRbFm79VDdTUhCtM0XpXf3VZxSm8xsSlhcGZOU/4tnblQXOF/OSmc
 XODu+vtLuObUV23zfAumwJ4r8xvdky2SleK9Crs0JzHbkzOw1KylZ4cKz3tVC/J9CItJ
 AhseAXGVWk/eCaldCxwryvJilYKIWCRALhhCf+b/1N3X5U4IQVZiWl/9D9AwveDvUbjU
 g8DA==
X-Gm-Message-State: AOAM533WCgJtCD90a21ydXZphqNKopEZ/s6pL6KW/+NkCBL46GnzNf3x
 vYBvs3khRMIUGwkTE8Lm1JzXUlFCfwbfdJm0UDYaUiyGzbUQaZ1sL0LWYKp+7TXWeSHH/SFU6qu
 4dRM0R6a8e+zhhzA=
X-Received: by 2002:a1c:9817:: with SMTP id a23mr2693468wme.133.1590070007109; 
 Thu, 21 May 2020 07:06:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuaScuj2FxkCusjugah1EVXoYU7ciTsrWONi1+DSrRXk4u0Px/qHt1KrYidHmfYhlsEoAtyg==
X-Received: by 2002:a1c:9817:: with SMTP id a23mr2693424wme.133.1590070006499; 
 Thu, 21 May 2020 07:06:46 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id z18sm6398905wmk.46.2020.05.21.07.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:06:46 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Fix OUTL debug output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200517110147.26026-1-f4bug@amsat.org>
 <234cbf5d-aed7-7b6c-e43d-ae47f8251916@linaro.org>
 <d4f069cd-6357-480a-3732-71e97d0e9aea@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f4fc712-5021-e4dd-03e6-f3490a1785e6@redhat.com>
Date: Thu, 21 May 2020 16:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d4f069cd-6357-480a-3732-71e97d0e9aea@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
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
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/20 14:23, Philippe Mathieu-Daudé wrote:
> On 5/19/20 5:39 AM, Richard Henderson wrote:
>> On 5/17/20 4:01 AM, Philippe Mathieu-Daudé wrote:
>>> Fix OUTL instructions incorrectly displayed as OUTW.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   target/i386/misc_helper.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> as far as it goes.  We should of course never be printing to stderr, but
>> logging or tracing.
> 
> Yes, this is what the cpu_io() functions do in ioport.c, but they use
> MEMTXATTRS_UNSPECIFIED.
> 
> If we could replace one with another, I'm not sure which one is the
> correct one.
> 
> Maybe keep cpu_io() from ioport.c but add a MemTxAttrs argument?
> 
> Regards,
> 
> Phil.
> 

Queued, thanks.

Paolo


