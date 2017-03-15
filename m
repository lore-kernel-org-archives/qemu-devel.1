Received: from eggs.gnu.org ([2001:4830:134:3::10]:42538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coE4L-00078X-1h
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coE4G-0005ee-5x
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coE4F-0005eD-TZ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:54:40 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB1C54E4D3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 18:54:39 +0000 (UTC)
References: <20170315182541.14073-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17cfe5cc-5692-c7b1-87da-548900379901@redhat.com>
Date: Wed, 15 Mar 2017 13:54:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170315182541.14073-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KDPcBvqehTC30EMq2og15IvcInqHU7JfI"
Subject: Re: [Qemu-devel] [PATCH] Default to GSSAPI (Kerberos) instead of
 DIGEST-MD5 for SASL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KDPcBvqehTC30EMq2og15IvcInqHU7JfI
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <17cfe5cc-5692-c7b1-87da-548900379901@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Default to GSSAPI (Kerberos) instead of
 DIGEST-MD5 for SASL
References: <20170315182541.14073-1-berrange@redhat.com>
In-Reply-To: <20170315182541.14073-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 01:25 PM, Daniel P. Berrange wrote:
> RFC 6331 documents a number of serious security weaknesses in
> the SASL DIGEST-MD5 mechanism. As such, QEMU should not be
> using or recommending it as a default mechanism for VNC auth
> with SASL.
>=20
> GSSAPI (Kerberos) is the only other viable SASL mechanism that
> can provide secure session encryption so enable that by defalt
> as the replacement. If users have TLS enabled for VNC, they can
> optionally decide to use SCRAM-SHA-1 instead of GSSAPI, allowing
> plain username and password auth.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-doc.texi | 50 +++++++++++++++++++++++++++++---------------------
>  qemu.sasl     | 54 +++++++++++++++++++++++++++++++--------------------=
---
>  2 files changed, 60 insertions(+), 44 deletions(-)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 794ab4a..922b3a4 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1732,37 +1732,45 @@ SASL service config /etc/sasl2/qemu.conf. If ru=
nning QEMU as an
>  unprivileged user, an environment variable SASL_CONF_PATH can be used
>  to make it search alternate locations for the service config.
> =20
> -The default configuration might contain
> +If the TLS option is enabled for VNC, then it will provide session enc=
ryption,
> +otherwise the SASL mechanism will have to provide encryption. In the l=
atter
> +case the list of possible plugins that can be used is drastically redu=
ced. In
> +fact only the GSSAPI SASL mechanism provides an acceptable level of se=
curity
> +by modern standards. Previous versions of QEMU referred to the DIGEST-=
MD5
> +mechansim, however, it has multiple serious flaws described in detail =
in

s/mechansim/mechanism/

> +RFC 6331 and thus should never be used any more. The SCRAM-SHA-1 mecha=
nism
> +provides a simple username/password auth facility similar to DIGEST-MD=
5, but
> +does not support session encryption, so can only be used in conbinatio=
n with

s/conbination/combination/

> +TLS.
> +
> +When not using TLS the recommended configuration is
> =20
>  @example
> -mech_list: digest-md5
> -sasldb_path: /etc/qemu/passwd.db
> +mech_list: gssapi
> +keytab: /etc/qemu/krb5.tab
>  @end example
> =20
> -This says to use the 'Digest MD5' mechanism, which is similar to the H=
TTP
> -Digest-MD5 mechanism. The list of valid usernames & passwords is maint=
ained
> -in the /etc/qemu/passwd.db file, and can be updated using the saslpass=
wd2
> -command. While this mechanism is easy to configure and use, it is not
> -considered secure by modern standards, so only suitable for developers=
 /
> -ad-hoc testing.
> +This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol,=
 with
> +the server principal stored in /etc/qemu/krb5.tab. For this to work th=
e
> +administrator of your KDC must generate a Kerberos principal for the s=
erver,
> +with a name of  'qemu/somehost.example.com@@EXAMPLE.COM' replacing

spurious double space

> +'somehost.example.com' with the fully qualified host name of the machi=
ne
> +running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
> =20
> -A more serious deployment might use Kerberos, which is done with the '=
gssapi'
> -mechanism
> +When using TLS, if username+password authentication is desired, then a=

> +reasonable configuration is
> =20
>  @example
> -mech_list: gssapi
> -keytab: /etc/qemu/krb5.tab
> +mech_list: scram-sha-1
> +sasldb_path: /etc/qemu/passwd.db
>  @end example
> =20
> -For this to work the administrator of your KDC must generate a Kerbero=
s
> -principal for the server, with a name of  'qemu/somehost.example.com@@=
EXAMPLE.COM'
> -replacing 'somehost.example.com' with the fully qualified host name of=
 the
> -machine running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
> +The saslpasswd2 program can be used to populate the passwd.db file wit=
h
> +accounts.
> =20
> -Other configurations will be left as an exercise for the reader. It sh=
ould
> -be noted that only Digest-MD5 and GSSAPI provides a SSF layer for data=

> -encryption. For all other mechanisms, VNC should always be configured =
to
> -use TLS and x509 certificates to protect security credentials from sno=
oping.
> +Other SASL configurations will be left as an exercise for the reader. =
Note that
> +all mechanisms except GSSAPI, should be combined with use of TLS to en=
sure a
> +security data channel.

s/security/secure/ ?

> =20
>  @node gdb_usage
>  @section GDB usage
> diff --git a/qemu.sasl b/qemu.sasl
> index 64fdef3..8c501a1 100644
> --- a/qemu.sasl
> +++ b/qemu.sasl
> @@ -1,36 +1,44 @@
> -# If you want to use the non-TLS socket, then you *must* include
> -# the GSSAPI or DIGEST-MD5 mechanisms, because they are the only
> -# ones that can offer session encryption as well as authentication.
> +# If you want to use VNC remotely without TLS, then you *must*
> +# pick  a mechanism which provides session encryption as well

spurious double space

> +# as authentication.
>  #
> -# If you're only using TLS, then you can turn on any mechanisms
> +# If you are only using TLS, then you can turn on any mechanisms
>  # you like for authentication, because TLS provides the encryption
>  #
> -# Default to a simple username+password mechanism
> -# NB digest-md5 is no longer considered secure by current standards
> -mech_list: digest-md5
> +# If you are only using UNIX, sockets then encryption is not

s/UNIX, sockets/UNIX sockets,/

> +# required at all.
> +#
> +# NB, previously DIGEST-MD5 was set as the default mechanism for
> +# QEMU VNC. Per RFC 6331 this is vulnerable to many serious security
> +# flaws as should no longer be used. Thus GSSAPI is now the default.
> +#
> +# To use GSSAPI requires that a QEMU service principal is
> +# added to the Kerberos server for each host running QEMU.
> +# This principal needs to be exported to the keytab file listed below
> +mech_list: gssapi
> =20
> -# Before you can use GSSAPI, you need a service principle on the
> -# KDC server for libvirt, and that to be exported to the keytab
> -# file listed below
> -#mech_list: gssapi
> +# If using TLS with VNC, or a UNIX socket only, it is possible to
> +# enable plugins which don't provide session encryption. The
> +# 'scram-sha-1' plugin allows plain username/password authentication
> +# to be performed
>  #
> -# You can also list many mechanisms at once, then the user can choose
> -# by adding  '?auth=3Dsasl.gssapi' to their libvirt URI, eg
> -#   qemu+tcp://hostname/system?auth=3Dsasl.gssapi
> -#mech_list: digest-md5 gssapi
> +#mech_list: scram-sha-1
> +
> +# You can also list many mechanisms at once, and the VNC server will
> +# negotiate which to use by considering the list enabled on the VNC
> +# client.
> +#mech_list: scram-sha-1 gssapi
> =20
>  # Some older builds of MIT kerberos on Linux ignore this option &
>  # instead need KRB5_KTNAME env var.
>  # For modern Linux, and other OS, this should be sufficient
>  #
> -# There is no default value here, uncomment if you need this
> -#keytab: /etc/qemu/krb5.tab
> +# This file needs to be populated with the service principal that
> +# was created on the Kerberos v5 server. If switching to a non-gssapi
> +# mechanism this can be commented out.
> +keytab: /etc/qemu/krb5.tab
> =20
> -# If using digest-md5 for username/passwds, then this is the file
> +# If using scram-sha-1 for username/passwds, then this is the file
>  # containing the passwds. Use 'saslpasswd2 -a qemu [username]'
>  # to add entries, and 'sasldblistusers2 -f [sasldb_path]' to browse it=

> -sasldb_path: /etc/qemu/passwd.db
> -
> -
> -auxprop_plugin: sasldb
> -
> +#sasldb_path: /etc/qemu/passwd.db
>=20

With typos fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KDPcBvqehTC30EMq2og15IvcInqHU7JfI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyY3oAAoJEKeha0olJ0Nq5R4H/jpS/HmZtvANggytq3ETvF5V
dVeL0p+KnQvAouBoELcy+fwejLfJmBZrQS0fzmAdUOtqL7Gepu1GnTkIop2P3n4Y
BDeDPrrFUU60Yx9vvejmMnvYJvKKpbyfhxdtpfrmCRKQlzskz3F1EkVuXCSQUWq3
f3j3T76YGtVx/tG72ilcFiE8JA3JPFIcfkgSpFnJu6tfr16evx1vmTeFGapjg6oW
iuSMxttBCcgDZWx2y0OHDBwC6S5uIKnaotWSfG3LVBV70A6Qr76CsjWwaISA03+G
LNCMlV6BfWKjzhUn1fvr6p5CxwwyUMiED5ooHhxxaT2LHXbr65YECmZPDl/D/cQ=
=tGDK
-----END PGP SIGNATURE-----

--KDPcBvqehTC30EMq2og15IvcInqHU7JfI--
