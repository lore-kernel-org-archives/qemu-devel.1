Received: from eggs.gnu.org ([209.51.188.92]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobld-0001ll-6c
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goblc-0002sa-6v
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:22:05 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-11-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c5ac6a4-0d1f-2ee1-af9b-16833480188a@redhat.com>
Date: Tue, 29 Jan 2019 16:21:44 -0600
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-11-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EcEEvxTNikX5VqC52GiMVmu7iLEvnfTSv"
Subject: Re: [Qemu-devel] [RFC PATCH v2 10/18] qemu-iotests: Ensure GNU sed
 is used
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
--EcEEvxTNikX5VqC52GiMVmu7iLEvnfTSv
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
Message-ID: <7c5ac6a4-0d1f-2ee1-af9b-16833480188a@redhat.com>
Subject: Re: [RFC PATCH v2 10/18] qemu-iotests: Ensure GNU sed is used
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-11-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Various sed regexp from common.filter use sed GNU extensions.
> Instead of spending time to write these regex to be POSIX compliant,
> verify the GNU sed is available and use it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> I think the test isn't well placed in common.filter and should be in
> common.rc, but couldn't get that working.
> ---

> +++ b/tests/qemu-iotests/common.filter
> @@ -23,37 +23,37 @@
>  #
>  _filter_date()
>  {
> -    sed \
> +    ${SED} \

I might have written $SED instead of ${SED}, but that's merely
aesthetics and not a correctness issue.


> +++ b/tests/qemu-iotests/common.rc
> @@ -17,6 +17,18 @@
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
>  #
> =20

If SED is inherited in the environment prior to this point,...

> +for sed in sed gsed; do
> +    (command $sed --version | grep 'GNU sed') > /dev/null 2>&1

Why do you need command here? (It doesn't hurt, but I also don't see how
it helps).

> +    if [ "$?" -eq 0 ]; then
> +        SED=3D$sed
> +        break
> +    fi
> +done

=2E..but neither sed nor gsed are GNU sed,

> +if [ -z "$SED" ]; then
> +    echo "$0: GNU sed not found"
> +    exit 1
> +fi

=2E..then you fail to diagnose that. Fix it by adding SED=3D prior to the=
 loop.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--EcEEvxTNikX5VqC52GiMVmu7iLEvnfTSv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQ0fgACgkQp6FrSiUn
Q2pBkwf9HHVbeuHqq0YZ1bnYT55fqtYUuK5obqfoUGCLg9ISBqK975RPnWKVEmAw
ZGQG6KGx8G2PMh92ykio4160N03gbpMm/GHFRaCWd7cJu6+XR/uhzwcvIV6NOPYn
W+rj3mQfJMcsQ+QpK0SB9gC1VpfJoZZWltyoCUyIaIR17Vaiox4/kHu0nvW4ZLqx
phDUGAwciu8rb63YqKFvFM4yPYvvW+ZmI4QO6EmPXCDpKECTLy/4CT+27KA5u9M+
kobY3UAy9hxrvMETq5RwlPcRbYUsZB9+DWrbeR+ozuLD4mc94PedpQOpw6lnOqLv
epQnmxdTbvkbm4PTr1/L7WLStq4DGg==
=M384
-----END PGP SIGNATURE-----

--EcEEvxTNikX5VqC52GiMVmu7iLEvnfTSv--
