Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fv2Ju-0007HQ-AB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fv2Jq-0001s1-6i
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:23:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fv2Jp-0001qy-UM
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:23:42 -0400
References: <1535368030-214556-1-git-send-email-imammedo@redhat.com>
	<20180827160239.54cc993a@bahia.lan>
	<20180828005237.GC2222@umbus.fritz.box>
	<20180828151848.3d09ca06@redhat.com>
	<20180829025440.GE2222@umbus.fritz.box>
	<20180829104311.5ea1a69e@redhat.com>
	<20180829091453-mutt-send-email-mst@kernel.org>
	<20180829155138.5e9af6af@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b428030a-f632-b6eb-910e-08bb6d02ac2c@redhat.com>
Date: Wed, 29 Aug 2018 17:23:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180829155138.5e9af6af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: make sure that guest isn't able to
 unplug the first cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, cohuck@redhat.com, david@redhat.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, pbonzini@redhat.com

On 08/29/18 15:51, Igor Mammedov wrote:
> On Wed, 29 Aug 2018 09:15:53 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Wed, Aug 29, 2018 at 10:43:11AM +0200, Igor Mammedov wrote:
>>> On Wed, 29 Aug 2018 12:54:40 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>   
>>>> On Tue, Aug 28, 2018 at 03:18:48PM +0200, Igor Mammedov wrote:  
>>>>> On Tue, 28 Aug 2018 10:52:37 +1000
>>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>>     
>>>>>> On Mon, Aug 27, 2018 at 04:02:39PM +0200, Greg Kurz wrote:    
>>>>>>> On Mon, 27 Aug 2018 13:07:10 +0200
>>>>>>> Igor Mammedov <imammedo@redhat.com> wrote:
>>>>>>>       
>>>>>>>> The first cpu unplug wasn't ever supported and corresponding
>>>>>>>> monitor/qmp commands refuse to unplug it. However guest is able
>>>>>>>> to issue eject request either using following command:
>>>>>>>>   # echo 1 >/sys/devices/system/cpu/cpu0/firmware_node/eject      
>>>>>>>
>>>>>>> I can't reproduce the issue with a pc guest and current master...
>>>>>>>
>>>>>>> All I seem to get is an error in dmesg:
>>>>>>>
>>>>>>> [   97.435446] processor cpu0: Offline failed.
>>>>>>>       
>>>>>>>> or directly writing to cpu hotplug registers, which makes
>>>>>>>> qemu crash with SIGSEGV following back trace:
>>>>>>>>
>>>>>>>>    kvm_flush_coalesced_mmio_buffer ()
>>>>>>>>        while (ring->first != ring->last)
>>>>>>>>    ...
>>>>>>>>    qemu_flush_coalesced_mmio_buffer
>>>>>>>>    prepare_mmio_access
>>>>>>>>    flatview_read_continue
>>>>>>>>    flatview_read
>>>>>>>>    address_space_read_full
>>>>>>>>    address_space_rw
>>>>>>>>    kvm_cpu_exec(cpu!0)
>>>>>>>>    qemu_kvm_cpu_thread_fn
>>>>>>>>
>>>>>>>> the reason for which is that ring == KVMState::coalesced_mmio_ring
>>>>>>>> happens to be a part of 1st CPU that was uplugged by guest.
>>>>>>>>
>>>>>>>> Fix it by forbidding 1st cpu unplug from guest side and in addition
>>>>>>>> remove CPU0._EJ0 ACPI method to make clear that unplug of the first
>>>>>>>> CPU is not supported.
>>>>>>>>
>>>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>>>> ---
>>>>>>>> CCing spapr and s390x folks in case targets need to prevent 1st CPU unplug as well
>>>>>>>>       
>>>>>>>
>>>>>>> A spapr guest can _release_ the first cpu by doing something like:
>>>>>>>
>>>>>>> # echo -n "/cpus/PowerPC,POWER8@0" > /sys/devices/system/cpu/release
>>>>>>>
>>>>>>> But AFAIK, this doesn't unplug the cpu from a QEMU standpoint.      
>>>>>>
>>>>>> Unplugging CPU 0 with device_del should be ok too.    
>>>>> Do you mean real unplugging (cpu0 object freed) or just remove request?    
>>>>
>>>> Real unplugging should be possible.  I'm not sure how thorougly it's
>>>> been tested, though.  
>>> Well, common kvm code in qemu seems to be in disagreement with it
>>> as backtrace in this patch shows also usage of first_cpu macro
>>> won't survive such unplug.  
>>
>> Paolo - any take on this? Do we need to make cpu 0 special like this?
> It probably would take a bunch of refactoring to get rid of first_cpu&co
> dependencies and besides of experimenting with cpu0 unplug in guest kernel
> there isn't any other value in it, so it probably not worth the effort.
> 
> On top of that, for pc/q35 machine we would need to select boot cpu
> in some other way (right now it's hardwired to first_cpu).
> 
> It seems that seabios might work if cpu0 isn't present, don't know about OVMF.
> 

Sorry, I have no idea. I'm not aware of any OVMF testing with partially
populated VCPU topologies.

Thanks
Laszlo
