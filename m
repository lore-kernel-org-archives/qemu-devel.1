Received: from eggs.gnu.org ([2001:4830:134:3::10]:55570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaMT-00068m-7n
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaMP-0003iM-SS
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:50:17 -0400
Date: Tue, 15 Aug 2017 12:50:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170815115005.GA21670@stefanha-x1.localdomain>
References: <20170815040454.4223-1-famz@redhat.com>
	<20170815040454.4223-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20170815040454.4223-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/4] block-backend: Defer
 shared_perm tightening migration completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 12:04:53PM +0800, Fam Zheng wrote:
> @@ -147,6 +166,24 @@ static void blk_root_activate(BdrvChild *child, Erro=
r **errp)
> =20
>      blk->disable_perm =3D false;
> =20
> +    blk_set_perm(blk, blk->perm, BLK_PERM_ALL, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        blk->disable_perm =3D true;
> +        return;
> +    }
> +
> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> +        /* Activation can happen when migration process is still active,=
 for
> +         * example when nbd_server_add is called during non-shared stora=
ge
> +         * migration. Defer the shared_perm update to migration completi=
on. */
> +        if (!blk->vmsh) {
> +            blk->vmsh =3D qemu_add_vm_change_state_handler(blk_vm_state_=
changed,
> +                                                         blk);

Please add a qemu_del_vm_change_state_handler() call to cover the case
where the BB is deleted before the migration state changes.

This is necessary to prevent a memory leak and a crash when the change
state handler is invoked.

Stefan

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkt/tAAoJEJykq7OBq3PIthAH/RYsT+LZZkuktgkcXJ3+pmLM
DzcCbB2cpke5aOQnhExEoP4+PMsjvhLyO5C1q+p40SqkwYr7wT+4yB2gDe6if37p
QFxLWmw1ePpfm7I8oWV31KiYFVpEc1QjcBUMeTr9dPYJBgqQIzVGaBifQyugwKao
qvTn1clsw746YcKoxEq2YRJm2uJaRS9Y4HQCtE6mA7hE7VDRjiACdPV+2VAfZ03t
y9mdNh2FHOWWMRvNtIyFoH1d6deZKI6bt2QHQOXqQktaj3Tt3JYJ8dvvBmRWWLA9
ReKTsmbT1DC43EpRMlCLu49O+jFJTRvJnWpe+Ndstiom9v3oCJfPfIT79985gvI=
=QpFx
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
