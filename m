Received: from eggs.gnu.org ([2001:4830:134:3::10]:59520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dUXvR-0005SB-8Q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dUXvN-0007yr-A6
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:36:29 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:50211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dUXvN-0007wq-3S
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:36:25 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id EBE006B08E
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 14:36:20 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<20170710102433.GD4083@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <574cac90-bbc1-ee49-c38e-aaf275fcfad5@kaod.org>
Date: Mon, 10 Jul 2017 14:36:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170710102433.GD4083@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/26] guest exploitation of the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/10/2017 12:24 PM, David Gibson wrote:
> On Wed, Jul 05, 2017 at 07:13:13PM +0200, C=E9dric Le Goater wrote:
>> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
>> negotiation process determines whether the guest operates with an
>> interrupt controller using the XICS legacy model, as found on POWER8,
>> or in XIVE exploitation mode, the newer POWER9 interrupt model. This
>> patchset is a first proposal to add XIVE support in the sPAPR machine.
>>
>> The first patches introduce the XIVE exploitation mode in CAS.
>>
>> Follow models for the XIVE interrupt controller, source and presenter.
>> We try to reuse the ICS and ICP models of XICS because the sPAPR
>> machine is tied to the XICSFabric interface and should be using a
>> common framework to be able to switch from one controller model to
>> another. To be discussed of course.
>>
>> Then comes support for the Hypervisor's call which are used to
>> configure the interrupt sources and the event/notification queues of
>> the guest.
>>
>> Finally, the last patches try to integrate the XIVE interrupt model in
>> the sPAPR machine and this not without a couple of serious hacks to
>> have something to test. See 'Caveats' below for more details.
>>
>> This is a first draft and I expect a lot of rewrite before it reaches
>> mainline QEMU. Nevertheless, it compiles, boots and can be used for
>> some testing.
>=20
> 1 & 2 are straightforward enough that I've applied them already.  The
> rest will take longer to review, obviously.

For sure ... I don't expect anything soon. This is really a first=20
draft to show the differences with XICS in the overall mechanics.=20
The guest boots and perf are OK but the integration with the sPAPR=20
machine is a mess. I also think the IRQ allocator is too complex=20
for the sPAPR need and the Xive ICP object is useless. The changelogs=20
are too short.=20

I have continued working on CAS support and have found a solution
which allows a guest to switch interrupt controller: XICS <-> XIVE,=20
under TCG and under KVM,kernel_irqchip=3Doff.=20

The XIVE ICP lives under ICPState for ease of use. As for the ICS,=20
two different objects, XIVE and XICS, are maintained under the=20
sPAPR machine in which the 'irqs' array needs to be synced when=20
changing model. It's not too much of a hack I think and it is=20
migration friendly. We will see when discussed.

I have pushed on github these changes and I am now exploring the=20
abyssal zone of migration and cpu hot-plugging.

Cheers,

C.
