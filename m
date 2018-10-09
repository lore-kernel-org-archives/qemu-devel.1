Received: from eggs.gnu.org ([2001:4830:134:3::10]:34692)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1g9sQD-0000nE-Ov
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1g9sQ9-0006AE-JA
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:51:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:42265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1g9sQ9-00063S-86
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:51:33 -0400
References: <20181007153731.GA32288@humpty.home.comstyle.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
Date: Tue, 9 Oct 2018 15:52:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181007153731.GA32288@humpty.home.comstyle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wr269VAOPhTf2oE6ffJpfDwHtLZdd2dam"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wr269VAOPhTf2oE6ffJpfDwHtLZdd2dam
From: Kamil Rytarowski <n54@gmx.com>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Message-ID: <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
References: <20181007153731.GA32288@humpty.home.comstyle.com>
In-Reply-To: <20181007153731.GA32288@humpty.home.comstyle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.10.2018 17:37, Brad Smith wrote:
> Use MAP_STACK in qemu_alloc_stack() on OpenBSD.
>=20
> Added to -current and will be in our soon to be 6.4 release.
>=20
> MAP_STACK      Indicate that the mapping is used as a stack.  This
>                flag must be used in combination with MAP_ANON and
>                MAP_PRIVATE.
>=20
> Implement MAP_STACK option for mmap().  Synchronous faults (pagefault a=
nd
> syscall) confirm the stack register points at MAP_STACK memory, otherwi=
se
> SIGSEGV is delivered. sigaltstack() and pthread_attr_setstack() are mod=
ified
> to create a MAP_STACK sub-region which satisfies alignment requirements=
=2E
> Observe that MAP_STACK can only be set/cleared by mmap(), which zeroes =
the
> contents of the region -- there is no mprotect() equivalent operation, =
so
> there is no MAP_STACK-adding gadget.
>=20
>=20
> Signed-off-by: Brad Smith <brad@comstyle.com>
>=20
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index fbd0dc8c57..51e9a012c2 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -611,7 +611,11 @@ void *qemu_alloc_stack(size_t *sz)
>      *sz +=3D pagesz;
> =20
>      ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE,
> -               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +               MAP_PRIVATE | MAP_ANONYMOUS
> +#ifdef MAP_STACK
> +               | MAP_STACK
> +#endif
> +               , -1, 0);
>      if (ptr =3D=3D MAP_FAILED) {
>          perror("failed to allocate memory for stack");
>          abort();
>=20

Can we handle it differently, storing MAP_* flags in a variable:

int flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
#ifdef MAP_STACK
flags |=3D MAP_STACK;
#endif

ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);

This way it will look nicer as we won't ifdef the middle of a function ca=
ll.


--wr269VAOPhTf2oE6ffJpfDwHtLZdd2dam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlu8sp8MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsTG0QAJ0J+nf8CurPodNs068MCEtW9J6+xCPB8oN2ytXW
tTB8/d8j8RtV7EieVFcmOyHkL5Ga4paDgf66ISnPVbOmjMnWiSvk1+qiVrt29OsL
HcPbsqCXPVlYW8QJOfi4YBKYPMJoupZt+viklCQZtEVXmiaJiYQgOQgPpcdVz8pj
cqn1HrnmpnVss5c5sjDdElNfRmj5hCeI2VSdhlbQLjei3KdrFxYMUSqTNN6eG9Bf
JX0lyeeeJb9Yod266e25bVvdrhRT8v+AAU0gJVWVH5nKMMoZu8z6MENCpG6UrqWI
inAC+SfSeu9SEAcjAuqabuh50Sz0OeUrZeDMKvvg0E3n6Ah9Jcn38D7nrZi/xSYy
q7VAGKU3XQtsb0Q/vzsH7QhvKPdQ/kmGI+n7lY3LQ9zNJNJoVH20cIS2CYqxPawV
/bM5Rla+J72/DLFYeXXZcikPRTYJeUD5G0Iymhr/Bz/nK4dqzn4Z3QBGozRb8D0E
EFUqaS1Odtq9/wiTovDv5bP9yi3PYvSM3QltKuC3wEgnrhy0uis9MpfDUZn1PBO/
7BLs5FyNcoFyBcROeqZJbfWQwIj/fQm4Hh2ceurMmVTL++pNNqz2NbbVDK07npvo
4iQEoX+/p3G6TQjF+KuDSucMEBfQg5cDtiCw88ZfCxBGl3hQTuhqTW0yCzUw503C
/ABG
=VoM9
-----END PGP SIGNATURE-----

--wr269VAOPhTf2oE6ffJpfDwHtLZdd2dam--
