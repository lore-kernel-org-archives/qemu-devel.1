Received: from eggs.gnu.org ([2001:4830:134:3::10]:47858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLsTp-0003OG-Du
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLsTn-00082K-IW
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:44:09 -0400
Date: Fri, 16 Jun 2017 22:40:53 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170616144053.GH30484@umbus>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
	<149748643237.3448.7122634958390452661@loki>
	<20170616155312.623f859e@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline
In-Reply-To: <20170616155312.623f859e@nial.brq.redhat.com>
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 03:53:12PM +0200, Igor Mammedov wrote:
> On Wed, 14 Jun 2017 19:27:12 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>=20
> > Quoting Igor Mammedov (2017-06-14 04:00:01)
> > > On Tue, 13 Jun 2017 16:42:45 -0500
> > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > >  =20
> > > > Quoting Igor Mammedov (2017-06-09 03:27:33) =20
> [...]
>=20
> > > Currently I'd suggest to look into always migrate DRCs if cpu hotplug
> > > is enabled even if dev->hotplugged is false (not nice but it might wo=
rk).
> > > Consider:
> > >   SRC1: hotplug CPU1 =3D> CPU1.hotplugged =3D true
> > >   DST1: -device CPU1 =3D> CPU1.hotplugged =3D false
> > > so in current code relying on CPU1.hotplugged would not work as expec=
ted,
> > > it works by accident because libvirt uses device_add on target
> > >   DST1: device_add CPU1 =3D> CPU1.hotplugged =3D true =20
> >=20
> > It's actually the reverse for us, DST1: -device CPU1 works, because
> > default DRC state for CPU1.hotplugged =3D false matches the state a
> > hotplugged CPU will be brought to after onlining at the source, so
> > we don't send it over the wire in the first place once it reaches
> > that post-hotplug/coldplug state. So things work as expected, even
> > though technically the source has dev->hotplugged =3D=3D true, whereas
> > the dest has dev->hotplugged =3D=3D false.
> in your case it seems fragile to rely on -device setting hotplugged cpu
> on target the way you want.
>=20
> it could be:
>=20
> SRC: hotplug CPU and start migration with DST: -device cpu[,hotplugged=3D=
false]
>   *: machine is in hotplugging state and one would lose transitional stat=
e if DRC is not migrated.
> =20
> > It's the DST1: device_add case that wasn't accounted for when the DRC
> > migration patches were written, as those don't default to coldplug,
> > so, because the source doesn't send it, it ends up being presented
> > in pre-hotplug state because the dest doesn't know that the guest
> > already onlined the resource and transitioned it to
> > post-hotplug/coldplug state. Ironically, dev->hotplugged
> > is true on both source and dest in this case, but it ends up being
> > the broken one.
> it looks like for hotplugged CPUs DRC state should be always migrated

Yeah, I think in the first instance we should just unconditionally
transfer DRC state for newer machine types (at least once I clean up
what exactly the DRC state _is_).  For old machine types things are
still likely to be broken, but it won't be a regression.

If we can work out a way to fix things for older machine types, that's
a bonus, but it looks like it's very difficult, maybe impossible.
First priority should be sane semantics for the newer machine types.

> > But your point stands, the fact that both situations are possible
> > means we can't currently rely on dev->hotplugged without migrating
> > it, infering it based on QEMU lifecycle, or forcing management to
> > set it.
> >=20
> > But that raises a 2nd point. Our dilemma isn't that we can't
> > rely on dev->hotplugged being synchronized (though if it
> > was we could build something around that), our dilemma is
> > that we make the following assumption in our code:
> >=20
> > "Devices present at start-time will be handled the same way,
> > on source or dest, regardless of whether they were added via
> > cmdline or via device_add prior to machine start / migration
> > stream processing."
> >=20
> > And I think that's a sensible expectation, since in theory
> > even the source could build up a machine via device_add
> > prior to starting it, and the reasonable default there is
> > dev->hotplugged =3D false rather than the opposite. That
> > suggests a need to fix things outside of migration.
> Agreed to a degree, i.e.
>=20
>   -device/device_add before machine has been started
> without migration should follow coldplug path
>=20
> it shouldn't cause problems for CPU/mem hotplug on x86
> and maybe will work for PCI (it may change behavior of
> ACPI based hotplug and bridges),
> CCing Marcel to confirm.

So for ppc the main problem with early plugged devices is a
duplication of device tree info between that delivered by CAS, and
that delivered through configure-connector.  I see two basic
approaches to fixing this:

1) At CAS, reset all DRCs before building the device tree to send to
the guest.  That will essentially "convert" everything present at CAS
time into coldplugged device.  There might still be a problem if there
are existing hotplug events in the queue from before CAS.

2) When building the device tree (at both CAS and reset) check the DRC
state, and omit DT information for anything that's not in CONFIGURED
state.  That should be correct, because the guest should call
configure-connector for anything not yet in CONFIGURED state, at which
point it will get the DT information.

I'm not sure which approach is best yet.  I'm not 100% sure of (1) is
correct in all cases, but it is a bit simpler than (2).

> > So far, all QEMU's existing migration code has managed ok
> > with the dest being starting with dev->hotplugged =3D=3D false
> > via cmdline devices, even though maybe they were hotplugged
> > on the source. To me, it makes more sense to maintain this
> > behavior by fixing up this relatively new use-case of
> > adding devices via device_add before start to match the
> > same expectations we have around cmdline-specified devices.
> >=20
> > This would fix migration for spapr, leave it working for
> > everyone else (since that's basically what we expect for
> > everything except newer-style cpu hotplug), and also make
> > the device-add-before-start be truly synonymous with
> > cmdline-created devices (which is applicable even outside
> > of migration).
> Neither -device or device_add can't really bring DRC/CPU into
> the state that devices might be at the moment when their state
> is transferred to target.
>=20
> i.e. any state that has been changed after -device/device_add
> on SRC, should be in migration stream. I'd say even if state would
> eventually go back default (coldplugged) when hotplug is completed.
> So trying to avoid transmitting runtime state to optimize some bytes
> on migration stream is just asking for trouble.

Yeah, I'm coming to the same conclusion.  Note that the reason for
omitting state wasn't to save space in the migration stream, but to
make the stream compatible with older versions which never transmit
the state - at least in as many cases as possible.

> [...]
> > >=20
> > > May be we should
> > >  1. make DeviceState:hotpluggable property write-able again
> > >  2. transmit DeviceState:hotpluggable as part of migration stream
> > >  3. add generic migration hook which will check if target and
> > >     source value match, if value differs =3D> fail/abort migration.
> > >  4. in case values mismatch mgmt will be forced to explicitly
> > >     provide hotplugged property value on -device/device_add
> > > That would enforce consistent DeviceState:hotpluggable value
> > > on target and source.
> > > We can enforce it only for new machine types so it won't break
> > > old mgmt tools with old machine types but would force mgmt
> > > for new machines to use hotplugged property on target
> > > so QEMU could rely on its value for migration purposes.
> > >  =20
> >=20
> > That would work, and generalizing this beyond spapr seems
> > appropriate.
> >=20
> > It also has reasonable semantics, and it would work for us
> > *provided that* we always send DRC state for hotplugged devices
> > and not just DRCs in a transitional state:
> >=20
> > SRC1: device_add $cpu
> >  -> dev->hotplugged =3D=3D true
> >  -> device starts in pre-hotplug, ends up in post-hotplug state =20
> >     after guest onlines it
> > <migrate>
> > DST1: device_add $cpu,hotplugged=3Dtrue
> >  -> dev->hotplugged =3D=3D true
> >  -> device starts in pre-hotplug state. guest sends updated state =20
> >     to transition DRC to post-hotplug
> >=20
> > But what about stuff like mem/pci? Currently, migration works for
> > cases like:
> >=20
> > SRC1: device_add virtio-net-pci
> > DST1: qemu -device virtio-net-pci
> >=20
> > Even though DST1 has dev->hotplugged =3D=3D false, and SRC1 has the
> > opposite. So for new machines, checking SRC1:dev->hotplugged =3D=3D
> > DST1:dev->hotplugged would fail, even though the migration
> > scenario is unchanged from before.
> >=20
> > So management would now have to do:
> >=20
> > SRC1: device_add virtio-net-pci
> > DST1: qemu -device virtio-net-pci,hotplugged=3Dtrue
> >=20
> > But the code behavior is a bit different then, since we now get
> > an ACPI hotplug event via the hotplug handler. Maybe the
> > migration stream fixes that up for us, but I think we would need
> > to audit this and similar cases to be sure.
> >=20
> > That's all fine if it's necessary, but I feel like this is
> > the hard way to address what's actually a much more specific
> > issue: that device_add before machine-start doesn't currently
> > match the behavior for a device started via cmdline. i.e.
> > dev->hotplugged in the former vs. !dev->hotplugged in the
> > latter. I don't really see a good reason these 2 cases should
> > be different, and we can bring them to parity by doing
> > something like:
> >=20
> > 1. For device_adds after qdev_machine_creation_done(), but
> >    before machine start, set a flag: reset_before_start.
> > 2. At the start of processing migration stream, or unpausing
> >    a -S guest (in the non-migration case), issue a system-wide
> >    reset if reset_before_start is set.
> > 3. reset handlers will already unset dev->hotplugged at that
> >    point and re-execute all the hotplug hooks with
> >    dev->hotplugged =3D=3D false. This should put everything in
> >    a state that's identical to cmdline-created devices.
> instead of flag for non migration case we could use
>  RUN_STATE_PRELAUNCH -> RUN_STATE_RUNNING
> transition to reset all devices or
> maybe do something like this:

Hrm, does the general reset call happen now before or after this
transition?  Resetting DRCs at CAS time should accomplish the same thing.

> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 0ce45a2..cdeb8f8 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
>=20
> @@ -1020,7 +1010,7 @@ static void device_initfn(Object *obj)
>      ObjectClass *class;
>      Property *prop;
> =20
> -    if (qdev_hotplug) {
> +    if (runstate_check(RUN_STATE_RUNNING) || ...) {
>          dev->hotplugged =3D 1;
>          qdev_hot_added =3D true;
>      }
>=20
> > 4. Only allow management to do device_add before it sends
> >    the migration stream (if management doesn't already guard
> >    against this then it's probably a bug anyway)
> seems like Juan already took care of it.
>=20
> > This allows management to treat device_add/cmdline as being
> > completely synonymous for guests that haven't started yet,
> > both for -incoming and -S in general, and it maintains
> > the behavior that existing migration code expects of
> > cmdline-specified devices.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQ+3yAAoJEGw4ysog2bOSIdQP/3Rqr7w97xkWUHoD/hIeJE8A
Tar9+WyOaAC+60Tp5jNX6lpsRascCG3Uz4qzh+bJB0DXZQsIrXOrgIWJxdGfS83B
nHyYWXmlyXCqakyVkwJxF+BaL6RvGjqpftFFBr1kKJz6lU3J0vF8t24vrfVryjnL
xs0y7Y4EpJ35bRBTzUT2h0TBwlnxBH0U4LlM31WJ4G3ztoQa+qd5LV+0Enx/BwIm
3JWM1i/l8hF4+33vB/HaveRw3GTVByDMMQKhAiIzWthOhnR6hZYiq+rtX7hihJYB
hKd2G9odM8j3KmBDOIdgw817sCXrDVvbZP6JeCOCv/mIw90n0rUnKyjqWDFLzMeM
b2FfPT2EFCmVsrQtxCXlS8T9KA6gw2f6ZuhtjTd4w8H7ZK7sNzpchpRnzoF+M+Rt
vVF/Jys7rO2t3UeA4Hy6+4ZoGLEJPiRxHFyZGkd8eb8HX+0SYh9d3C0kP7DAOvFf
a1nXmCxILn6cXnu5xUCq3g5dTXFW1fxd4X8JCFF7Hr6hGC7MOpSx7/2swQMI62Qn
mpXeIyfT4GMQWRxUzd9/n16dxststF5ifk7zwBS9FytKludsu28DSgrsHcrq4A0g
4okl33sUl9erIoScH5J/KVcMuvhnaQFwyNNGvBSk7h62r8gdKMow4z2proBrmuWr
eXYbSHUDOF4wBApVd/H7
=tg8F
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
