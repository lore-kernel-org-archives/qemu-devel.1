Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39210C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107CB20749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107CB20749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfqK-0006A3-9J
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jCfoI-0002eD-NG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jCfoH-0006ai-4J
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3203 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jCfoG-0006G3-Na
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6906E481E54121781860;
 Fri, 13 Mar 2020 16:36:42 +0800 (CST)
Received: from [10.173.228.124] (10.173.228.124) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 13 Mar
 2020 16:36:35 +0800
Subject: Re: [RFC] cpus: avoid get stuck in pause_all_vcpus
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200310091443.1326-1-longpeng2@huawei.com>
 <8ed76f64-1a24-a278-51f3-19515e65ff39@redhat.com>
 <a6c8eac3-a714-ff6f-2bd6-1fa1d1037a81@huawei.com>
 <e4dc19fd-bee2-251f-1fef-b41cd6da6c23@redhat.com>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <e7a49ec8-6a71-78a9-05c6-f6967e1d55f2@huawei.com>
Date: Fri, 13 Mar 2020 16:36:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e4dc19fd-bee2-251f-1fef-b41cd6da6c23@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel @ nongnu . org" <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/13 15:09, Paolo Bonzini wrote:
> On 13/03/20 02:43, Longpeng (Mike, Cloud Infrastructure Service Product
> Dept.) wrote:
>>> diff --git a/cpus.c b/cpus.c
>>> index b4f8b84b61..1eb7533a91 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -1899,6 +1899,10 @@ void resume_all_vcpus(void)
>>>  {
>>>      CPUState *cpu;
>>>
>>> +    if (!runstate_is_running()) {
>>> +        return;
>>> +    }
>>> +
>> Hi Paolo,
>>
>> The runstate of my above sketch is running, so maybe your patch can fix some
>> other issues but not mine ?
> 
> You're right, do_vm_stop sets the runstate after pause_all_vcpus.  We
> can move that before and it should fix your case too.
> 
Uh, it seems to work. So can I send a patch based on your suggestion ? Or feel
free to do if you want to fix it by yourself.

> Paolo
> 
> 
---
Regards,
Longpeng(Mike)

