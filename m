Received: from eggs.gnu.org ([2001:4830:134:3::10]:57738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dVb7t-0002ri-EZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dVb7p-0005IQ-76
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:13:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35292
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dVb7p-0005Hz-0U
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:13:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DADZUx067924
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:13:36 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bp1sqjx70-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:13:35 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 07:13:33 -0300
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<8b7aefb2-66e3-bc2b-ce13-11b130c85ce4@linux.vnet.ibm.com>
	<20170713005740.GR4083@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 07:13:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170713005740.GR4083@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <901df6de-ffc8-1b01-3f8d-37e30f852799@linux.vnet.ibm.com>
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
Cc: mdroth@linux.vnet.ibm.com, groug@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com



On 07/12/2017 09:57 PM, David Gibson wrote:
> On Wed, Jul 12, 2017 at 10:48:38AM -0300, Daniel Henrique Barboza wrote=
:
>> The dreaded Libvirt hotplug-migrate-hotunplug scenario is working nice=
ly.
> Good to hear.
>
>> device_add when the machine is in RUN_STATE_PRELAUNCH (-S) still doesn=
't
>> work but it is expected - as discussed in "[RFC drcVI PATCH] spapr: re=
set
>> DRCs
>> on migration pre_load=E2=80=8B", this scenario can't be fixed solely b=
y this DRC
>> cleanup.
> Hmm.. what's the exact test case you're using here?  The prelaunch
> case I tried _did_ work (queueing the event during prelaunch, then
> completing the hotplug sequence once the guest had booted).

This is the test case:

sudo ./qemu-system-ppc64 -name migrate_qemu -boot strict=3Don --enable-kv=
m=20
-device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0xf -device=20
spapr-vscsi,id=3Dscsi0,reg=3D0x2000 -smp=20
1,maxcpus=3D4,sockets=3D4,cores=3D1,threads=3D1 --machine=20
pseries,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 4G,slots=3D32,maxm=
em=3D32G=20
-drive=20
file=3D/home/danielhb/vm_imgs/ubuntu1704.qcow2,format=3Dqcow2,if=3Dnone,i=
d=3Ddrive-virtio-disk0,cache=3Dnone=20
-device=20
virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-virtio-dis=
k0,id=3Dvirtio-disk0,bootindex=3D1=20
-nographic -S
QEMU 2.9.50 monitor - type 'help' for more information
(qemu)
(qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
(qemu) cont

(...)

After OS boots:

danielhb@ubuntu1704:~$ lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                1
On-line CPU(s) list:   0
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          1
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8E (raw), altivec supported
Hypervisor vendor:     horizontal
Virtualization type:   full
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s):     0
danielhb@ubuntu1704:~$ (qemu)
(qemu) info cpus
* CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D6134
   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D6163
(qemu) info hotpluggable-cpus
Hotpluggable CPUs:
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   CPUInstance Properties:
     core-id: "3"
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   CPUInstance Properties:
     core-id: "2"
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   qom_path: "/machine/peripheral/core1"
   CPUInstance Properties:
     core-id: "1"
   type: "host-spapr-cpu-core"
   vcpus_count: "1"
   qom_path: "/machine/unattached/device[0]"
   CPUInstance Properties:
     core-id: "0"
(qemu)


I am not aware of anyone (e.g. Libvirt) using device_add at that point=20
so it's not
urgent to make this work AFAIC. I was just curious of why it doesn't.


Daniel



>
>> Given that we'll review the DT code sometime in the future I guess we =
can
>> postpone the fix for device_adding in pre-launch for that time.
>>
>>
>> Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
>>
>> On 07/12/2017 02:53 AM, David Gibson wrote:
>>> This sixth set of DRC cleanup patches is a complete rework of DRC
>>> state management.  We stop tracking some unnecessary things, and
>>> change the basic state representation to a simpler and more robust
>>> model.
>>>
>>> Many of the patches in this set "break" migration from earlier git
>>> snapshots, but not from any released qemu version.  The previous
>>> migration stream format had multiple problems, so better to fix them
>>> now, before 2.10 is out.
>>>
>>> Although there are certainly more things that can be improved in the
>>> DRC system, with this series we should have a solid foundation for
>>> migrating DRCs - the state trasferred is about as minimal and well
>>> defined as it's possible to be.
>>>
>>> Changes since v1:
>>>     * Rebased onto current tree
>>>     * Added cleanup to unplug path
>>>     * Added restriction of DR-indicator to physical DRCs
>>>     * Included revised version of Laurent's patch to correctly handle
>>>       things "hot" plugged before incoming migration
>>>
>>> David Gibson (7):
>>>     spapr: Remove 'awaiting_allocation' DRC flag
>>>     spapr: Simplify unplug path
>>>     spapr: Refactor spapr_drc_detach()
>>>     spapr: Cleanups relating to DRC awaiting_release field
>>>     spapr: Consolidate DRC state variables
>>>     spapr: Remove sPAPRConfigureConnectorState sub-structure
>>>     spapr: Implement DR-indicator for physical DRCs only
>>>
>>> Laurent Vivier (1):
>>>     spapr: Treat devices added before inbound migration as coldplugge=
d
>>>
>>>    hw/ppc/spapr.c             |  89 +++-------
>>>    hw/ppc/spapr_drc.c         | 399 ++++++++++++++++++++++++---------=
------------
>>>    hw/ppc/spapr_pci.c         |  17 +-
>>>    hw/ppc/trace-events        |   3 +-
>>>    include/hw/ppc/spapr_drc.h |  74 ++++++---
>>>    5 files changed, 301 insertions(+), 281 deletions(-)
>>>
