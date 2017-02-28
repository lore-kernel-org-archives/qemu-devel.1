Received: from eggs.gnu.org ([2001:4830:134:3::10]:41930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciqgy-0000mm-If
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciqgx-0003Oy-CZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:56:24 -0500
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
	<1488317230-26248-25-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb582b14-93a2-e505-2bf0-004821ed36ff@redhat.com>
Date: Tue, 28 Feb 2017 16:56:15 -0600
MIME-Version: 1.0
In-Reply-To: <1488317230-26248-25-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lnturp7OXxEr5sidHG2gQBeJT5p7wqSLV"
Subject: Re: [Qemu-devel] [PATCH v2 24/24] keyval: Support lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lnturp7OXxEr5sidHG2gQBeJT5p7wqSLV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <cb582b14-93a2-e505-2bf0-004821ed36ff@redhat.com>
Subject: Re: [PATCH v2 24/24] keyval: Support lists
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
 <1488317230-26248-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-25-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 03:27 PM, Markus Armbruster wrote:
> Additionally permit non-negative integers as key components.  A
> dictionary's keys must either be all integers or none.  If all keys
> are integers, convert the dictionary to a list.  The set of keys must
> be [0,N].
>=20

> +static void test_keyval_parse_list(void)
> +{
> +    Error *err =3D NULL;
> +    QDict *qdict, *sub_qdict;
> +

> +    /* Missing list indexes */
> +    qdict =3D keyval_parse("list.2=3Dlonely", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +    qdict =3D keyval_parse("list.0=3Dnull,list.2=3Deins,list.02=3Dzwei=
", NULL, &err);

You have a negative test that covers when list.2 and list.02 map to the
same thing (but we forgot list.1) [good], but no positive test of
leading zeroes still resulting in a correct QList.  Seems like a
reasonable followup patch during freeze (testsuite additions are freeze
material, and I don't want to delay the pull request).

At any rate, this one looks better than v1 at handling leading zero
index duplication.

>  /*
> + * Convert @key to a list index.
> + * Convert all leading digits to a (non-negative) number, capped at

Maybe insert the word 'decimal', to make it obvious that 010 is index
10, not 8?

> +/*
> + * Listify @cur recursively.
> + * Replace QDicts whose keys are all valid list indexes by QLists.
> + * @key_of_cur is the list of key fragments leading up to @cur.
> + * On success, return either @cur or its replacement.
> + * On failure, store an error through @errp and return NULL.
> + */
> +static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error *=
*errp)
> +{

> +
> +    /*
> +     * Make a list from @elt[], reporting any missing elements.
> +     * If we dropped an index >=3D nelt in the previous loop, this loo=
p
> +     * will run into the sentinel and report index @nelt missing.
> +     */
> +    list =3D qlist_new();
> +    assert(!elt[nelt-1]);       /* need the sentinel to be null */
> +    for (i =3D 0; i < MIN(nelt, max_index + 1); i++) {
> +        if (!elt[i]) {
> +            key =3D reassemble_key(key_of_cur);
> +            error_setg(errp, "Parameter '%s%d' missing", key, i);
> +            g_free(key);
> +            g_free(elt);
> +            QDECREF(list);
> +            return NULL;

If more than one gap exists, this only reports the first missing
element; "any missing elements" implies that it reports all.  No
different from our behavior on structs, where we only report one
(random!) excess element or the first missing one in visit order, rather
than all problems, so all that needs tweaking would be the comment.

Can all be done as followups, without invalidating the pull request.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Lnturp7OXxEr5sidHG2gQBeJT5p7wqSLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgAPAAoJEKeha0olJ0NqY90IAJTNq8zR5wx3EMCzPu3eHLu3
d3s4T0/eC8LwK1oxOzQFbt+qrPztr/G84fGeopKenHgZKO5ot+uqCipu9bifargP
iE9kQaWcip3dnOnv29R2R0GCCdj6fVe7h7wfix4e71f0EaTQOYqpIbxlU0wQ1UjQ
Z6pjUoSsJjeT8/qpweVZFeEK8M+iT8beIr5aYIhOnByHF4dI0qtRrk5FsRh5ldFG
gOOZFDUrE3fDFh162xiECMcXMbBXygchD8ztvOhGEiMbNgjTX9GUJK29BubUYnW6
PpeoqjuXdIPUsub9y6br2ElG3W9q30lbS8gMsNKsCMOQ0ZLRMg/qkMLEi6oBiZs=
=SlID
-----END PGP SIGNATURE-----

--Lnturp7OXxEr5sidHG2gQBeJT5p7wqSLV--
