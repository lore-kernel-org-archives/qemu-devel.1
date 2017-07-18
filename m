Received: from eggs.gnu.org ([2001:4830:134:3::10]:49219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWa4-000581-Re
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWa3-0008Al-MP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:46:44 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
Date: Tue, 18 Jul 2017 12:46:35 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-11-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SBeaXFBiFGv6kXw3384Mxr1o1iC5na5ce"
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SBeaXFBiFGv6kXw3384Mxr1o1iC5na5ce
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
Subject: Re: [PATCH for-2.10 10/10] migration: Use JSON null instead of "" to
 reset parameter to default
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> migrate-set-parameters sets migration parameters according to is
> arguments like this:
>=20
> * Present means "set the parameter to this value"
>=20
> * Absent means "leave the parameter unchanged"
>=20
> * Except for parameters tls_creds and tls_hostname, "" means "reset
>   the parameter to its default value
>=20
> The first two are perfectly normal: presence of the parameter makes
> the command do something.
>=20
> The third one overloads the parameter with a second meaning.  The
> overloading is *implicit*, i.e. it's not visible in the types.  Works
> here, because "" is neither a valid TLS credentials ID, nor a valid
> host name.
>=20
> Pressing argument values the schema accepts, but are semantically
> invalid, into service to mean "reset to default" is not general, as
> suitable invalid values need not exist.  I also find it ugly.
>=20
> To clean this up, we could add a separate flag argument to ask for
> "reset to default", or add a distinct value to @tls_creds and
> @tls_hostname.  This commit implements the latter: add JSON null to
> the values of @tls_creds and @tls_hostname, deprecate "".
>=20
> Because we're so close to the 2.10 freeze, implement it in the
> stupidest way possible: have qmp_migrate_set_parameters() rewrite null
> to "" before anything else can see the null.  The proper way to do it
> would be rewriting "" to null, but that requires fixing up code to
> work with null.  Add TODO comments for that.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> +++ b/qapi-schema.json
> @@ -116,6 +116,13 @@
>  { 'command': 'qmp_capabilities' }
> =20
>  ##
> +# @StrOrNull:

A little light on the documentation.

> +##
> +{ 'alternate': 'StrOrNull',
> +  'data': { 's': 'str',
> +            'n': 'null' } }
> +
> +##
>  # @LostTickPolicy:
>  #
>  # Policy for handling lost ticks in timer devices.
> @@ -1098,8 +1105,8 @@
>              '*decompress-threads': 'int',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
> -            '*tls-creds': 'str',
> -            '*tls-hostname': 'str',
> +            '*tls-creds': 'StrOrNull',
> +            '*tls-hostname': 'StrOrNull',
>              '*max-bandwidth': 'int',
>              '*downtime-limit': 'int',
>              '*x-checkpoint-delay': 'int',

By splitting input from output, you guarantee that 'null' won't appear
in the output and break an unsuspecting client, but that new clients can
introspect the existence of null and use that instead of "" on input.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SBeaXFBiFGv6kXw3384Mxr1o1iC5na5ce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluSXsACgkQp6FrSiUn
Q2pegQf+MaZ+B5GpPMJhbYEIqKzxW/psl9u0jjtob+prHXWWecidyyu65NvYhU0F
qImcxXw5Sltl1SI0FyXUZ/dLE87HUC3GinDbOxdu/jxw1P38JcCh3MpRtj+Xn8gY
u8A/K2GNqajKrf1M2znWIdItQSPq6bPm0L+VhxLV0sjyNRmNRBOnv2m99IjyjYcv
lx2J0XZvIdFcvmyPJC029VluE36XXSJJ9o/mIpDedIR5T04h5VLbWmvzBMNU4jZt
x6fyTKBqZuM53YJ3oYoJ2Db+bPSNSzRFN6qosHou446qwtWhsJ8HAz6/6lBRxNcH
EOhE+9NKAYb3c0eQiIT6yY3sQD0NFg==
=wmTg
-----END PGP SIGNATURE-----

--SBeaXFBiFGv6kXw3384Mxr1o1iC5na5ce--
