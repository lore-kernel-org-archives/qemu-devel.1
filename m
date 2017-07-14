Received: from eggs.gnu.org ([2001:4830:134:3::10]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dW10L-0000Vx-Le
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dW10I-0000gg-FV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:51:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dW10I-0000fi-5T
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:51:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EDpCqU024742
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:51:33 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpsncd9fv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:51:31 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 14 Jul 2017 10:50:16 -0300
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<8b7aefb2-66e3-bc2b-ce13-11b130c85ce4@linux.vnet.ibm.com>
	<20170713005740.GR4083@umbus.fritz.box>
	<901df6de-ffc8-1b01-3f8d-37e30f852799@linux.vnet.ibm.com>
	<20170714065316.GB17539@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 14 Jul 2017 10:50:06 -0300
MIME-Version: 1.0
In-Reply-To: <20170714065316.GB17539@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9308b227-ed59-caf0-eb41-608d37b8ed30@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv2 0/8] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com



On 07/14/2017 03:53 AM, David Gibson wrote:
> On Thu, Jul 13, 2017 at 07:13:23AM -0300, Daniel Henrique Barboza wrote=
:
>>
>> On 07/12/2017 09:57 PM, David Gibson wrote:
>>> On Wed, Jul 12, 2017 at 10:48:38AM -0300, Daniel Henrique Barboza wro=
te:
>>>> The dreaded Libvirt hotplug-migrate-hotunplug scenario is working ni=
cely.
>>> Good to hear.
>>>
>>>> device_add when the machine is in RUN_STATE_PRELAUNCH (-S) still doe=
sn't
>>>> work but it is expected - as discussed in "[RFC drcVI PATCH] spapr: =
reset
>>>> DRCs
>>>> on migration pre_load=E2=80=8B", this scenario can't be fixed solely=
 by this DRC
>>>> cleanup.
>>> Hmm.. what's the exact test case you're using here?  The prelaunch
>>> case I tried _did_ work (queueing the event during prelaunch, then
>>> completing the hotplug sequence once the guest had booted).
>> This is the test case:
>>
>> sudo ./qemu-system-ppc64 -name migrate_qemu -boot strict=3Don --enable=
-kvm
>> -device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0xf -device
>> spapr-vscsi,id=3Dscsi0,reg=3D0x2000 -smp 1,maxcpus=3D4,sockets=3D4,cor=
es=3D1,threads=3D1
>> --machine pseries,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m
>> 4G,slots=3D32,maxmem=3D32G -drive file=3D/home/danielhb/vm_imgs/ubuntu=
1704.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone
>> -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive=
-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
>> -nographic -S
>> QEMU 2.9.50 monitor - type 'help' for more information
>> (qemu)
>> (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
>> (qemu) cont
>>
>> (...)
>>
>> After OS boots:
>>
>> danielhb@ubuntu1704:~$ lscpu
>> Architecture:          ppc64le
>> Byte Order:            Little Endian
>> CPU(s):                1
>> On-line CPU(s) list:   0
>> Thread(s) per core:    1
>> Core(s) per socket:    1
>> Socket(s):             1
>> NUMA node(s):          1
>> Model:                 2.1 (pvr 004b 0201)
>> Model name:            POWER8E (raw), altivec supported
>> Hypervisor vendor:     horizontal
>> Virtualization type:   full
>> L1d cache:             64K
>> L1i cache:             32K
>> NUMA node0 CPU(s):     0
>> danielhb@ubuntu1704:~$ (qemu)
>> (qemu) info cpus
>> * CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D6134
>>    CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D6163
>> (qemu) info hotpluggable-cpus
>> Hotpluggable CPUs:
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    CPUInstance Properties:
>>      core-id: "3"
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    CPUInstance Properties:
>>      core-id: "2"
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    qom_path: "/machine/peripheral/core1"
>>    CPUInstance Properties:
>>      core-id: "1"
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    qom_path: "/machine/unattached/device[0]"
>>    CPUInstance Properties:
>>      core-id: "0"
>> (qemu)
> Huh.  I tried basically the same thing, and I get the second cpu once
> the OS is booted.  My first guess would be that the difference is in
> the guest (mine is RHEL 7.3).  Have you double checked that rtas_errd
> and drmgr are present in your guest?

Yeah the guest has drmgr and rtas_errd running. As you said, there might =
be
something different in the guests that explains why yours work and mine=20
doesn't.
Coupling that with the fact that this is not a common usage, I believe we
can leave it as a FYI/reminder if we need to revisit this issue in the
future.


Daniel

>
>> I am not aware of anyone (e.g. Libvirt) using device_add at that point=
 so
>> it's not
>> urgent to make this work AFAIC. I was just curious of why it
>> doesn't.
> Hm, I thought libvirt did use device_add here in at least some
> circumstances.
>
> I've gone ahead and sent a pull req with the changes, since AFAICT his
> is not a regression, so the DRC cleanups still improve matters
> overall.
>
