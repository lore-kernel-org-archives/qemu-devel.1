Received: from eggs.gnu.org ([2001:4830:134:3::10]:32970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMXmS-0004g6-Lx
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 06:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMXmQ-00069a-AW
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 06:50:08 -0400
Date: Sun, 18 Jun 2017 18:24:22 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170618102422.GD22449@umbus>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
	<149748643237.3448.7122634958390452661@loki>
	<20170616155312.623f859e@nial.brq.redhat.com>
	<149763356603.3448.7721371395232026174@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <149763356603.3448.7721371395232026174@loki>
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 12:19:26PM -0500, Michael Roth wrote:
> Quoting Igor Mammedov (2017-06-16 08:53:12)
> > On Wed, 14 Jun 2017 19:27:12 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> >=20
> > > Quoting Igor Mammedov (2017-06-14 04:00:01)
> > > > On Tue, 13 Jun 2017 16:42:45 -0500
> > > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > > >  =20
> > > > > Quoting Igor Mammedov (2017-06-09 03:27:33) =20
> > [...]
> >=20
> > > > Currently I'd suggest to look into always migrate DRCs if cpu hotpl=
ug
> > > > is enabled even if dev->hotplugged is false (not nice but it might =
work).
> > > > Consider:
> > > >   SRC1: hotplug CPU1 =3D> CPU1.hotplugged =3D true
> > > >   DST1: -device CPU1 =3D> CPU1.hotplugged =3D false
> > > > so in current code relying on CPU1.hotplugged would not work as exp=
ected,
> > > > it works by accident because libvirt uses device_add on target
> > > >   DST1: device_add CPU1 =3D> CPU1.hotplugged =3D true =20
> > >=20
> > > It's actually the reverse for us, DST1: -device CPU1 works, because
> > > default DRC state for CPU1.hotplugged =3D false matches the state a
> > > hotplugged CPU will be brought to after onlining at the source, so
> > > we don't send it over the wire in the first place once it reaches
> > > that post-hotplug/coldplug state. So things work as expected, even
> > > though technically the source has dev->hotplugged =3D=3D true, whereas
> > > the dest has dev->hotplugged =3D=3D false.
> > in your case it seems fragile to rely on -device setting hotplugged cpu
> > on target the way you want.
>=20
> Well, it's fragile in the sense that we try to assume post-hotplug =3D=3D
> coldplug as a way to avoid migrating hotplugged devices in some cases.
> This was mostly done to allow for backward-compatibility without
> relying on machine-specific behavior, but I have no problem with just
> always migrating DRC state for hotplugged devices.
>=20
> But that still leaves the following issue: on the source, we want to
> assume the default DRC state is coldplugged state. Based on that,
> we just migrate the hotplugged DRCs and everything would be fine,
> since we assume the target will initially put the DRC state in the
> coldplug state for all DRCs, same way it would for -device cpu/etc.
>=20
> But device_add on the target doesn't behave this way, it defaults to
> hotplugged state. It doesn't matter if the device is still in a hotplug
> state on the source, even if we reset the machine on the source side
> before migrating, device_add would still default to dev->hotplugged,
> and -device would still default to !dev->hotplugged.
>=20
> So we can't just send hotplugged DRCs, nor can we just send coldplugged
> DRCs, because there's no consistency in what the initial starting state
> will be on the dest. If they use -device to specify it it does one
> thing, if they use device_add it does another. So we're still stuck
> sending *all* DRCs.
>=20
> So addressing that inconsistency is the key issue I think.

I think that trying to do this in terms of dev->hotplugged is a
mistake.  That's really more about the device's history than its
current state.

What we want to detect is when the DRC is in a "transitional" state.
Basically if no hotplug processing is ongoing, a DRC should be in one
of two states:

A) DRC in UNUSABLE/ISOLATED state, no device plugged.

B) DRC in CONFIGURED state, device plugged.

Coldplugged devices go straight to state (B), an "empty" DRC is in
state (A).  When something is hotplugged the DRCs go through a few
transitional states, before arriving at state (B).  Likewise when
something is unplugged, there are various transitions, and then it
reaches state (A).

This is the common case, of course; if the guest is doing something
unusual, a "transitional" state can last arbitrarily long.

So, I think we always need to transfer DRC state if it's anything
other than (A) or (B).  On the destination, we determine starting
state (A) or (B) depending on whether a device is plugged (my reset
patch in DRC cleanups Part IV will already do this, I think).

No reference to, or manipulation of, dev->hotplugged is necessary.

> > it could be:
> >=20
> > SRC: hotplug CPU and start migration with DST: -device cpu[,hotplugged=
=3Dfalse]
> >   *: machine is in hotplugging state and one would lose transitional st=
ate if DRC is not migrated.
>=20
> In this case we'd actually check to see that the DRC is in a transitional
> state via .needed and migrate it. It's only when we've concluded that
> the state is identical to coldplug state that we don't send it.
>=20
> But as mentioned above, this is more of an optimization, even if we
> just always send DRC's for hotplugged devices, things are still broken,
> and we need a reliable way to infer the starting state of devices on
> the dest to fix them.
>=20
> >=20
> > > It's the DST1: device_add case that wasn't accounted for when the DRC
> > > migration patches were written, as those don't default to coldplug,
> > > so, because the source doesn't send it, it ends up being presented
> > > in pre-hotplug state because the dest doesn't know that the guest
> > > already onlined the resource and transitioned it to
> > > post-hotplug/coldplug state. Ironically, dev->hotplugged
> > > is true on both source and dest in this case, but it ends up being
> > > the broken one.
> > it looks like for hotplugged CPUs DRC state should be always migrated
>=20
> That would fix this case, but even if we adopt that approach we still
> have this scenario that's broken:
>=20
> SRC: hotplug CPU, reboot, CPU is now in a coldplugged state, so we don't
>      migrate it
> DST: device_add CPU, currently this defaults to dev->hotplugged =3D=3D tr=
ue,
>      so this incorrectly gets exposed to the guest as being in a
>      transitional state.
>=20
> This all stems from pre-start device_add semantics not aligning with
> cmdline-specified ones.

Right, we can fix this if we reset all DRC states based on device
presence before processing the incoming migration.

>=20
> >=20
> >=20
> > > But your point stands, the fact that both situations are possible
> > > means we can't currently rely on dev->hotplugged without migrating
> > > it, infering it based on QEMU lifecycle, or forcing management to
> > > set it.
> > >=20
> > > But that raises a 2nd point. Our dilemma isn't that we can't
> > > rely on dev->hotplugged being synchronized (though if it
> > > was we could build something around that), our dilemma is
> > > that we make the following assumption in our code:
> > >=20
> > > "Devices present at start-time will be handled the same way,
> > > on source or dest, regardless of whether they were added via
> > > cmdline or via device_add prior to machine start / migration
> > > stream processing."
> > >=20
> > > And I think that's a sensible expectation, since in theory
> > > even the source could build up a machine via device_add
> > > prior to starting it, and the reasonable default there is
> > > dev->hotplugged =3D false rather than the opposite. That
> > > suggests a need to fix things outside of migration.
> > Agreed to a degree, i.e.
> >=20
> >   -device/device_add before machine has been started
> > without migration should follow coldplug path
>=20
> I really feel like adopting this for the migration case as
> well is the cleanest solution. AFAICT none of the migration
> code really cares about synchronizing dev->hotplugged,
> something as simple as:
>=20
> SRC: device_add virtio-net-pci
> DST: -device virtio-net-pci
>=20
> results in a mismatch between dev->hotplugged. But the migration
> code doesn't really care, it's all based around knowledge of
> what the initial starting state of the device on DST will be.
>=20
> Now that we cases where device_add might be used instead of
> -device on DST, we no longer have that knowledge on the source.
> Having device_add-before-start match existing cmdline behavior
> seems like the most direct way to address this, and it seems
> sensible since they ostensibly serve the exact same purpose.

Come to think of it, I'm not sure we should really have any tests of
dev->hotplugged in our hotplug paths.  If we put everything into
"hotplugged" state, but the reset converts already attached things to
coldplug state, I think that should cover it, yes?

Maybe we need to omit notifications with !dev->hotplugged, although
even then we should flush the event queue on reset.

> > it shouldn't cause problems for CPU/mem hotplug on x86
> > and maybe will work for PCI (it may change behavior of
> > ACPI based hotplug and bridges),
> > CCing Marcel to confirm.
> >=20
> >=20
> > > So far, all QEMU's existing migration code has managed ok
> > > with the dest being starting with dev->hotplugged =3D=3D false
> > > via cmdline devices, even though maybe they were hotplugged
> > > on the source. To me, it makes more sense to maintain this
> > > behavior by fixing up this relatively new use-case of
> > > adding devices via device_add before start to match the
> > > same expectations we have around cmdline-specified devices.
> > >=20
> > > This would fix migration for spapr, leave it working for
> > > everyone else (since that's basically what we expect for
> > > everything except newer-style cpu hotplug), and also make
> > > the device-add-before-start be truly synonymous with
> > > cmdline-created devices (which is applicable even outside
> > > of migration).
> > Neither -device or device_add can't really bring DRC/CPU into
> > the state that devices might be at the moment when their state
> > is transferred to target.
> >=20
> > i.e. any state that has been changed after -device/device_add
> > on SRC, should be in migration stream. I'd say even if state would
> > eventually go back default (coldplugged) when hotplug is completed.
> > So trying to avoid transmitting runtime state to optimize some bytes
> > on migration stream is just asking for trouble.
> >=20
> > [...]
> > > >=20
> > > > May be we should
> > > >  1. make DeviceState:hotpluggable property write-able again
> > > >  2. transmit DeviceState:hotpluggable as part of migration stream
> > > >  3. add generic migration hook which will check if target and
> > > >     source value match, if value differs =3D> fail/abort migration.
> > > >  4. in case values mismatch mgmt will be forced to explicitly
> > > >     provide hotplugged property value on -device/device_add
> > > > That would enforce consistent DeviceState:hotpluggable value
> > > > on target and source.
> > > > We can enforce it only for new machine types so it won't break
> > > > old mgmt tools with old machine types but would force mgmt
> > > > for new machines to use hotplugged property on target
> > > > so QEMU could rely on its value for migration purposes.
> > > >  =20
> > >=20
> > > That would work, and generalizing this beyond spapr seems
> > > appropriate.
> > >=20
> > > It also has reasonable semantics, and it would work for us
> > > *provided that* we always send DRC state for hotplugged devices
> > > and not just DRCs in a transitional state:
> > >=20
> > > SRC1: device_add $cpu
> > >  -> dev->hotplugged =3D=3D true
> > >  -> device starts in pre-hotplug, ends up in post-hotplug state =20
> > >     after guest onlines it
> > > <migrate>
> > > DST1: device_add $cpu,hotplugged=3Dtrue
> > >  -> dev->hotplugged =3D=3D true
> > >  -> device starts in pre-hotplug state. guest sends updated state =20
> > >     to transition DRC to post-hotplug
> > >=20
> > > But what about stuff like mem/pci? Currently, migration works for
> > > cases like:
> > >=20
> > > SRC1: device_add virtio-net-pci
> > > DST1: qemu -device virtio-net-pci
> > >=20
> > > Even though DST1 has dev->hotplugged =3D=3D false, and SRC1 has the
> > > opposite. So for new machines, checking SRC1:dev->hotplugged =3D=3D
> > > DST1:dev->hotplugged would fail, even though the migration
> > > scenario is unchanged from before.
> > >=20
> > > So management would now have to do:
> > >=20
> > > SRC1: device_add virtio-net-pci
> > > DST1: qemu -device virtio-net-pci,hotplugged=3Dtrue
> > >=20
> > > But the code behavior is a bit different then, since we now get
> > > an ACPI hotplug event via the hotplug handler. Maybe the
> > > migration stream fixes that up for us, but I think we would need
> > > to audit this and similar cases to be sure.
> > >=20
> > > That's all fine if it's necessary, but I feel like this is
> > > the hard way to address what's actually a much more specific
> > > issue: that device_add before machine-start doesn't currently
> > > match the behavior for a device started via cmdline. i.e.
> > > dev->hotplugged in the former vs. !dev->hotplugged in the
> > > latter. I don't really see a good reason these 2 cases should
> > > be different, and we can bring them to parity by doing
> > > something like:
> > >=20
> > > 1. For device_adds after qdev_machine_creation_done(), but
> > >    before machine start, set a flag: reset_before_start.
> > > 2. At the start of processing migration stream, or unpausing
> > >    a -S guest (in the non-migration case), issue a system-wide
> > >    reset if reset_before_start is set.
> > > 3. reset handlers will already unset dev->hotplugged at that
> > >    point and re-execute all the hotplug hooks with
> > >    dev->hotplugged =3D=3D false. This should put everything in
> > >    a state that's identical to cmdline-created devices.
> > instead of flag for non migration case we could use
> >  RUN_STATE_PRELAUNCH -> RUN_STATE_RUNNING
> > transition to reset all devices or
> > maybe do something like this:
> >=20
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 0ce45a2..cdeb8f8 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> >=20
> > @@ -1020,7 +1010,7 @@ static void device_initfn(Object *obj)
> >      ObjectClass *class;
> >      Property *prop;
> >=20
> > -    if (qdev_hotplug) {
> > +    if (runstate_check(RUN_STATE_RUNNING) || ...) {
> >          dev->hotplugged =3D 1;
> >          qdev_hot_added =3D true;
> >      }
>=20
> Yah that sort of approach (this would coincedentally address the
> migration case as well, not sure if you are on board with that
> approach or not) is what I initially had in mind. The
> global flag seemed safer because we get a machine-wide reset
> will all devices already plugged just like for cmdline, but I'm
> not sure if that is really needed or not. This is definitely more
> elegant though.
>=20
> >=20
> > > 4. Only allow management to do device_add before it sends
> > >    the migration stream (if management doesn't already guard
> > >    against this then it's probably a bug anyway)
> > seems like Juan already took care of it.
>=20
> Ok, good to know.
>=20
> >=20
> > > This allows management to treat device_add/cmdline as being
> > > completely synonymous for guests that haven't started yet,
> > > both for -incoming and -S in general, and it maintains
> > > the behavior that existing migration code expects of
> > > cmdline-specified devices.
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZRlTRAAoJEGw4ysog2bOS5n8QANOAfOdVFL4AkuTpcgm4oAa9
y3tdNyxbjX+d/LAI2Jrfophe95itPWVPMXBvmF9glaE1XaMlEQ4La8Cr6ZYm8ghx
cD68V6h532BCUNnwzZnZMW09uDQewYucdaMxwYDEWhvM3tlccUxdNrgB4HsxcLhc
HXxyEdIx9WA4XpVIHS8i2j/VaKFlqWI6apbfFrYipfWNPgY1qWpXC0Kkhjer+MZv
sr/Ht+zjwPW6sni1/q+p8uVQTgIzYm2ko14uOKlVWtQsAQWH42ITpIaxyD+sojfB
hY/pyuUDrm97PKkTctxH4l7UI8hL6pKbqef1lMBKSYBq9gtEbHVdY4IxjVWTDhDd
ZGPQ3uJ7aKUNGcduKiee+W2S24L0JCtHW8t+FwEfNg+p+7HuKfrKx1p94xzrzKUw
lrPZY9sOKIr03ibrZUJzMIzZVvELu0s2jIsQsh/yu32CVtHO1FfBjQUCYZ7WasuR
7m+LAGyWJEou6YHYdY8bYX/sbxnZtn1GOvKIUT3Gbe7isXvK+6QgX/DhuBVx1vcM
Qk305gexvMSy/wK41dLtcn8IWoXRFQz016pZdx7eEq/nAmcl3gey+7SIJ8axBleM
KlwiM/6KZwf/S3hXtejNpDRT8qZRBxUgFIKEpdRnwkfI57Z4/QzzJDeBjO6YP+H9
KQRYtqtD4wTYgXPKiCdd
=X8Cf
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
