Received: from eggs.gnu.org ([2001:4830:134:3::10]:60104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct3g5-0008Sd-U2
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct3g4-0004DJ-Pr
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:49:41 -0400
Date: Wed, 29 Mar 2017 13:24:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329022449.GN21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-6-git-send-email-imammedo@redhat.com>
	<20170328041920.GC21068@umbus.fritz.box>
	<20170328125310.4fa3da50@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Content-Disposition: inline
In-Reply-To: <20170328125310.4fa3da50@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/23] numa: move source of
 default CPUs to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 12:53:10PM +0200, Igor Mammedov wrote:
> On Tue, 28 Mar 2017 15:19:20 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Mar 22, 2017 at 02:32:30PM +0100, Igor Mammedov wrote:
> > > Originally CPU threads were by default assigned in
> > > round-robin fashion. However it was causing issues in
> > > guest since CPU threads from the same socket/core could
> > > be placed on different NUMA nodes.
> > > Commit fb43b73b (pc: fix default VCPU to NUMA node mapping)
> > > fixed it by grouping threads within a socket on the same node
> > > introducing cpu_index_to_socket_id() callback and commit
> > > 20bb648d (spapr: Fix default NUMA node allocation for threads)
> > > reused callback to fix similar issues for SPAPR machine
> > > even though socket doesn't make much sense there.
> > >=20
> > > As result QEMU ended up having 3 default distribution rules
> > > used by 3 targets /virt-arm, spapr, pc/.
> > >=20
> > > In effort of moving NUMA mapping for CPUs into possible_cpus,
> > > generalize default mapping in numa.c by making boards decide
> > > on default mapping and let them explicitly tell generic
> > > numa code to which node a CPU thread belongs to by replacing
> > > cpu_index_to_socket_id() with @cpu_index_to_instance_props()
> > > which provides default node_id assigned by board to specified
> > > cpu_index.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
[snip]
> > > +static CpuInstanceProperties
> > > +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > > +{
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> > > +    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids=
(ms);
> > > +
> > > +    assert(cpu_index < possible_cpus->len);
> > > +    return possible_cpus->cpus[cpu_index].props;;
> > > +}
> > > +
> >=20
> > It seems a bit weird to have a machine specific hook to pull the
> > property information when one way or another it's coming from the
> > possible_cpus table, which is already constructed by a machine
> > specific hook.  Could we add a range or list of cpu_index values to
> > each possible_cpus entry instead, and have a generic lookup of the
> > right entry based on that?

[snip]
> > > -static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
> > > +static CpuInstanceProperties
> > > +pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > >  {
> > > -    X86CPUTopoInfo topo;
> > > -    x86_topo_ids_from_idx(smp_cores, smp_threads, cpu_index,
> > > -                          &topo);
> > > -    return topo.pkg_id;
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> > > +    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids=
(ms);
> > > +
> > > +    assert(cpu_index < possible_cpus->len);
> > > +    return possible_cpus->cpus[cpu_index].props;;
> >=20
> > Since the pc and arm version of this are basically identical, I wonder
> > if that should actually be the default implementation.  If we need it
> > at all.
> ARM is still moving target and props are not really defined for it yet,
> so I'd like to keep it separate for now and when it stabilizes we can thi=
nk
> about generalizing it.

Fair enough.

Any thoughts on my more general query above

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2xrvAAoJEGw4ysog2bOSlYAP/R3QY/plG35cKCa9j0vQOxem
R6qBPoEojVFc7a+188bM8dR5SJi9HVAQ7qPvNtaPRlAAS/PqpaCpB9KdEJFlTO5D
DmvXTM8QLisJ77LgZlbsSrmnkGjE8NrdeR9663vJ6jrHoTALpeG4eEsG1IZDw0A9
cLjREmmU3xDlGPSYJfR33qaHiy5MAXg7i7I34IsLUBZxBMqVPEDetJkY6l1Ci+xb
vz56yQEg1BDyhlJbB5nz52noK+bIV1yOKhvGts/P6w5GMf0BmfNRxIfb0qJwYpNj
qAZP8gT3bb0samK1drhmt+LkGxUnFRiHJhU5yNquRRISVQ7N+DX4TXON5HSheKZA
JfkHgAgNB9n9XK9JzOBHoCbzIdzvRSQb0WGgB/e6NhG8zqTyyqxie0UhydjJKfdK
5xmaDtQNpd3EmADw4NeqmcmMNKsf4Os2pHta4A7XVsRVstGq5VHYjqPjUKuysC2Q
l9B7EGJ/Sjmaf/gEXbct2o2qBPdk8jXLxJcHKYOuXCekFz9jsmGHa2vLrwKDOuQt
KxbjbaXRRgq14AqKgr488ma82cZiyctWcnMjOLr1RlPXuF+urUDHL33JdEjBh9JP
EFz73LN39b25VIJh67topZ1j9Tq1K0nXlm1MIcS7gOZ/r8h3vtAvLLqVeTc2quFw
9VdjJzoHYWK3xsETgnxo
=KCgP
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--
