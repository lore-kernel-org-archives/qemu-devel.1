Received: from eggs.gnu.org ([2001:4830:134:3::10]:34269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEvfz-00028J-Bd
	for qemu-devel@nongnu.org; Sat, 05 May 2018 07:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEvfx-0006iR-UV
	for qemu-devel@nongnu.org; Sat, 05 May 2018 07:48:31 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fEvfw-0006dN-Mr
	for qemu-devel@nongnu.org; Sat, 05 May 2018 07:48:29 -0400
Date: Sat, 5 May 2018 21:48:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505114812.GO13229@umbus.fritz.box>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zvf7DYrKnARJlhgd"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>


--zvf7DYrKnARJlhgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 11:44:25AM +0100, Peter Maydell wrote:
> cc'ing David -- is this the best way to do this?
>=20
> (It would be nicer if libfdt would just dynamically
> reallocate the buffer as needed,

That's a deliberate design tradeoff.  Because it's designed to be
embeddable in really limited environments, libfdt tries to keep to
really minimal dependencies - in particular it doesn't depend on an
allocator.

It'd be nice to have another (optional) layer on top that does
reallocate automatically.allocator.  In principle it's pretty simple -
you just call down to the existing functions and if they return
FDT_ERR_NOSPACE, rellocate and retry.  I've never had the time to
write it though - especially since in most simple cases just
allocating a far-to-big buffer initially actually works pretty well,
crude though it may be.

For complex fdt manipulations.. well.. there comes a point where fdt
is the wrong tool for the job and you'd be better off using a "live"
representation of the tree and just flattening it when you're
finished.  IMO qemu is already past that point.  I send some early
draft patches adding live tree infrastructure a while back but got too
sidetracked by higher priorities to follow it through.

> and then tell you
> the final size, rather than having to specify a
> maximum buffer size up front, but given the API we
> have a "tell me how big this thing actually is"
> function seems reasonable. I'm just surprised we
> need to know so much about the DT internals to do it.)

I'm not familiar with the rest of this thread, so I'm not sure at what
point you're wanting to know this.  If it's only right at the end
before loading the final blob you can fdt_pack() and then check
fdt_totalsize().

>=20
> thanks
> -- PMM
>=20
> On 4 May 2018 at 02:19, Michael Clark <mjc@sifive.com> wrote:
> > Currently the device-tree create_device_tree function
> > returns the size of the allocated device tree buffer
> > however there is no way to get the actual amount of
> > buffer space used by the device-tree.
> >
> > 14ec3cbd7c1e31dca4d23f028100c8f43e156573 increases
> > the FDT_MAX_SIZE to 1 MiB. This creates an issue
> > for boards that have less than 1 MiB in their ROM
> > for device tree. While cpu_physical_memory_write
> > will not write past the end of a buffer there is
> > and a board is aware of its ROM buffer size, so
> > can use min(fdt_size,rom_size); this provides no
> > indication as to whether the device-tree may be
> > truncated. qemu_fdt_totalsize allows a board to
> > check that a dynamically created device tree will
> > fit within its alloted ROM space.
> >
> > Add qemu_fdt_totalsize which uses the logic and
> > public APIs from libfdt to calculate the device
> > size: struct_offset + struct_size + strings_size
> > + terminator.
> >
> > Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Alistair Francis <Alistair.Francis@wdc.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  device_tree.c                | 6 ++++++
> >  include/sysemu/device_tree.h | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/device_tree.c b/device_tree.c
> > index 52c3358a5583..3a2166d61f37 100644
> > --- a/device_tree.c
> > +++ b/device_tree.c
> > @@ -215,6 +215,12 @@ void *load_device_tree_from_sysfs(void)
> >
> >  #endif /* CONFIG_LINUX */
> >
> > +size_t qemu_fdt_totalsize(void *fdt)
> > +{
> > +    return fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt) +
> > +           fdt_size_dt_strings(fdt) + sizeof(uint32_t) /* terminator *=
/;
> > +}
> > +
> >  static int findnode_nofail(void *fdt, const char *node_path)
> >  {
> >      int offset;
> > diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
> > index e22e5bec9c3f..4af232dfdc65 100644
> > --- a/include/sysemu/device_tree.h
> > +++ b/include/sysemu/device_tree.h
> > @@ -26,6 +26,12 @@ void *load_device_tree_from_sysfs(void);
> >  #endif
> >
> >  /**
> > + * qemu_fdt_total_size: returns the size required to store the current
> > + * device tree versus the buffer size returned by create_device_tree
> > + */
> > +size_t qemu_fdt_totalsize(void *fdt);
> > +
> > +/**
> >   * qemu_fdt_node_path: return the paths of nodes matching a given
> >   * name and compat string
> >   * @fdt: pointer to the dt blob
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zvf7DYrKnARJlhgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtmfkACgkQbDjKyiDZ
s5L0DRAAr/4nwFSWfgsq+byZGvP/fOSDWEkqLjFy79o5vG4/qXFAw+zkQflUQvWr
5WoGUaFIvNhrS9272LeepJOQ/GdBLODrAoxnC0dKcP8kC4bWvFuO9TjgGfvN30Y9
tzOWU/DUEMtmFvzeNz9K0LIRHWdSioDytdvuWkrpOsO6Mnb2y1wY8GJyQB1spPaN
T5GYAsGZ9PIQAo85udypPmZqJRt3iwW7CjrRzcxgRrj0euZA6mL1vxVL2U1JfEbn
QfwDHjGM8rbnBp7FP2Gc4JONfuDOLuQ8BAjCwFPdTCNqo7RFyHVfH2xmOre3SwVb
Rj5IcS2iBjtNq/Fs29PZMuJJ3xxixVIdaLhgQurkMyLEn5aDagWGIsIluVL4YR8k
oB4/9v8j2ay1RF2xhS7w3eGLqbAQJqwaZOodMLiIO0i+W3Mh8qe7L/ykv4pXNJP5
iKtItjcP/H5Nklh0ynuCHYPkukByE0/KhZZWtjQCiLbOWcFHhdV+mCKQ6khXWoVw
WkqBkgW57L5sOAAasBjF6jVQr+h3bTX+A65Hb3DTDucd+YJnJ6YKudlGI2vyyxTj
AF6LbWdYNenM52RA6EZAzbB2jBLUwpzTWY1vByDT7M03nHjmER4TVnV491Hy0pYN
vIRB1UZDXnevrRXy0spcNIWg7vTNwHQXX4BzCe+xgSj0YtEuWIc=
=dVm6
-----END PGP SIGNATURE-----

--zvf7DYrKnARJlhgd--
