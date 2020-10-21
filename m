Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2620C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A6621789
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMrNw534"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A6621789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVB0e-000836-JC
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVAzW-0007Qk-2j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVAzN-0000sx-L1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603274700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hic2/tl8M3Ytk7mMGy3zniuV3dJWkuNf2i35bbxq+A=;
 b=dMrNw534p8eTJzzZnYH/Jt/6aDFQgpe1Uqslo5NF2eXlo/Rwl02vSweH3PWkNPWdDjIUPd
 rLOLzuD3vq0oXifMeRGZP8n6Cj5BGTdYD6JJCaZvpZAxffdj/l8ciJLheCE4oecP43iAV2
 ArRWMPQUIHpO6+Sx3G0NAW0xJVItpfk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-c2Bh6sdiPFKGmnYvNXvZWQ-1; Wed, 21 Oct 2020 06:04:58 -0400
X-MC-Unique: c2Bh6sdiPFKGmnYvNXvZWQ-1
Received: by mail-wr1-f72.google.com with SMTP id h8so1848561wrt.9
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8hic2/tl8M3Ytk7mMGy3zniuV3dJWkuNf2i35bbxq+A=;
 b=M+s0KoNAboTneRwhplkVj4jJkbyMxGCwSLLxpqIVaAD8toqUI7aovWxe1O5tD7ou1G
 hvfWuHBIbaicH0V0UDOi6cTCqpHQpy/oqeWpxeiJtn60VLiqrB86RbcnIY+TWFC4A14u
 QCbyZVZV8IWlIgyAi+1F6M33rOaop4Ub0JGHjnRJ/FW2IVKHk2jezq9bF30qfncmVDez
 P3dZfdWfQHentm/9K5OmxJiyz8Rc9ttnK95FMvj3ucwClzfX1fn+FwxzR0NeOdN4DA2l
 uGbfYXJwLlu5UJxYifsgC99sTZJORGnW8Q1qZKszI7ZndmfoLH7MTvGXJc4tIYFsJfbS
 EMEA==
X-Gm-Message-State: AOAM531orYZ3eepXBf7ewOyWi/CNNm5mdL3T7kbZENLHm9gMCz68/aJD
 XSxxm07l1b4V/RCDHmbGh4esmo+YW1W/kz0W4heH5q3ixylIU+YZ72UD5LJT3gK0B7mhrGW+Z0q
 cFOI7M9bVwvXEweY=
X-Received: by 2002:adf:a455:: with SMTP id e21mr4051925wra.158.1603274697312; 
 Wed, 21 Oct 2020 03:04:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXgW5FuTbdSWhdz6jKNlouD/y07vkyOVB2RYaV25zEL5t3JJoBu4i0K5JuO9iOzEYPrjdUDQ==
X-Received: by 2002:adf:a455:: with SMTP id e21mr4051884wra.158.1603274697015; 
 Wed, 21 Oct 2020 03:04:57 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z11sm2821369wrh.70.2020.10.21.03.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 03:04:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] migration: Make save_snapshot() return bool, not
 0/-1
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201012122743.3390867-1-philmd@redhat.com>
 <20201012122743.3390867-3-philmd@redhat.com>
 <20201021095630.GG412988@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9def59c-4d74-4488-8115-61d2f9ee4f94@redhat.com>
Date: Wed, 21 Oct 2020 12:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021095630.GG412988@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 11:56 AM, Daniel P. Berrangé wrote:
> On Mon, Oct 12, 2020 at 02:27:42PM +0200, Philippe Mathieu-Daudé wrote:
>> Just for consistency, following the example documented since
>> commit e3fe3988d7 ("error: Document Error API usage rules"),
>> return a boolean value indicating an error is set or not.
>>
>> Acked-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   include/migration/snapshot.h |  9 ++++++++-
>>   migration/savevm.c           | 16 ++++++++--------
>>   replay/replay-debugging.c    |  2 +-
>>   replay/replay-snapshot.c     |  2 +-
>>   4 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
>> index c85b6ec75b7..a40c34307b5 100644
>> --- a/include/migration/snapshot.h
>> +++ b/include/migration/snapshot.h
>> @@ -15,7 +15,14 @@
>>   #ifndef QEMU_MIGRATION_SNAPSHOT_H
>>   #define QEMU_MIGRATION_SNAPSHOT_H
>>   
>> -int save_snapshot(const char *name, Error **errp);
>> +/**
>> + * save_snapshot: Save a snapshot.
>> + * @name: path to snapshot
> 
> This isn't a path, it is a name.
> 
> I'll apply this change:
> 
>    - * save_snapshot: Save a snapshot.
>    - * @name: path to snapshot
>    + * save_snapshot: Save an internal snapshot.
>    + * @name: name of internal snapshot

Thanks!


