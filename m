Received: from eggs.gnu.org ([2001:4830:134:3::10]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e57Ph-0006HN-3n
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e57Pe-0001ln-K2
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:46:53 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e57Pd-0001ib-PO
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:46:50 -0400
Date: Thu, 19 Oct 2017 17:31:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171019063151.GA13245@umbus>
References: <1508170976-96869-4-git-send-email-imammedo@redhat.com>
	<1508325132-70513-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <1508325132-70513-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 3/6] possible_cpus: add CPUArchId::type
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, drjones@redhat.com, cohuck@redhat.com


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 01:12:12PM +0200, Igor Mammedov wrote:
> For enabling early cpu to numa node configuration at runtime
> qmp_query_hotpluggable_cpus() should provide a list of available
> cpu slots at early stage, before machine_init() is called and
> the 1st cpu is created, so that mgmt might be able to call it
> and use output to set numa mapping.
> Use MachineClass::possible_cpu_arch_ids() callback to set
> cpu type info, along with the rest of possible cpu properties,
> to let machine define which cpu type* will be used.
>=20
> * for SPAPR it will be a spapr core type and for ARM/s390x/x86
>   a respective descendant of CPUClass.
>=20
> Move parse_numa_opts() in vl.c after cpu_model is parsed into
> cpu_type so that possible_cpu_arch_ids() would know which
> cpu_type to use during layout initialization.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>   v2:
>      - fix NULL dereference caused by not initialized
>        MachineState::cpu_type at the time parse_numa_opts()
>        were called
> ---
>  include/hw/boards.h        |  2 ++
>  hw/arm/virt.c              |  3 ++-
>  hw/core/machine.c          | 12 ++++++------
>  hw/i386/pc.c               |  4 +++-
>  hw/ppc/spapr.c             | 13 ++++++++-----
>  hw/s390x/s390-virtio-ccw.c |  1 +
>  vl.c                       |  3 +--
>  7 files changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 191a5b3..fa21758 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -80,6 +80,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
>   * CPUArchId:
>   * @arch_id - architecture-dependent CPU ID of present or possible CPU

I know this isn't really in scope for this patch, but is @arch_id here
supposed to have meaning defined by the target, or by the machine?

If it's the machime, it could do with a rename - "arch" means target
to most people (thanks to Linux).

If it's the target, it's kind of bogus, because it doesn't necessarily
have a clear meaning per target - get_arch_id in CPUClass has the same
problem, which is probably one reason it's basically only used by the
x86 code at present.

e.g. for target/ppc, what do we use?  There's the PIR, which is in the
CPU.. but only on some cpu models, not all.  There will generally be
some kind of master PIC id, but there are different PIC models on
different boards.  What goes in the devicetree?  Well only some
machines use devicetree, and they might define the cpu reg=20
differently.

Board designs will generally try to make some if not all of those
possible values equal for simplicity, but there's still no real way of
defining a sensible arch_id independent of machine / board.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnoRtcACgkQbDjKyiDZ
s5J3KBAAowqyp9rouZZuJpm6i5PXYzRw+68YdjYlTdO2184TiImPemcryuC9hPJ+
uTb1wAgZxFSg4ZQtF7oPbps1SMeP0c1GBwQf671Tf6loGFU0V6xmdH2q1V1o1sCC
xjlCoFa/dQVVOILYkH/AFHTW52q45G+3SqN2olkshVHT/Yhl7xsuQmLbi2mx2Prq
G7iD0Z8IMhbMAPL6WZcFH3QQ4jeOxti4OR/iHrfKSiPfy0gAO6Xe+InDVeLIGewc
9GSlUj+RpfvZZiU88X1eupfZy5RiEQWfLDxG9uiMeKAWsBMAqKHDugekYaxUV55T
Yz3WaBycYhEvUVXXEgnEL3IpFeFGVvHi/0tj4ieLxmMczuskW2gjbVqzDY+O8gCY
o64Ge18bRRsF12034EQ9NtaT84FH3uWYUaHgnZpddXPPRyx/+QsJQ/poFVnplqFV
ONikMwE85zHlpjEsZK82ipfUg2t6f+JMjHtftcPm3vrp67r82k2eIEK8QRQds6do
FSVXJNKpyv47BIZFHZE2QarPoxiOmeV7d0UrX8nomJH/nsKH06tcMz4L7c9uhOvM
lrrxHAisbU2cMUPvLBnXPMiN8jkVVVcOp4XH+fGof5XMZMFAZ2YK6XlxH+1jEjtr
iPp4rhzZLk2GbiM2BBVjJCL7ma7kW33s9QFeqjJH7JsrUiR1Qns=
=Jcdr
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
