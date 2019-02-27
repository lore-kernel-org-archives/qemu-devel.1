Received: from eggs.gnu.org ([209.51.188.92]:37030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz0Em-0000ZK-7N
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz09y-0005W7-2S
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:26:11 -0500
References: <20190227115152.1906-1-berrange@redhat.com>
	<20190227115152.1906-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61c14d41-362e-b6ba-be62-b360c215a98b@redhat.com>
Date: Wed, 27 Feb 2019 08:25:20 -0600
MIME-Version: 1.0
In-Reply-To: <20190227115152.1906-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>

On 2/27/19 5:51 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> Currently any client which can complete the TLS handshake is able to us=
e
> the NBD server. The server admin can turn on the 'verify-peer' option
> for the x509 creds to require the client to provide a x509 certificate.
> This means the client will have to acquire a certificate from the CA
> before they are permitted to use the NBD server. This is still a fairly
> low bar to cross.
>=20
> This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command whic=
h
> takes the ID of a previously added 'QAuthZ' object instance. This will
> be used to validate the client's x509 distinguished name. Clients
> failing the authorization check will not be permitted to use the NBD
> server.
>=20
> For example to setup authorization that only allows connection from a c=
lient
> whose x509 certificate distinguished name is
>=20
>    CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=3DG=
B
>=20
> escape the commas in the name and use:
>=20
>   qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemut=
ls,\
>                     endpoint=3Dserver,verify-peer=3Dyes \
>            --object 'authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.exa=
mple.com,,\
>                      O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB' =
\
>            --tls-creds tls0 \
>            --tls-authz authz0 \
> 	   ....other qemu-nbd args...
>=20
> NB: a real shell command line would not have leading whitespace after
> the line continuation, it is just included here for clarity.

I'm half-tempted to propose a QemuOpts patch that eats whitespace after
comma, to make examples like this actually valid command lines.
(Actually, your example breaks line after an escaped comma, which would
result in a literal 'identity=3DCN=3D...,   O=3DExample...' option even i=
f
space is eaten, and I don't know if that forms a valid identity).  But
doesn't hold up this patch.

>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/qemu-nbd.c

> +    } else {
> +        if (tlsauthz) {
> +            error_report("--tls-authz is not permitted without --tls-c=
reds");
> +            exit(EXIT_FAILURE);
> +        }
>      }
> =20
>      if (list) {

--list is new compared to when you originally proposed this patch. Does
anything need to be changed on that front?  (That is, does --tls-authz
make sense when qemu-nbd is used as a client to probe a remote server's
advertisements, or is it a server-only setting where we need to enhance
the --list mode to reject use of the option?)

> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index d0c5182814..d45ed9e0a0 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -117,6 +117,10 @@ option; or provide the credentials needed for conn=
ecting as a client
>  in list mode.
>  @item --fork
>  Fork off the server process and exit the parent once the server is run=
ning.
> +@item --tls-authz=3DID
> +Specify the ID of a qauthz object previously created with the
> +--object option. This will be used to authorize connecting users
> +against their x509 distinguished name.
>  @item -v, --verbose
>  Display extra debugging information.
>  @item -h, --help

qemu-nbd.texi now has examples (which it did not have when you first
wrote the patch).  I'd love it if your command line example from the
commit message were also included in the examples section of the man page=
.


>  echo "=3D=3D check TLS works =3D=3D"
> -obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dt=
ls0
> -$QEMU_IMG info --image-opts --object $obj \
> +obj1=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3D=
tls0
> +obj2=3Dtls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,id=3D=
tls0
> +$QEMU_IMG info --image-opts --object $obj1 \
>      driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3D=
tls0 \
>      2>&1 | sed "s/$nbd_tcp_port/PORT/g"
> -$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj \
> +$QEMU_IMG info --image-opts --object $obj2 \
> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3D=
tls0 \
> +    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
> +$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj1 \
>      --tls-creds=3Dtls0

It looks like you have both a positive and negative test that a qemu-img
client can only connect with the right auth, but only a positive test
for a qemu-nbd --list client.  Should we also duplicate the
QEMU_NBD_PROG line to use $obj2 for a negative test?

> =20
>  echo
> @@ -117,6 +122,26 @@ $QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m'=
 --image-opts \
> =20
>  $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_q=
emu_io
> =20
> +echo
> +echo "=3D=3D check TLS with authorization =3D=3D"
> +
> +nbd_server_stop
> +
> +nbd_server_start_tcp_socket \
> +    --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver=
,id=3Dtls0,verify-peer=3Dyes \
> +    --object "authz-simple,identity=3DCN=3Dlocalhost,,O=3DCthulu Dark =
Lord Enterprises client1,,L=3DR'lyeh,,C=3DSouth Pacific,id=3Dauthz0" \
> +    --tls-authz authz0 \
> +    --tls-creds tls0 \
> +    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
> +
> +$QEMU_IMG info --image-opts \
> +    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient=
,id=3Dtls0 \
> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3D=
tls0
> +
> +$QEMU_IMG info --image-opts \
> +    --object tls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient=
,id=3Dtls0 \
> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3D=
tls0

Similarly, do we want --list testing here?

Overall the patch looks good, but I'm wondering if we want a v6 to
address the items pointed out above, or if a followup patch is sufficient=
.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
