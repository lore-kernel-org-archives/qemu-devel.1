Received: from eggs.gnu.org ([2001:4830:134:3::10]:58450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnYf2-0002R2-4k
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnYex-0005NK-Iv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnYex-0005Mv-9v
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:41:47 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27b4a5aa-fa4e-ad49-c51a-cc5b49c58525@redhat.com>
Date: Mon, 13 Mar 2017 17:41:44 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7uPTunUBbo7aEW3aL4exFJKnttHfIFGen"
Subject: Re: [Qemu-devel] [PATCH for-2.9 05/47] qapi: Have each QAPI schema
 declare its returns white-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7uPTunUBbo7aEW3aL4exFJKnttHfIFGen
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <27b4a5aa-fa4e-ad49-c51a-cc5b49c58525@redhat.com>
Subject: Re: [PATCH for-2.9 05/47] qapi: Have each QAPI schema declare its
 returns white-list
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> qapi.py has a hardcoded white-list of command names that may violate
> the rules on permitted return types.  Add a new pragma directive
> 'returns-whitelist', and use it to replace the hard-coded white-list.

So now the list is per-client, rather than global. Nice idea!

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -51,6 +51,18 @@
> =20
>  { 'pragma': { 'doc-required': true } }
> =20
> +# Whitelists to permit QAPI rule violations; think twice before you
> +# add to them!
> +{ 'pragma': {
> +    # Commands allowed to return a non-dictionary:
> +    'returns-whitelist': [
> +        'human-monitor-command',
> +        'qom-get',
> +        'query-migrate-cache-size',
> +        'query-tpm-models',
> +        'query-tpm-types',
> +        'ringbuf-read' ] } }
> +

If I'm understanding the code right, we could have also written this all
as one pragma with a larger dict instead of two pragmas with one-element
dicts:

{ 'pragma': { 'doc-required': true,
              'returns-whitelist': [ ... ] } }

But see below about another potential for rewriting that I thought of
before reading your full patch [1]...

> @@ -317,12 +298,19 @@ class QAPISchemaParser(object):
>          self.docs.extend(exprs_include.docs)
> =20
>      def _pragma(self, name, value, info):
> -        global doc_required
> +        global doc_required, returns_whitelist
>          if name =3D=3D 'doc-required':
>              if not isinstance(value, bool):
>                  raise QAPISemError(info,
>                                     "Pragma 'doc-required' must be bool=
ean")
>              doc_required =3D value
> +        elif name =3D=3D 'returns-whitelist':
> +            if (not isinstance(value, list)
> +                    or any([not isinstance(elt, str) for elt in value]=
)):
> +                raise QAPISemError(info,
> +                                   "Pragma returns-whitelist must be"
> +                                   " a list of strings")

Again, a new error message with no testsuite coverage.

> +            returns_whitelist =3D value

[1] Hmm, this precludes the converse direction of specifying things.
You cannot usefully list the whitelist pragma more than once, because
only the last one wins.  Why would we want to allow it to be more than
once? because we could do:

{ 'pragma': 'returns-whitelist': [ 'human-monitor-command' ] }
{ 'pragma': 'returns-whitelist': [ 'qom-get' ] }

and then spread out the uses of the pragma to be closer to the
violations, rather than bunched up front.

Or maybe you want to consider rejecting a second whitelist, instead of
silently losing the first one, if you want to force that all violations
are bunched up front into a single pragma.

But that's food for thought - I'm leaving it up to you if you want to
spin a v2 (making non-trivial changes based on my comments), or leave
improvements (like any testsuite additions) for a followup patch.  If
you use this patch as-is, you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7uPTunUBbo7aEW3aL4exFJKnttHfIFGen
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxyAoAAoJEKeha0olJ0NqzckH/35e/FYTw1jDkZBKETiGjB8u
KQ3TnNozPhtzKMmD7MfNkVguJWDZ20WkJ6gQXkMCA5R6D1joQBujgHbqXtZcxJFL
Np9KmGtL+RML3/ThIokIBV+Ly1nxrJPMVcjjMhLC9bYA2/7h+Fuxrd8AqvDGLS+D
Kzlb3jLWBZzX+c3T0KrJ1lT7Nf87ED39SEJu11hwcELaJBUr+36p+WmvTcYaLMWQ
5plqKrhd7S23dqqoc7xy7ztYt4QK8UrNfwIK7qvm0MVFP5z6nay6U8wHUOzooHH7
mXaxWL8tOfeoNAxeHVqfMwnr9OUz4V8lIeDlWWHP3M1zOBnPwM16dGyE/dynbkY=
=2ABX
-----END PGP SIGNATURE-----

--7uPTunUBbo7aEW3aL4exFJKnttHfIFGen--
