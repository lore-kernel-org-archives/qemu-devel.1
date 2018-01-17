Received: from eggs.gnu.org ([2001:4830:134:3::10]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebjsn-0008W6-RQ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebjsj-0005vR-Gs
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:19:45 -0500
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:41695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ebjsj-0005kt-92
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:19:41 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D7B4017B1BF
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 10:19:26 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <683d0912-ad48-927c-8235-5358417be44c@kaod.org>
Date: Wed, 17 Jan 2018 10:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <1513896817.2743.63.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

>>> Also, have we decided how the process of switching between XICS and
>>> XIVE will work vs. CAS ? 
>>
>> That's how it is described in the architecture. The current choice is
>> to create both XICS and XIVE objects and choose at CAS which one to
>> use. It relies today on the capability of the pseries machine to 
>> allocate IRQ numbers for both interrupt controller backends. These
>> patches have been merged in QEMU.
>>
>> A change of interrupt mode results in a reset. The device tree is 
>> populated accordingly and the ICPs are switched for the model in 
>> use. 
> 
> For KVM we need to only instanciate one of them though.

Hmm,

How would we handle a guest rebooting on a kernel without XIVE support ? 
Are you suggesting to create the XICS or XIVE device in the CAS negotiation 
process ? So, the machine would not have any interrupt controller before 
CAS. That seems really late to me. grub uses the console for instance. 

I think it should prepare for both options, start in XIVE legacy mode, 
which is XICS, then possibly switch to XIVE exploitation mode.

>>> And how that will interact with KVM ? 
>>
>> I expect we will do the same, which is to create two KVM devices to 
>> be able to handle both interrupt controller backends depending on the 
>> mode negotiated by the guest.  
> 
> That will be an ungodly mess, I'd rather we only instanciate the right
> one.

It's rather transparent currently in the emulated version. There are two 
sets of objects in QEMU, switching is done in CAS. KVM support should not 
change anything in that area. 

I expect the 'xive-kvm' object to get/set states for migration, just like 
for XICS and to setup the ESB+TIMA memory regions, which is new. 

C. 
 
>>> I was
>>> thinking the kernel would implement a different KVM device type, ie
>>> the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would be
>>> KVM_DEV_TYPE_XIVE.
>>
>> yes. it makes sense. The new device will have a lot in common with the 
>> KVM_DEV_TYPE_XICS using kvm_xive_ops.
> 
> Ben.
> 
