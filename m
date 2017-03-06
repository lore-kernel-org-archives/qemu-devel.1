Received: from eggs.gnu.org ([2001:4830:134:3::10]:43953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckuxO-0007cg-1g
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckuxL-0000kQ-0b
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:53:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckuxK-0000kI-NJ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:53:50 -0500
References: <20170306071721.26708-1-ppandit@redhat.com>
	<20170306071721.26708-3-ppandit@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
Date: Mon, 6 Mar 2017 09:53:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170306071721.26708-3-ppandit@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vCg0S3CrbOtkLq457x5GRt7c7pCoB3cvE"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: allocate heap memory
 for execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vCg0S3CrbOtkLq457x5GRt7c7pCoB3cvE
From: Eric Blake <eblake@redhat.com>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Message-ID: <988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
Subject: Re: [PATCH v2 2/2] linux-user: allocate heap memory for execve
 arguments
References: <20170306071721.26708-1-ppandit@redhat.com>
 <20170306071721.26708-3-ppandit@redhat.com>
In-Reply-To: <20170306071721.26708-3-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 01:17 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Arguments passed to execve(2) call from user program could
> be large, allocating stack memory for them via alloca(3) call
> would lead to bad behaviour. Use 'g_malloc0' to allocate memory
> for such arguments.
>=20
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  linux-user/syscall.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Is this patch alone (without 1/2) sufficient to solve the problem?  If
so, then drop 1/2.

>=20
> Update per: replace alloca() with g_malloc0()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00750.htm=
l
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 86a4a9c..404fb0b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7800,8 +7800,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,

What version of qemu are you patching?  Line 7800 of current master is
nowhere near 'case TARGET_NR_execve:' (line 7899)

>                  ret =3D -TARGET_E2BIG;
>                  break;
>              }

and current master has 'goto efault' rather than directly setting ret at
this point.

> -            argp =3D alloca((argc + 1) * sizeof(void *));
> -            envp =3D alloca((envc + 1) * sizeof(void *));
> +            argp =3D g_malloc0((argc + 1) * sizeof(void *));
> +            envp =3D g_malloc0((envc + 1) * sizeof(void *));

Subject to a potential multiplication overflow.  I'd prefer:

g_new0(void *, argc + 1);

as that is guaranteed to not overflow.

> =20
>              for (gp =3D guest_argp, q =3D argp; gp;
>                    gp +=3D sizeof(abi_ulong), q++) {
> @@ -7862,6 +7862,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>                      break;
>                  unlock_user(*q, addr, 0);
>              }
> +
> +            g_free(argp);
> +            g_free(envp);
>          }
>          break;
>      case TARGET_NR_chdir:
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vCg0S3CrbOtkLq457x5GRt7c7pCoB3cvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvYYKAAoJEKeha0olJ0NqvIAH/3z+CiwnUOreG/shqdGd47Kz
fQcUIPiFFwHcBy8DnxWtFn0/jR0VvLc6DFGm2ehSapl4vAulgA4S1pNTPOLm3hSV
6GhLmXVOLFu8j4TVHprrfeLMH2t+gY+nBAe+IXVNdzS/AwUPP0BusE5x6tm4v8MZ
bbVpJGtovKHYjXNIOPMCtiKi3/O1Nj71gCNexhCLhlDoTo1Qx2i+bXqJmGQIMdmw
zYIjCqyUPr6+Hw22mPLqHI4rdb3WXcyLLVqeYiv8Fo4vNLJK+QrJS2H70OeL1zlC
PqlWw64jPKS8ZPJX70IGZ/f8LNqQH7T72VI0ixXIxeoJgJVXq6i7VMwAtCP5ZpY=
=xktu
-----END PGP SIGNATURE-----

--vCg0S3CrbOtkLq457x5GRt7c7pCoB3cvE--
