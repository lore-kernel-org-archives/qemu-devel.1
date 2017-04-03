Received: from eggs.gnu.org ([2001:4830:134:3::10]:36135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv3eG-0006SR-MZ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv3eA-0005MV-Hz
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:12:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cv3eA-0005MA-8G
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:11:58 -0400
Received: by mail-wr0-x241.google.com with SMTP id k6so33092015wre.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 08:11:58 -0700 (PDT)
Date: Mon, 3 Apr 2017 16:11:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403151154.GD3539@stefanha-x1.localdomain>
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170327172738.GG28620@stefanha-x1.localdomain>
	<CAAo6VWPPjX2UfU55rnR375jzmpMojUOHfmMafwBiZqBa80aBeQ@mail.gmail.com>
	<CAAo6VWNShCJDYkRSC-qCZ_X002ud5QLpHgP7V-51XaPqaRcggA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
In-Reply-To: <CAAo6VWNShCJDYkRSC-qCZ_X002ud5QLpHgP7V-51XaPqaRcggA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 11:25:02AM -0700, ashish mittal wrote:
> On Mon, Mar 27, 2017 at 6:04 PM, ashish mittal <ashmit602@gmail.com> wrot=
e:
> > On Mon, Mar 27, 2017 at 10:27 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
> >> On Sun, Mar 26, 2017 at 07:50:35PM -0700, Ashish Mittal wrote:
> >>
> >> Have you tested live migration?
> >>
> >> If live migration is not supported then a migration blocker should be
> >> added using migrate_add_blocker().
> >>
> >
> > We do support live migration. We have been testing a fork of this code
> > (slightly different version) with live migration.

The reason I ask is because this patch doesn't implement the
BlockDriver bdrv_invalidate_cache()/bdrv_inactivate() callbacks.  These
functions are invoked during live migration so that the block driver can
ensure data consistency.

Since the destination QEMU process is launched while the source QEMU is
still running and making changes to the disk, some block drivers need to
discard metadata at migration handover time that was read upon opening
the image on the destination.  The guarantees that they see the latest
metadata.

Not sure if libvxhs caches anything that might get stale during live
migration, but I wanted to raise this question?

Regarding a fork of this code that you haven't posted to the mailing
list, it doesn't exist as far as anyone here is concerned :).  Therefore
either the code on the mailing list needs to support migration or it
must register a migration blocker to prevent migration.

> >>> +static BlockDriver bdrv_vxhs =3D {
> >>> +    .format_name                  =3D "vxhs",
> >>> +    .protocol_name                =3D "vxhs",
> >>> +    .instance_size                =3D sizeof(BDRVVXHSState),
> >>> +    .bdrv_file_open               =3D vxhs_open,
> >>> +    .bdrv_parse_filename          =3D vxhs_parse_filename,
> >>> +    .bdrv_close                   =3D vxhs_close,
> >>> +    .bdrv_getlength               =3D vxhs_getlength,
> >>> +    .bdrv_aio_readv               =3D vxhs_aio_readv,
> >>> +    .bdrv_aio_writev              =3D vxhs_aio_writev,
> >>
> >> Missing .bdrv_aio_flush().  Does VxHS promise that every completed wri=
te
> >> request is persistent?
> >>
> >
> > Yes, every acknowledged write request is persistent.
> >
> >> In that case it may be better to disable the emulated disk write cache
> >> so the guest operating system and application know not to send flush
> >> commands.
> >
> > We do pass "cache=3Dnone" on the qemu command line for every block
> > device. Are there any other code changes necessary? Any pointers will
> > help.
> >
>=20
> Upon further reading, I now understand that cache=3Dnone will not
> disable the emulated disk write cache. I am trying to understand if -
> (1) It should still not be a problem since flush will just be a no-op for=
 us.

The guest operating system and applications may take different code
paths depending on the state of the disk write cache.

Useless vmexits can be eliminated if the guest doesn't need to send
flush commands.  Hence the file system and applications may perform
better.

> (2) Is there a way, or reason, to disable the emulated disk write
> cache in the code for vxhs? I think passing WCE=3D0 to the guest has
> something to do with this, although I have yet to figure out what that
> means.

Right, WCE =3D=3D "Write Cache Enable".  If you disable the write cache then
the guest's SCSI disk or virtio-blk drivers will notice that the disk
does not require flush commands.

Try launching a guest with -drive if=3Dnone,id=3Ddrive0,cache=3Ddirectsync,=
=2E..
and you should see that the write cache is disabled:

  # cat /sys/block/vda/queue/write_cache

> (3) Is this a must for merge?

This doesn't affect the block driver code so no change is necessary.

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4mY6AAoJEJykq7OBq3PIaTsH/1sf9Wh7fwcXEVDSdkhy8AOG
YE9z7E5hTk+j62tRXvGiTklRAabW4Ln6/wGt9vYlahbV8BEwKqDB5R5H1g+pyWjQ
P84HZ0vGKLewC9M0RXRe830UYn2lRUH0JxSOazLCpe82ssnqYnWkNmxPTxilEN6u
rRRpFpZnSQOM++zkoOxGv+h1ZFzqdkfCigkS6aHwsEgkI1KOJjawcb3YAe8y584b
Sg5lNgWCPfquKvywKK1p4nE2rRHrEXO+npu5E7nztiveUkytKEj1MTBAR4iu79fR
nNpxfP03veDzTm/2Zef7Gdf7IYU9yMDAAGh/sNmcXxLlNHTrNLaMjBq16x8/Xtk=
=YlZg
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
