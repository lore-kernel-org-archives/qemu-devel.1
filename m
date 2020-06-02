Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C717C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C11206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C11206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1rj-0001Hb-HB
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jg1r5-0000iq-PF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:01:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:64533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jg1r0-0003ly-5P
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:01:02 -0400
IronPort-SDR: K9wMjDqUnghDz92xhuP4NYwbmxocTNXLEe0NheCOy+q45U0elKoGBqxOIk9FK3XsVzHLbI2ZqF
 Rk4K5iXOKP9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2020 01:00:52 -0700
IronPort-SDR: WpFvqPhSnqXDB7ZkCoYzLmadNQQSekUYZrfwZOS8FKMxRDltpTacnR4BfTibc9igk0KU1e1uzt
 8USiSA/vvyLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; d="scan'208";a="286569234"
Received: from haoyang1-mobl3.ccr.corp.intel.com (HELO [10.255.29.205])
 ([10.255.29.205])
 by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 01:00:50 -0700
Subject: Re: [PATCH 3/3] numa: Initialize node initiator with respect to
 .has_cpu
To: Michal Privoznik <mprivozn@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
 <d3039c47e4ce1118bc7c4d4f51da6412c6669339.1590753455.git.mprivozn@redhat.com>
 <20200529170948.5bdb3316@redhat.com>
 <d6c8e7c5-62c5-5ac5-0941-d28867761014@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <4bde8796-7479-9fe0-20e4-6c173a865cec@intel.com>
Date: Tue, 2 Jun 2020 16:00:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d6c8e7c5-62c5-5ac5-0941-d28867761014@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=tao3.xu@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 04:00:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 T_SPF_TEMPERROR=0.01 autolearn=_AUTOLEARN
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6/1/2020 4:10 PM, Michal Privoznik wrote:
> On 5/29/20 5:09 PM, Igor Mammedov wrote:
>> On Fri, 29 May 2020 15:33:48 +0200
>> Michal Privoznik <mprivozn@redhat.com> wrote:
>>
>>> The initiator attribute of a NUMA node is documented as the 'NUMA
>>> node that has best performance to given NUMA node'. If a NUMA
>>> node has at least one CPU there can hardly be a different node
>>> with better performace and thus all NUMA nodes which have a CPU
>>> are initiators to themselves. Reflect this fact when initializing
>>> the attribute.
>>
>> It is not true in case of the node is memory-less
> 
> Are you saying that if there's a memory-less NUMA node, then it needs to
> have initiator set too? Asking mostly out of curiosity because we don't
> allow memory-less NUMA nodes in Libvirt just yet. Nor cpu-less, but my
> patches that I'm referring to in cover letter will allow at least
> cpu-less nodes. Should I allow both?
QEMU now is not support memory-less NUMA node, but in hardware may be 
supported. So we reserve this type of NUMA node for future usage. And 
QEMU now can support cpu-less NUMA node, for emulating some "slow" 
memory(like some NVDIMM).

> 
> Also, can you shed more light into why machine_set_cpu_numa_node() did
> not override the .initiator?
> 
> Thanks,
> Michal
> 

