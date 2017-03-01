Received: from eggs.gnu.org ([2001:4830:134:3::10]:37498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj5MQ-0002y3-Kr
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj5MN-0002HB-Hv
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:36:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cj5MN-0002Gw-9I
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:36:07 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C77C4E339
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 14:36:07 +0000 (UTC)
References: <20170301123223.12489-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
Date: Wed, 1 Mar 2017 08:36:03 -0600
MIME-Version: 1.0
In-Reply-To: <20170301123223.12489-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GogtbEIkqdNdLAA4L8qb5rxWULjbC08Jx"
Subject: Re: [Qemu-devel] [PATCH] migration: allow clearing migration string
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GogtbEIkqdNdLAA4L8qb5rxWULjbC08Jx
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela
 <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
Subject: Re: [PATCH] migration: allow clearing migration string parameters
References: <20170301123223.12489-1-berrange@redhat.com>
In-Reply-To: <20170301123223.12489-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/01/2017 06:32 AM, Daniel P. Berrange wrote:
> Some of the migration parameters are strings, which default to NULL,
> eg tls_hostname and tls_creds.
>=20
> The mgmt app will set the tls_creds parameter on both source and target=

> QEMU instances, in order to trigger use of TLS for migration.
>=20
> After performing a TLS encrypted migration though, migration might be
> used for other reasons - for example, to save the QEMU state to a file.=

> We need TLS turned off when doing this, but the migrate-set-parameters
> QAPI command does not provide any facility to clear/reset parameters
> to their default state.
>=20
> If you simply ommit the tls_creds parameter in migrate-set-parameters,

s/ommit/omit/

> then 'has_tls_creds' will be false and so no action will be taken. The
> only option that works with migrate-set-parameters is to treat "" on
> the wire as equivalent to requesting NULL. Failing that we would have
> to create a new 'migrate-reset-parameters' method to explicitly put
> a parameter back to its default value.

That happens to work in this case, because an empty string as the TLS
parameter makes no sense.

A nicer solution would be to support JSON null on the wire, so the user
can pass "tls-creds":null to explicitly request wiping out the
credentials rather than making the empty string magic.  But that's more
invasive (the QAPI parser would have to be enhanced to allow an
alternate that visits either a string or null).  Ultimately, I think
we'll have to do that when we come up with some string property where ""
should not be given magic treatment.

So now we have a dilemma: do we special case "" here, to be stuck with
it even if we later add nullable-string support later, or do we go all
the way to nullable-string support now?  We've missed soft freeze for
2.9, so my vote is that it is okay to special case "" in  this instance,
even though we'll have to continue to support it indefinitely even if we
gain nullable-string QMP.

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> CC'ing Eric & Markus since this is related to QAPI schema for migrate
> monitor commands
>=20

>      }
>      if (params->has_tls_creds) {
>          g_free(s->parameters.tls_creds);
> -        s->parameters.tls_creds =3D g_strdup(params->tls_creds);
> +        if (*params->tls_creds =3D=3D '\0') {
> +            s->parameters.tls_creds =3D NULL;

I'm wondering if you should also do s->parameters.has_tls_creds =3D false=

at this point?  The visitors expect that if has_tls_creds is true, then
the string is non-NULL.

> +        } else {
> +            s->parameters.tls_creds =3D g_strdup(params->tls_creds);
> +        }
>      }
>      if (params->has_tls_hostname) {
>          g_free(s->parameters.tls_hostname);
> -        s->parameters.tls_hostname =3D g_strdup(params->tls_hostname);=

> +        if (*params->tls_hostnane =3D=3D '\0') {
> +            s->parameters.tls_hostnane =3D NULL;

This build-breaking typo isn't intended. :)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GogtbEIkqdNdLAA4L8qb5rxWULjbC08Jx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYttxTAAoJEKeha0olJ0NqoWQH/id0XAVppk01/967u0tgquxj
HgG1F2MMcHBNItfQTRUd4mWlhVqE0HZaRPwfNXPaBvXoePgvOTdUFLbynH5HiyXw
tvpz2zPEq7GcFsvzBlRG4oTFYa8TNoYuYQNPn8H/SNQPosJimSjMvs/Op4Cd/osN
xVnVVp7XqpPUltYfs2YbAwH3crU9FiDJzt7YdChFBdW9ZIqvNRaXKRAB0zQWSzEX
b8xMheFUlclMnfvqnjZRPAHzipYEDhmpfM25uHDFi6x/3N8rScLOtbffLpgoMSxE
+gR0MNpPqegQGmHi/4IK4PTaHpqRrbCFixjZjlqdT32IX9dpb00qyBVX+ShS6K0=
=f29f
-----END PGP SIGNATURE-----

--GogtbEIkqdNdLAA4L8qb5rxWULjbC08Jx--
