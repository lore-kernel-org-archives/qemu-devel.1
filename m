Received: from eggs.gnu.org ([2001:4830:134:3::10]:45696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTdwv-0004A9-8f
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTdwt-0007p2-Ud
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:27:05 -0500
Date: Mon, 3 Dec 2018 12:18:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181203011812.GQ30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-12-clg@kaod.org>
	<20181128023902.GU2251@umbus.fritz.box>
	<dbd8810e-09b9-7344-92d2-faddebf30c10@kaod.org>
	<20181129010047.GM2251@umbus.fritz.box>
	<cde0bf38-a766-deab-8d46-41fa7e776185@kaod.org>
	<20181130011135.GG30479@umbus.fritz.box>
	<bed23f8a-68bb-0f88-54c4-a4dfea085e34@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rUztinBX/EQDJOOk"
Content-Disposition: inline
In-Reply-To: <bed23f8a-68bb-0f88-54c4-a4dfea085e34@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--rUztinBX/EQDJOOk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 07:56:02AM +0100, C=E9dric Le Goater wrote:
> On 11/30/18 2:11 AM, David Gibson wrote:
> > On Thu, Nov 29, 2018 at 04:27:31PM +0100, C=E9dric Le Goater wrote:
> >> [ ... ]=20
> >>
> >>>>>> +/*
> >>>>>> + * The allocation of VP blocks is a complex operation in OPAL and=
 the
> >>>>>> + * VP identifiers have a relation with the number of HW chips, the
> >>>>>> + * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
> >>>>>> + * controller model does not have the same constraints and can us=
e a
> >>>>>> + * simple mapping scheme of the CPU vcpu_id
> >>>>>> + *
> >>>>>> + * These identifiers are never returned to the OS.
> >>>>>> + */
> >>>>>> +
> >>>>>> +#define SPAPR_XIVE_VP_BASE 0x400
> >>>>>
> >>>>> 0x400 =3D=3D 1024.  Could we ever have the possibility of needing to
> >>>>> consider both physical NVTs and PAPR NVTs at the same time? =20
> >>>>
> >>>> They would not be in the same CAM line: OS ring vs. PHYS ring.=20
> >>>
> >>> Hm.  They still inhabit the same NVT number space though, don't they?
> >>
> >> No. skiboot reserves the range of VPs for the HW at init.
> >>
> >> https://github.com/open-power/skiboot/blob/master/hw/xive.c#L1093
> >=20
> > Uh.. I don't see how they're reserved is relevant.
> >=20
> > What I mean is that the ENDs address the NVTs for HW endpoints by the
> > same (block, index) tuples as the NVTs for virtualized endpoints, yes?
>=20
> Ah. Yes. The (block, index) tuples, fields END_W6_NVT_BLOCK and=20
> END_W6_NVT_INDEX in the END structure, are all in the same number space.

Right.

> skiboot defines some ranges though.

Ok.  I guess we can rely on that for PAPR, but not for PowerNV.

> >>> I'm thinking about the END->NVT stage of the process here, rather than
> >>> the NVT->TCTX stage.
> >>>
> >>> Oh, also, you're using "VP" here which IIUC =3D=3D "NVT".  Can we
> >>> standardize on one, please.
> >>
> >> VP is used in Linux/KVM Linux/Native and skiboot. Yes. it's a mess.=20
> >> Let's have consistent naming in QEMU and use NVT.=20
> >=20
> > Right.  And to cover any inevitable missed ones is why I'd like to see
> > a cheatsheet giving both terms in the header comments somewhere.
>=20
> yes. I have added a list of names in xive.h.=20

Great.  Oh BTW - this is getting big enough, that I wonder if it makes
sense to create a hw/intc/xive subdir to put things in, then splitting
IVSE, IVRE, IVPE related code into separate .c files (I'd still expect
a common .h though).

> I was wondering if I should put the diagram below somewhere in a .h file=
=20
> or under doc/specs/.

I'd prefer it in the .h file.

>=20
> Thanks,
>=20
> C. =20
>=20
>=20
> =3D XIVE =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The POWER9 processor comes with a new interrupt controller, called
> XIVE as "eXternal Interrupt Virtualization Engine".
>=20
>=20
> * Overall architecture
>=20
>=20
>              XIVE Interrupt Controller
>              +------------------------------------+      IPIs
>              | +---------+ +---------+ +--------+ |    +-------+
>              | |VC       | |CQ       | |PC      |----> | CORES |
>              | |     esb | |         | |        |----> |       |
>              | |     eas | |  Bridge | |   tctx |----> |       |
>              | |SC   end | |         | |    nvt | |    |       |
>  +------+    | +---------+ +----+----+ +--------+ |    +-+-+-+-+
>  | RAM  |    +------------------|-----------------+      | | |
>  |      |                       |                        | | |
>  |      |                       |                        | | |
>  |      |  +--------------------v------------------------v-v-v--+    other
>  |      <--+                     Power Bus                      +--> chips
>  |  esb |  +---------+-----------------------+------------------+
>  |  eas |            |                       |
>  |  end |        +---|-----+                 |
>  |  nvt |       +----+----+|            +----+----+
>  +------+       |SC       ||            |SC       |
>                 |         ||            |         |
>                 | PQ-bits ||            | PQ-bits |
>                 | local   |+            |  in VC  |
>                 +---------+             +---------+
>                    PCIe                 NX,NPU,CAPI
>=20
>                   SC: Source Controller (aka. IVSE)
>                   VC: Virtualization Controller (aka. IVRE)
>                   PC: Presentation Controller (aka. IVPE)
>                   CQ: Common Queue (Bridge)
>=20
>              PQ-bits: 2 bits source state machine (P:pending Q:queued)
>                  esb: Event State Buffer (Array of PQ bits in an IVSE)
>                  eas: Event Assignment Structure
>                  end: Event Notification Descriptor
>                  nvt: Notification Virtual Target
>                 tctx: Thread interrupt Context
>=20
>=20
> The XIVE IC is composed of three sub-engines :
>=20
>   - Interrupt Virtualization Source Engine (IVSE), or Source
>     Controller (SC). These are found in PCI PHBs, in the PSI host
>     bridge controller, but also inside the main controller for the
>     core IPIs and other sub-chips (NX, CAP, NPU) of the
>     chip/processor. They are configured to feed the IVRE with events.
>=20
>   - Interrupt Virtualization Routing Engine (IVRE) or Virtualization
>     Controller (VC). Its job is to match an event source with an Event
>     Notification Descriptor (END).
>=20
>   - Interrupt Virtualization Presentation Engine (IVPE) or Presentation
>     Controller (PC). It maintains the interrupt context state of each
>     thread and handles the delivery of the external exception to the
>     thread.
>=20
>=20
> * XIVE internal tables
>=20
> Each of the sub-engines uses a set of tables to redirect exceptions
> from event sources to CPU threads.
>=20
>                                           +-------+
>   User or OS                              |  EQ   |
>       or                          +------>|entries|
>   Hypervisor                      |       |  ..   |
>     Memory                        |       +-------+
>                                   |           ^
>                                   |           |
>              +-------------------------------------------------+
>                                   |           |
>   Hypervisor      +------+    +---+--+    +---+--+   +------+
>     Memory        | ESB  |    | EAT  |    | ENDT |   | NVTT |
>    (skiboot)      +----+-+    +----+-+    +----+-+   +------+
>                     ^  |        ^  |        ^  |       ^
>                     |  |        |  |        |  |       |
>              +-------------------------------------------------+
>                     |  |        |  |        |  |       |
>                     |  |        |  |        |  |       |
>                +----|--|--------|--|--------|--|-+   +-|-----+    +------+
>                |    |  |        |  |        |  | |   | | tctx|    |Thread|
>    IPI or   ---+    +  v        +  v        +  v |---| +  .. |----->     |
>   HW events    |                                 |   |       |    |      |
>                |             IVRE                |   | IVPE  |    +------+
>                +---------------------------------+   +-------+
>            =20
>=20
>=20
> The IVSE have a 2-bits, P for pending and Q for queued, state machine
> for each source that allows events to be triggered. They are stored in
> an array, the Event State Buffer (ESB) and controlled by MMIOs.
>=20
> If the event is let through, the IVRE looks up in the Event Assignment
> Structure (EAS) table for an Event Notification Descriptor (END)
> configured for the source. Each Event Notification Descriptor defines
> a notification path to a CPU and an in-memory Event Queue, in which
> will be pushed an EQ data for the OS to pull.
>=20
> The IVPE determines if a Notification Virtual Target (NVT) can handle
> the event by scanning the thread contexts of the VPs dispatched on the
> processor HW threads. It maintains the interrupt context state of each
> thread in a NVT table.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rUztinBX/EQDJOOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwEhFQACgkQbDjKyiDZ
s5J9Jw/+Owi2+dp96y3Or/x8lMr37hoPRKm1OLwmXPUr8iO80AUeEcUVKfSrM6l2
BKwQyMSk094zXAPuQXZFRNNFuFMthoGG6ud9SUB/FpNw/WTCFDnUNPQa5PYsoWDA
NjqnngVn5ek1oG7Tz1YE+2mED0luuvZnV4NUEZR6LO0jat16iQHtqMaTIjNNeN7r
rZCgr4koZCHwETf/xAbpHBu0lJC4vSddR5aldj/9jAZZsp6yCMWHPmRitefUyZwq
LRmcYZU7iUy9DQ4PH4X3NLIZMcitcHOEYG+7BXaWbXurUv7S5RW2aC/Q/MOt3Qgn
TFz9VQkPPqTS9kejjw4ah59ryJwq7HeH+x+3NRcx4mVjiRlD9NoOxz1oZRFfHdLQ
FqHDSNljsWxkYvgLzHJAZVWhlxSJig0J/Uo1pbAtNKh8wq318XZc3NVyzBq9wXP7
D7KodwEwqd96fjXhhxyH0Pe3ED8Za5YAmYar2C0UuBPoFd2Pt0ErcXtPaYnJxzv6
6JraaOkNk2ZxVHvCmHmOSBBlKj0iPOJLvv00ycatrmJuU9FpuL46QaeiOLsyavL8
K0J5tOlEHBLmgg6bylZ1qKn99iKSAo6eW+WGQLrv9AVHQOo/lAWftN2RBo7Su6N6
N6yjpyqMRWvBynm9BHrMgMwALwkYDs6Bxxmk8OyRWIzpBCB02Vk=
=LF+8
-----END PGP SIGNATURE-----

--rUztinBX/EQDJOOk--
