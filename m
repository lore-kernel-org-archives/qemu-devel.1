Received: from eggs.gnu.org ([2001:4830:134:3::10]:57488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f64Z6-0002b0-NA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f64Z1-0002E9-H2
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:28:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1f64Z1-0002Da-B3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:28:43 -0400
Date: Wed, 11 Apr 2018 11:28:24 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180411112824.27c3f42b@umbus.fritz.box>
In-Reply-To: <20180410100235.GC2559@work-vm>
References: <bb088a1ba2e344273db32402f7c9fae4@linux.vnet.ibm.com>
	<20180404080600.GA10540@xz-mi>
	<0a48a834f08d064eaa3eb4ef1b41235f@linux.vnet.ibm.com>
	<20180409185747.GL2449@work-vm>
	<20180410112255.7485f2a7@umbus.fritz.box>
	<20180410100235.GC2559@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/+hb753CaGhsT/wqkEahyxTi";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com

--Sig_/+hb753CaGhsT/wqkEahyxTi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Apr 2018 11:02:36 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * David Gibson (dgibson@redhat.com) wrote:
> > On Mon, 9 Apr 2018 19:57:47 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >  =20
> > > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote: =20
> > > > On 2018-04-04 13:36, Peter Xu wrote:   =20
> > > > > On Wed, Apr 04, 2018 at 11:55:14AM +0530, Balamuruhan S wrote: =20
> > [snip] =20
> > > > > > > - postcopy: that'll let you start the destination VM even wit=
hout
> > > > > > >   transferring all the RAMs before hand   =20
> > > > > >=20
> > > > > > I am seeing issue in postcopy migration between POWER8(16M) ->
> > > > > > POWER9(1G)
> > > > > > where the hugepage size is different. I am trying to enable it =
but
> > > > > > host
> > > > > > start
> > > > > > address have to be aligned with 1G page size in
> > > > > > ram_block_discard_range(),
> > > > > > which I am debugging further to fix it.   =20
> > > > >=20
> > > > > I thought the huge page size needs to be matched on both side
> > > > > currently for postcopy but I'm not sure.   =20
> > > >=20
> > > > you are right! it should be matched, but we need to support
> > > > POWER8(16M) -> POWER9(1G)
> > > >    =20
> > > > > CC Dave (though I think Dave's still on PTO).   =20
> > >=20
> > > There's two problems there:
> > >   a) Postcopy with really big huge pages is a problem, because it tak=
es
> > >      a long time to send the whole 1G page over the network and the v=
CPU
> > >      is paused during that time;  for example on a 10Gbps link, it ta=
kes
> > >      about 1 second to send a 1G page, so that's a silly time to keep
> > >      the vCPU paused.
> > >=20
> > >   b) Mismatched pagesizes are a problem on postcopy; we require that =
the
> > >      whole of a hostpage is sent continuously, so that it can be
> > >      atomically placed in memory, the source knows to do this based on
> > >      the page sizes that it sees.  There are some other cases as well=
=20
> > >      (e.g. discards have to be page aligned.) =20
> >=20
> > I'm not entirely clear on what mismatched means here.  Mismatched
> > between where and where?  I *think* the relevant thing is a mismatch
> > between host backing page size on source and destination, but I'm not
> > certain. =20
>=20
> Right.  As I understand it, we make no requirements on (an x86) guest
> as to what page sizes it uses given any particular host page sizes.

Right - AIUI there are basically separate gva->gpa and gpa->hpa page
tables and the pagesizes in each are unrelated.  That's also how it
works on POWER9 radix mode, so it doesn't suffer this restriction
either. In hash mode, though, there's just a single va->hpa hashed page
table which is owned by the host and updated by the guest via hcall.

>  [...] =20
> >=20
> > Sounds feasible, but like something that will take some thought and
> > time upstream. =20
>=20
> Yes; it's not too bad.
>=20
> > > (a) is a much much harder problem; one *idea* would be a major
> > > reorganisation of the kernels hugepage + userfault code to somehow
> > > allow them to temporarily present as normal pages rather than a
> > > hugepage. =20
> >=20
> > Yeah... for Power specifically, I think doing that would be really
> > hard, verging on impossible, because of the way the MMU is
> > virtualized.  Well.. it's probably not too bad for a native POWER9
> > guest (using the radix MMU), but the issue here is for POWER8 compat
> > guests which use the hash MMU. =20
>=20
> My idea was to fill the pagetables for that hugepage using small page
> entries but using the physical hugepages memory; so that once we're
> done we'd flip it back to being a single hugepage entry.
> (But my understanding is that doesn't fit at all into the way the kernel
> hugepage code works).

I think it should be possible with hugepage code, although we might end
up only the physical allocation side of the existing hugepage code, not
the actual putting it in the pagetable parts.  Which is not to say
there couldn't be some curly edge cases.

The bigger problem for us is it really doesn't fit with the way HPT
virtualization works.  The way the hcalls are designed assume a 1-to-1
correspondance between PTEs in the guest view and real hardware PTEs.
It's technically possible, I guess, that we could set up a shadow hash
table beside the guest view of the hash table and populate the former
based on the latter, but it would be a complete PITA.

> > > Does P9 really not have a hugepage that's smaller than 1G? =20
> >=20
> > It does (2M), but we can't use it in this situation.  As hinted above,
> > POWER9 has two very different MMU modes, hash and radix.  In hash mode
> > (which is similar to POWER8 and earlier CPUs) the hugepage sizes are
> > 16M and 16G, in radix mode (more like x86) they are 2M and 1G.
> >=20
> > POWER9 hosts always run in radix mode.  Or at least, we only support
> > running them in radix mode.  We support both radix mode and hash mode
> > guests, the latter including all POWER8 compat mode guests.
> >=20
> > The next complication is because the way the hash virtualization works,
> > any page used by the guest must be HPA-contiguous, not just
> > GPA-contiguous.  Which means that any pagesize used by the guest must
> > be smaller or equal than the host pagesizes used to back the guest.
> > We (sort of) cope with that by only advertising the 16M pagesize to the
> > guest if all guest RAM is backed by >=3D 16M pages.
> >=20
> > But that advertisement only happens at guest boot.  So if we migrate a
> > guest from POWER8, backed by 16M pages to POWER9 backed by 2M pages,
> > the guest still thinks it can use 16M pages and jams up.  (I'm in the
> > middle of upstream work to make the failure mode less horrible).
> >=20
> > So, the only way to run a POWER8 compat mode guest with access to 16M
> > pages on a POWER9 radix mode host is using 1G hugepages on the host
> > side. =20
>=20
> Ah ok;  I'm not seeing an easy answer here.
> The only vague thing I can think of is if you gave P9 a fake 16M
> hugepage mode, that did all HPA and mappings in 16M chunks (using 8 x 2M
> page entries).

Huh.. that's a really interesting idea.  Basically use the physical
allocation side of the hugepage stuff to allow allocation of 16M
contiguous chunks, even though they'd actually be mapped with 8 2M PTEs
when in radix mode.  I'll talk to some people and see if this might be
feasible.

Otherwise I think we basically just have to say "No, won't work" to
migrations of HPT hugepage backed guests to a radix host.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/+hb753CaGhsT/wqkEahyxTi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrNZLkACgkQbDjKyiDZ
s5KmEhAAlhdh3KKkYVJx9a1yRIgDpiSXw+y6WpzGA83GaA6dePmgOk+6oIVRDQ0a
SwAlqdX1P0IylQVs6IwToPrNHiWyesCwyrG4MR0VJbigGfEcV3oubzjqz0IEiS2o
kao9ynV+h7/2QEkXOss5nyEIo4Fjab9ic4HwwVe8oLiZ+5H6ZdFFK1+oRQH6RScV
JgOMC9QKcli/LEt5uzlRy0Ujw/VWgW01kMfoS/dqPIUXYWAcN3A8jx09LkZvrZCP
2dsNeQELLvmDfHlvMEBTNSvabVD3eTvI/yq97vKGkzWUtdDAvrl3ixgzdTjJzCgW
SGBNgHCKKfZ+qn/a5FqkWKg9iGJpMWUBGqaqhgscKKOPI/bFTrtJ1MsS/O4gi3ji
MsZjNaq7m2FXsmspz5tdrvGjyFkPX8GTKqO6WuHfCRw04+8ENfgzCm8WGEFpVk6Q
1HWjz+ZMtfXhER4jjy9A0AIZX7uFgR+jZHJwwVgYB4K1k5N+6pwsHmGKFJuKK1n7
i2Q3ci4u8M2OsbL55bQcNPjvHlRjKNzIhaHa2Jijn1OtbBSBndYlikRxvVQyUZUg
054FCEf5mgXNCfMyEYhYSnzZhPXaBXhUISBZi9IfjI8JAuAitd+GnnYtYf2zGxuF
Oj9uGAEpD4aQHLfYh6F37qkZgq/tYJ8eNvDnoN0AGjxwg4rPLyg=
=tPRl
-----END PGP SIGNATURE-----

--Sig_/+hb753CaGhsT/wqkEahyxTi--
