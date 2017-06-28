Received: from eggs.gnu.org ([2001:4830:134:3::10]:42273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dQCCn-0001XB-Ne
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dQCCm-0002ym-Pc
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:36:25 -0400
References: <1498577737-130264-1-git-send-email-agraf@suse.de>
	<20170628115110.nq7wdsrhxxjelzq6@kamzik.brq.redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <9e3a0693-d69b-4ae7-c449-457f7428fbff@suse.de>
Date: Wed, 28 Jun 2017 14:36:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170628115110.nq7wdsrhxxjelzq6@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] ARM: KVM: Enable in-kernel timers with
 user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, cdall@linaro.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 28.06.17 13:51, Andrew Jones wrote:
> On Tue, Jun 27, 2017 at 05:35:37PM +0200, Alexander Graf wrote:
>> When running with KVM enabled, you can choose between emulating the
>> gic in kernel or user space. If the kernel supports in-kernel virtualization
>> of the interrupt controller, it will default to that. If not, if will
>> default to user space emulation.
>>
>> Unfortunately when running in user mode gic emulation, we miss out on
>> interrupt events which are only available from kernel space, such as the timer.
>> This patch leverages the new kernel/user space pending line synchronization for
>> timer events. It does not handle PMU events yet.
>>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>>
>>    - whitespace fixes
>>    - use !! to determine whether bit is set
>>    - call in-kernel device IRQs out by their name everywhere
>>
>> v2 -> v3:
>>
>>    - fix last occurence of calling out timer IRQs explicitly
>> ---
>>   accel/kvm/kvm-all.c    |  5 +++++
>>   accel/stubs/kvm-stub.c |  5 +++++
>>   hw/intc/arm_gic.c      |  7 +++++++
>>   include/sysemu/kvm.h   | 11 +++++++++++
>>   target/arm/cpu.h       |  3 +++
>>   target/arm/kvm.c       | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 82 insertions(+)
>>
> 
> Tried testing this on a gicv3 machine, a ThunderX2. The guest kernel

Did you patch QEMU to automatically choose the gic version? The upstream 
default is to have gicv2 as the guest gic type. And gicv2 should work 
just fine.

I have seen issues with gicv3 emulation in user space, yes. I guess we 
don't have a channel to properly trap the MSRs into user space yet.


Alex
