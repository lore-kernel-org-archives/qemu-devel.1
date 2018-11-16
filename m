Received: from eggs.gnu.org ([2001:4830:134:3::10]:41382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNh9J-0007D9-HJ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNh9F-0002bi-RN
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:39:15 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5acd44f8-69c7-a791-0ce0-49cad6e48423@redhat.com>
Date: Fri, 16 Nov 2018 10:39:03 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: add iotests helpers for dealing
 with TLS certificates
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

On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> Add helpers to common.tls for creating TLS certificates for a CA,
> server and client.

MUCH appreciated!  We NEED this coverage, easily automated.

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/qemu-iotests/common.tls | 139 +++++++++++++++++++++++++++++++++=
+
>   1 file changed, 139 insertions(+)
>   create mode 100644 tests/qemu-iotests/common.tls
>=20
> diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.=
tls
> new file mode 100644

I was a bit surprised that this wasn't 100755, but this matches the fact=20
that none of the other common.* are executable. And after thinking more,=20
it makes sense - they aren't standalone scripts, but designed to be=20
sourced, and 'source' doesn't care about execute bits.

> +tls_dir=3D"${TEST_DIR}/tls"
> +
> +function tls_x509_cleanup()
> +{
> +    rm -f ${tls_dir}/*.pem
> +    rm -f ${tls_dir}/*/*.pem
> +    rmdir ${tls_dir}/*
> +    rmdir ${tls_dir}

Why not just:
rm -rf $tls_dir

Also, the quoting is a bit inconsistent. if ${TEST_DIR} can contain=20
spaces, then all uses of ${tls_dir} need to be in "".

> +}
> +
> +
> +function tls_x509_init()
> +{
> +    mkdir "${tls_dir}"

And this just highlights the quoting inconsistency.  Should this use=20
mkdir -p?

> +
> +function tls_x509_create_root_ca()
> +{
> +    name=3D$1
> +
> +    test -z "$name" && name=3Dca-cert

Could also be shortened as:

name=3D${1:-ca-cert}

> +
> +    cat > ${tls_dir}/ca.info <<EOF
> +cn =3D Cthulu Dark Lord Enterprises $name

s/Cthulu/Cthulhu/ - after all, we don't want him coming after us just=20
because we botched the spelling of his name :)

> +ca
> +cert_signing_key
> +EOF
> +
> +    certtool --generate-self-signed \
> +             --load-privkey ${tls_dir}/key.pem \
> +             --template ${tls_dir}/ca.info \
> +             --outfile ${tls_dir}/$name-cert.pem 2>&1 | head -1

More missing ""

> +
> +    rm -f ${tls_dir}/ca.info
> +}
> +
> +
> +function tls_x509_create_server()
> +{
> +    caname=3D$1
> +    name=3D$2
> +
> +    mkdir ${tls_dir}/$name
> +    cat > ${tls_dir}/cert.info <<EOF
> +organization =3D Cthulu Dark Lord Enterprises $name

Matched spelling

> +function tls_x509_create_client()
> +{
> +    caname=3D$1
> +    name=3D$2
> +
> +    mkdir ${tls_dir}/$name
> +    cat > ${tls_dir}/cert.info <<EOF
> +country =3D South Pacific
> +locality =3D  R'lyeh
> +organization =3D Cthulu Dark Lord Enterprises $name

And again

Needs several touch-ups, but the idea itself is sound.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
