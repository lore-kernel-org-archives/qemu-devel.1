Received: from eggs.gnu.org ([2001:4830:134:3::10]:53840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWbym-0003b1-TJ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWbyl-0007pt-CZ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:52:44 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:44595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eWbyk-0007n6-M1
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:52:43 -0500
Date: Wed, 3 Jan 2018 16:52:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180103055231.GQ24581@umbus.fritz.box>
References: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bEjdSXxHv0Az5++U"
Content-Disposition: inline
In-Reply-To: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 0/4] enable numa configuration before
 machine is running from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com


--bEjdSXxHv0Az5++U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2017 at 06:22:55PM +0100, Igor Mammedov wrote:
>=20
> As were suggested at (1) and at bof session where we discussed subj,
> I'm posting variant with late numa 'configuration' i.e. when QEMU is
> started with '-S' option in paused state and numa is configured via
> monitor/QMP before machine cpus are allowed to run.
>=20
> Suggested idea was to try 'late' numa configuration as it might result in
> shortcut approach allowing us reuse current pause point (-S) versus adding
> another preconfig option with earlier pause point.
> So this series tries to show how feasible this approach.
>=20
> Currently numa options mainly affect only firmware blobs (ACPI/FDT tables=
),
> it should have been possible to regenerate those blobs right before we st=
art
> CPUs, which would allow us setup numa configuration at first pause point =
and
> get firmware blobs with updated numa information.
>=20
> Series implements idea for x86 ans spapr machines and uses machine reset,
> to reconfigure firmware and other machine structures after each numa
> configuration command (HMP or QMP).
>=20
> It was relatively not hard to implement for above machines as they already
> rebuild firmware blobs at reset time. But it still was a pain as QEMU isn=
't
> written with dynamic reconfiguration in mind and one need to update device
> state with new data (I think I've got it right but not 100% sure)
>=20
> However when it comes to the last target supporting NUMA, ARM
> all simplification versus v1 goes down the drain, since FDT blob is build
> incrementally during machine_init(), -device, machine_done() time, and
> it turns out into huge refactoring to isolate scattered FDT pieces into
> single FDT build function (like we do for ACPI). It's job that we would n=
eed
> to do anyways for hotplug to work properly on ARM,

Kind of irrelevant to this series, but I agree.  pseries started out
with the FDT being almost static created at init time, with a few tiny
adjustments later on.  But as the platform developed we needed to move
more and more of the FDT generation to later on (reset time, roughly).
For a long time we had an ugly split between the "skeleton" built at
init time and the stuff built at reset time, until I eventually moved
it all to reset time.

I'm pretty sure ARM will want the same thing, for hotplug as you
mention, but also for other things.  I also think it'll save effort
over all to do it sooner rather than later.

I had stuff in the works for ages to make DT building easier,
including a full "live" DT model for qemu (fdt is a good format for
passing the DT from one unit to another, but it gets clunky to do lots
of manipulation with it).  Unfortunately I've been sufficiently busy
with other things that I haven't really gotten anywhere with that for
the last year or more.

> but I don't think it
> should get in the way of numa refactoring.
> So that was the point where I gave up and decided to post only x86/spapr
> pieces for demo purposes.

Fair enough.

>=20
> I'm inclined towards avoiding 'v2 shortcut' and going in direction of v1,
> as I didn't see v2 as the right way in general, since one would have to:
>   - build machine / connect / initalize / devices one way and then find o=
ut
>     devices / connections that need to be fixed/updated with new configur=
ation,
>     it's very fragile and easy break.
>=20
> If I remember correctly the bof session, consensus was that we would like=
 to have
> early configuration interface (like v1) in the end, so I'd rather send ti=
me
> on addressing v1 drawbacks instead of hacking machine init order to make =
numa work
> in backwards way.
>=20
> CC: eblake@redhat.com
> CC: armbru@redhat.com
> CC: ehabkost@redhat.com
> CC: pkrempa@redhat.com
> CC: david@gibson.dropbear.id.au
> CC: peter.maydell@linaro.org
> CC: pbonzini@redhat.com
>=20
> [1]
> v1 for reference:
> [Qemu-devel] [RFC 0/6] enable numa configuration before machine_init() fr=
om HMP/QMP
>     https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03583.html
>=20
> PS:
> exercise wasn't waste as it resulted in cleanups that were already merged.
>=20
>=20
> Igor Mammedov (4):
>   numa: split out NumaOptions parsing into parse_NumaOptions()
>   HMP: add set-numa-node command
>   QMP: add set-numa-node command
>   numa: pc: reset machine if numa config has changed in prelaunch time
>=20
>  hmp.h                 |  1 +
>  include/hw/boards.h   |  1 +
>  include/sysemu/numa.h |  1 +
>  hmp-commands.hx       | 13 +++++++++++
>  hmp.c                 | 23 +++++++++++++++++++
>  hw/core/machine.c     |  3 ++-
>  hw/i386/pc.c          |  1 +
>  numa.c                | 63 +++++++++++++++++++++++++++++++++++----------=
------
>  qapi-schema.json      | 13 +++++++++++
>  vl.c                  |  4 ++++
>  10 files changed, 102 insertions(+), 21 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bEjdSXxHv0Az5++U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpMb5wACgkQbDjKyiDZ
s5LO0xAAuGpkY9TesZ5DP/e+2+mDSaxopWnvymtIevLyty73+hMzRmVJw57fSrVq
0aJOfPzmnGWkYOvp5ombzXkzQbXD+Wcee50C4WykCtxoh7QujC/mLaRaW9esDGZh
KCQvXnZKzcMYzvBvmBRMl28qsizHtGA2Eukj6rSpKAl9BwtwRVdlWhjFrxGWSQZ5
T1cyGs73DubX0ctRSoLgu1gj8Bh4tHfC3A0QnJ9K7TlkXc2ZRmXpjMv8eiZbW395
ic+JS2325mSQ1Y0UEfkN5LKPcV0QRCLvYhfZqyY4AnMKN9LYj9EPPYqXwCcXn19f
tfEd2aSdLzgl+JWx4OlEA1KvCZyz7Z3DZJ/2v3hSTqKFUR5g19bT8+CMwJ6M/4Gy
MyL6gESpK+PSzHrNwfapgCOp0PG2GcmgaFX+2m5y0Tx6rbhUofhdYX0FmBjEm+1B
l9hOjS5wqhvIBzkiNbSdGSX98OPPisOZ06gWLQtWBbhdhYD0elDnW9F/NcFn8Cr7
EuxFMxFmO9XY9B1EwOo79FIBOruXEctrddQ4CPVUp99UtH4zI7xn0RSbd9oqbl8k
93gZqnFEzP+nZJTqHZr0QGQ1xJAmCLMtjCRPfum88gsccWeq+ZpM1HeU7uez8ik+
ZdaR6pH3e+wqvdrRAxJBWYrEms3f9j90cQm24LH6Qei91072Ig4=
=Dxkk
-----END PGP SIGNATURE-----

--bEjdSXxHv0Az5++U--
