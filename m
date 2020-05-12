Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB2C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927182078E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927182078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQ06-00055Z-R1
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jYPzD-00042a-HG
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:09:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49326 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jYPzB-0006QF-Of
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:09:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C059A7B10AE9D45F0431;
 Tue, 12 May 2020 16:09:49 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 May
 2020 16:09:44 +0800
Subject: Re: [PATCH] i386/kvm: fix a use-after-free when vcpu plug/unplug
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>,
 <mtosatti@redhat.com>
References: <20200512133933.8696-1-pannengyuan@huawei.com>
 <eab55b02-d51b-96c6-3c03-eb69964f162d@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <35cb4db2-f7f2-4cfb-aa8d-1c27887cdbfa@huawei.com>
Date: Tue, 12 May 2020 16:09:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eab55b02-d51b-96c6-3c03-eb69964f162d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 04:09:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/12/2020 3:54 PM, Philippe Mathieu-Daudé wrote:
> On 5/12/20 3:39 PM, Pan Nengyuan wrote:
>> When we hotplug vcpus, cpu_update_state is added to vm_change_state_head
>> in kvm_arch_init_vcpu(). But it forgot to delete in kvm_arch_destroy_vcpu() after
>> unplug. Then it will cause a use-after-free access. This patch delete it in
>> kvm_arch_destroy_vcpu() to fix that.
>>
>> Reproducer:
>>      virsh setvcpus vm1 4 --live
>>      virsh setvcpus vm1 2 --live
>>      virsh suspend vm1
>>      virsh resume vm1
>>
>> The UAF stack:
>> ==qemu-system-x86_64==28233==ERROR: AddressSanitizer: heap-use-after-free on address 0x62e00002e798 at pc 0x5573c6917d9e bp 0x7fff07139e50 sp 0x7fff07139e40
>> WRITE of size 1 at 0x62e00002e798 thread T0
>>      #0 0x5573c6917d9d in cpu_update_state /mnt/sdb/qemu/target/i386/kvm.c:742
>>      #1 0x5573c699121a in vm_state_notify /mnt/sdb/qemu/vl.c:1290
>>      #2 0x5573c636287e in vm_prepare_start /mnt/sdb/qemu/cpus.c:2144
>>      #3 0x5573c6362927 in vm_start /mnt/sdb/qemu/cpus.c:2150
>>      #4 0x5573c71e8304 in qmp_cont /mnt/sdb/qemu/monitor/qmp-cmds.c:173
>>      #5 0x5573c727cb1e in qmp_marshal_cont qapi/qapi-commands-misc.c:835
>>      #6 0x5573c7694c7a in do_qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:132
>>      #7 0x5573c7694c7a in qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:175
>>      #8 0x5573c71d9110 in monitor_qmp_dispatch /mnt/sdb/qemu/monitor/qmp.c:145
>>      #9 0x5573c71dad4f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu/monitor/qmp.c:234
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>   target/i386/cpu.h | 1 +
>>   target/i386/kvm.c | 5 ++++-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index e818fc712a..afbd11b7a3 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1631,6 +1631,7 @@ struct X86CPU {
>>         CPUNegativeOffsetState neg;
>>       CPUX86State env;
>> +    VMChangeStateEntry *vmsentry;
>>         uint64_t ucode_rev;
>>   diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 4901c6dd74..ff2848357e 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1770,7 +1770,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>           }
>>       }
>>   -    qemu_add_vm_change_state_handler(cpu_update_state, env);
>> +    cpu->vmsentry = qemu_add_vm_change_state_handler(cpu_update_state, env);
>>         c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
>>       if (c) {
>> @@ -1883,6 +1883,9 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>>           env->nested_state = NULL;
>>       }
>>   +    qemu_del_vm_change_state_handler(cpu->vmsentry);
>> +    cpu->vmsentry = NULL;
> 
> Why set it to NULL? there is no non-NULL check.
> 
> Anyway if it matters to you, why not do it in qemu_del_vm_change_state_handler()?

Yes, there is no non-NULL check and it will not be NULL at all.

Actually it doesn't matters to me, just habitually set to null after free.

I will remove it.

Thanks.

> 
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> +
>>       return 0;
>>   }
>>  
> 
> .

