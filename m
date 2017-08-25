Received: from eggs.gnu.org ([2001:4830:134:3::10]:58807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlKBL-0003i3-Dp
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 15:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlKBK-0002jQ-Bg
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 15:22:15 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-3-vsementsov@virtuozzo.com>
	<484ffeb7-6571-af84-ee4b-0bfcb83df7ad@redhat.com>
	<8a8054d8-a5cd-dfbb-fa28-287b63e79102@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07fd01db-d0d1-2c7c-bbfa-895b90939749@redhat.com>
Date: Fri, 25 Aug 2017 14:22:06 -0500
MIME-Version: 1.0
In-Reply-To: <8a8054d8-a5cd-dfbb-fa28-287b63e79102@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KnMMSkcqD87V2KxIEDMsnPalWCtIMHHVH"
Subject: Re: [Qemu-devel] [PATCH 02/17] nbd/client: refactor nbd_read_eof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KnMMSkcqD87V2KxIEDMsnPalWCtIMHHVH
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <07fd01db-d0d1-2c7c-bbfa-895b90939749@redhat.com>
Subject: Re: [PATCH 02/17] nbd/client: refactor nbd_read_eof
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-3-vsementsov@virtuozzo.com>
 <484ffeb7-6571-af84-ee4b-0bfcb83df7ad@redhat.com>
 <8a8054d8-a5cd-dfbb-fa28-287b63e79102@virtuozzo.com>
In-Reply-To: <8a8054d8-a5cd-dfbb-fa28-287b63e79102@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.08.2017 14:42, Eric Blake wrote:
>> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Refactor nbd_read_eof to return 1 on success, 0 on eof, when no
>>> data was read and <0 for other cases, because returned size of
>>> read data is not actually used.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---

>>> + * Returns 1 on success
>>> + *         0 on eof, when no data was read (errp is not set)
>>> + *         -EINVAL on eof, when some data < @size was read until eof=

>>> + *         < 0 on read fail
>> In general, mixing negative errno value and generic < 0 in the same
>> function is most likely ambiguous.
>=20
> Hmm, but this is entirely what we do so often:
>=20
> if (,,) return -EINVAL;
>=20
> return some_other_func().
>=20
> last two lines may be rewritten like this:
> + * < 0 on fail

Or even better as 'negative errno on failure'.

Here's what I'm proposing to squash in, at which point you have:

Reviewed-by: Eric Blake <eblake@redhat.com>

diff --git i/nbd/nbd-internal.h w/nbd/nbd-internal.h
index 3fb0b6098a..03549e3f39 100644
--- i/nbd/nbd-internal.h
+++ w/nbd/nbd-internal.h
@@ -80,8 +80,7 @@
  * Tries to read @size bytes from @ioc.
  * Returns 1 on success
  *         0 on eof, when no data was read (errp is not set)
- *         -EINVAL on eof, when some data < @size was read until eof
- *         < 0 on read fail
+ *         negative errno on failure (errp is set)
  */
 static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t siz=
e,
                                Error **errp)
@@ -95,7 +94,7 @@ static inline int nbd_read_eof(QIOChannel *ioc, void
*buffer, size_t size,
      * that this is coroutine-safe.
      */

-    assert(size > 0);
+    assert(size);

     ret =3D nbd_rwv(ioc, &iov, 1, size, true, errp);
     if (ret <=3D 0) {


>>> +
>>> +    if (ret !=3D size) {
>>> +        error_setg(errp, "End of file");
>>> +        return -EINVAL;
>> and so is this. Which makes the function documentation not quite
>> accurate; you aren't mixing a generic < 0.
>=20
> hmm.. my wordings are weird sometimes, sorry for that :(. and thank you=

> for your patience.

Not a problem - I understand that English is not your native language,
so you are already a leg up on me (I'm nowhere near as competent in a
second language as you already are on English, even if review still
gives you grammar hints and other improvements).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KnMMSkcqD87V2KxIEDMsnPalWCtIMHHVH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgeN4ACgkQp6FrSiUn
Q2oBNggAr6fR0MLe1aSfqCACbhkPrZP7nOk35Ffw/qIjw787XIIIe6beDgZxb5n4
TaybS3/3oxPdNrvjIuqrO+xvzXGQ9p6gsjY7LpvvYgcJJGz9x+kmHD+dXBfc/4bM
8z2qvkqYP3Up4yrIedHbH03QENpgSbK5hFuSHdFrfeNJUchlAh91YfT3QiRxRVml
DUerqGR8devc/pptw/PYqG40lrySXP/RhiRS1eJoNNLXtdELeDV/Sbn0YPzb80Ns
o2lTCH+Yd7nJiBBsbkWC6CmtHqnNaLIo6RyFwx4HorluvN4NlI6w7Ton7Zlf+aVI
I+vwEIbx0MGcp93L5EaglJ6ubKU4sg==
=GDZs
-----END PGP SIGNATURE-----

--KnMMSkcqD87V2KxIEDMsnPalWCtIMHHVH--
