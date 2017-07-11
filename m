Received: from eggs.gnu.org ([2001:4830:134:3::10]:53737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dUvb6-0003AQ-3o
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dUvb3-0002ew-I7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:53:04 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:36439)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dUvb3-0002as-Bb
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:53:01 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 2DE356BAC3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 15:52:55 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-4-git-send-email-clg@kaod.org>
	<20170710102655.GE4083@umbus.fritz.box>
	<9a7a16a0-f14f-bc65-d503-e2aee028633f@kaod.org>
	<1499720443.2865.15.camel@kernel.crashing.org>
	<57c22926-8ac9-1251-aba9-590b344673c6@kaod.org>
	<20170711132751.GJ4083@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c6d3bf29-9d5e-6b1c-f3b0-282fd16ec39f@kaod.org>
Date: Tue, 11 Jul 2017 15:52:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170711132751.GJ4083@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 03/26] target/ppc/POWER9: add
 POWERPC_EXCP_POWER9
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

On 07/11/2017 03:27 PM, David Gibson wrote:
> On Tue, Jul 11, 2017 at 11:01:15AM +0200, C=E9dric Le Goater wrote:
>> On 07/10/2017 11:00 PM, Benjamin Herrenschmidt wrote:
>>> On Mon, 2017-07-10 at 14:49 +0200, C=E9dric Le Goater wrote:
>>>> On 07/10/2017 12:26 PM, David Gibson wrote:
>>>>> On Wed, Jul 05, 2017 at 07:13:16PM +0200, C=E9dric Le Goater wrote:
>>>>>> Prepare ground for the new exception model XIVE of POWER9.
>>>>>
>>>>> I'm a bit confused by this.  The excp_model is about the CPU core's
>>>>> irq model, not the external irq controller's.
>>>>
>>>> yes this is true, but the POWER9 CPU is the only criteria we have=20
>>>> to distinguish a machine supporting XIVE and XICS from one only=20
>>>> supporting XICS.
>>>
>>> Why ? I don't understand.
>>>
>>> We do want an EXCP_POWER9 for other things, like the fact that we hav=
e
>>> a separate interrupt input for hypervisor, with associated vectors
>>> etc...  but that still doesn't relate to what interrupt controller is
>>> there.
>>>
>>>> My idea was to use this flag to activate the OV5_XIVE_EXPLOIT bit=20
>>>> in ibm,arch-vec-5-platform-support ov5_platform, like this is done
>>>> for the MMU. See spapr_dt_ov5_platform_support()
>>>
>>> I disagree, the MMU is in the core, the XIVE isn't. It would be
>>> possibly to make a P9 core if a XICS in theory :-)
>>
>> ok. I understand. We could even "build" one in QEMU. HW would be=20
>> another story ...=20
>>
>> So should XIVE support be a sPAPR machine property only enabled if=20
>> 'cpu_model' matches "POWER9.*" ? The XICS/XIVE initialization is done=20
>> quite early in the machine init so this needs some checks.
>=20
> Basically, yes.  The interrupt controller setup is generally something
> the machine looks after.  What I'd actually suggest is a machine
> parameter for XICS vs. XIVE, whose default value is based on the CPU
> model. =20

yes. That is what I have been starting to work with now :=20
=20
+static bool ppc_support_xive(MachineState *machine)
+{
+   PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(first_cpu);
+
+   return pcc->pvr_match(pcc, CPU_POWERPC_POWER9_BASE);
+}

I am using the PVR to catch the cpu 'host' model. We could add=20
later on a machine property to disable the XIVE mode. =20


> Just as we could build a POWER9 with XICS in qemu, we could build a=20
> POWER8 with XIVE.

That might be the case with a POWER9 running in POWER8 compat mode.=20
I need to check.=20

Thanks,

C.=20


>>>>> Now.. I could imagine the POWER9 having a different core model that
>>>>> came along with XIVE, but I can't see this new model being used for
>>>>> anything anywhere in the rest of the series.
>>>>
>>>> See patch 26. But, maybe, I am taking a shortcut and we need another
>>>> family of flags.=20
>>>
>>> Or just some kind of enum for the interrupt controller, how do we do
>>> with OpenPIC vs. XICS already ? Old POWER3 had OpenPIC.
>>
>> AFAICT, we don't have such a CPU in QEMU/ppc.
>=20
> More to the point we don't have any machine type for those old POWER3
> setups.
>=20
>> We could use some extra flag to change the ICS behavior. The path I am
>> taking duplicates the ICS code but in real, we only need to change the
>> irq handlers.=20
>>
>> Thanks,
>>
>> C.=20
>>
>=20
