Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1d949T-0002hp-9m
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1d949S-0003z4-Am
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:34:11 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:33871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1d949S-0003yT-67
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:34:10 -0400
Received: by mail-oi0-x22d.google.com with SMTP id b204so55586273oii.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 23:34:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE747395ADA61@dggeml511-mbx.china.huawei.com>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
	<CANRm+CwvYa01CLChSOGjG6P0q2_Zybov3ZMSULsCGH5GtmRy8A@mail.gmail.com>
	<B2D15215269B544CADD246097EACE747395ADA61@dggeml511-mbx.china.huawei.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 12 May 2017 14:34:05 +0800
Message-ID: <CANRm+CwLBcs+7rHKj7FCYrDF_o_pYM1wjq0sXi9rOFnXA=C3-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>

2017-05-11 22:18 GMT+08:00 Zhoujian (jay) <jianjay.zhou@huawei.com>:
> Hi Wanpeng,
>
>> 2017-05-11 21:43 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
>> > 2017-05-11 20:24 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>> >>
>> >>
>> >> On 11/05/2017 14:07, Zhoujian (jay) wrote:
>> >>> -        * Scan sptes if dirty logging has been stopped, dropping
>> those
>> >>> -        * which can be collapsed into a single large-page spte.
>> Later
>> >>> -        * page faults will create the large-page sptes.
>> >>> +        * Reset each vcpu's mmu, then page faults will create the
>> large-page
>> >>> +        * sptes later.
>> >>>          */
>> >>>         if ((change != KVM_MR_DELETE) &&
>> >>>                 (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>> >>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>> >>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
>> >
>> > This is an unlikely branch(unless guest live migration fails and
>> > continue to run on the source machine) instead of hot path, do you
>> > have any performance number for your real workloads?
>>
>> I find the original discussion by google.
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg04143.html
>> You will not go to this branch if the guest live migration successfully.
>
>  In our tests, this branch is taken when living migration is successful.
>  AFAIK, the kmod does not know whether living migration successful or not
>  when dealing with KVM_SET_USER_MEMORY_REGION ioctl. Do I miss something?

Original there is a bug which will not clear memslot dirty log flag
after live migration fails, a patch is submitted to fix it,
https://lists.nongnu.org/archive/html/qemu-devel/2015-04/msg00794.html,
however, I can't remember whether the dirty log flag will be cleared
if live migration complete successfully at that time, but maybe not.
Paolo replied to the patch he has a better method. Then I'm too busy
and didn't follow the qemu patch for this fix any more, I just find
this commit is merged currently:
http://git.qemu.org/?p=qemu.git;a=commit;h=6f6a5ef3e429f92f987678ea8c396aab4dc6aa19.
This commit will clear memslot dirty log flag after live migration no
matter whether it is successful or not.

Regards,
Wanpeng Li
