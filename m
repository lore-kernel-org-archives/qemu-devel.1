Received: from eggs.gnu.org ([209.51.188.92]:46377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw880-0003yZ-CR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw87u-0006g8-Jv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:20:16 -0500
References: <20190219161321.15012-1-berrange@redhat.com>
	<20190219161321.15012-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d50a19fd-b869-e7f4-cfc7-80191b01ecbf@redhat.com>
Date: Tue, 19 Feb 2019 17:19:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190219161321.15012-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: avoid broken pipe with
 certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 19/02/2019 17.13, Daniel P. Berrang=C3=A9 wrote:
> When we run "certtool | head -1" the latter command is likely to
> complete and exit before certtool has written everything it wants to
> stderr. In at least the RHEL-7 gnutls 3.3.29 this causes certtool to
> quit with broken pipe before it has finished writing the desired
> output file to disk. This causes non-deterministic failures of the
> iotest 233 because the certs are sometimes zero length files.
> If certtool fails the "head -1" means we also loose any useful error
> message it would have printed.
>=20
> Thus this patch gets rid of the pipe and post-processes the output in a
> more flexible & reliable manner.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/common.tls | 48 +++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.=
tls
> index eae81789bb..6cf11ed383 100644
> --- a/tests/qemu-iotests/common.tls
> +++ b/tests/qemu-iotests/common.tls
> @@ -29,6 +29,17 @@ tls_x509_cleanup()
>  }
> =20
> =20
> +tls_certtool()
> +{
> +    certtool "$@" 1>certtool.log 2>&1
> +    if test "$?" =3D 0; then
> +      head -1 certtool.log
> +    else
> +      cat certtool.log
> +    fi
> +    rm -f certtool.log
> +}

I assume this is running in a unique directory so that there can not be
a clash with a test running in parallel? Otherwise I'd recommend an
mktemp file name here...

Anyway, this fixes the issue for me, too, thus:

Tested-by: Thomas Huth <thuth@redhat.com>
