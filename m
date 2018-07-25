Received: from eggs.gnu.org ([2001:4830:134:3::10]:57142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maran.wilson@oracle.com>) id 1fiNYb-0005b8-KH
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maran.wilson@oracle.com>) id 1fiNYY-00029c-Jw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:26:37 -0400
References: <000e01d3afad$b9a13830$2ce3a890$@codeaurora.org>
	<20180227104708.GA11391@cbox>
	<ac329e1b1f5265a805916ab4f8708f9d@codeaurora.org>
	<20180227124604.GA2373@cbox>
	<20180227132131.fipafmnb56a7fj76@kamzik.brq.redhat.com>
	<b589d714-4f12-e450-7ca5-e55fed4d1705@oracle.com>
	<74427c65-b860-d576-04f9-766253285210@arm.com>
	<20180725122806.g2gpvdbrbdkriprg@kamzik.brq.redhat.com>
	<202a2c63-1a3e-7f01-850c-4fb5e48f43e7@arm.com>
From: Maran Wilson <maran.wilson@oracle.com>
Message-ID: <fd9e6f7e-3ede-2f73-effe-cc0d3afce22c@oracle.com>
Date: Wed, 25 Jul 2018 10:26:05 -0700
MIME-Version: 1.0
In-Reply-To: <202a2c63-1a3e-7f01-850c-4fb5e48f43e7@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] VCPU hotplug on KVM/ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>, Andrew Jones <drjones@redhat.com>, imammedo@redhat.com, kvmarm@lists.cs.columbia.edu
Cc: bthakur@codeaurora.org, Christoffer Dall <cdall@cs.columbia.edu>, Christoffer Dall <cdall@kernel.org>, peter.maydell@linaro.org, david@redhat.com, qemu-devel@nongnu.org, Christoffer Dall <christofferdall@christofferdall.dk>, qemu-arm@nongnu.org

Thanks everyone. It sounds like there is consensus around how best to 
proceed (at a high level at least).

Since Igor has already gotten started, I'll coordinate with him offline 
to see where I can jump in.

Thanks,
-Maran

On 7/25/2018 6:07 AM, Marc Zyngier wrote:
> On 25/07/18 13:28, Andrew Jones wrote:
>> On Wed, Jul 25, 2018 at 11:40:54AM +0100, Marc Zyngier wrote:
>>> On 24/07/18 19:35, Maran Wilson wrote:
>>>> It's been a few months since this email thread died off. Has anyone
>>>> started working on a potential solution that would allow VCPU hotplug on
>>>> KVM/ARM ? Or is this a project that is still waiting for an owner who
>>>> has the time and inclination to get started?
>>> This is typically a project for someone who would have this particular
>>> itch to scratch, and who has a demonstrable need for this functionality.
>>>
>>> Work wise, it would have to include adding physical CPU hotplug support
>>> to the arm64 kernel as a precondition, before worrying about doing it in
>>> KVM.
>>>
>>> For KVM itself, particular area of interests would be:
>>> - Making GICv3 redistributors magically appear in the IPA space
>>> - Live resizing of GICv3 structures
>>> - Dynamic allocation of MPIDR, and mapping with vcpu_id
>> I have CPU topology description patches on the QEMU list now[*]. A next
>> step for me is to this MPIDR work. I probably won't get to it until the
>> end of August though.
>>
>> [*] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
>>
>>> This should keep someone busy for a good couple of weeks (give or take a
>>> few months).
>> :-)
>>
>>> That being said, I'd rather see support in QEMU first, creating all the
>>> vcpu/redistributors upfront, and signalling the hotplug event via the
>>> virtual firmware. And then post some numbers to show that creating all
>>> the vcpus upfront is not acceptable.
>> I think the upfront allocation, allocating all possible cpus, but only
>> activating all present cpus, was the planned approach. What were the
>> concerns about that approach? Just vcpu memory overhead for too many
>> overly ambitious VM configs?
> I don't have any ARM-specific concern about that, and I think this is
> the right approach. It has the good property of not requiring much
> change in the kernel (other than actually supporting CPU hotplug).
>
> vcpu memory overhead is a generic concern though, and not only for ARM.
> We currently allow up to 512 vcpus per VM, which looks like a lot, but
> really isn't. If we're to allow this to be bumped up significantly, we
> should start accounting the vcpu-related memory against the user's
> allowance...
>
> Thanks,
>
> 	M.
