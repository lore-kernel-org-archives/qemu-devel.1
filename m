Received: from eggs.gnu.org ([209.51.188.92]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobOh-0003nd-OC
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobOg-0000Ep-Hu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:58:23 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-4-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4842872-2ef7-c2d8-6579-45047f042b99@redhat.com>
Date: Tue, 29 Jan 2019 15:58:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-4-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p43GSK8ChqEK3QbFti2ikNlxCuUIUU3Ke"
Subject: Re: [Qemu-devel] [PATCH v2 03/18] tests/vm/openbsd: Disable the W^X
 protection on the build partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p43GSK8ChqEK3QbFti2ikNlxCuUIUU3Ke
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <f4842872-2ef7-c2d8-6579-45047f042b99@redhat.com>
Subject: Re: [PATCH v2 03/18] tests/vm/openbsd: Disable the W^X protection on
 the build partition
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-4-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since OpenBSD 6.0 [1], W^X is enforced by default [2].
> TCG requires WX access, and QEMU binaries are now built with the WX
> flag to disable the protection. However, WX allowed binaries need
> to be run on a WX allowed partition.
> To be able to run the QEMU test suite on the VM, mount the partition
> where QEMU is built/tested as WX allowed.
>=20
> [1] https://www.openbsd.org/faq/upgrade60.html
> [2] https://undeadly.org/cgi?action=3Darticle&sid=3D20160527203200
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/vm/openbsd | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 2105c01a26..6263c8956b 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -41,6 +41,12 @@ class OpenBSDVM(basevm.BaseVM):
>          if os.path.exists(img):
>              os.remove(img)
>          os.rename(img_tmp, img)
> +        self.boot(img)
> +        self.wait_ssh()
> +        sys.stderr.write("Disabling W^X on the build partition...\n")
> +        self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\ ]*)_\\1 \\=
2,wxallowed_' /etc/fstab")

sed -i is non-POSIX, but it looks like it works in OpenBSD.

> +        self.ssh_root("shutdown -p now")
> +        self.wait()
> =20
>  if __name__ =3D=3D "__main__":
>      sys.exit(basevm.main(OpenBSDVM))
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--p43GSK8ChqEK3QbFti2ikNlxCuUIUU3Ke
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQzHIACgkQp6FrSiUn
Q2qKgAf+LDeramGq9BWwYueNN5FPF+Y/B88czDH9NnEEI6I46gXQ6OowkwJ6E8tf
vKQveol225olRi8lXk0oR2UyjO6Fvv4u21pb2d5Xn8i2OZrpmV09r5zaR6huziWU
RkfV5TswWiIfVUyStL5nQhJjkzhZ04EZdu1Z1aIp3ZjTkmC76BUUCi0unyUcpUb7
ZjEt8NiUlFg1ZuJUfabJkclN/gY92fDjD/sLQYHZSv6zgSvHVq1+UYz4wY93BC7g
IP8U0cf2AuTCPQpnqXuHv9YVfk5GWeRwgWjPvGgkLkDGbw6BYvcjr7ev/1eZJSgw
dm7KTFnY7f3XucsSrtmhYvCVXHOfYQ==
=mkDV
-----END PGP SIGNATURE-----

--p43GSK8ChqEK3QbFti2ikNlxCuUIUU3Ke--
