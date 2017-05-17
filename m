Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dAtVi-0000Bj-4g
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dAtVe-0000Uu-5Z
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:36:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dAtVa-0000TV-PE
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:36:38 -0400
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
	<B2D15215269B544CADD246097EACE747395C283F@dggeml511-mbx.china.huawei.com>
	<CANRm+CzdnFkTL+sWDv_m6DM135DaOVrT6PCO3TYVEDwTdNHhQg@mail.gmail.com>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <591BFD57.2080204@huawei.com>
Date: Wed, 17 May 2017 15:35:51 +0800
MIME-Version: 1.0
In-Reply-To: <CANRm+CzdnFkTL+sWDv_m6DM135DaOVrT6PCO3TYVEDwTdNHhQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>



On 2017/5/17 13:47, Wanpeng Li wrote:
> Hi Zhoujian,
> 2017-05-17 10:20 GMT+08:00 Zhoujian (jay) <jianjay.zhou@huawei.com>:
>> Hi Wanpeng,
>>
>>>> On 11/05/2017 14:07, Zhoujian (jay) wrote:
>>>>> -        * Scan sptes if dirty logging has been stopped, dropping those
>>>>> -        * which can be collapsed into a single large-page spte.  Later
>>>>> -        * page faults will create the large-page sptes.
>>>>> +        * Reset each vcpu's mmu, then page faults will create the
>>> large-page
>>>>> +        * sptes later.
>>>>>           */
>>>>>          if ((change != KVM_MR_DELETE) &&
>>>>>                  (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>>>>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>>>>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
>>>
>>> This is an unlikely branch(unless guest live migration fails and continue
>>> to run on the source machine) instead of hot path, do you have any
>>> performance number for your real workloads?
>>>
>>
>> Sorry to bother you again.
>>
>> Recently, I have tested the performance before migration and after migration failure
>> using spec cpu2006 https://www.spec.org/cpu2006/, which is a standard performance
>> evaluation tool.
>>
>> These are the results:
>> ******
>>      Before migration the score is 153, and the TLB miss statistics of the qemu process is:
>>      linux-sjrfac:/mnt/zhoujian # perf stat -e dTLB-load-misses,dTLB-loads,dTLB-store-misses, \
>>      dTLB-stores,iTLB-load-misses,iTLB-loads -p 26463 sleep 10
>>
>>      Performance counter stats for process id '26463':
>>
>>             698,938      dTLB-load-misses          #    0.13% of all dTLB cache hits   (50.46%)
>>         543,303,875      dTLB-loads                                                    (50.43%)
>>             199,597      dTLB-store-misses                                             (16.51%)
>>          60,128,561      dTLB-stores                                                   (16.67%)
>>              69,986      iTLB-load-misses          #    6.17% of all iTLB cache hits   (16.67%)
>>           1,134,097      iTLB-loads                                                    (33.33%)
>>
>>        10.000684064 seconds time elapsed
>>
>>      After migration failure the score is 149, and the TLB miss statistics of the qemu process is:
>>      linux-sjrfac:/mnt/zhoujian # perf stat -e dTLB-load-misses,dTLB-loads,dTLB-store-misses, \
>>      dTLB-stores,iTLB-load-misses,iTLB-loads -p 26463 sleep 10
>>
>>      Performance counter stats for process id '26463':
>>
>>             765,400      dTLB-load-misses          #    0.14% of all dTLB cache hits   (50.50%)
>>         540,972,144      dTLB-loads                                                    (50.47%)
>>             207,670      dTLB-store-misses                                             (16.50%)
>>          58,363,787      dTLB-stores                                                   (16.67%)
>>             109,772      iTLB-load-misses          #    9.52% of all iTLB cache hits   (16.67%)
>>           1,152,784      iTLB-loads                                                    (33.32%)
>>
>>        10.000703078 seconds time elapsed
>> ******
>
> Could you comment out the original "lazy collapse small sptes into
> large sptes" codes in the function kvm_arch_commit_memory_region() and
> post the results here?
>

   With the patch below,

diff --git a/source/x86/x86.c b/source/x86/x86.c
index 054a7d3..e0288d5 100644
--- a/source/x86/x86.c
+++ b/source/x86/x86.c
@@ -8548,10 +8548,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
          * which can be collapsed into a single large-page spte.  Later
          * page faults will create the large-page sptes.
          */
-       if ((change != KVM_MR_DELETE) &&
-               (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
-               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
-               kvm_mmu_zap_collapsible_sptes(kvm, new);

         /*
          * Set up write protection and/or dirty logging for the new slot.

   After migration failure the score is 148, and the TLB miss statistics 
of the qemu process is:
   linux-sjrfac:/mnt/zhoujian # perf stat -e 
dTLB-load-misses,dTLB-loads,dTLB-store-misses,dTLB-stores,iTLB-load-misses,iTLB-loads 
-p 12432 sleep 10

  Performance counter stats for process id '12432':

          1,052,697      dTLB-load-misses          #    0.19% of all 
dTLB cache hits   (50.45%)
        551,828,702      dTLB-loads 
                (50.46%)
            147,228      dTLB-store-misses 
                (16.55%)
         60,427,834      dTLB-stores 
                (16.50%)
             93,793      iTLB-load-misses          #    7.43% of all 
iTLB cache hits   (16.67%)
          1,262,137      iTLB-loads 
                (33.33%)

       10.000709900 seconds time elapsed

   Regards,
   Jay Zhou

> Regards,
> Wanpeng Li
>
>>
>> These are the steps:
>> ======
>>   (1) the version of kmod is 4.4.11(with slightly modified) and the version of qemu is 2.6.0
>>      (with slightly modified), the kmod is applied with the following patch according to
>>      Paolo's advice:
>>
>> diff --git a/source/x86/x86.c b/source/x86/x86.c
>> index 054a7d3..75a4bb3 100644
>> --- a/source/x86/x86.c
>> +++ b/source/x86/x86.c
>> @@ -8550,8 +8550,10 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>           */
>>          if ((change != KVM_MR_DELETE) &&
>>                  (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
>> +               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
>> +               printk(KERN_ERR "zj make KVM_REQ_MMU_RELOAD request\n");
>> +               kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
>> +       }
>>
>>          /*
>>           * Set up write protection and/or dirty logging for the new slot.
>>
>> (2) I started up a memory preoccupied 10G VM(suse11sp3), which means its "RES column" in top is 10G,
>>      in order to set up the EPT table in advance.
>> (3) And then, I run the test case 429.mcf of spec cpu2006 before migration and after migration failure.
>>      The 429.mcf is a memory intensive workload, and the migration failure is constructed deliberately
>>      with the following patch of qemu:
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5d725d0..88dfc59 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -625,6 +625,9 @@ static void process_incoming_migration_co(void *opaque)
>>                         MIGRATION_STATUS_ACTIVE);
>>       ret = qemu_loadvm_state(f);
>>
>> +    // deliberately construct the migration failure
>> +    exit(EXIT_FAILURE);
>> +
>>       ps = postcopy_state_get();
>>       trace_process_incoming_migration_co_end(ret, ps);
>>       if (ps != POSTCOPY_INCOMING_NONE) {
>> ======
>>
>>
>> Results of the score and TLB miss rate are almost the same, and I am confused.
>> May I ask which tool do you use to evaluate the performance?
>> And if my test steps are wrong, please let me know, thank you.
>>
>> Regards,
>> Jay Zhou
>>
>>
>>
>>
>>
>
> .
>
