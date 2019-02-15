Received: from eggs.gnu.org ([209.51.188.92]:33146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guccz-0000ue-4O
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guccy-00050V-9G
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:30:01 -0500
References: <20190215091950.20270-1-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13099f7d-3c90-8aea-d118-47370eb3685b@redhat.com>
Date: Fri, 15 Feb 2019 06:29:50 -0600
MIME-Version: 1.0
In-Reply-To: <20190215091950.20270-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="II6huPjFLu5xbQ9qDBAOADV9SekTG2I9j"
Subject: Re: [Qemu-devel] [PATCH] block: don't set the same context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--II6huPjFLu5xbQ9qDBAOADV9SekTG2I9j
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com
Message-ID: <13099f7d-3c90-8aea-d118-47370eb3685b@redhat.com>
Subject: Re: [PATCH] block: don't set the same context
References: <20190215091950.20270-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190215091950.20270-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/15/19 3:19 AM, Denis Plotnikov wrote:
> Adds a fast path on aio context setting preventing
> unnecessary context setting routine.
> Also, it prevents issues with cyclic walk of child
> bds-es appeared because of registring aio walking

registering

> notifiers:
>=20

> This can happen because of "new" context attachment to VM disk bds.
> When attaching a new context the corresponding aio context handler is
> called for each of aio_notifiers registered on the VM disk bds context.=

> Among those handlers, there is the block_job_attached_aio_context handl=
er
> which sets a new aio context for the block job bds. When doing so,
> the old context is detached from all the block job bds children and one=
 of
> them is the VM disk bds, serving as backing store for the blockjob bds,=

> although the VM disk bds is actually the initializer of that process.
> Since the VM disk bds is protected with walking_aio_notifiers flag
> from double processing in recursive calls, the assert fires.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20

Naive question - do we have to always call
attach_aio_context/detach_aio_context in pairs?  If so, will
short-circuiting a nested attach cause reference count problems when we
come to the matching detach calls?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--II6huPjFLu5xbQ9qDBAOADV9SekTG2I9j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxmsL4ACgkQp6FrSiUn
Q2pRXAf+M5EL5qSvypdoJcN/wDihC3d4Ky6P7uzFXyP1SLB2uCCwDs+9N5ZNgHjN
3scUh99Vq0a5irlQUTSW09htbN41+zLw+EPXEGeH8+Bvd3P01B+iwNSHt/wRwOku
nQHW6IKM9K2kwYsQ84viKzz+pep4ZL/ESAMgDd+AwJmwTuf8zxKXINYCuRHCbJT/
AJHbrluuIliLzmYFgSFs9YuWqTdYU8bWo6/gJcbOyGgtEKhfBtb8W++HftO4DUAT
q8TNJXRjC6cE3QmGinXobo1t2aEEqHwIdZgrg/rd0dUt2RfkNFTMJn0QbhBpcZrp
dSIL53sSr8XttzLyymY7NE6hpHIylg==
=gO52
-----END PGP SIGNATURE-----

--II6huPjFLu5xbQ9qDBAOADV9SekTG2I9j--
