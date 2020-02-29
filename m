Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA058C3F2C6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 09:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A004E214DB
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 09:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwtlOIqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A004E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ybf-0002HU-TD
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 04:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7yb2-0001qN-A6
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7yaz-0007eI-Oo
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:39:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7yaz-0007dJ-9k
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 04:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582969180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dW0sxKfEgR/rNUpSESuFq/3WlFc4kBtSkUECv/IOtg=;
 b=RwtlOIqyXwkXmmAx9a1TXwvO2NgGY2Q8SnmKk8UqLCDEBUnN7kWAop61cTTdf14mYGoCEf
 7EtfxbrTT37SESQ0BNmxJ3AWtwGsDufrOsNX/u2jOi5OAQaMs/uizGMY4n3DF5/BYdqZLJ
 AAQF+Dm/erOaifqX4eJk/VpHxrRVa34=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-m8oR41mzMQy5htw2_rMh1g-1; Sat, 29 Feb 2020 04:39:38 -0500
X-MC-Unique: m8oR41mzMQy5htw2_rMh1g-1
Received: by mail-wr1-f72.google.com with SMTP id n12so2615090wrp.19
 for <qemu-devel@nongnu.org>; Sat, 29 Feb 2020 01:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dW0sxKfEgR/rNUpSESuFq/3WlFc4kBtSkUECv/IOtg=;
 b=qd3yk+TCKQDFeXCRtkvaDLEAHqQY6chzmukwkT4gpSl6E7aS/ZeYXFBVawcZWlL80W
 XEf062AJK2wodeeYkrYqGs2+QU7Zk/IGJMh2IhQZ0qrHpIcc6sIYQp0uQ0/S0+Ir1g/b
 z+jX6JZL2LfpACwFS60NorqywGQUCUZJDjm9yJ1p285p5nyX0ltLBM5tMAdQ2enr2fYh
 GlnvPj5uzVxr129UPoHdO1tzuEEdR1k0bMKbNXnQhmAPIOtt6VFbLUPIvGVgJBMkNzqH
 0sgWM07NUOy1a57rDJ8EeqfQRYuPb/fr0diXPyxsyxE6FSMtpC+66ZaH5Xoyt6k6ijo5
 FNeg==
X-Gm-Message-State: APjAAAVJHIhGEnWIS7iSnKCToVr4ipfKuURHgzCk660JC3UcmdjCkExp
 JxQ/BRBdSQ9ZF/KZK658BXKTdQNY1qh4q5o7gebgirNwJ9pQKH3ZfIMkYG+yw5gMxGxGsfSaSnG
 2oakdp5J0JJYz23c=
X-Received: by 2002:a5d:6082:: with SMTP id w2mr9974489wrt.300.1582969177877; 
 Sat, 29 Feb 2020 01:39:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyImn8cxpuQownFPdApQjBUX3URFuIu6dpGc71J/pvXiZPq/JhIDJi0G4x5R9q/XTYwEgeow==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr9974465wrt.300.1582969177529; 
 Sat, 29 Feb 2020 01:39:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47?
 ([2001:b07:6468:f312:30cb:d037:e500:2b47])
 by smtp.gmail.com with ESMTPSA id z14sm16370959wru.31.2020.02.29.01.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Feb 2020 01:39:36 -0800 (PST)
Subject: Re: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
 <SN4PR2101MB0880FE16EE36BF356552A9DDC0E80@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4277f568-2b20-f7c4-5764-f516c8e281a9@redhat.com>
Date: Sat, 29 Feb 2020 10:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880FE16EE36BF356552A9DDC0E80@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/02/20 22:02, Sunil Muthuswamy wrote:
>> -----Original Message-----
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Sent: Friday, February 28, 2020 2:45 AM
>> To: Sunil Muthuswamy <sunilmut@microsoft.com>; Richard Henderson <rth@twiddle.net>; Eduardo Habkost
>> <ehabkost@redhat.com>
>> Cc: qemu-devel@nongnu.org; Stefan Weil <sw@weilnetz.de>
>> Subject: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent on VM state
>>
>> On 26/02/20 21:54, Sunil Muthuswamy wrote:
>>> Currently, TSC is set as part of the VM runtime state. Setting TSC at
>>> runtime is heavy and additionally can have side effects on the guest,
>>> which are not very resilient to variances in the TSC. This patch uses
>>> the VM state to determine whether to set TSC or not. Some minor
>>> enhancements for getting TSC values as well that considers the VM state.
>>>
>>> Additionally, while setting the TSC, the partition is suspended to
>>> reduce the variance in the TSC value across vCPUs.
>>>
>>> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>>
>> Looks good.  Do you want me to queue this until you can have your GPG
>> key signed?  (And also, I can help you sign it of course).
>>
> 
> Yes, please. Thanks.
> 
> I haven't used GPG keys before. What would I be using it for?

You'd be using it to include a signed tags in a pull requests; that is,
the git tag that you ask to pull has a cryptographic signature attached
to it.

Paolo


