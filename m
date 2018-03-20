Received: from eggs.gnu.org ([2001:4830:134:3::10]:54807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eyFa3-0005TU-CS
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eyFa2-0008HK-JA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:37:27 -0400
Message-ID: <5AB0F254.3050503@huawei.com>
Date: Tue, 20 Mar 2018 19:36:52 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
	<1521530809-11780-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA96qV_f7i_36Yzb-QV7W9SRHKfJpg=rvv3tia2X-Xi7QQ@mail.gmail.com>
In-Reply-To: <CAFEAcA96qV_f7i_36Yzb-QV7W9SRHKfJpg=rvv3tia2X-Xi7QQ@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>



On 2018/3/20 19:22, Peter Maydell wrote:
> On 20 March 2018 at 07:26, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> While we skip the GIC_INTERNAL irqs, we don't change the register offset
>> accordingly. This will overlap the GICR registers value and leave the
>> last GIC_INTERNAL irq's registers out of update.
>>
>> Fix this by skipping the registers banked by GICR.
>>
> 
> I'm still not entirely sure what the underlying problem
> you're trying to fix is...
> 
> Do we fail to correctly migrate a VM without this change?
> Does the code work on some host CPU/GIC implementations but
> not others? Is this just improving efficiency by avoiding
> doing some unnecessary work?
> 
When we reboot a VM and before entering uefi or guest kernel, we expect
all these registers staying at the initial state. But currently these
registers of the last 32 irqs are not reset. For example, the PRIORITY
of irq from 32 to 255 is 0 but the PRIORITY of irq from 256 to 287 is
0xa0(Linux kernel set the PRIORITY to 0xa0 by default).

When migrating a VM, since we don't save and restore the registers of
the last 32 irq, so the PRIORITY is 0 while we expecting 0xa0.
And also it will overlap the PRIORITY of SGIs and PPIs.

We don't fail to migrate a vm since currently we don't use the last 32
irqs in virt machine. But the bug is still there.

Thanks,
-- 
Shannon
