Received: from eggs.gnu.org ([2001:4830:134:3::10]:45875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea7Bb-0001mK-7y
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea7BY-000550-5b
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:48:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ea7BX-00054C-T7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:48:24 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-15-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30db45d4-66fa-167f-4f32-22ed47a3bfd2@redhat.com>
Date: Fri, 12 Jan 2018 15:48:10 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-15-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qBFXFCJZOwkdMr3711wsyMX8cjisOzGW2"
Subject: Re: [Qemu-devel] [RFC v6 14/27] monitor: let suspend_cnt be thread
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qBFXFCJZOwkdMr3711wsyMX8cjisOzGW2
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <30db45d4-66fa-167f-4f32-22ed47a3bfd2@redhat.com>
Subject: Re: [RFC v6 14/27] monitor: let suspend_cnt be thread safe
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-15-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-15-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> Monitor code now can be run in more than one thread.  Let it be thread
> safe when accessing suspend_cnt counter.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index cf1e5d881c..844508d134 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3862,7 +3862,7 @@ static int monitor_can_read(void *opaque)
>  {
>      Monitor *mon =3D opaque;
> =20
> -    return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
> +    return (atomic_mb_read(&mon->suspend_cnt) =3D=3D 0) ? 1 : 0;

Worth a comment at the declaration of suspend_cnt that it must be
accessed atomically?

I find anything that does '(boolexpr) ? 1 : 0' to be a pointless waste
of typing.  It is semantically equivalent and shorter to write either of:=


return atomic_mb_read(&mon->suspend_cnt) =3D=3D 0;
return !atomic_mb_read(&mon->suspend_cnt);

At any rate, I checked that all uses of suspend_cnt were converted over
to atomic API, so this looks correct, whether or not you add my tweaks.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qBFXFCJZOwkdMr3711wsyMX8cjisOzGW2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpZLRoACgkQp6FrSiUn
Q2qeCwgAkxqdkQKYq5I5s7sMKY40aCw1DIcVwh70fKy806ZGCg/LzAbknKxmDzQF
M7zVoUBCvljqoM7E3fGOXG6/c5Uic0D5k/ckAiZESVMndhps+uUHG5QCIbTvwgGL
994H6wqJUG9GovmhoUjbPsEmjXfZtlSQ0hrNQtihBJ5latVo3fj/0ZguQ/NYx6X6
1Enl0pst3gXB1NkTfWRn8LrQb6v8WOHhPiBAd/loN8HNEQE/fXu7vk/VBB9bDpOm
B9mB22V9Sj7dHW8UiQjk6i4wktMQ1/YMGH78aTlOz7vLzMP19YBkTwlLG2hHQrGr
an/Wk18I25u26tzKKo0rbtwnrTPHZw==
=NmuE
-----END PGP SIGNATURE-----

--qBFXFCJZOwkdMr3711wsyMX8cjisOzGW2--
