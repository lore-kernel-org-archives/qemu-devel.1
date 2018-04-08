Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1f4zU0-0001a1-Al
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 21:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1f4zTz-0003Wp-Eu
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 21:51:04 -0400
Message-ID: <5AC97568.2040502@huawei.com>
Date: Sun, 8 Apr 2018 09:50:32 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
	<1521530809-11780-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA96qV_f7i_36Yzb-QV7W9SRHKfJpg=rvv3tia2X-Xi7QQ@mail.gmail.com>
	<5AB0F254.3050503@huawei.com>
	<CAFEAcA-Ct3qa0OFZ4U+9RH68SQJgmkxJKKS5e+if_MuL2pSu3A@mail.gmail.com>
	<5AB21130.2020309@huawei.com>
	<CAFEAcA8yr+KJFwBSksMP-VjNbsSd190VCzB4wGwOCoaX2ScDiA@mail.gmail.com>
	<CAFEAcA_r=S=YWAuZue1zZnFdtFYK2wU7NnaCcGThZU_u33qD4g@mail.gmail.com>
	<CAFEAcA_JYyHj6NGJahGPQ9p9XQz6rkmhWMfheW96DzkciModDA@mail.gmail.com>
	<CAFEAcA_GwG-80oNHHb1wcJxkzS5YcbH335JHBo48_ksFmgRB7A@mail.gmail.com>
In-Reply-To: <CAFEAcA_GwG-80oNHHb1wcJxkzS5YcbH335JHBo48_ksFmgRB7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 2/2] arm_gicv3_kvm:
 kvm_dist_get/put: skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>



On 2018/4/6 17:36, Peter Maydell wrote:
> On 5 April 2018 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > On 29 March 2018 at 11:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> >> On 23 March 2018 at 12:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> >>> On 21 March 2018 at 08:00, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>>>>> >>>> On 2018/3/20 19:54, Peter Maydell wrote:
>>>>>> >>>>> Can you still successfully migrate a VM from a QEMU version
>>>>>> >>>>> without this bugfix to one with the bugfix ?
>>>>>> >>>>>
>>>>> >>>> I've tested this case. I can migrate a VM between these two versions.
>>>> >>>
>>>> >>> Hmm. Looking at the code I can't see how that would work,
>>>> >>> except by accident. Let me see if I understand what's happening
>>>> >>> here:
>> >
>>> >> I was thinking a bit more about how to handle this, and
>>> >> my best idea was:
>>> >>
>>> >> (1) send something in the migration stream that says
>>> >> "I don't have this bug" (version number change?
>>> >> vmstate field that's just a "no bug" flag? subsection
>>> >> with no contents?)
>>> >>
>>> >> (2) on the destination, if the source doesn't tell us
>>> >> it doesn't have this bug, and we are running KVM, then
>>> >> shift all the data in the arrays down to fix it up
>>> >> [Strictly what we want to know is if the source is
>>> >> running KVM, not if the destination is, but I don't
>>> >> know of a way to find that out, and in practice TCG->KVM
>>> >> migrations don't work anyway, so it's not a big deal.]
>> >
>> > Shannon, are you planning to look at this for 2.12, or should
>> > we postpone it to 2.13? (It's not a regression, right? So
>> > we don't necessarily have to urgently fix it for 2.12.)
> On reflection, I think I'd aim for 2.13 for this, since:
>  * it's not a regression
>  * it doesn't actually affect any of our boards, because
>    none of them define enough interrupt lines that they
>    would actually be using the top 32 that we fail to migrate
>  * getting the migration compat right is a bit tricky and
>    will benefit from having the time for careful review and testing
> 
> Let me know if I'm wrong with any of those assumptions.
Yes, it's no need to merge this for 2.12. I'll respin this patch later.

Thanks,
-- 
Shannon
