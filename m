Received: from eggs.gnu.org ([2001:4830:134:3::10]:59262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctqev-0004Da-CY
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctqes-0004Ke-47
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:07:45 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:40525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctqer-0004JR-UB
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:07:42 -0400
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4F12A33F12
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 09:07:38 +0200 (CEST)
Date: Fri, 31 Mar 2017 09:07:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170331090731.27b10c0c@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAKXe6SKEbvxLWiCjSo7AYzAQmzdEGOeeYL47BYkcFPGx8VA20g@mail.gmail.com>
References: <1490876834-61392-1-git-send-email-liqiang6-s@360.cn>
	<c65ce78e-9a33-ee17-0a49-2a28390060f0@redhat.com>
	<20170330174608.0ed57618@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAKXe6SKEbvxLWiCjSo7AYzAQmzdEGOeeYL47BYkcFPGx8VA20g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ra+Ot=Y2mYfnsN0b5S2.rOz";
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
To: Li Qiang <liq3ea@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>

--Sig_/ra+Ot=Y2mYfnsN0b5S2.rOz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Mar 2017 09:26:35 +0800
Li Qiang <liq3ea@gmail.com> wrote:

> Hello,
>=20
> 2017-03-30 23:46 GMT+08:00 Greg Kurz <groug@kaod.org>:
>=20
> > On Thu, 30 Mar 2017 08:25:25 -0500
> > Eric Blake <eblake@redhat.com> wrote:
> >
> > > On 03/30/2017 07:27 AM, Li Qiang wrote:
> > > > The guest can leave the pdu->s->migration_blocker exists by attach
> > >
> > > s/exists/in place/
> > > s/attach/attaching/
> > >
> >
>=20
> Eric,
> Thanks for pointing my mistakes!
>=20
>=20
> > > > but not remove a fid. Then if we hot unplug the 9pfs device, the
> > >
> >
> > In theory you're right, but the current 9p client in linux won't let you
> > hot
> > unplug the device unless you unmount the 9p share first, hence freeing =
the
> > blocker.
> >
> >
> I think we should consider every possible situation.
>=20
>=20
> > > s/remove/removing/
> > >
> > > > v9fs_reset() just free the fids, but not free the migration_blocker.
> > > > This will leak a memory leak. This patch avoid this.
> >
> > I had a similar issue sitting my TODO list for quite a time: the blocker
> > survives a system_reset. It doesn't cause a memory leak but it prevents
> > migration until the guest mounts/unmounts the 9p share again.
> >
> > This boils down to virtfs_reset() calling free_fid() instead of put_fid=
()
> > IIRC.
> >
> > >
> > > s/leak a/cause a/
> > > s/avoid/avoids/
> > >
> > > >
> > > > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > > > ---
> > > >  hw/9pfs/9p.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > >
> > > Probably worth including in 2.9 as a bug fix.
> > >
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > >
> > > >
> > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > index 48babce..b55c02d 100644
> > > > --- a/hw/9pfs/9p.c
> > > > +++ b/hw/9pfs/9p.c
> > > > @@ -548,6 +548,12 @@ static void coroutine_fn virtfs_reset(V9fsPDU
> > *pdu)
> > > >              free_fid(pdu, fidp);
> > > >          }
> > > >      }
> > > > +
> > > > +    if (pdu->s->migration_blocker) {
> > > > +        migrate_del_blocker(pdu->s->migration_blocker);
> > > > +        error_free(pdu->s->migration_blocker);
> > > > +        pdu->s->migration_blocker =3D NULL;
> > > > +    }
> >
> > I'd prefer to drain all PDUs in virtfs_reset() and have the loop above
> > to call put_fid() instead of free_fid(). If this isn't doable for 2.9,
> > I'll apply this patch with a comment.
> >
> >
> Yes, I have considered to use put_fid() to fix this. But I'm not sure the
> 'fidp->ref' is  at most 1 in virtfs_reset() function(I think it is).
>=20

And indeed, if the fid is involved in an I/O then its ref will be !=3D 0.

> IIUC I think omit the 'else' branch, and call put_fid() directly like thi=
s.
>=20

This won't work: we must ensure that fidp->ref reaches zero (ie, drain
all PDUs), then we can fidp->ref++ (ie, get a ref on the fid) and call
put_fid(), which will drop the last ref of the fid and clear the blocker
if this is the root fid.

> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 48babce..ae97e79 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -544,9 +544,8 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
>=20
>          if (fidp->ref) {
>              fidp->clunked =3D 1;
> -        } else {
> -            free_fid(pdu, fidp);
>          }
> +        put_fid(pdu, fidp);
>      }
>  }
>=20
>=20
> If you agree, I will send a formal patch.
>=20
>=20
>=20
> > > >  }
> > > >
> > > >  #define P9_QID_TYPE_DIR         0x80
> > > >
> > >
> >
> >


--Sig_/ra+Ot=Y2mYfnsN0b5S2.rOz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljeADMACgkQAvw66wEB28KQJwCfRQFVm1hlPR6lmCxcFJExX6HJ
pJgAoJdR8u3oumm+qF14RFZjic50kHdQ
=+F/n
-----END PGP SIGNATURE-----

--Sig_/ra+Ot=Y2mYfnsN0b5S2.rOz--
