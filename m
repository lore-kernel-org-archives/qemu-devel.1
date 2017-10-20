Received: from eggs.gnu.org ([2001:4830:134:3::10]:39051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5LyN-0000Cr-Ef
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5LyJ-0003Nj-6e
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:19:39 -0400
Received: from ozlabs.org ([103.22.144.67]:33249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e5LyI-0003Ma-9U
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:19:35 -0400
Date: Fri, 20 Oct 2017 12:19:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171020011917.GF13245@umbus>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
	<20171019104218.GB13245@umbus>
	<20171020001548.GK2942@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <20171020001548.GK2942@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2017 at 10:15:48PM -0200, Eduardo Habkost wrote:
> On Thu, Oct 19, 2017 at 09:42:18PM +1100, David Gibson wrote:
> > On Mon, Oct 16, 2017 at 02:59:16PM -0200, Eduardo Habkost wrote:
> > > On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  include/sysemu/sysemu.h |  1 +
> > > >  qemu-options.hx         | 15 ++++++++++++++
> > > >  qmp.c                   |  5 +++++
> > > >  vl.c                    | 54 +++++++++++++++++++++++++++++++++++++=
+++++++++++-
> > > >  4 files changed, 74 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > > index b213696..3feb94f 100644
> > > > --- a/include/sysemu/sysemu.h
> > > > +++ b/include/sysemu/sysemu.h
> > > > @@ -66,6 +66,7 @@ typedef enum WakeupReason {
> > > >      QEMU_WAKEUP_REASON_OTHER,
> > > >  } WakeupReason;
> > > > =20
> > > > +void qemu_exit_preconfig_request(void);
> > > >  void qemu_system_reset_request(ShutdownCause reason);
> > > >  void qemu_system_suspend_request(void);
> > > >  void qemu_register_suspend_notifier(Notifier *notifier);
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index 39225ae..bd44db8 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -3498,6 +3498,21 @@ STEXI
> > > >  Run the emulation in single step mode.
> > > >  ETEXI
> > > > =20
> > > > +DEF("paused", HAS_ARG, QEMU_OPTION_paused, \
> > > > +    "-paused [state=3D]postconf|preconf\n"
> > > > +    "                postconf: pause QEMU after machine is initial=
ized\n"
> > > > +    "                preconf: pause QEMU before machine is initial=
ized\n",
> > > > +    QEMU_ARCH_ALL)
> > >=20
> > > I would like to allow pausing before machine-type is selected, so
> > > management could run query-machines before choosing a
> > > machine-type.  Would that need a third "-pause" mode, or will we
> > > be able to change "preconf" to pause before select_machine() is
> > > called?
> > >=20
> > > The same probably applies to other things initialized before
> > > machine_run_board_init() that could be configurable using QMP,
> > > including but not limited to:
> > > * Accelerator configuration
> > > * Registering global properties
> > > * RAM size
> > > * SMP/CPU configuration
> >=20
> > Yeah.. having a bunch of different possible pause stages to select
> > doesn't sound great.
>=20
> I agree.  The number of externally visible pause states should be
> as small as possible.
>=20
>=20
> >                       Could we avoid this by instead changing -S to
> > pause at the earliest possible spot, but having any monitor commands
> > that require a later stage automatically "fast forwarding" to the
> > right phase?
>=20
> That would hide the internal details from the outside.  Sounds
> nice, but adding new machine/device configuration QMP commands
> while hiding the QEMU state from the outside sounds impossible.
>=20
> For example, if we use -S today, this works:
>=20
>   $ qemu-system-x86_64 -S -qmp stdio
>   <- {"QMP": {"version": {"qemu": {"micro": 0, "minor": 10, "major": 2}, =
"package": " (v2.10.0-83-g9375da7831)"}, "capabilities": []}}
>   -> {"execute":"qmp_capabilities"}
>   <- {"return": {}}
>   -> {"execute":"query-cpus"}
>   <- {"return": [{"arch": "x86", "current": true, "props": {"core-id": 0,=
 "thread-id": 0, "socket-id": 0}, "CPU": 0, "qom_path": "/machine/unattache=
d/device[0]", "pc": 4294967280, "halted": false, "thread_id": 4038}]}
>=20
> This means "query-cpus" needs to fast-forward to the CPU creation
> stage if we want to keep compatibility.
>=20
> Now, assume we add a set-numa-node command like the one in this
> series.  e.g.:
>=20
>   $ qemu-system-x86_64 -S -qmp stdio
>   <- {"QMP": {"version": {"qemu": {"micro": 0, "minor": 10, "major": 2}, =
"package": " (v2.10.0-83-g9375da7831)"}, "capabilities": []}}
>   -> {"execute":"qmp_capabilities"}
>   <- {"return": {}}
>   -> {"execute":"set-numa-node" ... }
>   <- {"return": ...}
>=20
> The command will work only if machine initialization didn't run
> yet.
>=20
> But now an innocent-looking query command would change QEMU state
> in an unexpected way:
>=20
>   $ qemu-system-x86_64 -S -qmp stdio
>   <- {"QMP": {"version": {"qemu": {"micro": 0, "minor": 10, "major": 2}, =
"package": " (v2.10.0-83-g9375da7831)"}, "capabilities": []}}
>   -> {"execute":"qmp_capabilities"}
>   <- {"return": {}}
>   -> {"execute":"query-cpus"}  [will silently fast-forward QEMU state]
>   <- {"return": [{"arch": "x86", "current": true, "props": {"core-id": 0,=
 "thread-id": 0, "socket-id": 0}, "CPU": 0, "qom_path": "/machine/unattache=
d/device[0]", "pc": 4294967280, "halted": false, "thread_id": 4038}]}
>   -> {"execute":"set-numa-node" ... }
>   <- {"error": ...}  [the command will fail because the machine was alrea=
dy created]
>=20
> This means we do have a externally visible "too late to use
> set-numa-node" QEMU state, and query-cpus will have a externally
> visible side effect.  Every QMP command would need to document
> how it affects QEMU state in a externally visible way.
>=20
> If QEMU pause state is still going to be externally visible this
> way, I would prefer to let the client to explicitly tell what's
> the state they want QEMU to be, instead of making QEMU change
> state silently as a side effect of QMP commands.

Yeah, good point.  My proposal would just have changed explicitly
exposed ugly internal state to subtly exposed ugly internal state,
which is probably worse :(.


Ok.. next possibly bad idea..

What about a "re-exec" monitor command; it would take what's
essentially a new command line, and basically restart qemu from the
beginning, reparsing this new command line, but without actually=20

Pro:
  * Mitigates Daniel Berrange's concern about lots of qemu
    configuration being buried in the qmp session - if libvirt logged
    its last "re-exec" that would have what is generally needed.
  * Lets libvirt do assorted investigation of options, then rewind to
    choose what it actually wants

Con:
  * Would require a bunch of auditing of structures/state to make sure
    they can be re-initialized cleanly
  * Would it be fast enough for libvirt to use?  Do we know if the
    slowness which makes multiple qemu invocations by libvirt
    unattractive is from the kernel/libc/ldso overhead, or from qemu's
    internal start up processing?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnpTxMACgkQbDjKyiDZ
s5IHHw//SmDU0ReAEzTrCRGIjwdRdR56CYyh/A0rapko9X+9N2+YvmLYU1ZSSSVv
A2g0S0hgM2ghtIX5pw2DYEFJ3P0fRYAJb+M4bnhDk/69vtHhz6/rTQw45Kfg0P2I
y+4A+pgBQDR/OSO/WJCUCP7hbHRGCPCtiurnMlEIP2r6KLvLp8x1rjtx/DFkPERD
t6zobdOd2OxBeup03XuYT5vz12F3zjNfd4CjJPJaEmW9n490bnDVRnjujGrUEErx
ems9aVPcszdYs+hmbFhXAh0mBb5GKRJS7MRnXcEOaz8TLtnYe+PMU0UNFvBEMNNR
I1utnewJSB466y5QXF4VQ+4PpqHzkPuasUUAQ1lARd3M9zec6hkXqNt2uwe1PzBA
p6V5G9enUq5l2lrAUWSOujozQAQUm+7uiRL1th9t1BH+TAnOz56dk6iHeOnmTAKb
KGhmDh49xJ6KkVaiprdwIMUQtrSyKdATb5Rx3AEO38i0livR7jP9CLZY9mTpyXXa
7bCAwZ4CY3i50JUYLA70Bsxr54Tziv3Ao07slL4QG07omT/Ntvyq082h6tjDYYQS
GJD29kQ+VuiWb+XHQlOolsOomncWzfTlb7QZp8RDAHDb6jt2NggSNe93/QD5fdHz
ZBaqRNaNGoERu3fimk2KIl5///DXwUZXAopp2v219fEcIHhh17o=
=NhuV
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
