Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1940C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 07:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69812067B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 07:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69812067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHjWS-0002u4-Ns
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 03:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iHjVA-0002LL-N1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 03:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iHjV5-0003Rm-KG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 03:01:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2246 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iHjV2-0003Ps-OU; Tue, 08 Oct 2019 03:01:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 25EA08A9D591A1209D42;
 Tue,  8 Oct 2019 15:01:32 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 15:01:24 +0800
Subject: Re: [Qemu-arm] [PATCH v18 4/6] KVM: Move hwpoison page related
 functions into include/sysemu/kvm_int.h
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-5-zhengxiang9@huawei.com>
 <CAFEAcA_o6NkOGptWFOoVt4pUgHU+dNyWQ9h_VfNweR17CtHSnw@mail.gmail.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <a857520c-f115-a096-3aeb-3d3588575c4a@huawei.com>
Date: Tue, 8 Oct 2019 15:01:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_o6NkOGptWFOoVt4pUgHU+dNyWQ9h_VfNweR17CtHSnw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
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



On 2019/9/27 21:19, Peter Maydell wrote:
> On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>
>> kvm_hwpoison_page_add() and kvm_unpoison_all() will both be used by X86
>> and ARM platforms, so moving them into "include/sysemu/kvm_int.h" to
>> avoid duplicate code.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>  accel/kvm/kvm-all.c      | 33 +++++++++++++++++++++++++++++++++
>>  include/sysemu/kvm_int.h | 23 +++++++++++++++++++++++
>>  target/arm/kvm.c         |  3 +++
>>  target/i386/kvm.c        | 34 ----------------------------------
>>  4 files changed, 59 insertions(+), 34 deletions(-)
> 
>>  static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
>>  {
>>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
>> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
>> index 72b2d1b3ae..3ad49f9a28 100644
>> --- a/include/sysemu/kvm_int.h
>> +++ b/include/sysemu/kvm_int.h
>> @@ -41,4 +41,27 @@ typedef struct KVMMemoryListener {
>>  void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>>                                    AddressSpace *as, int as_id);
>>
>> +/**
>> + * kvm_hwpoison_page_add:
>> + *
>> + * Parameters:
>> + *  @ram_addr: the address in the RAM for the poisoned page
>> + *
>> + * Add a poisoned page to the list
>> + *
>> + * Return: None.
>> + */
>> +void kvm_hwpoison_page_add(ram_addr_t ram_addr);
>> +
>> +/**
>> + * kvm_unpoison_all:
>> + *
>> + * Parameters:
>> + *  @param: some data may be passed to this function
>> + *
>> + * Free and remove all the poisoned pages in the list
>> + *
>> + * Return: None.
>> + */
>> +void kvm_unpoison_all(void *param);
>>  #endif
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index b2eaa50b8d..3a110be7b8 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -20,6 +20,7 @@
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/kvm.h"
>>  #include "sysemu/kvm_int.h"
>> +#include "sysemu/reset.h"
>>  #include "kvm_arm.h"
>>  #include "cpu.h"
>>  #include "trace.h"
>> @@ -195,6 +196,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>
>>      cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>>
>> +    qemu_register_reset(kvm_unpoison_all, NULL);
>> +
> 
> Rather than registering the same reset handler in
> all the architectures, we could register it in the
> generic kvm_init() function. (For architectures that
> don't use the poison-list functionality the reset handler
> will harmlessly do nothing, because there will be nothing
> in the list.)
> 
> This would allow you to not have to make the
> kvm_unpoison_all() function global -- it can be static
> in accel/tcg/kvm-all.c.

OK, I will move the register code into the kvm_init() function.

> 
>>      return 0;
>>  }
> 
> thanks
> -- PMM
> 
> .
> 

-- 

Thanks,
Xiang


