Received: from eggs.gnu.org ([2001:4830:134:3::10]:41377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBdtF-0006mN-8w
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBdt9-0007FL-CD
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:08:05 -0400
Date: Fri, 19 May 2017 10:07:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170519090750.GA12305@stefanha-x1.localdomain>
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-4-stefanha@redhat.com>
	<20170518081846.GB4646@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20170518081846.GB4646@noname.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] migration: avoid
 recursive AioContext locking in save_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 10:18:46AM +0200, Kevin Wolf wrote:
> Am 17.05.2017 um 19:09 hat Stefan Hajnoczi geschrieben:
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 7f66d58..a70ba20 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2153,6 +2153,14 @@ int save_vmstate(const char *name)
> >          goto the_end;
> >      }
> > =20
> > +    /* The bdrv_all_create_snapshot() call that follows acquires the A=
ioContext
> > +     * for itself.  BDRV_POLL_WHILE() does not support nested locking =
because
> > +     * it only releases the lock once.  Therefore synchronous I/O will=
 deadlock
> > +     * unless we release the AioContext before bdrv_all_create_snapsho=
t().
> > +     */
> > +    aio_context_release(aio_context);
> > +    aio_context =3D NULL;
> > +
> >      ret =3D bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
> >      if (ret < 0) {
> >          error_report("Error while creating snapshot on '%s'",
> > @@ -2163,7 +2171,9 @@ int save_vmstate(const char *name)
> >      ret =3D 0;
> > =20
> >   the_end:
> > -    aio_context_release(aio_context);
> > +    if (aio_context) {
> > +        aio_context_release(aio_context);
> > +    }
> >      if (saved_vm_running) {
> >          vm_start();
> >      }
>=20
> It might actually even be true before this patch because the lock is
> already only taken for some parts of the function, but don't we need to
> call bdrv_drain_all_begin/end() around the whole function now?
>=20
> We're stopping the VM, so hopefully no device is continuing to process
> requests, but can't we still have block jobs, NBD server requests etc.?
>=20
> And the same is probably true for qemu_loadvm_state().

Yes, they currently rely on bdrv_drain_all() but that's not enough.
Thanks for the suggestion, will add a patch in v2.

Stefan

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHrXmAAoJEJykq7OBq3PIt6YH/RTYZ+1dGx4Dtq1cvUD6Im42
+bfJUQ3QwYxvYpRnEMKLZ/Lpsxs8WGq+rs1olzA5Wu1B20KGod90QofzMVlFOP4x
KZLHG77AcwB/WBMMjKqhlVky93TcQgUJMI8wwsxVTPeo6VJjiV/wE8tSdMGr9ktN
meEbYdD6pBzAY8MlXi0Qd0aqBL09dIPR/wd/nIlZgO16eTkezRTnmOECTj0DeDKa
ewqreU2rcT8ntTlcULGzHwKmaUCKzszpucARpPP0s53/xFbJzXKBQ1u7IDiTUJdE
n+vonWtjXOSX4yxS1Vz2wfo8TVxW6K7niJff+fVe9RVVq3ufD/P4ugUBUJklQYQ=
=n6lV
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
