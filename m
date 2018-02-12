Received: from eggs.gnu.org ([2001:4830:134:3::10]:43732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1el3SO-0000iW-M6
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 21:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1el3SK-0003Xr-D6
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 21:03:00 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:43416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1el3SK-0003Wj-6g
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 21:02:56 -0500
Received: by mail-pg0-x230.google.com with SMTP id f6so6528825pgs.10
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 18:02:55 -0800 (PST)
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
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c0a92679-c237-1bd4-d9d5-91be16d043b4@ozlabs.ru>
Date: Mon, 12 Feb 2018 13:02:47 +1100
MIME-Version: 1.0
In-Reply-To: <1518389717.2312.245.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org

On 12/02/18 09:55, Benjamin Herrenschmidt wrote:
> On Sun, 2018-02-11 at 19:08 +1100, David Gibson wrote:
>> On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wrote:
>>> On Wed, 2018-01-17 at 15:39 +0100, Cédric Le Goater wrote:
>>>> Migration is a problem. We will need both backend QEMU objects to be 
>>>> available anyhow if we want to migrate. So we are back to the current 
>>>> solution creating both QEMU objects but we can try to defer some of the 
>>>> KVM inits and create the KVM device on demand at CAS time.
>>>
>>> Do we have a way to migrate a piece of info from the machine *first*
>>> that indicate what type of XICS/XIVE to instanciate ?
>>
>> Nope.  qemu migration doesn't work like that.  Yes, it should, and
>> everyone knows it, but changing it is a really long term project.
> 
> Well, we have a problem then. It looks like Qemu broken migration is
> fundamentally incompatible with PAPR and CAS design...
> 
> I know we don't migrate the configuration, that's not exactly what I
> had in mind tho... Can we have some piece of *data* from the machine be
> migrated first, and use it on the target to reconfigure the interrupt
> controller before the stream arrives ?


These days this is done via libvirt - it reads properties it needs via QMP,
then sends an XML with everything (the interrupt controller type may be one
of such properties), and starts the destination QEMU with the explicit
interrupt controller (like -machine pseries,intrc=xive).

Hacking QEMU to do all of this is still in a distant TODO...


> Otherwise, we have indeed no much choice but the horrible wart of
> creating both interrupt controllers with only one "active".
> 
>>>
>>>> The next problem is the ICP object that currently needs the KVM device 
>>>> fd to connect the vcpus ... So, we will need to change that also. 
>>>> That is probably the biggest problem today. We need a way to disconnect 
>>>> the vpcu from the KVM device and see how we can defer the connection.
>>>> I need to make sure this is possible, I can check that without XIVE



-- 
Alexey
