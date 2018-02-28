Received: from eggs.gnu.org ([2001:4830:134:3::10]:54205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er2Cj-0008Kv-8r
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er2Ci-0004Rs-8y
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:55:33 -0500
References: <20180228131315.30194-1-mreitz@redhat.com>
	<20180228131315.30194-2-mreitz@redhat.com>
	<20180228133434.GL17774@redhat.com>
	<1fc55643-7ca6-26a5-7e2e-7d6b09a43a13@redhat.com>
	<20180228135305.GM17774@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <86d7e709-6981-822d-9849-7af38e7453ce@redhat.com>
Date: Wed, 28 Feb 2018 14:55:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180228135305.GM17774@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Z8Cy0IBQAIiwSXsr1Fl3yZ43wWG9s1fj"
Subject: Re: [Qemu-devel] [PATCH 1/2] block/file-posix: Fix fully
 preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, "eblake@redhat.com Kevin Wolf" <kwolf@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Z8Cy0IBQAIiwSXsr1Fl3yZ43wWG9s1fj
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "eblake@redhat.com Kevin Wolf" <kwolf@redhat.com>, qemu-stable@nongnu.org
Message-ID: <86d7e709-6981-822d-9849-7af38e7453ce@redhat.com>
Subject: Re: [PATCH 1/2] block/file-posix: Fix fully preallocated truncate
References: <20180228131315.30194-1-mreitz@redhat.com>
 <20180228131315.30194-2-mreitz@redhat.com>
 <20180228133434.GL17774@redhat.com>
 <1fc55643-7ca6-26a5-7e2e-7d6b09a43a13@redhat.com>
 <20180228135305.GM17774@redhat.com>
In-Reply-To: <20180228135305.GM17774@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-28 14:53, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 28, 2018 at 02:45:49PM +0100, Max Reitz wrote:
>> On 2018-02-28 14:34, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Feb 28, 2018 at 02:13:14PM +0100, Max Reitz wrote:
>>>> Storing the lseek() result in an int results in it overflowing when =
the
>>>> file is at least 2 GB big.  Then, we have a 50 % chance of the resul=
t
>>>> being "negative" and thus thinking an error occurred when actually
>>>> everything went just fine.
>>>>
>>>> So we should use the correct type for storing the result: off_t.
>>>>
>>>> Reported-by: Daniel P. Berrange <berrange@redhat.com>
>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1549231
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block/file-posix.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>> index f1591c3849..90c25864a0 100644
>>>> --- a/block/file-posix.c
>>>> +++ b/block/file-posix.c
>>>> @@ -1697,6 +1697,7 @@ static int raw_regular_truncate(int fd, int64_=
t offset, PreallocMode prealloc,
>>>>      case PREALLOC_MODE_FULL:
>>>>      {
>>>>          int64_t num =3D 0, left =3D offset - current_length;
>>>> +        off_t seek_result;
>>>> =20
>>>>          /*
>>>>           * Knowing the final size from the beginning could allow th=
e file
>>>> @@ -1711,8 +1712,8 @@ static int raw_regular_truncate(int fd, int64_=
t offset, PreallocMode prealloc,
>>>> =20
>>>>          buf =3D g_malloc0(65536);
>>>> =20
>>>> -        result =3D lseek(fd, current_length, SEEK_SET);
>>>> -        if (result < 0) {
>>>> +        seek_result =3D lseek(fd, current_length, SEEK_SET);
>>>> +        if (seek_result < 0) {
>>>
>>> off_t is an unsigned type, so this comparison to "< 0" is bogus - onl=
y the
>>> exact value (off_t)-1 indicates an error. So this needs to be
>>>
>>>    if (seek_result =3D=3D (off_t)-1) {
>>>       ...
>>>    }
>>
>> Hmmm... On my system, it appears to be a long int[1].  And
>> find_allocation() does an off_t < 0 comparison already.  And
>> "man 0p sys_types.h" says "blkcnt_t and off_t shall be signed integer
>> types."
>=20
> Hmm, that's odd then - lseek man page explicitly said it must be cast,
> which suggested to me it could be unsigned:
>=20
>    RETURN VALUE
>        Upon successful completion, lseek() returns the resulting offset=
  loca=E2=80=90
>        tion  as  measured  in bytes from the beginning of the file.  On=
 error,
>        the value (off_t) -1 is returned and  errno  is  set  to  indica=
te  the
>        error.
>=20
> CC'ing Eric for the "official" POSIX answer....

But it also says (under NOTES):

The off_t data type is a signed integer data type specified by POSIX.1.

Max


--6Z8Cy0IBQAIiwSXsr1Fl3yZ43wWG9s1fj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqWtMoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhmQH/jePXypviRVuF1mKw9hdcgZaK5YquGai
uZrgB6oymBjfWA75Hp85r+28o/+DbN1d17OaIL5OJ2zjfxAZ6x9i03Ky55V+evQp
FhxXaD+lrvS2sfQJGf9T8RkCtdIPuberuifJ518yunUKL5VRhpLEihySKtHUD0rY
W8+kwS4yCMn2aE29Fcatzie5xNdm41AmOHa8mZ5VQb5jETCU0fT4E/xrcW8a4XCc
a2OWdu4Ccl8YlEqcpM+FujYHReWCQDU4OvP5nE5/B7LTKk8i8FSJDTliIngaDLoH
fmXPf7ihG4XZWwOlJvb5awbWR/UXgyadcQheA5m/lcJu2lyuCyEPkRU=
=B5Ja
-----END PGP SIGNATURE-----

--6Z8Cy0IBQAIiwSXsr1Fl3yZ43wWG9s1fj--
