Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D6AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B76E2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B76E2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCgqA-0004dp-Cj
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 05:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jCgpa-00047S-DP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jCgpZ-00077a-Dk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:42:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3286 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jCgpZ-0006vt-1D
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:42:13 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2DF691F8448EDAF12C7A;
 Fri, 13 Mar 2020 17:42:08 +0800 (CST)
Received: from [10.173.228.124] (10.173.228.124) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 13 Mar
 2020 17:41:58 +0800
Subject: Re: [RFC] cpus: avoid get stuck in pause_all_vcpus
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200310091443.1326-1-longpeng2@huawei.com>
 <8ed76f64-1a24-a278-51f3-19515e65ff39@redhat.com>
 <a6c8eac3-a714-ff6f-2bd6-1fa1d1037a81@huawei.com>
 <e4dc19fd-bee2-251f-1fef-b41cd6da6c23@redhat.com>
 <e7a49ec8-6a71-78a9-05c6-f6967e1d55f2@huawei.com>
 <0b380490-dafc-39ef-1bf7-d3f4e54c14ad@redhat.com>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <525050da-7fe6-4371-f1c0-4d1251239b43@huawei.com>
Date: Fri, 13 Mar 2020 17:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0b380490-dafc-39ef-1bf7-d3f4e54c14ad@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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



On 2020/3/13 17:22, Paolo Bonzini wrote:
> On 13/03/20 09:36, Longpeng (Mike, Cloud Infrastructure Service Product
> Dept.) wrote:
>>> You're right, do_vm_stop sets the runstate after pause_all_vcpus.  We
>>> can move that before and it should fix your case too.
>>>
>> Uh, it seems to work. So can I send a patch based on your suggestion ? Or feel
>> free to do if you want to fix it by yourself.
>>
> 
> Yes, please.
> 
A pleasure.

I've just merged the patch into our production and started to running our test
suites for 2-3 days. I'll send it to the mail list if everything goes well :)

> Paolo
> 
> 

---
Regards,
Longpeng(Mike)

