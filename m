Received: from eggs.gnu.org ([2001:4830:134:3::10]:43675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecKeL-0005rU-58
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 19:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecKeH-0005fu-Si
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 19:35:17 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:44757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ecKeH-0005ey-Dw
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 19:35:13 -0500
Received: by mail-pf0-x236.google.com with SMTP id m26so39060pfj.11
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 16:35:12 -0800 (PST)
References: <20171205205409.5348.53070.stgit@gimli.home>
	<9519f733-ddb1-beea-830b-4c9cda69ca67@ozlabs.ru>
	<20171205183039.5fe06906@t450s.home>
	<f74132ca-9144-d152-c5ca-67373347ce2b@ozlabs.ru>
	<20180118151504.6f634582@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <de0a294b-8c72-f71e-fff4-ccc8402b6ba8@ozlabs.ru>
Date: Fri, 19 Jan 2018 11:35:06 +1100
MIME-Version: 1.0
In-Reply-To: <20180118151504.6f634582@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] vfio: Fix vfio-kvm group
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com

On 19/01/18 09:15, Alex Williamson wrote:
> On Thu, 18 Jan 2018 20:29:48 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 06/12/17 12:30, Alex Williamson wrote:
>>> On Wed, 6 Dec 2017 12:02:01 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>   
>>>> On 06/12/17 08:09, Alex Williamson wrote:  
>>>>> Commit 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container
>>>>> attaching") moved registration of groups with the vfio-kvm device from
>>>>> vfio_get_group() to vfio_connect_container(), but it missed the case
>>>>> where a group is attached to an existing container and takes an early
>>>>> exit.  Perhaps this is a less common case on ppc64/spapr, but on x86
>>>>> (without viommu) all groups are connected to the same container and
>>>>> thus only the first group gets registered with the vfio-kvm device.
>>>>> This becomes a problem if we then hot-unplug the devices associated
>>>>> with that first group and we end up with KVM being misinformed about
>>>>> any vfio connections that might remain.  Fix by including the call to
>>>>> vfio_kvm_device_add_group() in this early exit path.
>>>>>
>>>>> Fixes: 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container attaching")
>>>>> Cc: qemu-stable@nongnu.org # qemu-2.10+
>>>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>>>> ---
>>>>>
>>>>> This bug also existed in QEMU 2.10, but I think the fix is sufficiently
>>>>> obvious (famous last words) to propose for 2.11 at this late date.  If
>>>>> the first group is hot unplugged then KVM may revert to code emulation
>>>>> that assumes no non-coherent DMA is present on some systems.  Also for
>>>>> KVMGT, if the vGPU is not the first device registered, then the
>>>>> notifier to enable linkages to KVM would not be called.  Please review.    
>>>>
>>>> For what it is worth
>>>>
>>>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
>>>
>>> Thanks!
>>>   
>>>> Sorry for the breakage...
>>>>
>>>> One question - how was this discovered? I'd love to set up a test
>>>> environment on my old thinkpad x230 if possible.  
>>>
>>> Assign two devices from separate iommu groups, hot unplug the first
>>> device, followed by the second device.  The second unplug will trigger:
>>>
>>> qemu-kvm: Failed to remove group ## from KVM VFIO device: No such file or directory
>>>
>>> Laptops don't have many devices and we're not good about keeping up
>>> with ACS quirks on laptop chipsets, so it might be difficult to find
>>> the prerequisite setup there.  Thanks,  
>>
>> Tried the laptop, these worked:
>>
>> 03:00.0 Network controller: Intel Corporation Centrino Advanced-N 6205
>> [Taylor Peak] (rev 34)
>> 00:1a.0 USB controller: Intel Corporation 7 Series/C216 Chipset Family USB
>> Enhanced Host Controller #2 (rev 04)
> 
> Worked as in reproduced the issue above?


Nah, that issue I reproduced on a powerpc box.


> 
>> However VGA did not.
>>
>> $ lspci -nns 00:02.0
>> 00:02.0 VGA compatible controller [0300]: Intel Corporation 3rd Gen Core
>> processor Graphics Controller [8086:0166] (rev 09)
>>
>> I run like this:
>>
>> pbuild/qemu-localhost-x86_64/x86_64-softmmu/qemu-system-x86_64 \
>> -enable-kvm -m 2G \
>> -netdev "tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0" \
>> -device "virtio-net-pci,id=vnet0,mac=C0:41:49:4b:00:32,netdev=TAP0" \
>> virtimg/fc27-32GB.qcow2 -nodefaults \
>> -chardev stdio,id=STDIO0,signal=off,mux=on \
>> -device isa-serial,id=isa-serial0,chardev=STDIO0 \
>> -mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
>> -snapshot \
>> -device "vfio-pci,id=vfio0000_00_02_0,host=0000:00:02.0"
>>
>> and it crashes pretty soon, I suppose, as @pc does not change:
>>
>> (qemu) info cpus
>> * CPU #0: pc=0x00000000000c5afa thread_id=4024
>> (qemu) info cpus
>> * CPU #0: pc=0x00000000000c5afa thread_id=4024
>>
>> and it does not seem to reach seabios or it does and seabios is
>> initializing VGA - hard to tell, without any VGA - seabios prints messages
>> to the console and shows grub. Is there any trick to try? Not big deal if
>> none, just curious. Thanks.
> 
> Intel graphics is very "special", see docs/igd-assign.txt.  If your
> goal is just to have one more device to assign that isn't too much
> trouble, walk away slowly ;)  Minimally you'll need to decide if you're
> trying to get legacy mode or UPT mode working (see doc), the former
> needs to have the device at guest address 00:02.0.  The latter doesn't
> technically support output to the display, but can be coaxed to work
> with the x-igd-opregion option, but Intel is pretty fickle about
> whether they actually care if this works, so YMMV.  Thanks,

Wow.

Anyway, this worked - I can see few boot prints (not many as console=ttyS0)
and eventually the fedora login screen.

pbuild/qemu-localhost-x86_64/x86_64-softmmu/qemu-system-x86_64 \
-enable-kvm -m 2G \
-netdev "tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0" \
-device \
"virtio-net-pci,id=vnet0,bus=pci.0,addr=8.0,mac=C0:41:49:4b:00:32,netdev=TAP0"
\
virtimg/fc27-32GB.qcow2 -nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device isa-serial,id=isa-serial0,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
-snapshot \
-device \
vfio-pci-igd-lpc-bridge,id=vfio-pci-igd-lpc-bridge0,bus=pci.0,addr=1f.0 \
-device \
"vfio-pci,id=vfio0000_00_02_0,host=0000:00:02.0,bus=pci.0,addr=2.0"


In the guest:

[aik@aiktest50 ~]$ lspci
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 09)
00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:01.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor
Graphics Controller (rev 09)
00:08.0 Ethernet controller: Red Hat, Inc. Virtio network device
00:1f.0 ISA bridge: Intel Corporation QM77 Express Chipset LPC Controller
(rev 04)

Good, thanks.


The problem I see now is if I ever run QEMU + VFIO with that IGD, I cannot
reload vfio_pci module. It must be unrelated but if I do not do IGD
passthru, then I do not see it. This is my python script output, pretty
straightforward:

[aik@balbir ~]$ s/pci/bind 0:00:02.0 unbind
Call: ['sudo', 'bash', '-c', "echo '0000:00:02.0' >
'/sys/bus/pci/devices/0000:00:02.0/driver/unbind'"]
[aik@balbir ~]$ s/pci/bind 0:00:02.0 rebind
Succeeded: echo "0000:00:02.0" > /sys/bus/pci/drivers/i915/bind
[aik@balbir ~]$ sudo rmmod vfio_pci vfio_virqfd vfio_iommu_type1 vfio
[aik@balbir ~]$ lsmod | grep vfio
[aik@balbir ~]$ s/pci/bind 0:00:02.0
Link=/sys/bus/pci/devices/0000:00:02.0/iommu_group
Call: ['sudo', 'bash', '-c', "echo '0000:00:02.0' >
'/sys/bus/pci/devices/0000:00:02.0/driver/unbind'"]
Cmd: bash -c lsmod
Call: ['sudo', 'bash', '-c', 'modprobe vfio_pci']

Message from syslogd@localhost at Jan 19 11:29:12 ...
 kernel:NMI watchdog: Watchdog detected hard LOCKUP on cpu 2

Message from syslogd@localhost at Jan 19 11:29:12 ...
 kernel:watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [modprobe:2065]

Does this look familiar, before I decide I really want to dig further?


Another question - how do you configure input (keyboard, mouse) for a guest
with IGD?


-- 
Alexey
