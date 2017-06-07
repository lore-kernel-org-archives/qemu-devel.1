Received: from eggs.gnu.org ([2001:4830:134:3::10]:47222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIdF3-0005J9-RM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIdF2-0003na-QZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:51:29 -0400
Date: Wed, 7 Jun 2017 17:51:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170607155118.GE8144@noname.redhat.com>
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
	<20170601091224.GB4987@noname.redhat.com>
	<8baa473d-d756-2a0b-3356-1cc00f31bd25@openvz.org>
	<b1171a15-72c2-ca25-2d7b-e0abde8a71f3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <b1171a15-72c2-ca25-2d7b-e0abde8a71f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.06.2017 um 15:37 hat Max Reitz geschrieben:
> On 2017-06-01 13:11, Denis V. Lunev wrote:
> > On 06/01/2017 12:12 PM, Kevin Wolf wrote:
> >> Am 31.05.2017 um 17:03 hat Eric Blake geschrieben:
> >>> On 05/31/2017 09:43 AM, Pavel Butsykin wrote:
> >>>> This patch adds the reduction of the image file for qcow2. As a resu=
lt, this
> >>>> allows us to reduce the virtual image size and free up space on the =
disk without
> >>>> copying the image. Image can be fragmented and reduction is done by =
punching
> >>>> holes in the image file.
> >>>>
> >>>> # ./qemu-img create -f qcow2 -o size=3D4G image.qcow2
> >>>> Formatting 'image.qcow2', fmt=3Dqcow2 size=3D4294967296 encryption=
=3Doff cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> >>>>
> >>>> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
> >>> So this is 1G of guest-visible data...
> >>>
> >>>> # ./qemu-img resize image.qcow2 128M
> >>>> Image resized.
> >>> ...and you are truncating the image by throwing away guest-visible
> >>> content, with no warning or double-checking (such as requiring a -f
> >>> force parameter or something) about the data loss.  Shrinking images =
is
> >>> something we should allow, but it feels like is a rare enough operati=
on
> >>> that you don't want it to be casually easy to throw away data.
> >>>
> >>> Is it feasible to require that a shrink operation will not be perform=
ed
> >>> unless all clusters being eliminated have been previously discarded (=
or
> >>> maybe written to zero), as an assurance that the guest did not care
> >>> about the tail of the image?
> >> I think that ship has sailed long ago because raw images have always
> >> supported shrinking images without any special checks or options. We
> >> want consistency between raw and qcow2, and we also need to provide
> >> backwards compatibility.
> >>
> >> The only thing I can imagine we could do now is to introduce a --shrink
> >> option in qemu-img, print a deprecation warning for shrinking without
> >> this option, and then make it mandatory in a few years.
>=20
> Do I hear a "3.0"?

You do.

> >> If we want to distinguish based on the block driver, so that we can
> >> require --shrink for all drivers that didn't support shrinking until
> >> now, we'd have to check the .bdrv_truncate() implementations of all
> >> drivers to see whether it already allowed shrinking.
>=20
> We could have an ugly raw-only hack directly in qemu-img (and
> qmp_block_resize) until 3.0.
>=20
> I'm really concerned about someone mistyping something and accidentally
> dropping a digit.

Me too. But still we can't break working command lines (at least before
3.0).

I'm okay with temporary hacks in qemu-img, but did you check whether
it's really raw-only? We know that raw can shrink currently and qcow2
can't, but there are 12 drivers implementing .bdrv_truncate, not only
two.

> > Will the solution proposed by Pavel in the answer to Max work:
> > - if there are no data blocks in the truncated space, truncate is allow=
ed
> >   without additional options
> > - if there are data blocks in the truncated space, truncate is allowed
> >   with the flag --force or error is generated
>=20
> I'd be OK with that, but I'm not sure we really need it.

Agreed. It would add a lot of complexity for little use. As I wrote in a
previous mail: I don't even know how I would discard the unpartitioned
space after shrinking my guest filesystem.

> It would be nice to have for convenience, but I don't think it solves
> the backwards-compatibility problem (as said by Kevin), and I'm not
> sure it makes things that much more convenient: Just specifying
> --force is easier than to manually trim the device in the guest (and
> then maybe having to specify --force anyway because you didn't do it
> right).

I think it should be specifically --shrink rather than an unspecific
--force that could mean anything.

Kevin

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZOCD2AAoJEH8JsnLIjy/W290P/i/TIf5tYh6sWxQ2dVNg8NBq
IkCgSEw+/zPGDWdqe+wpSKsRJnqDdJ07tQW+3i/09Ys1FyHjivxHtQFVyMIA/4G9
MUcj6ICh/xnt5BQN0+uk7zBUST1mZyEjKH+9CTgHrt9FUJqYl+J2xBqbA6m0tSj8
gN60KsbrOcwKtxLb121/x3EhvmxRF5K2LO6bYsk0ge5EGqH5KHfKNWiHzQ8IEWsw
Nh0inTXOI2jsklgcjLPwBHj6xeQxFAz1MYnAyS+ndR2ERmEjgc4pliUN0OtJwTxo
7s1H27xTXbOV3GANboYnA0KwqWqVEjU6sSCcAbVPXPyR/YiJVtIizIlCO/jR5NmZ
Ozw2z1gPep2IF6qoi1cR1E8lKg0pdU0iw6nXBl7H7Xfp5aqeqN0M91aMdNQG9/Cn
3TmrxT+ILnfdlnwq0fq+BYXM69NfHvDLS4SgCRQ3K7aoADbTAwZSvF/ownjK3uc1
2NTBI5nnLTynVs+fSvgoMVRCQLiQbNIVgsNj3tfLe41ujFAeejRzPUgJhsSkhmId
mh1aB/t2zyYAiCqFqZMFHV0bSFeXC1kvq6AwldUHdgWe3RC5n74eNKxSxrZfbKDp
zK8YmzcfuikD+b85WfEZXWKMpmu3u44B0FbwyGZvYtTzXnaM7pcO3r9SeqMRpXK2
SDpSCiMUBxJwpHuodiGb
=l+gY
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
