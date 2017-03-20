Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzah-0004yb-H0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzac-0004N3-LT
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cpzac-0004Mv-Co
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:51:22 -0400
Date: Mon, 20 Mar 2017 15:51:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170320155115.GE7320@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<CAMRbyyuOxePB5ErcGmkTErSd0FiezgaAjCDGRJWAr4ZGOgcK2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <CAMRbyyuOxePB5ErcGmkTErSd0FiezgaAjCDGRJWAr4ZGOgcK2A@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 0/8] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 11:45:20PM +0000, Nir Soffer wrote:
> On Wed, Mar 15, 2017 at 11:29 AM Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
>=20
> > RFCv2:
> >  * Publishing RFC again to discuss the new user-visible interfaces.  Co=
de
> > has
> >    changed quite a bit, I have not kept any Reviewed-by tags.
> >  * Rename qemu-img sub-command "measure" and API bdrv_measure() [Nir]
> >  * Report both "required bytes" and "fully allocated bytes" to handle t=
he
> > empty
> >    image file and prealloc use cases [Nir and Dan]
> >  * Use bdrv_getlength() instead of bdrv_nb_sectors() [Berto]
> >  * Rename "err" label "out" in qemu-img-cmds.c [Nir]
> >  * Add basic qcow2 support, doesn't support qemu-img convert from exist=
ing
> > files yet
> >
> > RFCv1:
> >  * Publishing patch series with just raw support, no qcow2 yet.  Please
> > review
> >    the command-line interface and let me know if you are happy with this
> >    approach.
> >
> > Users and management tools sometimes need to know the size required for=
 a
> > new
> > disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of
> > time.
> > Image formats like qcow2 have non-trivial metadata that makes it hard to
> > estimate the exact size without knowledge of file format internals.
> >
> > This patch series introduces a new qemu-img sub-command that calculates=
 the
> > required size for both image creation and conversion scenarios.
>=20
>=20
> > The conversion scenario is:
> >
> >   $ qemu-img measure -f raw -O qcow2 input.img
> >   required bytes: 1327680
> >   fully allocated bytes: 1074069504
>=20
>=20
> Other commands like qemu-img info are using "size" instead of "bytes", I
> guess
> we like to keep the term "size" for consistency.

Will fix.

> Here an existing image file is taken and the output includes the space
> > required
> > for data from the input image file.
> >
> > The creation scenario is:
> >
> >   $ qemu-img measure -O qcow2 --size 5G
> >   required bytes: 327680
> >   fully allocated bytes: 1074069504
> >
>=20
> There is a third scenario that you may want to describe
> here, extending a block device when it becomes full. In this case
> we want to limit the block device to the fully allocated size, including
> additional size needed for bitmaps. Currently ovirt is using virtual_size=
 *
> 1.1
> for this limit, which seems to work for images without additional bitmaps.

Please elaborate, I'm not sure which use case you mean:

1. The user wishes to grow the virtual disk size because the guest has
   filled up the disk.

2. The block device was thinly provisioned and needs to grow so that the
   guest can write more data.  In this case the virtual disk size stays
   constant.

Case #1 is the qemu-img convert case.  We have an existing file with
some data and the new image will have a larger virtual disk size.
(Nevermind that no actual new image needs to be created.)

Regarding case #2, the management tool doesn't need qemu-img measure.
It just increments the block device size by an arbitrary amount (e.g. 1
GB) whenever the write threshold is reached.

Stefan

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz/pzAAoJEJykq7OBq3PIQyQIAI26cQ5QtD3dYpRYv7i3LJaW
xWjB0f6+RpLh4C50MTU2GYG5uY36huU1tNgBENGVMNugoU4s10L/Cj3JJ4Q6FXcq
zEeCm4D47RhasJhEEkII6HA0fFNFqGePfmXxClDcB/Kd19P0XAatt8enr8dUZWb/
RV2YPKloJ2V28/kZzB78XEhf6jOUY+APU0SQMOXbEYIeE3TrFjumVdOC21ca2p64
sxs4z69QW+OdGn1qHGivR2Ikk7JDDJhoZtWo2U4iq0PdsAY383ipsJLw6I9pznDV
Twsoo4Ei+aIVALDnTU+yCi99YSEi9rHQoe3kxTlFu4ISfgrP3it2lE/kSVVpaVw=
=2lya
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
