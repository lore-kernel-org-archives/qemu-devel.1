Received: from eggs.gnu.org ([2001:4830:134:3::10]:40180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXSUo-0006Cr-LU
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXSUn-00069y-HP
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:57:18 -0500
References: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
	<20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07c8789d-bebb-deed-b64c-806edf17f99c@redhat.com>
Date: Fri, 5 Jan 2018 07:57:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AAaXQFfVLO3rXjsl9f30AXSjfQ4lYSmAY"
Subject: Re: [Qemu-devel] [PATCH 1/1] block/nbd: fix segmentation fault when
 .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-ppc@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AAaXQFfVLO3rXjsl9f30AXSjfQ4lYSmAY
From: Eric Blake <eblake@redhat.com>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-ppc@nongnu.org, Max Reitz
 <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, R Nageswara Sastry
 <nasastry@in.ibm.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <07c8789d-bebb-deed-b64c-806edf17f99c@redhat.com>
Subject: Re: [PATCH 1/1] block/nbd: fix segmentation fault when .desc is not
 null-terminated
References: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
 <20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
In-Reply-To: <20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 07:32 AM, Murilo Opsfelder Araujo wrote:
> The find_desc_by_name() from util/qemu-option.c relies on the .name not=
 being
> NULL to call strcmp(). This check becomes unsafe when the list is not
> NULL-terminated, which is the case of nbd_runtime_opts in block/nbd.c, =
and can
> result in segmentation fault when strcmp() tries to access an invalid m=
emory:

Thanks for the report and patch.  Adding qemu-stable in cc.

>=20
> This patch fixes the segmentation fault in strcmp() by adding a NULL el=
ement at
> the end of nbd_runtime_opts.desc list, which is the common practice to =
most of
> other structs like runtime_opts in block/null.c. Thus, the desc[i].name=
 !=3D NULL
> check becomes safe because it will not evaluate to true when .desc list=
 reached
> its end.
>=20
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1727259
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>

I'll update the commit message to add in the commit id that introduced
the problem, as well as check that other QemuOptsList do not have a
similar problem; I'm queueing this on the NBD tree and will submit a
pull request soon.

Reviewed-by: Eric Blake <eblake@redhat.com>

> ---
>  block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index a50d24b50a..8b8ba56cdd 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -388,6 +388,7 @@ static QemuOptsList nbd_runtime_opts =3D {
>              .type =3D QEMU_OPT_STRING,
>              .help =3D "ID of the TLS credentials to use",
>          },
> +        { /* end of list */ }
>      },
>  };
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AAaXQFfVLO3rXjsl9f30AXSjfQ4lYSmAY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPhDMACgkQp6FrSiUn
Q2rjsQf/SvkkDxx8t8bpkBsqD3yb95cMqBbzDopdHZMgdscV8QeR11kZT+X9uUeM
IKtBKOfx3Wzd96DrbNSm5EEwU8WCN2tXKOldquAu45o9h1IH3JXOwafjLpDNlvX2
3EY5aeWlYJY1ednVQc0gYBhKjmpC2e17VmvGWoqx80HwDG59NPGlapA3WTyYu8Ah
5j/dDIO8Z0St06fwADMOr5OdBnqBzPoqrACQEBvQQAru/c/ws7uEEnl+vMoc8Ng2
V4X0wBGd+WKBLWSk3hy2NSykL/fEzwvt1+4dHDJr4x1mU+l98lH0VgBi+zF5PhPc
iJgLxdMJJECk/atXM4uc5PMaehedMA==
=Syfw
-----END PGP SIGNATURE-----

--AAaXQFfVLO3rXjsl9f30AXSjfQ4lYSmAY--
