Received: from eggs.gnu.org ([209.51.188.92]:36859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEazd-000074-U9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEazY-0005LC-7i
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:47:55 -0400
References: <20190410204215.5963-1-eblake@redhat.com>
	<61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <111374f2-ad0c-3f81-9c51-33201c63b6c5@redhat.com>
Date: Thu, 11 Apr 2019 09:47:34 -0500
MIME-Version: 1.0
In-Reply-To: <61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP"
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotest: Fix 241 to run in generic
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <111374f2-ad0c-3f81-9c51-33201c63b6c5@redhat.com>
Subject: Re: [PATCH for-4.0?] iotest: Fix 241 to run in generic directory
References: <20190410204215.5963-1-eblake@redhat.com>
 <61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
In-Reply-To: <61e3b78b-4daf-eebc-7e8b-860c57658933@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/11/19 2:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.04.2019 23:42, Eric Blake wrote:
>> Filter the qemu-nbd server output to get rid of a direct reference
>> to my build directory.
>>
>> Fixes: e9dce9cb
>> Reported-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> Not worth -rc4 on its own, but if something else pops up that requires=

>> another spin, I plan on a pull request for this one. Otherwise it
>> slips to 4.1, and 4.0 just has a broken iotest.
>>

>> @@ -69,12 +70,13 @@ echo
>>
>>   # Intentionally omit '-f' to force image probing, which in turn forc=
es
>>   # sector alignment, here at the server.
>> -nbd_server_start_unix_socket "$TEST_IMG_FILE"
>> +nbd_server_start_unix_socket "$TEST_IMG_FILE" 2> "$TEST_DIR/server.lo=
g"
>>

>>   1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
>> +WARNING: Image format was not specified for 'TEST_DIR/t.raw' and prob=
ing guessed raw.
>> +         Automatically detecting the format is dangerous for raw imag=
es, write operations on block 0 will be restricted.
>> +         Specify the 'raw' format explicitly to remove the restrictio=
ns.
>=20
> May be, just add -f raw to nbd server, to make this message disappear? =
And than, don't do any redirections, as if there
> will be failed unfiltered output it is OK?

No. See the comment in the test - it is intentional that we are omitting
-f, in two different places, in order to get three test scenarios:

normal: server '-f raw' 1-byte align, client '-f raw' 1-byte align
server-constrained: server omit for 512-byte align, client '-f raw'
obeys server align
client-constrained: server '-f raw' 1-byte align, client omit for
intentional 512-byte align

in order to show both that the server with forced alignment is able to
round requests correctly before sending to the client, and to show that
the client with forced alignment is able to round requests correctly in
spite of the server sending answers narrower than the client wants.

In 4.1, when Max's filter handling patches land, it will be possible to
use the blkdebug driver to force alignment instead of omitting '-f raw';
at which point we can take away the server.log file. But until the
filter handling patches land, any use of blkdebug causes odd test
misbehaviors because not everything in the block layer properly sees
through filter nodes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyvU4YACgkQp6FrSiUn
Q2ojxAgAhL8AHmx3Vd2BDEoBPUVbsmLMcNsVzqqGEeGrV2wZR7YpT8a5Zc4ixn2p
b+a19WQfkrPKj1NNGaTsAsggVyiZWwxBP1IzKIcXOt9hLb/+uPljxj3jF6y3mOcC
SrBmlKxDj2JydeF/nPW9cA77pEIwbtYIyhZ2h2vuRT8zKPY0/zZDchqRhgl7qE5r
gBYfAuygfw4xfoYPa4nB4U34GrMSgDizlrAy4ghSrEsvSR/R4UGNwftqcToQ2y6L
y66+O4+2oYgE2wBf/lTn9IkOzvCbMRdp0p+HSoXtiUPNNWG7PNzZY/xrwEuWDIBJ
XV6H7imiuJBcvMv7rNQdfEj5DJsBfg==
=KGq9
-----END PGP SIGNATURE-----

--lCg0bCzthqmVZ5ux4fdjoWjBu4UfuniYP--
