Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB5C20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e16VUdM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB5C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itr8j-0000xg-NP
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itr7e-00086u-C9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itr7a-0002Pk-2v
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:51:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itr7Z-0002O7-Ub
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579603857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6z6VMHQRuZ71QFFUl75dnxsvN2jLBKErbicOLLiKQU=;
 b=e16VUdM6YbU/q95lv9+r0kDND8PMKF1jCi1Tc+DEVuHZdM/qrYGJ2ZW34aJeDXeSWVx8Sm
 lJvbO2ISyVZ+5iOti14826P7YpsBlu3IQi7tyfLOTB8USlhMcIBjBlBEpPmf8sZPTeY5vY
 H/SpZV5dA/HIJtscYa+W/M1dcCDahds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-pySqy1JbOQ-8LLq1qxd8_Q-1; Tue, 21 Jan 2020 05:50:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so1127523wrm.16
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V6z6VMHQRuZ71QFFUl75dnxsvN2jLBKErbicOLLiKQU=;
 b=RA8uCPSg6snNn24dm9gFtqiuJBCHOrSIIkyLFrMTQmQJqEBey+qm0tltXPfoXFYgp0
 E/LUnKRK94GIg0kF4zuAPs8Go9R3vO+k/r8KQAZ+ZaEaL7JaaNnVaSvCwy/AA3s/7EVf
 a7ymzU5vut6OUUbU6A+T5XU9zvOMHtlmX8LI23T2y7IHvtV9ZURUDBbZBfUiAY5POZ8e
 IzNa3QaD22AV9OLuet7Sysp39UTYcoF34OGWRNxoYH36b2m39+ydppMODFa8q/LTCUjd
 f6fCn8fEddyEiJut44pmHqEt5hIqjfhZXWCvzt4PZYO2ibIP1hf1vu2qUpOjFDsMDu5t
 Al0A==
X-Gm-Message-State: APjAAAXe6eBVdfm8WqHOHQl27hZmmpL5Jqrt5fexO6HoTfSCDKO5WHPD
 HJbGCjnuY/x62B9VkCywTpTohObm/RUOjGGNjsILUMFcwUJP8TTPpSZZEw8b6hId2HYjOj122uh
 GdYt5dmivgwVarXA=
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr3853826wmj.156.1579603854819; 
 Tue, 21 Jan 2020 02:50:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxX1Xw2u+ogi7FugqbtA5dPIMYvwCnIn6jc/X1zPZECXUuxOc5Z3dQGa+aCINYeOlO8bo9l2g==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr3853798wmj.156.1579603854510; 
 Tue, 21 Jan 2020 02:50:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id h8sm54673071wrx.63.2020.01.21.02.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 02:50:54 -0800 (PST)
Subject: Re: [PATCH 1/2] pvpanic: introduce crashloaded for pvpanic
To: Markus Armbruster <armbru@redhat.com>, zhenwei pi <pizhenwei@bytedance.com>
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
 <20200110100634.491936-2-pizhenwei@bytedance.com>
 <87h80pi5hf.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <247586dd-576a-a0c9-9c43-5d9a310a4ddc@redhat.com>
Date: Tue, 21 Jan 2020 11:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87h80pi5hf.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: pySqy1JbOQ-8LLq1qxd8_Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yelu@bytedance.com, libvir-list@redhat.com, gregkh@linuxfoundation.org,
 qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/20 09:22, Markus Armbruster wrote:
> zhenwei pi <pizhenwei@bytedance.com> writes:
> 
>> Add bit 1 for pvpanic. This bit means that guest hits a panic, but
>> guest wants to handle error by itself. Typical case: Linux guest runs
>> kdump in panic. It will help us to separate the abnormal reboot from
>> normal operation.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>  docs/specs/pvpanic.txt | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
>> index c7bbacc778..bdea68a430 100644
>> --- a/docs/specs/pvpanic.txt
>> +++ b/docs/specs/pvpanic.txt
>> @@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
>>  recognized by the device are set. Software should ignore bits it doesn't
>>  recognize. On write, the bits not recognized by the device are ignored.
>>  Software should set only bits both itself and the device recognize.
> 
> Guest software, I presume.
> 
>> -Currently, only bit 0 is recognized, setting it indicates a guest panic
>> -has happened.
>> +
>> +Bit Definition
>> +--------------
>> +bit 0: setting it indicates a guest panic has happened.
>> +bit 1: named crashloaded. setting it indicates a guest panic and run
>> +       kexec to handle error by guest itself.
> 
> Suggest to scratch "named crashloaded."

bit 1: a guest panic has happened and will be handled by the guest;
       the host should record it or report it, but should not affect
       the execution of the guest.

?

Paolo


