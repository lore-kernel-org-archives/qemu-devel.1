Received: from eggs.gnu.org ([2001:4830:134:3::10]:44245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNLKa-00072q-8g
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNLKX-0006ZU-3m
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:16:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNLKW-0006ZN-PX
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:16:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02CEEA63E0
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 16:16:52 +0000 (UTC)
References: <20171208115834.21577-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e85e5e6-01f6-9c01-f7fa-e33ec4f9d6c7@redhat.com>
Date: Fri, 8 Dec 2017 10:16:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171208115834.21577-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9p5E76FDXMIKX9h0sU2WVfDCHc201DRpe"
Subject: Re: [Qemu-devel] [PATCH] docs: update information for TLS
 certificate management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9p5E76FDXMIKX9h0sU2WVfDCHc201DRpe
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Message-ID: <8e85e5e6-01f6-9c01-f7fa-e33ec4f9d6c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: update information for TLS certificate
 management
References: <20171208115834.21577-1-berrange@redhat.com>
In-Reply-To: <20171208115834.21577-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 05:58 AM, Daniel P. Berrange wrote:
> The current docs for TLS assume only VNC is using TLS. Some of the info=
rmation
> is also outdated (ie lacking subject alt name info for certs). Rewrite =
it to
> more accurately reflect the current situation.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-doc.texi | 368 +++++++++++++++++++++++++++++++++++++++++++-------=
--------
>  1 file changed, 275 insertions(+), 93 deletions(-)
>=20

> +@subsection Configuring SASL mechanisms
> +
> +The following documentation assumes use of the Cyrus SASL implementati=
on on a
> +Linux host, but the principals should apply to any other SASL impl. Wh=
en SASL

s/impl/implementation/

> +is enabled, the mechanism configuration will be loaded from system def=
ault
> +SASL service config /etc/sasl2/qemu.conf. If running QEMU as an
> +unprivileged user, an environment variable SASL_CONF_PATH can be used
> +to make it search alternate locations for the service config.
> +


> +@node tls_generate_server
> +@subsection Issuing server certificates
> =20
>  Each server (or host) needs to be issued with a key and certificate. W=
hen connecting
>  the certificate is sent to the client which validates it against the C=
A certificate.
> -The core piece of information for a server certificate is the hostname=
=2E This should
> -be the fully qualified hostname that the client will connect with, sin=
ce the client
> -will typically also verify the hostname in the certificate. On the hos=
t holding the
> -secure CA private key:
> +The core pieces of information for a server certificate are the hostna=
mes and/or IP
> +addresses that will be used by clients when connecting. The hostname /=
 IP address
> +that the client specifies when connecting will be validated aganist th=
e hostname(s)

s/aganist/against/

> +and IP address(es) recorded in the server certificate, and if no match=
 is found
> +the client will close the connection.
> +
> +Thus it is recommended that the server certificate include both the fu=
lly qualfied

s/qualfied/qualified/


> +
> +If a single host is going to be using TLS in both a client and server
> +role, it is possible to create a single certificate to cover both role=
s.
> +This would be quite common for the migration and NBD services, where a=

> +QEMU be start by accepting a TLS protected incoming migration, and lat=
er

s/QEMU be start/QEMU process will be started/

> +itself be migrated out to another host. To generate a single certifica=
te,
> +simply include the template data from both the client and server
> +instructions in one.
> =20

> =20
> -When not using TLS the recommended configuration is
> +When copying the PEM files to the target host, save them twice
> +once as @code{server-cert.pem} and @code{server-key.pem}, and

s/twice/twice,/

> +against as @code{client-cert.pem} and @code{client-key.pem}.

s/against/again/

> +
> +@node tls_creds_setup
> +@subsection TLS x509 credential configuration
> +
> +QEMU has a standard mechanism for loading x509 credentials that will b=
e
> +used for network services and clients. It requires specifying the
> +@code{tls-creds-x509} class name to the @code{-object} command line
> +argument for the system emulators. This also works for the helper tool=
s
> +like @code{qemu-nbd} and @code{qemu-img}, but is named @code{--object}=
=2E

You can use '--object' with qemu as well (getopt_long_only() accepts
double-dash form in addition to single dash).  If it makes it any easier
to only document the double-dash form, then go for it.

> +Each set of credentials loaded should be given a unique string identif=
ier
> +via the @code{id} parameter. A single set of TLS credentials can be us=
ed
> +for multiple network backends, so VNC, migration, NBD, character devic=
es
> +can all share the same credentials. Note, however, that credentials fo=
r
> +use in a client endpoint must be loaded separately from those used in
> +a server endpoint.
> +
> +When specifying the object, the @code{dir} parameters specifies which
> +directory contains the credential files. This directory is expected to=

> +contain files with the names mentioned previously, @code{ca-cert.pem},=

> +@code{server-key.pem}, @code{server-cert.pem}, @code{client-key.pem}
> +and @code{client-cert.pem} as appropriate. It is also possible to
> +include a set of pre-generated diffie-hellman parameters in a file
> +@code{dh-params.pem}, which can be created using the
> +@code{certtool --generate-dh-params} command. If omitted, QEMU will
> +dynamically generated DH parameters when loading the credentials.

s/generated/generate/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9p5E76FDXMIKX9h0sU2WVfDCHc201DRpe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloquvIACgkQp6FrSiUn
Q2r+xgf/S90XOCytUC/mUX0F00Ksy1TYNlgByLxnPr0LihqDygBz7q4tjKLpjDLs
GZ8bUSL6b2qABhglU1EamL9QY+u4XQMab1hyQd2JlBfyyfQKMeww79z3sNGO4lyc
tEC/kNhxc1/gyp9kMKJMvbC3VccR/IplxFEqfohFMS7+28oiiR8ay6pYqFE2S6Eu
4JSBtdYqZ4lRvDd0CAcnBSiUOJhtYWF7zcySpxjl0mWH87d0Hng8wpoR/SokUfab
p57KMqxNUhauWnAD4QyGVqEZ8giN1RswMkQXpwjclFFhatSBu7tu/ztRnD8UGGw9
bYZDPju/FsDoJf+pGk93kqjN3fXZ2w==
=rxF1
-----END PGP SIGNATURE-----

--9p5E76FDXMIKX9h0sU2WVfDCHc201DRpe--
