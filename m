Received: from eggs.gnu.org ([2001:4830:134:3::10]:56962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1elVCe-00085J-9s
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1elVCb-00083Z-6B
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:40:36 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:59215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1elVCa-00080q-V2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:40:33 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 16D1B9E058
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:40:23 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
	<1518389717.2312.245.camel@kernel.crashing.org>
	<c0a92679-c237-1bd4-d9d5-91be16d043b4@ozlabs.ru>
	<1518438032.11875.26.camel@redhat.com>
	<1518446406.2959.22.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3fc231cd-4cc6-9950-b393-3b023556a87a@kaod.org>
Date: Tue, 13 Feb 2018 08:40:13 +0100
MIME-Version: 1.0
In-Reply-To: <1518446406.2959.22.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 02/19] spapr: introduce a
 skeleton for the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrea Bolognani <abologna@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>

On 02/12/2018 03:40 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2018-02-12 at 13:20 +0100, Andrea Bolognani wrote:
>> On Mon, 2018-02-12 at 13:02 +1100, Alexey Kardashevskiy wrote:
>>> On 12/02/18 09:55, Benjamin Herrenschmidt wrote:
>>>> Well, we have a problem then. It looks like Qemu broken migration is
>>>> fundamentally incompatible with PAPR and CAS design...
>>>>
>>>> I know we don't migrate the configuration, that's not exactly what I
>>>> had in mind tho... Can we have some piece of *data* from the machine be
>>>> migrated first, and use it on the target to reconfigure the interrupt
>>>> controller before the stream arrives ?
>>>
>>> These days this is done via libvirt - it reads properties it needs via QMP,
>>> then sends an XML with everything (the interrupt controller type may be one
>>> of such properties), and starts the destination QEMU with the explicit
>>> interrupt controller (like -machine pseries,intrc=xive).
>>
>> Clarification: libvirt will use the user-defined XML configuration
>> to generate the QEMU command line both for the source and the target
>> of the migration, but it will not automagically figure out properties
>> through QMP. So if you want the controller to explicitly show up on
>> the QEMU command line, libvirt should be taught about it.
> 
> Which can't work because the guest pretty much decides what it will be
> early on during the boot process.
> 
> So we're back to square 1 having to instanciate both objects in qemu
> with some kind of "activation" flag.

yes and the activation flag is the associated bit in CAS OV5 :

	spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)

if a new interrupt mode is negotiated, a machine reset is required,
a new device tree is populated, new ICPs are installed, etc. There
is a little more to do with KVM and we need to find the right model 
abstraction for it. Anyhow, it is not a big problem to switch from 
one mode to another when both objects are around. It is even easier
to keep the allocated IRQs in sync in fact. 

What problem do you foresee with KVM ? this is already solved for 
irqchip=off.

Cheers, 

C.
