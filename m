Received: from eggs.gnu.org ([2001:4830:134:3::10]:42632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ef3m8-0001LZ-UB
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ef3m3-0003lk-Rp
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:10:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ef3m3-0003lM-Jg
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:10:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ECEDEC0AA
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 12:53:13 +0000 (UTC)
Date: Fri, 26 Jan 2018 13:53:09 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180126125309.euaviiu3x2cmgeu5@eukaryote>
References: <20180125170930.20009-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125170930.20009-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] docs: update information for TLS
 certificate management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 25, 2018 at 05:09:30PM +0000, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>

[...]

> +@node vnc_setup_sasl
> +
> +@subsection Configuring SASL mechanisms
> +
> +The following documentation assumes use of the Cyrus SASL implementati=
on on a
> +Linux host, but the principals should apply to any other SASL implemen=
tation

s/principals/principles/

[I can imagine how the typo could've come about -- as you talk about
Kerberos principal(s) further below :-)]

> +or host. When SASL is enabled, the mechanism configuration will be loa=
ded from
> +system default SASL service config /etc/sasl2/qemu.conf. If running QE=
MU as an
> +unprivileged user, an environment variable SASL_CONF_PATH can be used =
to make
> +behaviour suddenly changedit search alternate locations for the servic=
e config.

The last part above reads odd, maybe you accidentally removed some
words?

[...]

> +This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol,=
 with
> +the server principal stored in /etc/qemu/krb5.tab. For this to work th=
e
> +administrator of your KDC must generate a Kerberos principal for the s=
erver,
> +with a name of 'qemu/somehost.example.com@@EXAMPLE.COM' replacing
> +'somehost.example.com' with the fully qualified host name of the machi=
ne
> +running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
> +
> +When using TLS, if username+password authentication is desired, then a
> +reasonable configuration is
> +
> +@example
> +mech_list: scram-sha-1
> +sasldb_path: /etc/qemu/passwd.db
> +@end example
> +
> +The saslpasswd2 program can be used to populate the passwd.db file wit=
h
> +accounts.

Maybe: "saslpasswd2" --> "@code{saslpasswd2}"

(Also helps with consistency, as I see you've used the @code{} attribute
further below.)

> +
> +Other SASL configurations will be left as an exercise for the reader. =
Note that
> +all mechanisms except GSSAPI, should be combined with use of TLS to en=
sure a

Spurious comma above.

> +secure data channel.

[...]

> +The GNUTLS package includes a command called @code{certtool} which can

Super nit: s/GNUTLS/GnuTLS/

[...]

> +@node tls_creds_setup
> +@subsection TLS x509 credential configuration
> =20
> -@node vnc_setup_sasl
> +QEMU has a standard mechanism for loading x509 credentials that will b=
e
> +used for network services and clients. It requires specifying the
> +@code{tls-creds-x509} class name to the @code{-object} command line
> +argument for the system emulators. This also works for the helper tool=
s
> +like @code{qemu-nbd} and @code{qemu-img}, but is named @code{--object}=
.

The '-object' for QEMU command-line, and the double-dashed '--object'
for external tools looks a tiny bit odd.  But not this patch's problem.

(I just noticed Eric remarked on this too.)

 =20
> -@subsection Configuring SASL mechanisms
> +When specifying the object, the @code{dir} parameters specifies which
> +directory contains the credential files. This directory is expected to
> +contain files with the names mentioned previously, @code{ca-cert.pem},
> +@code{server-key.pem}, @code{server-cert.pem}, @code{client-key.pem}
> +and @code{client-cert.pem} as appropriate. It is also possible to
> +include a set of pre-generated diffie-hellman parameters in a file

Would be nice capitalize proper nouns: s/diffie-hellman/Diffie=E2=80=93He=
llman
(DH) --- 'DH' in brackets because you use that acronym two lines below,
although it should be obvious to those setting up TLS.

> +@code{dh-params.pem}, which can be created using the
> +@code{certtool --generate-dh-params} command. If omitted, QEMU will
> +dynamically generate DH parameters when loading the credentials.

[...]

 =20
> -The saslpasswd2 program can be used to populate the passwd.db file wit=
h
> -accounts.
> +Network services which support TLS will all have a @code{tls-creds}
> +parameter which expects the ID of the tls credentials object.=20

s/tls/TLS

[...]

Whether you fix these minor nits or not, your write-up is a strict
improvement, so:

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

--=20
/kashyap
