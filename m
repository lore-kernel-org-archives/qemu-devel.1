Received: from eggs.gnu.org ([2001:4830:134:3::10]:53064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbN-0007kd-EX
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbM-00062U-9f
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:13 -0400
Date: Fri, 9 Jun 2017 20:53:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609105305.GN26521@umbus.fritz.box>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BjavXC7V3ilNTWHC"
Content-Disposition: inline
In-Reply-To: <20170609102733.0eb7293d@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--BjavXC7V3ilNTWHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 10:27:33AM +0200, Igor Mammedov wrote:
> On Thu, 08 Jun 2017 15:00:53 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>=20
> > Quoting David Gibson (2017-05-30 23:35:57)
> > > On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote: =20
> > > > For QEMU, a hotlugged device is a device added using the HMP/QMP
> > > > interface.
> > > > For SPAPR, a hotplugged device is a device added while the
> > > > machine is running. In this case QEMU doesn't update internal
> > > > state but relies on the OS for this part
> > > >=20
> > > > In the case of migration, when we (libvirt) hotplug a device
> > > > on the source guest, we (libvirt) generally hotplug the same
> > > > device on the destination guest. But in this case, the machine
> > > > is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> > > > the OS will manage it as an hotplugged device as it will
> > > > be "imported" by the migration.
> > > >=20
> > > > This patch changes the meaning of "hotplugged" in spapr.c
> > > > to manage a QEMU hotplugged device like a "coldplugged" one
> > > > when the machine is awaiting an incoming migration.
> > > >=20
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com> =20
> > >=20
> > > So, I think this is a reasonable concept, at least in terms of
> > > cleanliness and not doing unnecessary work.  However, if it's fixing
> > > bugs, I suspect that means we still have problems elsewhere. =20
> >=20
> > I was hoping a lot of these issues would go away once we default
> > the initial/reset DRC states to "coldplugged". I think your pending
> > patch:
> >=20
> >   "spapr: Make DRC reset force DRC into known state"
> >=20
> > But I didn't consider the fact that libvirt will be issuing these
> > hotplugs *after* reset, so those states would indeed need to
> > be fixed up again to reflect boot-time,attached as opposed to
> > boot-time,unattached before starting the target.
> >=20
> > So I do think this patch addresses a specific bug that isn't
> > obviously fixable elsewhere.
> >=20
> > To me it seems like the only way to avoid doing something like
> > what this patch does is to migrate all attached DRCs from the
> > source in all cases.
> >=20
> > This would break backward-migration though, unless we switch from
> > using subregions for DRCs to explicitly disabling DRC migration
> > based on machine type.
> we could leave old machines broken and fix only new machine types,
> then it would be easy ot migrate 'additional' DRC state as subsection
> only on new for new machines.
>=20
> >=20
> > That approach seems to similar to what x86 does, e.g.
> > hw/acpi/ich9.c and hw/acpi/piix.c migrate vmstate_memhp_state
> > (corresponding to all DIMMs' slot status) in all cases where
> > memory hotplug is enabled. If they were to do this using
> > subregions for DIMMs in a transitional state I think similar
> > issues would pop up in that code as well.
> >=20
> > Even if we take this route, we still need to explicitly suppress
> > hotplug events during INMIGRATE to avoid extra events going on
> > the queue. *Unless* we similarly rely purely on the ones sent by
> > the source.
> pc/q35 might also lose events if device is hotplugged during migration,
> in addition migration would fail anyway since dst qemu
> should be launched with all devices that are present on src.
>=20
> ex: consider if one hotplugs DIMM during migration, it creates
> RAM region mapped into guest and that region might be transferred
> as part of VMState (not sure if it even works)
> and considering dst qemu has no idea about hotplugged memory mapping,
> the migration would fail on receiving unknown VMState.
>=20
> Hotplug generally doesn't work during migration, so it should be disabled
> in a generic way on migration start and re-enabled on target
> on migration completion. How about blocking device_add when
> INMIGRATE state and unblocking it when switching to runnig on dst?

Yeah, that sounds like a good idea.  We need to cover the case of
migration during an incomplete hot (un)plug as well as hotplug during
a migration.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BjavXC7V3ilNTWHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOn4RAAoJEGw4ysog2bOSEfsP/1I/VbTVBdRLM7CvtJwNqujh
zihdx6zDT43hanw5haFP+IkY/iQz6RjUfqhcTmkdCEOM41VYOrhmBOa0USaQwTB/
kyBdsjA4pot8U46gZFdxpwVXOVGmB5GiZkEi0sroLAiytXjU8mUt/vc+Xxr056j4
dUF+vctPfLNpQALonxz5FMMFtpeyVajh7WDZglU6MyWabC0Q4y1VMQrk93IlSldQ
ajggUqAcZrUaOYXMU8GG67x1Gp5cBMCbe7gZd+RTrowgMP11Nr3plPWPYy3KUzof
/wxwkBKGbgQg+X91Rz1crTB7LcjUMERMtl8gH5/4MCKgM3eXnQzb0XjScr1jjTfJ
D4tw80VFhEN7PNTW5vk2boWUrqDz2Igirkl+jZoYFDRpTYuCDTNNStL1ZuEqpeWe
pBUtrnmLwgNrxn+gFlGwp6+RYr519j6eLXt+v04loN38vdNw90LMuaEt2dNBj0hT
1g3IN9jGW2Fykz/aX6YY0n6jmcTtPksQNDwEPFpDuX+IJEsegfMEIKIQYO9/mBm2
5rd+gkPGA+nOp0j4BxSdTlAqn+WvOtCdkW1761Yd8ArtCghSEJLawpQFK/hYoXo5
kbWDsSCcQoKqgA+akyPKrcL2uehksYN0OZrxTynZkhir/w9PvEj9WRVutx2PSosE
8IbH9ECoC7I4n3vqppwy
=HgjN
-----END PGP SIGNATURE-----

--BjavXC7V3ilNTWHC--
