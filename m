Received: from eggs.gnu.org ([209.51.188.92]:52162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw8U5-0008C2-N9
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw8U4-0006pQ-GA
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:43:05 -0500
References: <20190219161321.15012-1-berrange@redhat.com>
	<20190219161321.15012-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9daffdc-2978-040b-062c-41448b4e890e@redhat.com>
Date: Tue, 19 Feb 2019 10:42:50 -0600
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2/19/19 10:13 AM, Daniel P. Berrang=C3=A9 wrote:
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

Better than my attempt.

> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/common.tls | 48 +++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 16 deletions(-)

As Thomas pointed out, it is not parallel-safe, but that's a bigger
issue with all of the iotests, so not this patch's problem.

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

I tend to use '>' instead of '1>', but they are identical.

> +    if test "$?" =3D 0; then
> +      head -1 certtool.log

Technically, POSIX says 'head -1' is not portable (it was historical
practice, but a wording change in POSIX 2001 made it invalid, which
wasn't fixed until POSIX 2008 - and there are historical versions of GNU
coreutils which went out of their way to reject the usage, although that
has since been fixed); the portable spelling these days is 'head -n1'.
But as the test was already using 'head -1', I'm not going to make you
switch it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
