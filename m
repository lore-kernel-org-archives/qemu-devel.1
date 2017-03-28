Received: from eggs.gnu.org ([2001:4830:134:3::10]:43597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csurM-0008CX-WF
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csurM-0004A7-6s
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:24:44 -0400
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-6-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA-wQwM=g-geopcn+9Y28UL22ugTWKwUOqmdbV=YD5Q1Rg@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <f25cd84c-30d4-5e57-aec5-dd37b84a1a6f@suse.de>
Date: Tue, 28 Mar 2017 19:24:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wQwM=g-geopcn+9Y28UL22ugTWKwUOqmdbV=YD5Q1Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 5/5] hw/intc/arm_gicv3_kvm: Reset GICv3
 cpu interface registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Vijay Kilari <vijay.kilari@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Pavel Fedin <p.fedin@samsung.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>, Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>

On 02/23/2017 07:37 PM, Peter Maydell wrote:
> On 23 February 2017 at 11:51,  <vijay.kilari@gmail.com> wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>
>> Reset CPU interface registers of GICv3 when CPU is reset.
>> For this, ARMCPRegInfo struct is registered with one ICC
>> register whose resetfn is called when cpu is reset.
>>
>> All the ICC registers are reset under one single register
>> reset function instead of calling resetfn for each ICC
>> register.
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>> ---
>>   hw/intc/arm_gicv3_kvm.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This patch breaks execution on 4.4 (SLES12 SP2) for me:

$ ./aarch64-softmmu/qemu-system-aarch64 -nographic -M 
virt,gic-version=host -enable-kvm -cpu host -kernel /boot/Image
qemu-system-aarch64: KVM_GET_DEVICE_ATTR failed: No such device or address
Group 6 attr 0x000000000000c664
Aborted (core dumped)

If I revert it, it works again. Is that device attr something only newer 
kernels received? In that case, it needs to be guarded by a capability 
check.


Alex
