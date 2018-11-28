Received: from eggs.gnu.org ([2001:4830:134:3::10]:41995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gS32u-0006Ul-5y
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gS32o-0004pP-N3
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:50:40 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:52017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gS32o-0004ZK-8l
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:50:34 -0500
Received: from player690.ha.ovh.net (unknown [10.109.160.12])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E8AC0E0F81
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:50:26 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-13-clg@kaod.org>
	<20181128025714.GW2251@umbus.fritz.box>
	<20181128103551.42397998@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <128a0c2a-2f7e-55cf-1216-80266ac8a8a9@kaod.org>
Date: Wed, 28 Nov 2018 17:50:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181128103551.42397998@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 12/36] spapr: initialize VSMT
 before initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/28/18 10:35 AM, Greg Kurz wrote:
> On Wed, 28 Nov 2018 13:57:14 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
>> On Fri, Nov 16, 2018 at 11:57:05AM +0100, C=C3=A9dric Le Goater wrote:
>>> We will need to use xics_max_server_number() to create the sPAPRXive
>>> object modeling the interrupt controller of the machine which is
>>> created before the CPUs.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org> =20
>>
>> My only concern here is that this moves the spapr_set_vsmt_mode()
>> before some of the sanity checks in spapr_init_cpus().  Are we certain
>> there are no edge cases that could cause badness?
>>
>=20
> The early checks in spapr_init_cpus() filter out topologies that would
> result in partially filled cores. They're only related to the rest of
> the code that creates the boot CPUs. Before commit 1a5008fc17,
> spapr_set_vsmt_mode() was even being called before spapr_init_cpus().
> The rationale to move it there was to ensure it is called before the
> first user of spapr->vsmt, which happens to be a call to
> xics_max_server_number().
>=20
> Now that xics_max_server_number() needs to be called even earlier, I th=
ink a
> better change is to have xics_max_server_number() to call spapr_set_vsm=
t_mode()
> if spapr->vsmt isn't set.

That 'smt' routine is black magic to me and I would not dare touching it.

C.
=20
>=20
>>> ---
>>>  hw/ppc/spapr.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 7afd1a175bf2..50cb9f9f4a02 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineState =
*spapr)
>>>          boot_cores_nr =3D possible_cpus->len;
>>>      }
>>> =20
>>> -    /* VSMT must be set in order to be able to compute VCPU ids, ie =
to
>>> -     * call xics_max_server_number() or spapr_vcpu_id().
>>> -     */
>>> -    spapr_set_vsmt_mode(spapr, &error_fatal);
>>> -
>>>      if (smc->pre_2_10_has_unused_icps) {
>>>          int i;
>>> =20
>>> @@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState *m=
achine)
>>>      /* Setup a load limit for the ramdisk leaving room for SLOF and =
FDT */
>>>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD=
;
>>> =20
>>> +    /* VSMT must be set in order to be able to compute VCPU ids, ie =
to
>>> +     * call xics_max_server_number() or spapr_vcpu_id().
>>> +     */
>>> +    spapr_set_vsmt_mode(spapr, &error_fatal);
>>> +
>>>      /* Set up Interrupt Controller before we create the VCPUs */
>>>      smc->irq->init(spapr, &error_fatal);
>>>   =20
>>
>=20
