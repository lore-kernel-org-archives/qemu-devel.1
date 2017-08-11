Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dg39e-0005Dr-6p
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dg39b-0001Kn-8N
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:10:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:48450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dg39a-00015Q-V4
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:10:39 -0400
References: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
	<20170810102649.GF12980@redhat.com>
	<00cb01a4-5c27-fc69-d3ae-0653aa54b121@intel.com>
	<20170810124102.GA21850@flask>
	<20170810181648.GC3108@localhost.localdomain>
	<20170810192207.GA22459@flask>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <a4b72fef-3fc3-787f-fb7e-6e8d9ee96396@intel.com>
Date: Fri, 11 Aug 2017 14:07:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170810192207.GA22459@flask>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net, Igor Mammedov <imammedo@redhat.com>

On 2017年08月11日 03:22, Radim Krčmář wrote:
> 2017-08-10 15:16-0300, Eduardo Habkost:
>> On Thu, Aug 10, 2017 at 02:41:03PM +0200, Radim Krčmář wrote:
>>> 2017-08-10 19:02+0800, Lan Tianyu:
>>>> On 2017年08月10日 18:26, Daniel P. Berrange wrote:
>>>>> On Thu, Aug 10, 2017 at 06:08:07PM +0800, Lan Tianyu wrote:
>>>>>> Intel Xeon phi chip will support 352 logical threads. For HPC
>>>>>> usage case, it will create a huge VM with vcpus number as same as host
>>>>>> cpus. This patch is to increase max vcpu number to 352.
>>>>>
>>>>> If we pick arbitray limits based on size of physical CPUs that happen
>>>>> to be shipping today, we'll continue the cat+mouse game forever trailing
>>>>> latest CPUs that vendors ship.
>>>>>
>>>>> IMHO we should pick a higher number influenced by technical constraints
>>>>> of the q35 impl instead. eg can we go straight to something like 512 or
>>>>> 1024  ?
>>>>
>>>> Sure. 512 should be enough and some arrays is defined according to max
>>>> vcpu number.
>>>
>>> Hm, which arrays are that?  I was thinking it is safe to bump it to
>>> INT_MAX as the number is only used when setting global max_cpus.
>>
>> We had a MAX_CPUMASK_BITS macro, and bitmaps whose sizes were
>> defined at compile time based on it.  But commit
>> cdda2018e3b9ce0c18938767dfdb1e05a05b67ca removed it.  Probably
>> those arrays all use max_cpus, by now (and the default for
>> max_cpus is smp_cpus, not MachineClass::max_cpus).
> 
> Ah, thanks.
> 
>> Anyway, if we set it to INT_MAX, there are some cases where more
>> appropriate error checking/reporting could be required because
>> they won't handle overflow very well:
>> * pcms->apic_id_limit initialization at pc_cpus_init()
>> * ACPI code that assumes possible_cpus->cpus[i].arch_id fits
>>   in a 32-bit integer
>> * Other x86_cpu_apic_id_from_index() calls in PC code
>>   (especially the initialization of possible_cpus->cpus[i].arch_id).
>>   Note that x86_cpu_apic_id_from_index(cpu_index) might not fit
>>   in 32 bits even if cpu_index <= UINT32_MAX.
> 
> Good point, looks like it all comes to x86_cpu_apic_id_from_index().
> Each level of the topology has at most one underutilized bit, so
> 2^(32 - 3) would be safe.
> 
> It is still needlessly large for the foreseeable future, but 512 is
> going to be surpassed pretty soon, so I think that jumping at least to
> 8k would be better.
> (8k the current default maximum for Linux and the resulting overcommit
>  of ~20 is bearable for smoke testing on current hardware.)
> 

Hi All:
	Thanks for your input. I tried Qemu with 8192 as max_vcpu and it works
normally. I will update patches.

-- 
Best regards
Tianyu Lan
