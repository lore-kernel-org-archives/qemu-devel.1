Received: from eggs.gnu.org ([2001:4830:134:3::10]:55363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dCnYQ-0004lh-D6
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dCnYP-0007SZ-DC
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:39:22 -0400
Date: Mon, 22 May 2017 14:39:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170522133910.GB24772@stefanha-x1.localdomain>
References: <20170519103247.4405-1-stefanha@redhat.com>
	<20170519103247.4405-5-stefanha@redhat.com>
	<20170522121735.GA6350@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20170522121735.GA6350@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] migration: use
 bdrv_drain_all_begin/end() instead bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 02:17:35PM +0200, Kevin Wolf wrote:
> Am 19.05.2017 um 12:32 hat Stefan Hajnoczi geschrieben:
> > blk/bdrv_drain_all() only takes effect for a single instant and then
> > resumes block jobs, guest devices, and other external clients like the
> > NBD server.  This can be handy when performing a synchronous drain
> > before terminating the program, for example.
> >=20
> > Monitor commands usually need to quiesce I/O across an entire code
> > region so blk/bdrv_drain_all() is not suitable.  They must use
> > bdrv_drain_all_begin/end() to mark the region.  This prevents new I/O
> > requests from slipping in or worse - block jobs completing and modifying
> > the graph.
> >=20
> > I audited other blk/bdrv_drain_all() callers but did not find anything
> > that needs a similar fix.  This patch fixes the savevm/loadvm commands.
> > Although I haven't encountered a read world issue this makes the code
> > safer.
> >=20
> > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> > @@ -2279,7 +2284,7 @@ int load_vmstate(const char *name, Error **errp)
> >      }
> > =20
> >      /* Flush all IO requests so they don't interfere with the new stat=
e.  */
> > -    bdrv_drain_all();
> > +    bdrv_drain_all_begin();
> > =20
> >      ret =3D bdrv_all_goto_snapshot(name, &bs);
> >      if (ret < 0) {
> > @@ -2303,6 +2308,8 @@ int load_vmstate(const char *name, Error **errp)
> >      qemu_fclose(f);
> >      aio_context_release(aio_context);
> > =20
> > +    bdrv_drain_all_end();
> > +
> >      migration_incoming_state_destroy();
> >      if (ret < 0) {
> >          error_setg(errp, "Error %d while loading VM state", ret);
>=20
> There are a few error returns between these two places where a
> bdrv_drain_all_end() is missing.

Thank you, will fix in the next revision.

Stefan

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZIun+AAoJEJykq7OBq3PIFLoH/0eWsmkM2yscaBXS2y/P+MN2
d0oWmvOALKLHfZBBi7UKllv2YarykW7+TTXDKlt1+P4HiH/xK0QG7oEyfIl5LZwZ
c7zpU2WvCJLvUIATaqC9qZCoelZ1f1d53/Z+e7/JmigLRlq2D8dK89tXK5El1L20
mgrV4sCTXX1a4YzM9ELro2ZUuW44jSUccQMUfOfMuMYue/EOlpbh+FFHsY9GuoEj
l+qCIpI2+xomK8344rlPtE5vlnPGQ6GhfUuUcMLfF5UXqaWFV0aETJdo4AKJe6wu
DMNPD2SHiR60UKYN7KUO0Q1cxBeH7zbMEqiyvLKbL5XCJDod5OGcErfKLd4QNcE=
=KYBi
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
