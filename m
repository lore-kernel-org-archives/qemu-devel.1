Received: from eggs.gnu.org ([2001:4830:134:3::10]:35214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKOnZ-0007xM-8L
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKOnV-0001yc-Au
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:22:40 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-7-mreitz@redhat.com>
	<20171130031646.GK16237@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3dcb2e5e-6fc8-67ff-6d89-239dd719506c@redhat.com>
Date: Thu, 30 Nov 2017 14:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <20171130031646.GK16237@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UV4798CCfSQwXqIJPe2sU5AxtSbhc7Gmr"
Subject: Re: [Qemu-devel] [PATCH 06/17] iotests: Drop format-specific in
 _filter_img_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UV4798CCfSQwXqIJPe2sU5AxtSbhc7Gmr
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <3dcb2e5e-6fc8-67ff-6d89-239dd719506c@redhat.com>
Subject: Re: [PATCH 06/17] iotests: Drop format-specific in _filter_img_info
References: <20171123020832.8165-1-mreitz@redhat.com>
 <20171123020832.8165-7-mreitz@redhat.com> <20171130031646.GK16237@lemon>
In-Reply-To: <20171130031646.GK16237@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-30 04:16, Fam Zheng wrote:
> On Thu, 11/23 03:08, Max Reitz wrote:
>> _filter_img_info should remove format-specific information, too.  We
>> already have such a filter in _img_info, and it is very useful for
>> query-block-named-block-nodes (etc.), too.
>>
>> However, in 198 we need that information (but we still want the rest o=
f
>> the filter), so make that filtering optional.  Note that "the rest of
>> the filter" includes filtering of the test directory, so we can drop t=
he
>> _filter_testdir from 198 at the same time.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/198           |  6 ++++--
>>  tests/qemu-iotests/common.filter | 29 ++++++++++++++++++++++++++++-
>>  2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
>> index 34ef666381..a84a058396 100755
>> --- a/tests/qemu-iotests/198
>> +++ b/tests/qemu-iotests/198
>> @@ -91,11 +91,13 @@ $QEMU_IO --object $SECRET0 --object $SECRET1 -c "r=
ead -P 0x9 0 $size" --image-op
>> =20
>>  echo
>>  echo "=3D=3D checking image base =3D=3D"
>> -$QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info | _filter=
_testdir | sed -e "/^disk size:/ D"
>> +$QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-=
specific \
>> +    | sed -e "/^disk size:/ D"
>> =20
>>  echo
>>  echo "=3D=3D checking image layer =3D=3D"
>> -$QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info | _filte=
r_testdir | sed -e "/^disk size:/ D"
>> +$QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format=
-specific \
>> +    | sed -e "/^disk size:/ D"
>> =20
>> =20
>>  # success, all done
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/com=
mon.filter
>> index d9237799e9..0c0e53fae7 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -139,6 +139,15 @@ _filter_img_create()
>> =20
>>  _filter_img_info()
>>  {
>> +    if [[ "$1" =3D=3D "--format-specific" ]]; then
>> +        local format_specific=3D1
>> +        shift
>> +    else
>> +        local format_specific=3D0
>> +    fi
>> +
>> +    discard=3D0
>> +    regex_json_spec_start=3D'^ *"format-specific": \{'
>>      sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$TEST_DIR#TEST_DIR#g" \
>>          -e "s#$IMGFMT#IMGFMT#g" \
>> @@ -159,7 +168,25 @@ _filter_img_info()
>>          -e "/block_state_zero: \\(on\\|off\\)/d" \
>>          -e "/log_size: [0-9]\\+/d" \
>>          -e "s/iters: [0-9]\\+/iters: 1024/" \
>> -        -e "s/uuid: [-a-f0-9]\\+/uuid: 00000000-0000-0000-0000-000000=
000000/"
>> +        -e "s/uuid: [-a-f0-9]\\+/uuid: 00000000-0000-0000-0000-000000=
000000/" | \
>> +    while IFS=3D'' read -r line; do
>> +        if [[ $format_specific =3D=3D 1 ]]; then
>> +            discard=3D0
>> +        elif [[ $line =3D=3D "Format specific information:" ]]; then
>> +            discard=3D1
>> +        elif [[ $line =3D~ $regex_json_spec_start ]]; then
>> +            discard=3D2
>> +            regex_json_spec_end=3D"^${line%%[^ ]*}\\},? *$"
>> +        fi
>> +        if [[ $discard =3D=3D 0 ]]; then
>> +            echo "$line"
>> +        elif [[ $discard =3D=3D 1 && ! $line ]]; then
>=20
> s/\$line/"\$line"/ ?
>=20
>> +            echo
>> +            discard=3D0
>> +        elif [[ $discard =3D=3D 2 && $line =3D~ $regex_json_spec_end =
]]; then
>=20
> Ditto.

It's in double brackets, so it should be fine.

(I just copied it from _img_info in common.rc, and that was reviewed by
Eric, so I assume it's fine. :-))

Max

>> +            discard=3D0
>> +        fi
>> +    done
>>  }
>> =20
>>  # filter out offsets and file names from qemu-img map; good for both
>> --=20
>> 2.13.6
>>



--UV4798CCfSQwXqIJPe2sU5AxtSbhc7Gmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlogBgoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASwAIALfm4rZpMjMjn+hg+InxkxyxTayn517L
TflekYKHfuNZufArFdR5cnT9T4MNLRA5IxZKq/C9Eepj2/ll6rj3lb7pd0d/v0Bc
kp1qysJ2LnSId0eeeuG0C0yhXSRjquRX3R5O9mS2SIDZa1orO72frLl8EDoimwSP
Z/EH2AnNEsztdwSg1xFu+nPxPJ1Q36YsdSEzcwLXYcHeIyxyx7GnKtMR5oWsLeJ/
5esMeTd8p1qqiZ2F8E5ME73K2Y6tmccFC09JYP57nBUl5ECj+dexlcu+vy8LGust
G/r1yrLBUKFaSSnrsTcZtgA2gpMq6shb/pI2gre5Uy5XQgw+gk/WQ/U=
=EkG/
-----END PGP SIGNATURE-----

--UV4798CCfSQwXqIJPe2sU5AxtSbhc7Gmr--
