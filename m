Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D44206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bt/q1Btb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D44206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOQW-0008OJ-LP
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jjOPb-0007pq-3E
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:42:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35029
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jjOPY-0003Q2-MA
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591886549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Aj9yQ9oVDkmCnw6/U7oEkmz/bTO8fySLcwGI6Cf93Q=;
 b=Bt/q1Btb5Mi8Rwgh99Z3zW+0R1XNzvp9vvHsW0fkZZZuORjVNQYvAwLtQbQNiMAeVhbOwR
 eWb2XJfSCVsMUU3JsXMWDIWvGl/jSCe4dc/inux7/i+kW+prf5EvRI7GiS6icDk6sNKZTU
 xkBM/VfJCQEBz3RhDMYFg24PTtFvakM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-S2sZ4g-MMiGjFUXmtMO4og-1; Thu, 11 Jun 2020 10:42:24 -0400
X-MC-Unique: S2sZ4g-MMiGjFUXmtMO4og-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DC2981CBE1;
 Thu, 11 Jun 2020 14:42:23 +0000 (UTC)
Received: from [10.40.193.30] (unknown [10.40.193.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E3687E596;
 Thu, 11 Jun 2020 14:42:22 +0000 (UTC)
Subject: Re: [PATCH 3/3] numa: Initialize node initiator with respect to
 .has_cpu
To: Tao Xu <tao3.xu@intel.com>, Igor Mammedov <imammedo@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
 <d3039c47e4ce1118bc7c4d4f51da6412c6669339.1590753455.git.mprivozn@redhat.com>
 <20200529170948.5bdb3316@redhat.com>
 <d6c8e7c5-62c5-5ac5-0941-d28867761014@redhat.com>
 <4bde8796-7479-9fe0-20e4-6c173a865cec@intel.com>
 <33014889-a70e-3d5d-3138-0e0f72553477@redhat.com>
 <1b670edc-dd14-4e7e-34db-c1f2860297f0@intel.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <bb9d32bd-3273-542f-4451-2711cff481f3@redhat.com>
Date: Thu, 11 Jun 2020 16:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1b670edc-dd14-4e7e-34db-c1f2860297f0@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/5/20 3:52 AM, Tao Xu wrote:
> On 6/3/20 5:16 PM, Michal Privoznik wrote:
>> On 6/2/20 10:00 AM, Tao Xu wrote:
>>>
>>> On 6/1/2020 4:10 PM, Michal Privoznik wrote:
>>>> On 5/29/20 5:09 PM, Igor Mammedov wrote:
>>>>> On Fri, 29 May 2020 15:33:48 +0200
>>>>> Michal Privoznik <mprivozn@redhat.com> wrote:
>>>>>
>>>>>> The initiator attribute of a NUMA node is documented as the 'NUMA
>>>>>> node that has best performance to given NUMA node'. If a NUMA
>>>>>> node has at least one CPU there can hardly be a different node
>>>>>> with better performace and thus all NUMA nodes which have a CPU
>>>>>> are initiators to themselves. Reflect this fact when initializing
>>>>>> the attribute.
>>>>>
>>>>> It is not true in case of the node is memory-less
>>>>
>>>> Are you saying that if there's a memory-less NUMA node, then it 
>>>> needs to
>>>> have initiator set too? Asking mostly out of curiosity because we don't
>>>> allow memory-less NUMA nodes in Libvirt just yet. Nor cpu-less, but my
>>>> patches that I'm referring to in cover letter will allow at least
>>>> cpu-less nodes. Should I allow both?
>>> QEMU now is not support memory-less NUMA node, but in hardware may be
>>> supported. So we reserve this type of NUMA node for future usage. And
>>> QEMU now can support cpu-less NUMA node, for emulating some "slow"
>>> memory(like some NVDIMM).
>>
>> Oh yeah, I understand that. But it doesn't explain why initiator needs
>> to be specified for NUMA nodes with cpus and memory, or does it? Maybe
>> I'm still misunderstanding what the initiator is.
>>
> 
> Yes, the initiator NUMA nodes with cpus and memory should be itself. In 
> ACPI 6.3 spec, initiator is defined as:
> 
> This field is valid only if the memory controller
> responsible for satisfying the access to memory
> belonging to the specified memory proximity
> domain is directly attached to an initiator that
> belongs to a proximity domain. In that case, this
> field contains the integer that represents the
> proximity domain to which the initiator (Generic
> Initiator or Processor) belongs. This number shall
> match the corresponding entry in the SRAT table’s
> processor affinity structure (e.g., Processor Local
> APIC/SAPIC Affinity Structure, Processor Local
> x2APIC Affinity Structure, GICC Affinity Structure) if
> the initiator is a processor, or the Generic Initiator
> Affinity Structure if the initator is a generic
> initiator.
> Note: this field provides additional information as
> to the initiator node that is closest (as in directly
> attached) to the memory address ranges within
> the specified memory proximity domain, and
> therefore should provide the best performance.
> 
> And if in the future, there is a memory-less NUMA node. Because in HMAT 
> we describe "Memory" Proximity Domain Attributes Structure, I think we 
> should not add memory-less NUMA node into HMAT.

Then I guess something else must be broken. Because as reported here [1] 
if I configure two numa nodes, both with two vCPUs and set initiators of 
each node to itselfs I get the following error message:

qemu-system-x86_64: -numa 
node,nodeid=1,cpus=2-3,initiator=1,memdev=ram-node1: The initiator of 
CPU NUMA node 1 should be itself

Funny about this error message is how contradictory it is. The cmd line 
showed in the error shows the initiator of the node 1 is indeed node 1.

1: https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg00071.html

Michal


