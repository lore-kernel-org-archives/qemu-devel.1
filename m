Received: from eggs.gnu.org ([2001:4830:134:3::10]:38596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS28A-0001kf-TP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS289-0003ul-RK
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:15:14 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78e9f722-b6b8-ed94-cf1e-4760059b077f@redhat.com>
Date: Mon, 3 Jul 2017 09:15:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170703122505.32017-6-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cqq3dDAo404QKMIFq3qMg6uXE3EKiUQTX"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add check-qobject for
 equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cqq3dDAo404QKMIFq3qMg6uXE3EKiUQTX
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <78e9f722-b6b8-ed94-cf1e-4760059b077f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add check-qobject for equality
 tests
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-6-mreitz@redhat.com>
In-Reply-To: <20170703122505.32017-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 07:25 AM, Max Reitz wrote:
> Add a new test file (check-qobject.c) for unit tests that concern
> QObjects as a whole.
>=20
> Its only purpose for now is to test the qobject_is_equal() function.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/Makefile.include |   4 +-
>  tests/check-qobject.c  | 312 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 315 insertions(+), 1 deletion(-)
>  create mode 100644 tests/check-qobject.c
>=20

> + * Note that qobject_is_equal() is not really an equivalence relation,=

> + * so this function may not be used for all objects (reflexivity is
> + * not guaranteed).

May be worth expanding the comment to mention NaN in QNum as the culprit
for this fact.


> +static void do_test_equality(bool expected, ...)
> +{
> +    va_list ap_count, ap_extract;
> +    QObject **args;
> +    int arg_count =3D 0;
> +    int i, j;
> +
> +    va_start(ap_count, expected);
> +    va_copy(ap_extract, ap_count);
> +    while (va_arg(ap_count, QObject *) !=3D &_test_equality_end_of_arg=
uments) {

Here, you're careful to allow a NULL argument,


> +static void do_free_all(int _, ...)
> +{
> +    va_list ap;
> +    QObject *obj;
> +
> +    va_start(ap, _);
> +    while ((obj =3D va_arg(ap, QObject *)) !=3D NULL) {
> +        qobject_decref(obj);
> +    }

Here, you stop on the first NULL, and aren't checking for the special
sentinel that can't be freed.

> +    va_end(ap);
> +}
> +
> +#define free_all(...) \
> +    do_free_all(0, __VA_ARGS__, NULL)

Then again, you don't pass the special sentinel. So as long as NULL is
the last argument(s) on any test that passes NULL (rather than an
intermediate argument), you don't need to use the sentinel, and stopping
iteration on the first NULL is okay.  A bit magic, but I can live with it=
=2E

> +
> +static void qobject_is_equal_null_test(void)
> +{
> +    test_equality(false, qnull(), NULL);
> +}

Where do you test_equality(true, NULL, NULL) ?

> +
> +static void qobject_is_equal_num_test(void)
> +{
> +    QNum *u0, *i0, *d0, *d0p25, *dnan, *um42, *im42, *dm42;
> +    QString *s0, *s_empty;
> +    QBool *bfalse;
> +
> +    u0 =3D qnum_from_uint(0u);
> +    i0 =3D qnum_from_int(0);
> +    d0 =3D qnum_from_double(0.0);
> +    d0p25 =3D qnum_from_double(0.25);
> +    dnan =3D qnum_from_double(0.0 / 0.0);

Ah, so you ARE testing NaN as a QNum, even though it can't occur in
JSON.  Might be worth a comment.


> +
> +    /* Containing an NaN value will make this dict compare unequal to

s/an/a/ (if you pronounce it "nan" or "not-a-number") (but I guess no
change if you pronounce it "en-a-en")

There might be some improvements to add, but as written the test is
reasonable, and some testing is better than none, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Cqq3dDAo404QKMIFq3qMg6uXE3EKiUQTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWlFnAAoJEKeha0olJ0NqWdkH/3eMs83HVwOLZy8eyTjbFDkA
Gpjrxi9rM5Qs6fE7CSiwtlU+SvigFDuQKrZW9xucVUaqNw1pVAvT3UIDoWpk/6+W
b49QEJFLweaoiMjnUxelRKrfjMrD8Fl1GIm/vXK9dMAiA+5lHxhl0RISEYQVNGBe
4d4NYvxfMaxyocIzbO/jvNFLRSf3rdzWWVZkTbUHWaBoJnEljV0ksFQtjtv0vQeu
UncnrmVMG40KMX46RCFXJCc7yhU3oNtOvXfKn+c0JrTVNn7PTwnOSbeWitW2PWPJ
m6ihxz79Fx1BOgENtTnNOsffxZ7lnk7AdL6vCRv1KHv/CCD8khiOKJebOYBYjuI=
=E253
-----END PGP SIGNATURE-----

--Cqq3dDAo404QKMIFq3qMg6uXE3EKiUQTX--
