Received: from eggs.gnu.org ([2001:4830:134:3::10]:43219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTr7Q-0007Sp-Bl
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTr7L-00046Z-CM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:30:48 -0500
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:39211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gTr7L-00046B-5w
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:30:43 -0500
Received: from player774.ha.ovh.net (unknown [10.109.143.146])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 5EEA6EE0A8
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 17:30:41 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-12-clg@kaod.org>
	<20181128023902.GU2251@umbus.fritz.box>
	<dbd8810e-09b9-7344-92d2-faddebf30c10@kaod.org>
	<20181129010047.GM2251@umbus.fritz.box>
	<cde0bf38-a766-deab-8d46-41fa7e776185@kaod.org>
	<20181130011135.GG30479@umbus.fritz.box>
	<bed23f8a-68bb-0f88-54c4-a4dfea085e34@kaod.org>
	<20181203011812.GQ30479@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8752cd19-cc18-5dbc-dd5a-2bcf2db63332@kaod.org>
Date: Mon, 3 Dec 2018 17:30:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181203011812.GQ30479@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

>>>>> I'm thinking about the END->NVT stage of the process here, rather than
>>>>> the NVT->TCTX stage.
>>>>>
>>>>> Oh, also, you're using "VP" here which IIUC == "NVT".  Can we
>>>>> standardize on one, please.
>>>>
>>>> VP is used in Linux/KVM Linux/Native and skiboot. Yes. it's a mess. 
>>>> Let's have consistent naming in QEMU and use NVT. 
>>>
>>> Right.  And to cover any inevitable missed ones is why I'd like to see
>>> a cheatsheet giving both terms in the header comments somewhere.
>>
>> yes. I have added a list of names in xive.h. 
> 
> Great.  Oh BTW - this is getting big enough, that I wonder if it makes
> sense to create a hw/intc/xive subdir to put things in, then splitting
> IVSE, IVRE, IVPE related code into separate .c files (I'd still expect
> a common .h though).

Here is what I have for now, for the new files only :

   190 include/hw/ppc/xive_regs.h
   343 include/hw/ppc/xive.h
    78 include/hw/ppc/spapr_xive.h
  1453 hw/intc/spapr_xive.c (sPAPRXive + hcalls)
  1678 hw/intc/xive.c       (XiveSource, XiveRouter, XiveENDSource, XiveTCTX, 
			     END helpers)
   864 hw/intc/spapr_xive_kvm.c
  4606 total

I am putting the KVM export definitions in spapr_xive.h and xive.h but all 
the code is in spapr_xive_kvm.c.

So you would rather have something like :
 
   include/hw/ppc/xive_regs.h
   include/hw/ppc/xive.h
   include/hw/ppc/spapr_xive.h

   hw/intc/xive/spapr.c 
   hw/intc/xive/spapr_kvm.c 
   hw/intc/xive/source.c 
   hw/intc/xive/router.c 
   hw/intc/xive/presenter.c 
   hw/intc/xive/tcontext.c 

>> I was wondering if I should put the diagram below somewhere in a .h file 
>> or under doc/specs/.
> 
> I'd prefer it in the .h file.

OK. will do in  xive.h
 
>>
>> Thanks,
>>
>> C.  
>>
>>
>> = XIVE =================================================================
>>
>> The POWER9 processor comes with a new interrupt controller, called
>> XIVE as "eXternal Interrupt Virtualization Engine".
>>
>>
>> * Overall architecture
>>
>>
>>              XIVE Interrupt Controller
>>              +------------------------------------+      IPIs
>>              | +---------+ +---------+ +--------+ |    +-------+
>>              | |VC       | |CQ       | |PC      |----> | CORES |
>>              | |     esb | |         | |        |----> |       |
>>              | |     eas | |  Bridge | |   tctx |----> |       |
>>              | |SC   end | |         | |    nvt | |    |       |
>>  +------+    | +---------+ +----+----+ +--------+ |    +-+-+-+-+
>>  | RAM  |    +------------------|-----------------+      | | |
>>  |      |                       |                        | | |
>>  |      |                       |                        | | |
>>  |      |  +--------------------v------------------------v-v-v--+    other
>>  |      <--+                     Power Bus                      +--> chips
>>  |  esb |  +---------+-----------------------+------------------+
>>  |  eas |            |                       |
>>  |  end |        +---|-----+                 |
>>  |  nvt |       +----+----+|            +----+----+
>>  +------+       |SC       ||            |SC       |
>>                 |         ||            |         |
>>                 | PQ-bits ||            | PQ-bits |
>>                 | local   |+            |  in VC  |
>>                 +---------+             +---------+
>>                    PCIe                 NX,NPU,CAPI
>>
>>                   SC: Source Controller (aka. IVSE)
>>                   VC: Virtualization Controller (aka. IVRE)
>>                   PC: Presentation Controller (aka. IVPE)
>>                   CQ: Common Queue (Bridge)
>>
>>              PQ-bits: 2 bits source state machine (P:pending Q:queued)
>>                  esb: Event State Buffer (Array of PQ bits in an IVSE)
>>                  eas: Event Assignment Structure
>>                  end: Event Notification Descriptor
>>                  nvt: Notification Virtual Target
>>                 tctx: Thread interrupt Context
>>
>>
>> The XIVE IC is composed of three sub-engines :
>>
>>   - Interrupt Virtualization Source Engine (IVSE), or Source
>>     Controller (SC). These are found in PCI PHBs, in the PSI host
>>     bridge controller, but also inside the main controller for the
>>     core IPIs and other sub-chips (NX, CAP, NPU) of the
>>     chip/processor. They are configured to feed the IVRE with events.
>>
>>   - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
>>     Controller (VC). Its job is to match an event source with an Event
>>     Notification Descriptor (END).
>>
>>   - Interrupt Virtualization Presentation Engine (IVPE) or Presentation
>>     Controller (PC). It maintains the interrupt context state of each
>>     thread and handles the delivery of the external exception to the
>>     thread.
>>
>>
>> * XIVE internal tables
>>
>> Each of the sub-engines uses a set of tables to redirect exceptions
>> from event sources to CPU threads.
>>
>>                                           +-------+
>>   User or OS                              |  EQ   |
>>       or                          +------>|entries|
>>   Hypervisor                      |       |  ..   |
>>     Memory                        |       +-------+
>>                                   |           ^
>>                                   |           |
>>              +-------------------------------------------------+
>>                                   |           |
>>   Hypervisor      +------+    +---+--+    +---+--+   +------+
>>     Memory        | ESB  |    | EAT  |    | ENDT |   | NVTT |
>>    (skiboot)      +----+-+    +----+-+    +----+-+   +------+
>>                     ^  |        ^  |        ^  |       ^
>>                     |  |        |  |        |  |       |
>>              +-------------------------------------------------+
>>                     |  |        |  |        |  |       |
>>                     |  |        |  |        |  |       |
>>                +----|--|--------|--|--------|--|-+   +-|-----+    +------+
>>                |    |  |        |  |        |  | |   | | tctx|    |Thread|
>>    IPI or   ---+    +  v        +  v        +  v |---| +  .. |----->     |
>>   HW events    |                                 |   |       |    |      |
>>                |             IVRE                |   | IVPE  |    +------+
>>                +---------------------------------+   +-------+
>>             
>>
>>
>> The IVSE have a 2-bits, P for pending and Q for queued, state machine
>> for each source that allows events to be triggered. They are stored in
>> an array, the Event State Buffer (ESB) and controlled by MMIOs.
>>
>> If the event is let through, the IVRE looks up in the Event Assignment
>> Structure (EAS) table for an Event Notification Descriptor (END)
>> configured for the source. Each Event Notification Descriptor defines
>> a notification path to a CPU and an in-memory Event Queue, in which
>> will be pushed an EQ data for the OS to pull.
>>
>> The IVPE determines if a Notification Virtual Target (NVT) can handle
>> the event by scanning the thread contexts of the VPs dispatched on the
>> processor HW threads. It maintains the interrupt context state of each
>> thread in a NVT table.
>>
> 
