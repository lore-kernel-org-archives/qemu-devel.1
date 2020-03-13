Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE2B206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE2B206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCZNN-00060W-Vx
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 21:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jCZMo-0005bT-RI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jCZMn-0003h6-HF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:44:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3200 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jCZMn-0003aB-69
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:44:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B1F04DF983B2DAA674EF;
 Fri, 13 Mar 2020 09:43:53 +0800 (CST)
Received: from [10.173.228.124] (10.173.228.124) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 13 Mar
 2020 09:43:45 +0800
Subject: Re: [RFC] cpus: avoid get stuck in pause_all_vcpus
To: Paolo Bonzini <pbonzini@redhat.com>, <rth@twiddle.net>
References: <20200310091443.1326-1-longpeng2@huawei.com>
 <8ed76f64-1a24-a278-51f3-19515e65ff39@redhat.com>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <a6c8eac3-a714-ff6f-2bd6-1fa1d1037a81@huawei.com>
Date: Fri, 13 Mar 2020 09:43:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8ed76f64-1a24-a278-51f3-19515e65ff39@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Peter Maydell <peter.maydell@linaro.org>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel @ nongnu . org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/12 23:28, Paolo Bonzini wrote:
> On 10/03/20 10:14, Longpeng(Mike) wrote:
>> From: Longpeng <longpeng2@huawei.com>
>>
>> We find an issue when repeat reboot in guest during migration, it cause the
>> migration thread never be waken up again.
>>
>> <main loop>                        |<migration_thread>
>>                                    |
>> LOCK BQL                           |
>> ...                                |
>> main_loop_should_exit              |
>>  pause_all_vcpus                   |
>>   1. set all cpus ->stop=true      |
>>      and then kick                 |
>>   2. return if all cpus is paused  |
>>      (by '->stopped == true'), else|
>>   3. qemu_cond_wait [BQL UNLOCK]   |
>>                                    |LOCK BQL
>>                                    |...
>>                                    |do_vm_stop
>>                                    | pause_all_vcpus
>>                                    |  (A)set all cpus ->stop=true
>>                                    |     and then kick
>>                                    |  (B)return if all cpus is paused
>>                                    |     (by '->stopped == true'), else
>>                                    |  (C)qemu_cond_wait [BQL UNLOCK]
>>   4. be waken up and LOCK BQL      |  (D)be waken up BUT wait for  BQL
>>   5. goto 2.                       |
>>  (BQL is still LOCKed)             |
>>  resume_all_vcpus                  |
>>   1. set all cpus ->stop=false     |
>>      and ->stopped=false           |
>> ...                                |
>> BQL UNLOCK                         |  (E)LOCK BQL
>>                                    |  (F)goto B. [but stopped is false now!]
>>                                    |Finally, sleep at step 3 forever.
>>
>>
>> Note: This patch is just for discuss this issue, I'm looking forward to
>>       your suggestions, thanks!
> 
> Thanks Mike,
> 
> the above sketch is really helpful.
> 
> I think the problem is not that pause_all_vcpus() is not pausing hard
> enough; the problem is rather than resume_all_vcpus(), when used outside
> vm_start(), should know about the race and do nothing if it happens.
> 
> Fortunately resume_all_vcpus does not release the BQL so it should be
> enough to test once; translated to code, this would be the patch to fix it:
> 
> diff --git a/cpus.c b/cpus.c
> index b4f8b84b61..1eb7533a91 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1899,6 +1899,10 @@ void resume_all_vcpus(void)
>  {
>      CPUState *cpu;
> 
> +    if (!runstate_is_running()) {
> +        return;
> +    }
> +
Hi Paolo,

The runstate of my above sketch is running, so maybe your patch can fix some
other issues but not mine ?

main_loop_should_exit
  ( *reset* requested )
  pause_all_vcpus
  resume_all_vcpus
  if (!runstate_check(RUN_STATE_RUNNING) &&
          !runstate_check(RUN_STATE_INMIGRATE)) {
      runstate_set(RUN_STATE_PRELAUNCH);
  ...


migration_completion
  vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
    vm_stop ( if runstate_is_running )
      do_vm_stop
        pause_all_vcpus ( if runstate_is_running )


>      qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>      CPU_FOREACH(cpu) {
>          cpu_resume(cpu);
> 
> 
> Thanks,
> 
> Paolo
> 
> .
> 

---
Regards,
Longpeng(Mike)

