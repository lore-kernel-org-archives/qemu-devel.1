Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F62AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 06:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AE02078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 06:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AE02078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8eLX-00048J-Mj
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 02:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8eKO-0003VI-DI; Thu, 20 Aug 2020 02:45:37 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:37165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8eKM-0000Yu-FE; Thu, 20 Aug 2020 02:45:36 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.2])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 1FFC95226F31;
 Thu, 20 Aug 2020 08:45:30 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 08:45:30 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001e613f738-6209-4e31-96e2-8da9e4718a83,
 02C359FD435C2C4122574921AFFD4D91C9CEEBEA) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] spapr/xive: Allocate IPIs from the vCPU contexts
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200814150358.1682513-1-clg@kaod.org>
 <42e8bb9f-c052-5abb-9ffe-0700bfe3904d@kaod.org>
 <20200816043000.GH12805@yekko.fritz.box>
 <2d621c86-b951-8c62-2015-e307f955c93a@kaod.org>
 <20200820004246.GB271315@yekko.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <da9fd7b8-3f95-531b-835d-597a58328947@kaod.org>
Date: Thu, 20 Aug 2020 08:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820004246.GB271315@yekko.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: fa777870-f699-4ee4-a14f-2b9fd6100786
X-Ovh-Tracer-Id: 2020427383607692195
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtledgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeelgfejveehieefffduueehvdevfedtleeiudekjeegveeigfeifefhtdfffedtnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 02:45:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 2:42 AM, David Gibson wrote:
> On Sun, Aug 16, 2020 at 03:38:20PM +0200, Cédric Le Goater wrote:
>> On 8/16/20 6:30 AM, David Gibson wrote:
>>> On Fri, Aug 14, 2020 at 05:08:13PM +0200, Cédric Le Goater wrote:
>>>>
>>>> This works as expected with a 128 vCPUs guest with pinned vcpus. The
>>>> first 64 IPIs are allocated on the first chip and the remaining 64
>>>> on the second chip.
>>>>
>>>> Still, this is more an RFC. We have time before the end of the merge
>>>> window.
>>>
>>> It looks reasonable to me.  AFAICT it makes things better than they
>>> were, and even if we can improve it further, that won't break
>>> migration or other interfaces we need to preserve.
>>
>> Yeah. What I don't like is this test below. I am not sure that 
>> machine->smp.cpus is the correct way to test the number of currently
>> active vCPUs.
> 
> Ah, yeah.  It should be correct at initial startup, but might not be
> after a bunch of hotplugs/unplugs, which could result in a sparse set
> of active vcpus.

Yes. I have a v2 ready to be sent in which the vCPU IPI is allocated
under kvmppc_xive_cpu_connect().

Thanks,

C. 

> 
> Usually this code will be called during initial setup, but I think
> there are some edge cases where it won't be (e.g. boot a XICS kernel,
> do some vcpu plugs/unplugs, reboot into a XIVE kernel).
> 
> So I think we need to explicitly check for each vcpu # if it's
> currently active.  Using... spapr_find_cpu(), I guess?
> 
>>
>>>>> +    if (srcno < machine->smp.cpus) {
>>>>> +        return kvmppc_xive_reset_ipi(xive, srcno, errp);
>>>>> +    }
>>>>> +
>>>>>      if (xive_source_irq_is_lsi(xsrc, srcno)) {
>>>>>          state |= KVM_XIVE_LEVEL_SENSITIVE;
>>>>>          if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
>>
> 


