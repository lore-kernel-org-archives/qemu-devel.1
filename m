Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414AFA372B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B843320854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B843320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKyuD-00033S-L8
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 02:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iKyt8-000292-BB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iKyt7-0005ep-4o
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:03:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36676 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iKyt4-0005ao-DJ; Thu, 17 Oct 2019 02:03:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E14F230BF13D4765E53A;
 Thu, 17 Oct 2019 14:03:42 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 14:03:32 +0800
Subject: Re: [PATCH v19 5/5] target-arm: kvm64: handle SIGBUS signal from
 kernel or KVM
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191015140140.34748-1-zhengxiang9@huawei.com>
 <20191015140140.34748-6-zhengxiang9@huawei.com>
 <CAFEAcA-92YEgrBPDVVFEmjBYnw=keJWKUDnqNRakw-jKYaxK5Q@mail.gmail.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <c0ecb6af-c26f-0f97-c6dd-7745a03da94c@huawei.com>
Date: Thu, 17 Oct 2019 14:03:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-92YEgrBPDVVFEmjBYnw=keJWKUDnqNRakw-jKYaxK5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>, QEMU
 Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/10/15 22:48, Peter Maydell wrote:
> On Tue, 15 Oct 2019 at 15:02, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>
>> Add a SIGBUS signal handler. In this handler, it checks the SIGBUS type,
>> translates the host VA delivered by host to guest PA, then fills this PA
>> to guest APEI GHES memory, then notifies guest according to the SIGBUS
>> type.
>>
>> When guest accesses the poisoned memory, it will generate a Synchronous
>> External Abort(SEA). Then host kernel gets an APEI notification and calls
>> memory_failure() to unmapped the affected page in stage 2, finally
>> returns to guest.
>>
>> Guest continues to access the PG_hwpoison page, it will trap to KVM as
>> stage2 fault, then a SIGBUS_MCEERR_AR synchronous signal is delivered to
>> Qemu, Qemu records this error address into guest APEI GHES memory and
>> notifes guest using Synchronous-External-Abort(SEA).
>>
>> In order to inject a vSEA, we introduce the kvm_inject_arm_sea() function
>> in which we can setup the type of exception and the syndrome information.
>> When switching to guest, the target vcpu will jump to the synchronous
>> external abort vector table entry.
>>
>> The ESR_ELx.DFSC is set to synchronous external abort(0x10), and the
>> ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
>> not valid and hold an UNKNOWN value. These values will be set to KVM
>> register structures through KVM_SET_ONE_REG IOCTL.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> 
>> +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>> +                                      uint64_t error_physical_addr,
>> +                                      uint32_t data_length)
>> +{
>> +    GArray *block;
>> +    uint64_t current_block_length;
>> +    /* Memory Error Section Type */
>> +    QemuUUID mem_section_id_le = UEFI_CPER_SEC_PLATFORM_MEM;
>> +    QemuUUID fru_id = {0};
> 
> Hi; this makes at least some versions of clang complain
> (this is a clang bug, but it's present in shipped versions):
> 
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/acpi/acpi_ghes.c:135:24:
> error: suggest braces around
>       initialization of subobject [-Werror,-Wmissing-braces]
>     QemuUUID fru_id = {0};
>                        ^
>                        {}
> 
> We generally use "{}" as the generic zero-initializer for
> this reason (it's gcc/clang specific whereas "{0}" is
> in the standard, but all of the compilers we care about
> support it and don't warn about its use).
> 
>> +    uint8_t fru_text[20] = {0};
> 
> Clang doesn't mind this one because it's not initializing
> a struct type, but you could use "{}" here too for consistency.
> 

OK, I will replace all the "{0}" with "{}".

> thanks
> -- PMM
> 
> .
> 

-- 

Thanks,
Xiang


