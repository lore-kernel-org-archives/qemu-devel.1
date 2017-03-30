Received: from eggs.gnu.org ([2001:4830:134:3::10]:54197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctcHE-00058i-SE
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctcHB-0005xI-N1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:46:20 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:41942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctcHB-0005wW-G4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:46:17 -0400
Received: from player159.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C55F15A910
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 17:46:15 +0200 (CEST)
Date: Thu, 30 Mar 2017 17:46:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170330174608.0ed57618@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <c65ce78e-9a33-ee17-0a49-2a28390060f0@redhat.com>
References: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
	<c65ce78e-9a33-ee17-0a49-2a28390060f0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/bdJ5hmHQK_6Gko/zJ1jqefd";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] 9pfs: fix migration_block leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>, qemu-devel@nongnu.org, ppandit@redhat.com

--Sig_/bdJ5hmHQK_6Gko/zJ1jqefd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Mar 2017 08:25:25 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 03/30/2017 07:27 AM, Li Qiang wrote:
> > The guest can leave the pdu->s->migration_blocker exists by attach =20
>=20
> s/exists/in place/
> s/attach/attaching/
>=20
> > but not remove a fid. Then if we hot unplug the 9pfs device, the =20
>=20

In theory you're right, but the current 9p client in linux won't let you hot
unplug the device unless you unmount the 9p share first, hence freeing the
blocker.

> s/remove/removing/
>=20
> > v9fs_reset() just free the fids, but not free the migration_blocker.
> > This will leak a memory leak. This patch avoid this. =20

I had a similar issue sitting my TODO list for quite a time: the blocker
survives a system_reset. It doesn't cause a memory leak but it prevents
migration until the guest mounts/unmounts the 9p share again.

This boils down to virtfs_reset() calling free_fid() instead of put_fid() I=
IRC.

>=20
> s/leak a/cause a/
> s/avoid/avoids/
>=20
> >=20
> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > ---
> >  hw/9pfs/9p.c | 6 ++++++
> >  1 file changed, 6 insertions(+) =20
>=20
> Probably worth including in 2.9 as a bug fix.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> >=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 48babce..b55c02d 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -548,6 +548,12 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
> >              free_fid(pdu, fidp);
> >          }
> >      }
> > +
> > +    if (pdu->s->migration_blocker) {
> > +        migrate_del_blocker(pdu->s->migration_blocker);
> > +        error_free(pdu->s->migration_blocker);
> > +        pdu->s->migration_blocker =3D NULL;
> > +    }

I'd prefer to drain all PDUs in virtfs_reset() and have the loop above
to call put_fid() instead of free_fid(). If this isn't doable for 2.9,
I'll apply this patch with a comment.

> >  }
> > =20
> >  #define P9_QID_TYPE_DIR         0x80
> >  =20
>=20


--Sig_/bdJ5hmHQK_6Gko/zJ1jqefd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljdKEEACgkQAvw66wEB28LeKgCeOcgrWSdsXOORDXTFo58IMF19
F5EAoITYYGxA/PjzzI/R4a2sHD0Z8EWp
=v3c0
-----END PGP SIGNATURE-----

--Sig_/bdJ5hmHQK_6Gko/zJ1jqefd--
