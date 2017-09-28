Received: from eggs.gnu.org ([2001:4830:134:3::10]:53959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCT-0000cS-He
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCR-0003V6-SG
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:25 -0400
Date: Thu, 28 Sep 2017 13:58:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928035815.GX12504@umbus>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287474187.9760.12052550430995757993.stgit@aravinda>
	<20170817013934.GC5509@umbus.fritz.box>
	<555e187e-38af-d897-85b7-f08364b264fd@linux.vnet.ibm.com>
	<20170822020854.GY12356@umbus.fritz.box>
	<98ef38a4-9c09-adec-6f0c-b280e5349d64@linux.vnet.ibm.com>
	<20170927071508.GP12504@umbus>
	<bcc42ba6-6c71-d8d0-a196-7588a4d4a0d2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9CzcV6dAFIr7O1Ie"
Content-Disposition: inline
In-Reply-To: <bcc42ba6-6c71-d8d0-a196-7588a4d4a0d2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--9CzcV6dAFIr7O1Ie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 05:23:51PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Wednesday 27 September 2017 12:45 PM, David Gibson wrote:
> > On Thu, Sep 21, 2017 at 02:39:06PM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Tuesday 22 August 2017 07:38 AM, David Gibson wrote:
> >>
> >> [ . . . ]
> >>
> >>>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>>>> index 46012b3..eee8d33 100644
> >>>>>> --- a/include/hw/ppc/spapr.h
> >>>>>> +++ b/include/hw/ppc/spapr.h
> >>>>>> @@ -123,6 +123,12 @@ struct sPAPRMachineState {
> >>>>>>       * occurs during the unplug process. */
> >>>>>>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> >>>>>> =20
> >>>>>> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock=
" calls */
> >>>>>> +    target_ulong guest_machine_check_addr;
> >>>>>> +    bool mc_in_progress;
> >>>>>> +    int mc_cpu;
> >>>>>
> >>>>> mc_cpu isn't actually used yet in this patch.  In any case it and
> >>>>> mc_in_progress could probably be folded together, no?
> >>>>
> >>>> It is possible to fold mc_cpu and mc_in_progress together with the
> >>>> convention that if it is set to -1 mc is not in progress otherwise i=
t is
> >>>> set to the CPU handling the mc.
> >>>>
> >>>>>
> >>>>> These values will also need to be migrated, AFAICT.
> >>>>
> >>>> I am thinking of how to handle the migration when machine check hand=
ling
> >>>> is in progress. Probably wait for machine check handling to complete
> >>>> before migrating as the error could be irrelevant once migrated to a=
 new
> >>>> hardware. If that is the case we don't need to migrate these values.
> >>>
> >>> Ok.
> >>
> >> This is what I think about handling machine check during migration bas=
ed
> >> on my understanding of the VM migration code.
> >>
> >> There are two possibilities here. First, migration can be initiated
> >> while the machine check handling is in progress. Second, A machine che=
ck
> >> error can happen when the migration is in progress.
> >>
> >> To handle the first case we can add migrate_add_blocker() call when we
> >> start handling the machine check error and issue migrate_del_blocker()
> >> when done. I think this should solve the issue.
> >>
> >> The second case is bit tricky. The migration has already started and
> >> hence migrate_add_blocker() call will fail. We also cannot wait till t=
he
> >> completion of the migration to handle machine check error as the VM's
> >> data could be corrupt.
> >>
> >> Machine check errors should not be an issue when the migration is in t=
he
> >> RAM copy phase as VM is still active with vCPUs running. The problem is
> >> when we hit a machine check when the migration is about to complete. F=
or
> >> example,
> >>
> >> 1. vCPU2 hits a machine check error during migration.
> >>
> >> 2. KVM causes VM exit on vCPU2 and the NIP of vCPU2 is changed to the
> >> guest registered machine check handler.
> >>
> >> 3. The migration_completion() issues vm_stop() and hence either vCPU2 =
is
> >> never scheduled again on the source hardware or vCPU2 is preempted whi=
le
> >> executing the machine check handler.
> >>
> >> 4. vCPU2 is resumed on the target hardware and either starts or
> >> continues processing the machine check error. This could be a problem =
as
> >> these errors are specific to the source hardware. For instance, when t=
he
> >> the guest issues memory poisoning upon such error, a clean page on the
> >> target hardware is poisoned while the corrupt page on source hardware =
is
> >> not poisoned.
> >>
> >> The second case of hitting machine check during the final phase of
> >> migration is rare but wanted to check what others think about it.
> >=20
> > So, I've had a bit of a think about this.  I don't recall if these
> > fwnmi machine checks are expected on guest RAM, or guest IO addresses.
>=20
> It is expected on guest RAM. I am not sure about guest IO address.
>=20
> >=20
> > 1) If RAM
> >=20
> >   What exactly is the guest's notification for?  Even without
> >   migration, the host's free to move guest memory around in host
> >   memory, so it seems any hardware level poking should be done on the
> >   host side.
>=20
> If the error is a correctable error, then host takes care of it by
> moving the page to a different location, the guest need not be and will
> not be notified. Guest will be notified if host is not able to fully
> recover. Hence we hit FWNMI in guest when RAM errors are not recovered
> by the host.

Ok.

> >   Is it just to notify the guest that we weren't able to fully recover
> >   on the host side and that page may contain corrupted data?  If
> >   that's so then it seems resuming the handling on the destination is
> >   still right.  It may be new good RAM, but the contents we migrated
> >   could still be corrupt from the machine check event on the source.
>=20
> Yes. This is what I am doing in my v5 patch set which I am about to
> post. Additionally I block migration when processing machine check errors.
>=20
> >=20
> > 2) If IO
> >=20
> >   AFAICT this could only happen with VFIO passthrough devices.. but it
> >   shouldn't be possible to migrate if there are any of those.
> >=20
>=20
> I am not very sure about IO errors.

Ok.  It sounds like that's not the primary case you're interested, so
I guess we can ignore it for now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9CzcV6dAFIr7O1Ie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMc1cACgkQbDjKyiDZ
s5JuihAA5L93HFs9ndp3wW/M1nPAM8f6ek5VCrdqBiDLQwgV7tVjM3W8I819OOOO
yDeAa8UeBDeA9K7Z5n505HbX8owjZxfWA7x0/Lnes4Dm4SklkR4p6yoot5RFAGcM
0hZw17m4wMD20c20zU9nKfJ3YgCEpXD4JYFaSOQtxFGmdAoWqzhyPrl2s0fvbzhS
OkTjv1+hdP5mK5VXOSXhkX+6rTOZLHXQUh5B3ansasguOD3bVIyd/bIsA+2vSNxn
HXuQOIarimu5zy5XY2eOS2Lqa4VJNezrax+9x2DUwANW0j/kja90+SbR28iSi2Ui
tpFqipsuPp160ukKfkNPiX4EjeK3kt47G2G3vsLg0Fkunfh+mLHeq3FlYru8ayBF
fSIlXopGGUD4e/fUE+fPEWpgFaMX2mjY8fG9P4/pLaM5WYwcna9jCX5gG2u402Ph
aYCGNQWHWodXY5BRrMNBPKm39VwS8kC8Cw6P3SRzkk8K4qsfuS/qqbBLU43gwwXX
dOal0CE4vxf0ooMQMa4YLbofzeR9zSyATM0wCNgfWEMlCjSdSuAKoDRQSM2VlHAw
U+X6pBixBmZiN6qIjsnvk+Apg7GcJmYVWuMpax6pen7GOVXXISZEX9elqum0SToQ
+lL0woaDKbo9bzMXU24z6yQ2mONu+7tmIxe/X3Sj64rUw2qO92Y=
=8yHT
-----END PGP SIGNATURE-----

--9CzcV6dAFIr7O1Ie--
