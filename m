Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED548C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE74B20768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEQD1-0006RG-0N
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 00:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jEQCC-00060w-9X
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jEQCA-0001nu-Ed
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:20:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:3104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jEQCA-0001ar-50; Wed, 18 Mar 2020 00:20:42 -0400
IronPort-SDR: mPMes4ZIliJ30Tcpn6pnKpifONJ8wpNeL3wsrmhUOTK3i1QEOqTjJsiV+uiCAXaz4eTx7nMtZQ
 U+O4iL0l2wLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 21:20:33 -0700
IronPort-SDR: bQj5+7MYzyQxC7P8oUBFjvB6wJTt32sjoZfcuVNv1TXMgcFzA+fJ0/6E2EUWsJBQcnlo8UeuAV
 wfuliYshzmyQ==
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="391311957"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.9.59])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 21:20:33 -0700
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe 1.4
 spec
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
 <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
 <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
 <12576914-0ef4-efd2-355a-cff3f4eeae69@linux.intel.com>
 <20200312060827.gjddwgmevyptsmpl@apples.localdomain>
 <20200316113216.GB449975@stefanha-x1.localdomain>
 <cf3833cc-fbd1-9930-fee1-ed9b26647f1c@linux.intel.com>
 <CAJSP0QUmO2sbCscL=f+=Ps8Wud5vcxWmL0U64Jy7XJ7VPuQGFA@mail.gmail.com>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <eaeefd2d-fa51-8141-e53d-fa9cee2ca1f3@linux.intel.com>
Date: Tue, 17 Mar 2020 21:20:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUmO2sbCscL=f+=Ps8Wud5vcxWmL0U64Jy7XJ7VPuQGFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Dave Gilbert <dgilbert@redhat.com>, kbusch@kernel.org,
 Zhang Yi <yi.z.zhang@linux.intel.com>, "He, Junyan" <junyan.he@intel.com>,
 Klaus Birkelund Jensen <its@irrelevant.dk>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 4:23 AM, Stefan Hajnoczi wrote:
>> Code is posted here
>> https://github.com/AndrzejJakowski/qemu/commit/3a7762a1d13ff1543d1da430748eb24e38faab6f
>>
>> QEMU command line:
>>
>> # below are just relevant pieces of configuration, other stuff omitted
>> # tried different setting (e.g. pmem=on and pmem=off)
>>
>> ./x86_64-softmmu/qemu-system-x86_64 ... \
>> -object memory-backend-file,id=mem1,share=off,pmem=on,mem-path=../nvme_pmr.bin,size=$((1*1024*1024)) \
> share=off is MAP_PRIVATE.  If persistence is desired then share=on
> should be used.
> 
> However, this shouldn't affect "system_reset" behavior since the QEMU
> process still has the same mapped file open.
> 

Hi Stefan,

Thx!! share=off setting was the problem. I confirmed with my simple test
that persistence is achieved.
I didn't find API to perform flush (msync). Any suggestion what function to use?

Given that host memory backend is working I think my patch is almost ready for 
resubmission -- let me know if there are any other comments.

Andrzej

>> -drive file=../nvme.bin,format=raw,if=none,id=nvme_emulated \
>> -device nvme,drive=nvme_emulated,serial="test serial",pmrdev=mem1
>>
>> In VM:
>> My persisent memory region is exposed PCI BAR
>> Region 2: Memory at fe000000 (64-bit, prefetchable) [size=1M]
>>
>> So I perform reads/writes from/to following adress 0xfe000000 (decimal 4261412864)
>>
>> dd if=test.bin of=/dev/mem bs=1 count=30 seek=4261412864
>> dd if=/dev/mem of=test1.bin bs=1 count=30 skip=4261412864
> Did you verify that the guest kernel is really accessing the BAR?  I
> remember that distro kernels often ship with options that make
> /dev/mem of limited use because it's considered insecure.
> 
>> On VMM I didn't observe that backing file has been updated and after power cycling VM
>> I see old junk when reading PMR region.
> Did you check that the pmrdev mmap region contains the data the guest
> wrote before power cycling?
> 
>> Also from include/qemu/pmem.h it looks like pmem_persist() will cause qemu to exit
>> if libpmem is not installed:
> The libpmem support only needs to be used when the pmem=on option was
> given.  If there isn't a physical pmem device then it doesn't need to
> be used.
> 
> Stefan


