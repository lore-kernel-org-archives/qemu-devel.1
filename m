Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19FEC04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EB1214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMVn-0003MC-OJ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:21:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOMUf-0002jW-Ln
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOMUd-00075I-Tm
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:20:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hOMUb-0006r9-C9; Wed, 08 May 2019 09:20:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D508A30842B2;
	Wed,  8 May 2019 13:20:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 517241724D;
	Wed,  8 May 2019 13:20:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A2B401132B35; Wed,  8 May 2019 15:20:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
References: <20190505070059.4664-1-zhengxiang9@huawei.com>
	<87a7fyb0v7.fsf@dusky.pond.sub.org>
	<72adbed8-f650-42df-98d5-e98154baec08@redhat.com>
Date: Wed, 08 May 2019 15:20:10 +0200
In-Reply-To: <72adbed8-f650-42df-98d5-e98154baec08@redhat.com> (Laszlo Ersek's
	message of "Tue, 7 May 2019 21:03:51 +0200")
Message-ID: <87h8a513sl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 08 May 2019 13:20:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] pflash: Only read non-zero parts of
 backend image
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	ard.biesheuvel@linaro.org, qemu-devel@nongnu.org,
	mreitz@redhat.com, Xiang Zheng <zhengxiang9@huawei.com>,
	stefanha@redhat.com, guoheyi@huawei.com, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laszlo Ersek <lersek@redhat.com> writes:

> Hi Markus,
>
> On 05/07/19 20:01, Markus Armbruster wrote:
>> The subject is slightly misleading.  Holes read as zero.  So do
>> non-holes full of zeroes.  The patch avoids reading the former, but
>> still reads the latter.
>> 
>> Xiang Zheng <zhengxiang9@huawei.com> writes:
>> 
>>> Currently we fill the memory space with two 64MB NOR images when
>>> using persistent UEFI variables on virt board. Actually we only use
>>> a very small(non-zero) part of the memory while the rest significant
>>> large(zero) part of memory is wasted.
>> 
>> Neglects to mention that the "virt board" is ARM.
>> 
>>> So this patch checks the block status and only writes the non-zero part
>>> into memory. This requires pflash devices to use sparse files for
>>> backends.
>> 
>> I started to draft an improved commit message, but then I realized this
>> patch can't work.
>> 
>> The pflash_cfi01 device allocates its device memory like this:
>> 
>>     memory_region_init_rom_device(
>>         &pfl->mem, OBJECT(dev),
>>         &pflash_cfi01_ops,
>>         pfl,
>>         pfl->name, total_len, &local_err);
>> 
>> pflash_cfi02 is similar.
>> 
>> memory_region_init_rom_device() calls
>> memory_region_init_rom_device_nomigrate() calls qemu_ram_alloc() calls
>> qemu_ram_alloc_internal() calls g_malloc0().  Thus, all the device
>> memory gets written to even with this patch.
>
> As far as I can see, qemu_ram_alloc_internal() calls g_malloc0() only to
> allocate the the new RAMBlock object called "new_block". The actual
> guest RAM allocation occurs inside ram_block_add(), which is also called
> by qemu_ram_alloc_internal().

You're right.  I should've read more attentively.

> One frame outwards the stack, qemu_ram_alloc() passes NULL to
> qemu_ram_alloc_internal(), for the 4th ("host") parameter. Therefore, in
> qemu_ram_alloc_internal(), we set "new_block->host" to NULL as well.
>
> Then in ram_block_add(), we take the (!new_block->host) branch, and call
> phys_mem_alloc().
>
> Unfortunately, "phys_mem_alloc" is a function pointer, set with
> phys_mem_set_alloc(). The phys_mem_set_alloc() function is called from
> "target/s390x/kvm.c" (setting the function pointer to
> legacy_s390_alloc()), so it doesn't apply in this case. Therefore we end
> up calling the default qemu_anon_ram_alloc() function, through the
> funcptr. (I think anyway.)
>
> And qemu_anon_ram_alloc() boils down to mmap() + MAP_ANONYMOUS, in
> qemu_ram_mmap(). (Even on PPC64 hosts, because qemu_anon_ram_alloc()
> passes (-1) for "fd".)
>
> I may have missed something, of course -- I obviously didn't test it,
> just speculated from the source.

Thanks for your sleuthing!

>> I'm afraid you neglected to test.

Accusation actually unsupported.  I apologize, and replace it by a
question: have you observed the improvement you're trying to achieve,
and if yes, how?

[...]

