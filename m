Received: from eggs.gnu.org ([2001:4830:134:3::10]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjoat-00053O-U8
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjoas-0005sN-T5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:54:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjoas-0005sE-K4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:54:06 -0500
From: Eric Blake <eblake@redhat.com>
References: <20170303112503.32277-1-ppandit@redhat.com>
Message-ID: <bd2e3c1d-0fa5-7be4-c223-81d87c87fe0c@redhat.com>
Date: Fri, 3 Mar 2017 08:54:03 -0600
MIME-Version: 1.0
In-Reply-To: <20170303112503.32277-1-ppandit@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IVpGBef2B2Uvw9Nj2cDpQXJeTCELUvjpE"
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>, Jann Horn <jannh@google.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IVpGBef2B2Uvw9Nj2cDpQXJeTCELUvjpE
From: Eric Blake <eblake@redhat.com>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit
 <pjp@fedoraproject.org>, Jann Horn <jannh@google.com>
Message-ID: <bd2e3c1d-0fa5-7be4-c223-81d87c87fe0c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
References: <20170303112503.32277-1-ppandit@redhat.com>
In-Reply-To: <20170303112503.32277-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 05:25 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Limit the number of arguments passed to execve(2) call from
> a user program, as large number of them could lead to a bad
> guest address error.

Depending on how the kernel was compiled, you may have a limited maximum
size for the combined storage used by argc, environ, and all pointers.
Older kernels had a hard ceiling on storage used by argc and environ as
small as 128k (not just the bytes pointed to, but also the storage
occupied by the pointers) - it was possible to trigger E2BIG failures
with a large number of arguments in the array, but also with a single
argument that was too long.  Modern kernels have increased the limits
somewhat (now it is as large as 1/4 available stack size), but still has
maximum sizes for a single argument (larger than before, but still
finite).  Any one of these E2BIG failures is something we need to handle
gracefully, especially if the guest is expecting to be able to use a
larger limit than the host is supporting.  So I'm not sure that limiting
the number of arguments is sufficient - you may also have to limit the
size of the arguments.

I typed the above without looking at your patch.  Now that I've done
that, I see that you are tackling yet another type of corruption...

>=20
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  linux-user/syscall.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9be8e95..c545c12 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7766,6 +7766,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>  #endif
>      case TARGET_NR_execve:
>          {
> +#define ARG_MAX 65535
>              char **argp, **envp;
>              int argc, envc;
>              abi_ulong gp;
> @@ -7794,6 +7795,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
>                  envc++;
>              }
> =20
> +            if (argc > ARG_MAX || envc > ARG_MAX) {
> +                fprintf(stderr,
> +                        "argc(%d), envc(%d) exceed %d\n", argc, envc, =
ARG_MAX);

Isn't there something better than fprintf() for reporting errors?

> +                ret =3D -TARGET_EFAULT;
> +                break;
> +            }
>              argp =3D alloca((argc + 1) * sizeof(void *));
>              envp =3D alloca((envc + 1) * sizeof(void *));

=2E..Uggh. You're using alloca() but allowing an allocation of way more
than 4k.  That means a guest can cause corruption of the stack (or, with
large enough arguments, even escape out of the stack) before you even
get to the execve() call to even worry about E2BIG issues.  Even though
your new limit of 64k argc/envc limits the damage compared to what it
used to be, you are still prone to an allocation that walks beyond the
guard page and causes bad behavior.  Either you need the limits to be
much smaller, or you should consider using the heap instead of the stack
(alloca should never be used for more than about 4k).  And there's still
the possibility that even with your cap, that you are not handling E2BIG
correctly.  You'll need to respin this patch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IVpGBef2B2Uvw9Nj2cDpQXJeTCELUvjpE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuYOMAAoJEKeha0olJ0NqQosH/RiNVL+zQlHIJ0ganey6PQDm
gTrTCtJ8qMmugElqoedfZQ/A/Oa/getKLLe3mnBS+Awq4njh+YGvn6h/YutH7Kei
c1r+rhnhrxWID07lin1dTawsHVUznYJCG1B4JXGAXVe6x2WecbcZCMDUmDHjwP0G
UuXeo1MHdBmf/yF8fLHP5Ocvl5YlFYlny3+G7iCvUtigDlMeScQA8NGX553xb3t9
WId0Nvp9aezt1zxtLnUXJt3EMQIELRjADvKJUxbnZN/moiMKBe0HJZUYXZgaJqQD
gAVL3JCgUA342pjp8c00J34vVbI82FVS5jS9+iNMJCnh/d1tdpO74Dln3e1jkv4=
=lUoC
-----END PGP SIGNATURE-----

--IVpGBef2B2Uvw9Nj2cDpQXJeTCELUvjpE--
