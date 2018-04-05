Received: from eggs.gnu.org ([2001:4830:134:3::10]:47782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f45mj-00027O-9o
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f45mi-000427-8g
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:22:41 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f45mi-00041a-2p
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:22:40 -0400
Received: by mail-ot0-x232.google.com with SMTP id n40-v6so27353053otd.3
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 07:22:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_r=S=YWAuZue1zZnFdtFYK2wU7NnaCcGThZU_u33qD4g@mail.gmail.com>
References: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
	<1521530809-11780-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA96qV_f7i_36Yzb-QV7W9SRHKfJpg=rvv3tia2X-Xi7QQ@mail.gmail.com>
	<5AB0F254.3050503@huawei.com>
	<CAFEAcA-Ct3qa0OFZ4U+9RH68SQJgmkxJKKS5e+if_MuL2pSu3A@mail.gmail.com>
	<5AB21130.2020309@huawei.com>
	<CAFEAcA8yr+KJFwBSksMP-VjNbsSd190VCzB4wGwOCoaX2ScDiA@mail.gmail.com>
	<CAFEAcA_r=S=YWAuZue1zZnFdtFYK2wU7NnaCcGThZU_u33qD4g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 15:22:12 +0100
Message-ID: <CAFEAcA_JYyHj6NGJahGPQ9p9XQz6rkmhWMfheW96DzkciModDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 29 March 2018 at 11:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 March 2018 at 12:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 21 March 2018 at 08:00, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>>> On 2018/3/20 19:54, Peter Maydell wrote:
>>>> Can you still successfully migrate a VM from a QEMU version
>>>> without this bugfix to one with the bugfix ?
>>>>
>>> I've tested this case. I can migrate a VM between these two versions.
>>
>> Hmm. Looking at the code I can't see how that would work,
>> except by accident. Let me see if I understand what's happening
>> here:

> I was thinking a bit more about how to handle this, and
> my best idea was:
>
> (1) send something in the migration stream that says
> "I don't have this bug" (version number change?
> vmstate field that's just a "no bug" flag? subsection
> with no contents?)
>
> (2) on the destination, if the source doesn't tell us
> it doesn't have this bug, and we are running KVM, then
> shift all the data in the arrays down to fix it up
> [Strictly what we want to know is if the source is
> running KVM, not if the destination is, but I don't
> know of a way to find that out, and in practice TCG->KVM
> migrations don't work anyway, so it's not a big deal.]

Shannon, are you planning to look at this for 2.12, or should
we postpone it to 2.13? (It's not a regression, right? So
we don't necessarily have to urgently fix it for 2.12.)

thanks
-- PMM
