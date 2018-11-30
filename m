Received: from eggs.gnu.org ([2001:4830:134:3::10]:47646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSct9-0001eq-Dd
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gScig-000183-W1
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:56:16 -0500
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:46876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gScig-000126-MS
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:56:10 -0500
Received: from player739.ha.ovh.net (unknown [10.109.143.24])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id F3C9DED541
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:56:08 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-12-clg@kaod.org>
	<20181128023902.GU2251@umbus.fritz.box>
	<dbd8810e-09b9-7344-92d2-faddebf30c10@kaod.org>
	<20181129010047.GM2251@umbus.fritz.box>
	<cde0bf38-a766-deab-8d46-41fa7e776185@kaod.org>
	<20181130011135.GG30479@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bed23f8a-68bb-0f88-54c4-a4dfea085e34@kaod.org>
Date: Fri, 30 Nov 2018 07:56:02 +0100
MIME-Version: 1.0
In-Reply-To: <20181130011135.GG30479@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 11/36] spapr/xive: use the VCPU id as a
 NVT identifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/30/18 2:11 AM, David Gibson wrote:
> On Thu, Nov 29, 2018 at 04:27:31PM +0100, C=E9dric Le Goater wrote:
>> [ ... ]=20
>>
>>>>>> +/*
>>>>>> + * The allocation of VP blocks is a complex operation in OPAL and=
 the
>>>>>> + * VP identifiers have a relation with the number of HW chips, th=
e
>>>>>> + * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
>>>>>> + * controller model does not have the same constraints and can us=
e a
>>>>>> + * simple mapping scheme of the CPU vcpu_id
>>>>>> + *
>>>>>> + * These identifiers are never returned to the OS.
>>>>>> + */
>>>>>> +
>>>>>> +#define SPAPR_XIVE_VP_BASE 0x400
>>>>>
>>>>> 0x400 =3D=3D 1024.  Could we ever have the possibility of needing t=
o
>>>>> consider both physical NVTs and PAPR NVTs at the same time? =20
>>>>
>>>> They would not be in the same CAM line: OS ring vs. PHYS ring.=20
>>>
>>> Hm.  They still inhabit the same NVT number space though, don't they?
>>
>> No. skiboot reserves the range of VPs for the HW at init.
>>
>> https://github.com/open-power/skiboot/blob/master/hw/xive.c#L1093
>=20
> Uh.. I don't see how they're reserved is relevant.
>=20
> What I mean is that the ENDs address the NVTs for HW endpoints by the
> same (block, index) tuples as the NVTs for virtualized endpoints, yes?

Ah. Yes. The (block, index) tuples, fields END_W6_NVT_BLOCK and=20
END_W6_NVT_INDEX in the END structure, are all in the same number space.

skiboot defines some ranges though.


>>> I'm thinking about the END->NVT stage of the process here, rather tha=
n
>>> the NVT->TCTX stage.
>>>
>>> Oh, also, you're using "VP" here which IIUC =3D=3D "NVT".  Can we
>>> standardize on one, please.
>>
>> VP is used in Linux/KVM Linux/Native and skiboot. Yes. it's a mess.=20
>> Let's have consistent naming in QEMU and use NVT.=20
>=20
> Right.  And to cover any inevitable missed ones is why I'd like to see
> a cheatsheet giving both terms in the header comments somewhere.

yes. I have added a list of names in xive.h.=20

I was wondering if I should put the diagram below somewhere in a .h file=20
or under doc/specs/.

Thanks,

C. =20


=3D XIVE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The POWER9 processor comes with a new interrupt controller, called
XIVE as "eXternal Interrupt Virtualization Engine".


* Overall architecture


             XIVE Interrupt Controller
             +------------------------------------+      IPIs
             | +---------+ +---------+ +--------+ |    +-------+
             | |VC       | |CQ       | |PC      |----> | CORES |
             | |     esb | |         | |        |----> |       |
             | |     eas | |  Bridge | |   tctx |----> |       |
             | |SC   end | |         | |    nvt | |    |       |
 +------+    | +---------+ +----+----+ +--------+ |    +-+-+-+-+
 | RAM  |    +------------------|-----------------+      | | |
 |      |                       |                        | | |
 |      |                       |                        | | |
 |      |  +--------------------v------------------------v-v-v--+    othe=
r
 |      <--+                     Power Bus                      +--> chip=
s
 |  esb |  +---------+-----------------------+------------------+
 |  eas |            |                       |
 |  end |        +---|-----+                 |
 |  nvt |       +----+----+|            +----+----+
 +------+       |SC       ||            |SC       |
                |         ||            |         |
                | PQ-bits ||            | PQ-bits |
                | local   |+            |  in VC  |
                +---------+             +---------+
                   PCIe                 NX,NPU,CAPI

                  SC: Source Controller (aka. IVSE)
                  VC: Virtualization Controller (aka. IVRE)
                  PC: Presentation Controller (aka. IVPE)
                  CQ: Common Queue (Bridge)

             PQ-bits: 2 bits source state machine (P:pending Q:queued)
                 esb: Event State Buffer (Array of PQ bits in an IVSE)
                 eas: Event Assignment Structure
                 end: Event Notification Descriptor
                 nvt: Notification Virtual Target
                tctx: Thread interrupt Context


The XIVE IC is composed of three sub-engines :

  - Interrupt Virtualization Source Engine (IVSE), or Source
    Controller (SC). These are found in PCI PHBs, in the PSI host
    bridge controller, but also inside the main controller for the
    core IPIs and other sub-chips (NX, CAP, NPU) of the
    chip/processor. They are configured to feed the IVRE with events.

  - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
    Controller (VC). Its job is to match an event source with an Event
    Notification Descriptor (END).

  - Interrupt Virtualization Presentation Engine (IVPE) or Presentation
    Controller (PC). It maintains the interrupt context state of each
    thread and handles the delivery of the external exception to the
    thread.


* XIVE internal tables

Each of the sub-engines uses a set of tables to redirect exceptions
from event sources to CPU threads.

                                          +-------+
  User or OS                              |  EQ   |
      or                          +------>|entries|
  Hypervisor                      |       |  ..   |
    Memory                        |       +-------+
                                  |           ^
                                  |           |
             +-------------------------------------------------+
                                  |           |
  Hypervisor      +------+    +---+--+    +---+--+   +------+
    Memory        | ESB  |    | EAT  |    | ENDT |   | NVTT |
   (skiboot)      +----+-+    +----+-+    +----+-+   +------+
                    ^  |        ^  |        ^  |       ^
                    |  |        |  |        |  |       |
             +-------------------------------------------------+
                    |  |        |  |        |  |       |
                    |  |        |  |        |  |       |
               +----|--|--------|--|--------|--|-+   +-|-----+    +------=
+
               |    |  |        |  |        |  | |   | | tctx|    |Thread=
|
   IPI or   ---+    +  v        +  v        +  v |---| +  .. |----->     =
|
  HW events    |                                 |   |       |    |      =
|
               |             IVRE                |   | IVPE  |    +------=
+
               +---------------------------------+   +-------+
           =20


The IVSE have a 2-bits, P for pending and Q for queued, state machine
for each source that allows events to be triggered. They are stored in
an array, the Event State Buffer (ESB) and controlled by MMIOs.

If the event is let through, the IVRE looks up in the Event Assignment
Structure (EAS) table for an Event Notification Descriptor (END)
configured for the source. Each Event Notification Descriptor defines
a notification path to a CPU and an in-memory Event Queue, in which
will be pushed an EQ data for the OS to pull.

The IVPE determines if a Notification Virtual Target (NVT) can handle
the event by scanning the thread contexts of the VPs dispatched on the
processor HW threads. It maintains the interrupt context state of each
thread in a NVT table.
