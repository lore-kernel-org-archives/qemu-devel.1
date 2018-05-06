Received: from eggs.gnu.org ([2001:4830:134:3::10]:35882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fFK7N-0008BO-8e
	for qemu-devel@nongnu.org; Sun, 06 May 2018 09:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fFK7L-0005OC-IJ
	for qemu-devel@nongnu.org; Sun, 06 May 2018 09:54:25 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fFK7K-0005JS-Eb
	for qemu-devel@nongnu.org; Sun, 06 May 2018 09:54:23 -0400
Date: Sun, 6 May 2018 23:53:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180506135312.GQ13229@umbus.fritz.box>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
	<CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wTzoGrkn2AhIv4sC"
Content-Disposition: inline
In-Reply-To: <CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>


--wTzoGrkn2AhIv4sC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 09:59:50AM +1200, Michael Clark wrote:
> On Sat, May 5, 2018 at 11:48 PM, David Gibson <david@gibson.dropbear.id.a=
u>
> wrote:
>=20
> > On Sat, May 05, 2018 at 11:44:25AM +0100, Peter Maydell wrote:
> > > cc'ing David -- is this the best way to do this?
> > >
> > > (It would be nicer if libfdt would just dynamically
> > > reallocate the buffer as needed,
> >
> > That's a deliberate design tradeoff.  Because it's designed to be
> > embeddable in really limited environments, libfdt tries to keep to
> > really minimal dependencies - in particular it doesn't depend on an
> > allocator.
> >
> > It'd be nice to have another (optional) layer on top that does
> > reallocate automatically.allocator.  In principle it's pretty simple -
> > you just call down to the existing functions and if they return
> > FDT_ERR_NOSPACE, rellocate and retry.  I've never had the time to
> > write it though - especially since in most simple cases just
> > allocating a far-to-big buffer initially actually works pretty well,
> > crude though it may be.
> >
> > For complex fdt manipulations.. well.. there comes a point where fdt
> > is the wrong tool for the job and you'd be better off using a "live"
> > representation of the tree and just flattening it when you're
> > finished.  IMO qemu is already past that point.  I send some early
> > draft patches adding live tree infrastructure a while back but got too
> > sidetracked by higher priorities to follow it through.
> >
> > > and then tell you
> > > the final size, rather than having to specify a
> > > maximum buffer size up front, but given the API we
> > > have a "tell me how big this thing actually is"
> > > function seems reasonable. I'm just surprised we
> > > need to know so much about the DT internals to do it.)
> >
> > I'm not familiar with the rest of this thread, so I'm not sure at what
> > point you're wanting to know this.  If it's only right at the end
> > before loading the final blob you can fdt_pack() and then check
> > fdt_totalsize().
>=20
> Okay, so an alternative is to call fdt_pack() and then fdt_totalsize().
> Thanks!

Yes.

> QEMU has its own wrapper around libfdt and neither the fdt_pack() nor
> fdt_totalsize() functions are exposed.
>=20
> Some architecture use only the wrapper functions provided by
> qemu/include/include/sysemu/device_tree.h
>=20
> It seems that target/ppc has #include <libfdt.h> and calls fdt_pack() and
> fdt_totalsize() directly.
>=20
> Some architectures appear to copy the unpacked fdt into their ROMS where
> the allocated size in QEMU defaults to 1MiB.

See my other reply for some of the history of that.

> QEMU has a wrapper function called create_device_tree that
> calls fdt_create(), fdt_finish_reservemap(), fdt_begin_node(),
> fdt_end_node(), fdt_finish(), fdt_open_into()
> with a 1MiB initial buffer size. The resulting device tree is modified in
> memory using various QEMU wrapper APIs that call fdt_setprop_string(),
> fdt_setprop_cell(), etc

Ah.. we should probably get rid of that. libfdt now has
fdt_create_empty_tree() built into it, which does basically the same
thing.

> For RISC-V we were able to get an accurate size using this function:
>=20
> size_t qemu_fdt_totalsize(void *fdt)
> {
>     return fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt) +
>            fdt_size_dt_strings(fdt) + sizeof(uint32_t) /* terminator */;
> }
>=20
> Now that we're aware of fdt_pack() and then fdt_totalsize() then we can
> avoid changing target neutral code in
> qemu/include/include/sysemu/device_tree.h by following ppc's lead and add
> #include <libfdt.h> and call fdt_pack() and fdt_totalsize() directly.
>=20
> The thing I spotted in fdt_resize() was the calculation to check that the

Note that fdt_resize() works on trees in "sequential write" mode -
using it on completed trees (which is nearly all of qemu's fdt
manipulation) won't work (or if it does, only by accident).

> new buffer was large enough however it excludes dt_off_dt_struct(fdt) and
> space for the uin32_t terminator. See here:

Uh.. what uint32_t terminator?

> int fdt_resize(void *fdt, void *buf, int bufsize)
> {
> ...
>=20
> headsize =3D fdt_off_dt_struct(fdt);

=2E. and it's including off_dt_struct right here.

> tailsize =3D fdt_size_dt_strings(fdt);
>=20
> if ((headsize + tailsize) > bufsize)
> return -FDT_ERR_NOSPACE;
>=20
> ...
>=20
> return 0;
> }
>=20
> >
> > > thanks
> > > -- PMM
> > >
> > > On 4 May 2018 at 02:19, Michael Clark <mjc@sifive.com> wrote:
> > > > Currently the device-tree create_device_tree function
> > > > returns the size of the allocated device tree buffer
> > > > however there is no way to get the actual amount of
> > > > buffer space used by the device-tree.
> > > >
> > > > 14ec3cbd7c1e31dca4d23f028100c8f43e156573 increases
> > > > the FDT_MAX_SIZE to 1 MiB. This creates an issue
> > > > for boards that have less than 1 MiB in their ROM
> > > > for device tree. While cpu_physical_memory_write
> > > > will not write past the end of a buffer there is
> > > > and a board is aware of its ROM buffer size, so
> > > > can use min(fdt_size,rom_size); this provides no
> > > > indication as to whether the device-tree may be
> > > > truncated. qemu_fdt_totalsize allows a board to
> > > > check that a dynamically created device tree will
> > > > fit within its alloted ROM space.
> > > >
> > > > Add qemu_fdt_totalsize which uses the logic and
> > > > public APIs from libfdt to calculate the device
> > > > size: struct_offset + struct_size + strings_size
> > > > + terminator.
> > > >
> > > > Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> > > > Cc: Alexander Graf <agraf@suse.de>
> > > > Cc: Alistair Francis <Alistair.Francis@wdc.com>
> > > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > > ---
> > > >  device_tree.c                | 6 ++++++
> > > >  include/sysemu/device_tree.h | 6 ++++++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/device_tree.c b/device_tree.c
> > > > index 52c3358a5583..3a2166d61f37 100644
> > > > --- a/device_tree.c
> > > > +++ b/device_tree.c
> > > > @@ -215,6 +215,12 @@ void *load_device_tree_from_sysfs(void)
> > > >
> > > >  #endif /* CONFIG_LINUX */
> > > >
> > > > +size_t qemu_fdt_totalsize(void *fdt)
> > > > +{
> > > > +    return fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt) +
> > > > +           fdt_size_dt_strings(fdt) + sizeof(uint32_t) /* terminat=
or
> > */;
> > > > +}
> > > > +
> > > >  static int findnode_nofail(void *fdt, const char *node_path)
> > > >  {
> > > >      int offset;
> > > > diff --git a/include/sysemu/device_tree.h
> > b/include/sysemu/device_tree.h
> > > > index e22e5bec9c3f..4af232dfdc65 100644
> > > > --- a/include/sysemu/device_tree.h
> > > > +++ b/include/sysemu/device_tree.h
> > > > @@ -26,6 +26,12 @@ void *load_device_tree_from_sysfs(void);
> > > >  #endif
> > > >
> > > >  /**
> > > > + * qemu_fdt_total_size: returns the size required to store the cur=
rent
> > > > + * device tree versus the buffer size returned by create_device_tr=
ee
> > > > + */
> > > > +size_t qemu_fdt_totalsize(void *fdt);
> > > > +
> > > > +/**
> > > >   * qemu_fdt_node_path: return the paths of nodes matching a given
> > > >   * name and compat string
> > > >   * @fdt: pointer to the dt blob
> > >
> >
> >

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wTzoGrkn2AhIv4sC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrvCMMACgkQbDjKyiDZ
s5JiIQ/+I4TKVmFO8wG57b4pc25ZC5CzIpNuvX2oZ06D5a32oWeHgZ3FkoH7fJwK
PVX6HOOp+P0xoz9bf1XZkyyql3NdfReNk2TSXvIozgN+EbGZERRz2ONfe7cXkjh4
L5IaFBHxLZ4Uo3tl1yItj4K6ah2tDTzbqVvcx6E70wDBiInolourD6z6TOphHuGj
pc9FB63gOLAgTJDA3z9yafbd6WEyDwwHynzkGwmfeaLiG9MeBYFS74MI4FwK3hgJ
NwmV9ZJQXNvFk5NTrXBm/Y7o7OaUJEwNp8zweyapzyAiLcqOa5F5Grtfn26fflxO
sDFwAEhWeI+ghyB0e/7u5GrS2JwoFkRPyJPG355au295g5ZCtzu0ob9truW1++q9
XEnBiEe1DG9+F8hVD54faWkBSuzNHa4Mec/27DMm9PEGCiUyi5FyvpV9bQ02RVbR
hGFzyef7hrDL0VTsN4/qE5JxKsN4o9DK/jxBWtG03q0sTf6EmKQuVpQsboiIiPcj
O/4Q97oIzgIqcZBx77GkLkm1Fq7DkkvKuznTZlDa5skD8YgKq4ljCxTwOLyXoTsM
V+qhfg1qumlTDM6J6bL1ozqL5/MTk9Avt3UwhD/tuOOKW3OF5+uQJpzwzajuhc/l
ZOzfxd4yThcyVqP0prilH4m2RA4MASZgBzFJoaBN1rhX+a/eTto=
=3fBY
-----END PGP SIGNATURE-----

--wTzoGrkn2AhIv4sC--
