Received: from eggs.gnu.org ([2001:4830:134:3::10]:36870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgE2M-0001Vt-JB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgE2I-00068N-6J
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:47:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dgE2H-00067G-Sl
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:47:50 -0400
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
	<1502467522-32237-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df0646df-6e46-4361-010d-aac529177b62@redhat.com>
Date: Fri, 11 Aug 2017 12:47:44 -0500
MIME-Version: 1.0
In-Reply-To: <1502467522-32237-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NNuiR0MxOGLuAMiNqphRcOO6vvolOd9i1"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NNuiR0MxOGLuAMiNqphRcOO6vvolOd9i1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com, f4bug@amsat.org
Message-ID: <df0646df-6e46-4361-010d-aac529177b62@redhat.com>
Subject: Re: [PATCH v2 2/2] vl: Partial support for non-scalar properties with
 -object
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
 <1502467522-32237-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1502467522-32237-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 11:05 AM, Markus Armbruster wrote:
> We've wanted -object to support non-scalar properties for a while.
> Dan Berrange tried in "[PATCH v4 00/10]Provide a QOM-based
> authorization API".  Review led to the conclusion that we need to
> replace rather than add to QemuOpts.  Initial work towards that goal
> has been merged to provide -blockdev (commit 8746709), but there's
> substantial work left, mostly due to an bewildering array of
> compatibility problems.
>=20
> Even if a full solution is still out of reach, we can have a partial
> solution now: accept -object argument in JSON syntax.  This should
> unblock development work that needs non-scalar properties with
> -object.
>=20
> The implementation is similar to -blockdev, except we use the new
> infrastructure only for the new JSON case, and stick to QemuOpts for
> the existing KEY=3DVALUE,... case, to sidestep compatibility problems.
>=20
> If we did this for more options, we'd have to factor out common code.
> But for one option, this will do.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi-schema.json | 14 +++++++++++---
>  vl.c             | 51 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  2 files changed, 62 insertions(+), 3 deletions(-)
>=20
>  static void object_create(bool (*type_predicate)(const char *))
>  {
> +    ObjectOptionsQueueEntry *e, *next;
> +
> +    QSIMPLEQ_FOREACH_SAFE(e, &oo_queue, entry, next) {
> +        if (!type_predicate(e->oo->qom_type)) {
> +            continue;
> +        }
> +
> +        loc_push_restore(&e->loc);
> +        qmp_object_add(e->oo->qom_type, e->oo->id,
> +                       e->oo->has_props, e->oo->props, &error_fatal);
> +        loc_pop(&e->loc);
> +
> +        QSIMPLEQ_REMOVE(&oo_queue, e, ObjectOptionsQueueEntry, entry);=

> +        qapi_free_ObjectOptions(e->oo);
> +    }
> +
>      if (qemu_opts_foreach(qemu_find_opts("object"),

This handles all JSON forms prior to any QemuOpt forms (within the two
priority levels), such that a command line using:

 -object type,id=3D1,oldstyle... -object '{'id':2, 'type':..., newstyle..=
=2E}'

processes the arguments in a different order than

 -object type,id=3D1,oldstyle... -object type,id=3D2,oldstyle

But I don't see that as too bad (ideally, someone using the {} JSON
style will use it consistently).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NNuiR0MxOGLuAMiNqphRcOO6vvolOd9i1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmN7cEACgkQp6FrSiUn
Q2q/1gf7Be8O7JHXXlb+WgtQFDMdm6O9rOpsIoDjQXUt6iZaX4wX54zFIK2Zk08O
9BMotyHm217W5R/fCoo/gh3VMRSz65MaU/rh88d6zQ2pulxLOOJ6vOmeA54yMaTn
bD2w8JAT4M80VBD1N6Yw7xsAqfvmYIz/1b2HkYQGF8cSEGKsMUa7ehdZ3QWrSIBZ
7mxb5oIEm3t56+VdOxGQw5JMSGd+okbzsvYSL37I9uoL2G9YPJdYl8QcATV3kpKq
GbqNWB0LlFS4PeNnl2Jzc4KsEJTwcHMuHpWPBDNNQImEWjejZUxvA4Z4ToT3nI2q
XeY7XP94w9rJZrxINJ1itrJ7JQgqSg==
=IQdL
-----END PGP SIGNATURE-----

--NNuiR0MxOGLuAMiNqphRcOO6vvolOd9i1--
