Received: from eggs.gnu.org ([2001:4830:134:3::10]:35041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwF2-0004HK-L3
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwF1-0004nZ-Kz
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:53:56 -0400
References: <20170411131327.10734-1-mreitz@redhat.com>
	<CAFEAcA_bvMvXa7MtYY0UGhF6xwqFhTCU2ZEy7phj95fFXTzd8g@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6edf1cdd-86f7-3a09-ee7a-364ee18b697a@redhat.com>
Date: Tue, 11 Apr 2017 15:53:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bvMvXa7MtYY0UGhF6xwqFhTCU2ZEy7phj95fFXTzd8g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7oLJIsKhvv9MNwgbHcgqPwLfqQ4QouR9N"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/nfs: Do not strcmp() with
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7oLJIsKhvv9MNwgbHcgqPwLfqQ4QouR9N
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <6edf1cdd-86f7-3a09-ee7a-364ee18b697a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/nfs: Do not strcmp() with
 NULL
References: <20170411131327.10734-1-mreitz@redhat.com>
 <CAFEAcA_bvMvXa7MtYY0UGhF6xwqFhTCU2ZEy7phj95fFXTzd8g@mail.gmail.com>
In-Reply-To: <CAFEAcA_bvMvXa7MtYY0UGhF6xwqFhTCU2ZEy7phj95fFXTzd8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 15:30, Peter Maydell wrote:
> On 11 April 2017 at 14:13, Max Reitz <mreitz@redhat.com> wrote:
>> Parsing the URI is not required to give us a scheme; uri->scheme may b=
e
>> NULL.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/nfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/nfs.c b/block/nfs.c
>> index 0816678307..0c7d5619fe 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -83,7 +83,7 @@ static int nfs_parse_uri(const char *filename, QDict=
 *options, Error **errp)
>>          error_setg(errp, "Invalid URI specified");
>>          goto out;
>>      }
>> -    if (strcmp(uri->scheme, "nfs") !=3D 0) {
>> +    if (!uri->scheme || strcmp(uri->scheme, "nfs") !=3D 0) {
>>          error_setg(errp, "URI scheme must be 'nfs'");
>>          goto out;
>>      }
>=20
> Just as a record of IRC discussion, a lot of the callers of uri_parse()=

> get this wrong; for instance
>  qemu-img info -f nbd blub#://
>  qemu-img info -f sheepdog blub#://
> both segfault.

Yes, thanks for catching this.

>                So since this isn't new (2.8 behaved the same way) I thi=
nk
> we should not try to fix this at this point in the 2.9 release cycle.

And also because it'll always be a NULL pointer dereference, so it's not
*too* bad.

(If it had been just the single place in block/nfs.c, I think it would
have made sense to still take this into 2.9 (because the fix is trivial
and obviously makes sense), but sprinkling this "all over the place"
(well, 8 lines changed) is a bit different.)

> For 2.10 we might consider whether there's a change we could make to
> the uri_parse() API that makes this mistake less easy. (For instance
> do any of the users really ever want to handle a relative URL without
> a schema?)

Well, gluster (the only caller of uri_parse() which handles NULL scheme
correctly) just defaults to a scheme then. So changing this might mean
to break compatibility.

In my opinion, if someone wants to improve uri_parse(), great, but I'm
neither the maintainer of util/uri.c (not that we really have one...),
nor have I ever touched it before, so I'm not exactly avid to be the one
to do so.

I think the number of callers is manageable (5), they're all in the
block layer, they all do roughly the same with the result, and they all
do the appropriate NULL checks except for URI.scheme. So just
(trivially) fixing those 8 lines seems to be much easier and good enough
from my perspective.

(Rather than giving uri_parse() a new interface which might introduce
again new bugs...)

Max


--7oLJIsKhvv9MNwgbHcgqPwLfqQ4QouR9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs3+0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AThAIALOiuzicseM0dICx26EEfcdy3Cws4ttz
+B4k1vvnIK6iSECTYhl4shIP3sCLmjcndQyrWd/Z0XnlZuqDW2T/M+SsEf4JBtum
mCucA7KA/x6/GlfdgO8cVKcDU4VWAlqITawd984PJQ6+puEPLfhDs6YhY3c4UY4z
QaJRJE6F8jPuy2E0ixTZDGAgHmSv08+3JGVxOQcpL3F5fAIqFCBup6nUx0MLu8De
zw8AjbcgCRvpmjC1eTzVN5VwIiuwZ/6cfibJ4NLnIlvVfQqtbqCP4rPDYWtWdqT7
J2sEJhhpYMZHwCiASKyZpGvjkkAxTcD2zmu4F697IQ2RuUUA9qHwprc=
=8TRL
-----END PGP SIGNATURE-----

--7oLJIsKhvv9MNwgbHcgqPwLfqQ4QouR9N--
