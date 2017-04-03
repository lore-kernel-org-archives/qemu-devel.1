Received: from eggs.gnu.org ([2001:4830:134:3::10]:41743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cv2MH-0004Fa-He
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1cv2ME-0007AC-Bf
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1cv2ME-0007A0-3Q
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:49:22 -0400
Date: Mon, 3 Apr 2017 15:50:12 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170403135012.GY26598@andariel.pipo.sk>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2y/feSa6JmJqKeZ6"
Content-Disposition: inline
In-Reply-To: <20170403130041.GD5036@noname.str.redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>


--2y/feSa6JmJqKeZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 15:00:41 +0200, Kevin Wolf wrote:
> Am 03.04.2017 um 14:39 hat Max Reitz geschrieben:
> > On 03.04.2017 10:15, Kevin Wolf wrote:
> > > Am 31.03.2017 um 19:43 hat Max Reitz geschrieben:
> >=20
> > [...]
> >=20
> > >> So in theory all that's necessary is to set share-rw=3Don for the de=
vice
> > >> in the management layer. But I'm not sure whether that's practical.
> > >=20
> > > Yes, libvirt needs to provide this option if the guest supports shari=
ng.
> > > If it doesn't support sharing, rejecting a read-write NBD client seems
> > > correct to me.
> > >=20
> > > Peter, Eric, what is the status on the libvirt side here?
> > >=20
> > >> As for just allowing the NBD server write access to the device... To=
 me
> > >> that appears pretty difficult from an implementation perspective. We
> > >> assert that nobody can write without having requested write access a=
nd
> > >> we make sure that nobody can request write access without it being
> > >> allowed. Making an exception for NBD seems very difficult and would
> > >> probably mean we'd have to drop the assertion for write accesses alt=
ogether.
> > >=20
> > > Making an exception would simply be wrong.
> >=20
> > Indeed. That is why it would be so difficult.
> >=20
> > The question remains whether it is practical not to make an exception.
> > As far as I know, libvirt is only guaranteed to support older qemu
> > versions, not necessarily future ones. So we should be allowed to break
> > existing use cases here until libvirt is updated (assuming it is
> > possible for libvirt to express "guest device allows shared writes" as
> > an option for its next release).
>=20
> If I understand correctly, this is a case of incoming live migration,
> i.e. the virtio-blk device which is blocking the writes to the image
> doesn't really belong to a running guest yet.

Yes, exactly. libvirt starts the NBD server on the destination of
the migration. Until then the VM did not ever run yet. The VM will run
once the memory migration finishes, so the guest front-end will not
write anything at that point.

> So if we need to make an exception (and actually reading the context
> makes it appear so), I guess it would have to be that devices actually
> can share the write permission during incoming migration, but not any
> more later (unless the share-rw flag is set).

Yes, this would be desired to avoid a regression. Libvirt then tears
down the mirror prior to resuming the VM (afaik).

--2y/feSa6JmJqKeZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAljiUxAACgkQHGwCByjY
1GoDfxAAuc4AyWANojVA77edFXKjuVd0YELq09VdXDdTrhK5fZWa23RYl1sRdHV5
gcJAB1w5kYKwKK2ckEbicQKheiyjh67g1lfJ1+2ouEPaxhlbYIxZPyZCmURNHuqV
Yyu9/8ZhVzi1GLNrwC8Fr6/vqP9+g3r2nZI68PeD6HbJ50jZhbq/oQ1eyjB/LzNJ
LSGz/f/Hc6KdLyosmdLtR8OczJyd7x5C+1Q+urAJPZZgzkw/Xf69h+AnqvJtLHN5
KOQ03M4yPwsYZePBJUR0juEDErIeEli2WjdEe5YXkwvcucZfs4b10dIRUNoE3kJo
/jIdbhDwe01sRug4EIbgOb3CRoo/SrZCUPLu0mzfdZtZqwvqgyeYgPBGDJ3PHxCR
qQsvWp6fBVorkYnAezVLWsAzd0TH6HZgiHLjUAs4iV6/U7CgRpMlgvHAgLTGYTR+
NzNtWyHpPP80x/ca/4zWO6vjXyuTtJa+/lF9I0gsfi8xsnXYRsiaEHkq576RQQMb
1DI7gnoFSShH+u2EVKmR6lJEIH4d0MwySTH7Ij8seajrb5nazCR9m3EkVuVEFwW1
VVMMP9ZS0exqsz5FMSg1t+cZDfzeAVxl4rf2wcInrSULeJQZom9cHPdBTCYGgH/w
HveC7zJ/uL1rvwGTuI7zx+iQHmB/lsodt1YAz0buVAra561e0dY=
=ouUB
-----END PGP SIGNATURE-----

--2y/feSa6JmJqKeZ6--
