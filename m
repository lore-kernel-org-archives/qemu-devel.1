Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtS9-0001gx-6w
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtS8-0002nn-7x
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:29:33 -0500
References: <20171109013804.14488-1-mreitz@redhat.com>
	<20171109013804.14488-5-mreitz@redhat.com>
	<02eb8b5d-7b5a-271c-0a54-aa177dc65ce8@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a98337c3-cc5a-0ae9-83fd-a33e99f8f090@redhat.com>
Date: Thu, 9 Nov 2017 21:29:20 +0100
MIME-Version: 1.0
In-Reply-To: <02eb8b5d-7b5a-271c-0a54-aa177dc65ce8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="evPMKLgA0Ucg7IoUBpq3RjuE97RAX6uqm"
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests: Make 083 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--evPMKLgA0Ucg7IoUBpq3RjuE97RAX6uqm
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <a98337c3-cc5a-0ae9-83fd-a33e99f8f090@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests: Make 083 less flaky
References: <20171109013804.14488-1-mreitz@redhat.com>
 <20171109013804.14488-5-mreitz@redhat.com>
 <02eb8b5d-7b5a-271c-0a54-aa177dc65ce8@redhat.com>
In-Reply-To: <02eb8b5d-7b5a-271c-0a54-aa177dc65ce8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 15:11, Eric Blake wrote:
> On 11/08/2017 07:38 PM, Max Reitz wrote:
>> 083 has (at least) two issues:
>=20
> I think I hit one of them intermittently yesterday; thanks for
> diagnosing these (and like you say, there may be more lurking, but we'l=
l
> whack them separately if we can reproduce and identify them).
>=20
>>
>> 1. By launching the nbd-fault-injector in background, it may not be
>>    scheduled until the first grep on its output file is executed.
>>    However, until then, that file may not have been created yet -- so =
it
>>    either does not exist yet (thus making the grep emit an error), or =
it
>>    does exist but contains stale data (thus making the rest of the tes=
t
>>    case work connect to a wrong address).
>>    Fix this by explicitly overwriting the output file before executing=

>>    nbd-fault-injector.
>>
>> 2. The nbd-fault-injector prints things other than "Listening on...".
>>    It also prints a "Closing connection" message from time to time.  W=
e
>>    currently invoke sed on the whole file in the hope of it only
>>    containing the "Listening on..." line yet.  That hope is sometimes
>>    shattered by the brutal reality of race conditions, so invoke grep
>>    before sed.
>=20
> Invoking 'grep | sed' is almost always a waste of a process; sed can do=

> the job alone.
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/083 | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
>> index 0306f112da..2f6444eeb9 100755
>> --- a/tests/qemu-iotests/083
>> +++ b/tests/qemu-iotests/083
>> @@ -86,6 +86,7 @@ EOF
>> =20
>>  	rm -f "$TEST_DIR/nbd.sock"
>> =20
>> +        echo > "$TEST_DIR/nbd-fault-injector.out"
>=20
> This makes the file contain a blank line.  Would it be any better as a
> truly empty file, as in:
>=20
> : > "$TEST_DIR/nbd-fault-injector.out"

Although ":>" looks funny, I guess I'd rather stay with the echo...
Yes, it may look stupid to you, but I would have to look up what exactly
that will do, whereas the echo is clear.

And in the end, both work equally fine.

>>  	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd=
-fault-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
>> =20
>>  	# Wait for server to be ready
>> @@ -94,7 +95,7 @@ EOF
>>  	done
>> =20
>>  	# Extract the final address (port number has now been assigned in tc=
p case)
>> -	nbd_addr=3D$(sed 's/Listening on \(.*\)$/\1/' "$TEST_DIR/nbd-fault-i=
njector.out")
>> +        nbd_addr=3D$(grep 'Listening on ' "$TEST_DIR/nbd-fault-inject=
or.out" | sed 's/Listening on \(.*\)$/\1/')
>=20
> Fixing TAB damage while at it - nice.
>=20
> Here's how to do it using just sed, and with less typing:
>=20
>     nbd_addr=3D$(sed -n 's/^Listening on //p' \
>                "$TEST_DIR/nbd-fault-injector.out")

Oh, nice!  Will do, thanks.

Max


--evPMKLgA0Ucg7IoUBpq3RjuE97RAX6uqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloEuqASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApfoH/A3KNE9Iq4qwu1h920FbbblQB4Cy3E4t
WU1ctcigFh4jOqyJVOXaGr4zkfittf9iiAxqDsAn0vwSyJZmH8mAZmW1osez5KEu
fpBsvaxG+7n5gcuJ0e5RaYDOkl7Zi3NKHgO2cTnVZGbC8cJJbI/XjYo5dHPATqn2
Y6MwMijIAaKe1U0865C5s/7WYJUFDQdcupEXzBo7JnMYTB6eZKjsmmmO0ibnLNB1
6wrPgvc/6Vqo6o4WQQ/LhqkGmBfmW4M3XS86Tq/XIxJ4fksDAcFefRSKjX1pWEj1
rsqqjb2pt2F7ARDvutpvd8VitJUHThHF09I011/S0K+nkwyJrlHcv8s=
=ZS6L
-----END PGP SIGNATURE-----

--evPMKLgA0Ucg7IoUBpq3RjuE97RAX6uqm--
