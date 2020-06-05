Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2730E207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2730E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1YD-00051V-CV
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jh1Xe-0004bP-OW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 21:53:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:12692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jh1Xd-0004eS-7z
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 21:53:06 -0400
IronPort-SDR: CeXeBrvG2dzZqV4gjs8LRCDQ/pmlXSUGHKdetzU5zZYPdTRkeR74TYwvyyuzVVEBMnE5d/YYO6
 IkETciZf5Wsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:52:54 -0700
IronPort-SDR: qsewg8BNe+KLlgJfF0bgGdbrOSTgpffrDjhXkOZhP0dif86lAR82VDsyC5m4Ut2O9Ly6eA2hMA
 SUAu5XooKdmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,474,1583222400"; d="scan'208";a="294532294"
Received: from shzintpr03.sh.intel.com (HELO [0.0.0.0]) ([10.239.4.100])
 by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2020 18:52:52 -0700
Subject: Re: [PATCH 3/3] numa: Initialize node initiator with respect to
 .has_cpu
To: Michal Privoznik <mprivozn@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
 <d3039c47e4ce1118bc7c4d4f51da6412c6669339.1590753455.git.mprivozn@redhat.com>
 <20200529170948.5bdb3316@redhat.com>
 <d6c8e7c5-62c5-5ac5-0941-d28867761014@redhat.com>
 <4bde8796-7479-9fe0-20e4-6c173a865cec@intel.com>
 <33014889-a70e-3d5d-3138-0e0f72553477@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <1b670edc-dd14-4e7e-34db-c1f2860297f0@intel.com>
Date: Fri, 5 Jun 2020 09:52:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <33014889-a70e-3d5d-3138-0e0f72553477@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100; envelope-from=tao3.xu@intel.com;
 helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:52:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/3/20 5:16 PM, Michal Privoznik wrote:
> On 6/2/20 10:00 AM, Tao Xu wrote:
>>
>> On 6/1/2020 4:10 PM, Michal Privoznik wrote:
>>> On 5/29/20 5:09 PM, Igor Mammedov wrote:
>>>> On Fri, 29 May 2020 15:33:48 +0200
>>>> Michal Privoznik <mprivozn@redhat.com> wrote:
>>>>
>>>>> The initiator attribute of a NUMA node is documented as the 'NUMA
>>>>> node that has best performance to given NUMA node'. If a NUMA
>>>>> node has at least one CPU there can hardly be a different node
>>>>> with better performace and thus all NUMA nodes which have a CPU
>>>>> are initiators to themselves. Reflect this fact when initializing
>>>>> the attribute.
>>>>
>>>> It is not true in case of the node is memory-less
>>>
>>> Are you saying that if there's a memory-less NUMA node, then it needs to
>>> have initiator set too? Asking mostly out of curiosity because we don't
>>> allow memory-less NUMA nodes in Libvirt just yet. Nor cpu-less, but my
>>> patches that I'm referring to in cover letter will allow at least
>>> cpu-less nodes. Should I allow both?
>> QEMU now is not support memory-less NUMA node, but in hardware may be
>> supported. So we reserve this type of NUMA node for future usage. And
>> QEMU now can support cpu-less NUMA node, for emulating some "slow"
>> memory(like some NVDIMM).
> 
> Oh yeah, I understand that. But it doesn't explain why initiator needs
> to be specified for NUMA nodes with cpus and memory, or does it? Maybe
> I'm still misunderstanding what the initiator is.
> 

Yes, the initiator NUMA nodes with cpus and memory should be itself. In 
ACPI 6.3 spec, initiator is defined as:

This field is valid only if the memory controller
responsible for satisfying the access to memory
belonging to the specified memory proximity
domain is directly attached to an initiator that
belongs to a proximity domain. In that case, this
field contains the integer that represents the
proximity domain to which the initiator (Generic
Initiator or Processor) belongs. This number shall
match the corresponding entry in the SRAT table’s
processor affinity structure (e.g., Processor Local
APIC/SAPIC Affinity Structure, Processor Local
x2APIC Affinity Structure, GICC Affinity Structure) if
the initiator is a processor, or the Generic Initiator
Affinity Structure if the initator is a generic
initiator.
Note: this field provides additional information as
to the initiator node that is closest (as in directly
attached) to the memory address ranges within
the specified memory proximity domain, and
therefore should provide the best performance.

And if in the future, there is a memory-less NUMA node. Because in HMAT 
we describe "Memory" Proximity Domain Attributes Structure, I think we 
should not add memory-less NUMA node into HMAT.

>>
>>>
>>> Also, can you shed more light into why machine_set_cpu_numa_node() did
>>> not override the .initiator?
> 
> And this one is still unanswered too. Because from user's perspective,
> initiator has to be set on all NUMA nodes (if HMAT is enabled) and it
> seems like this auto assignment code is not run/not working.
> 
> Michal
> 

So we check the HMAT configure in hw/core/machine.c 
numa_validate_initiator(NumaState *numa_state) because the initiator 
NUMA nodes with cpus and memory should be itself. And in 
machine_set_cpu_numa_node we didn't use auto assignment way just use 
user's setting in cli (although there is only one right choice for NUMA 
nodes with cpus and memory). But I don't know if it is appropriate to 
auto assign the initiator for NUMA nodes with cpus and memory.

