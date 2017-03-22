Received: from eggs.gnu.org ([2001:4830:134:3::10]:38090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqg4e-0008La-2L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqg4a-00033d-R9
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:13:12 -0400
References: <20170322023820.10772-1-eblake@redhat.com>
	<20170322023820.10772-4-eblake@redhat.com>
	<87a88derjc.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fa4a97ed-cbcd-fd8a-ec3e-7ae9df1d9f66@redhat.com>
Date: Wed, 22 Mar 2017 08:13:05 -0500
MIME-Version: 1.0
In-Reply-To: <87a88derjc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Il64NOvRIafcehvbWkqOWlD18jNUqWGGa"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qapi: Fix QemuOpts visitor
 regression on unvisited input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Il64NOvRIafcehvbWkqOWlD18jNUqWGGa
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable@nongnu.org
Message-ID: <fa4a97ed-cbcd-fd8a-ec3e-7ae9df1d9f66@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qapi: Fix QemuOpts visitor regression
 on unvisited input
References: <20170322023820.10772-1-eblake@redhat.com>
 <20170322023820.10772-4-eblake@redhat.com>
 <87a88derjc.fsf@dusky.pond.sub.org>
In-Reply-To: <87a88derjc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 01:47 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> An off-by-one in commit 15c2f669e meant that we were failing to
>> check for unparsed input in all QemuOpts visitors.  Recent testsuite
>> additions show that fixing the obvious bug with bogus fields will
>> also fix the case of an incomplete list visit; update the tests to
>> match the new behavior.
>>

>> @@ -276,8 +276,8 @@ static void
>>  opts_check_list(Visitor *v, Error **errp)
>>  {
>>      /*
>> -     * FIXME should set error when unvisited elements remain.  Mostly=

>> -     * harmless, as the generated visits always visit all elements.
>> +     * Unvisited list elements will be reported later when checking i=
f
>> +     * unvisited struct members remain.
>=20
> Non-native speaker question: if or whether?
>=20

Both work to my ear, but whether sounds a bit more formal. I can switch,
since...


>> -    visit_check_list(v, &error_abort); /* BUG: unvisited tail not rep=
orted */
>> +    visit_check_list(v, &error_abort); /* unvisited tail ignored unti=
l... */
>>      visit_end_list(v, (void **)&list);
>>
>> -    visit_check_struct(v, &error_abort);
>> +    visit_check_struct(v, &err); /* ...here */
>> +    error_free_or_abort(&err);
>>      visit_end_struct(v, NULL);
>>
>>      qapi_free_intList(list);
>=20
> How come unvisited tails are diagnosed late?

Because opts_check_list() is still a no-op, and I didn't want to muck
with how to make it work to catch things earlier.  The late catch is by
virtue of the fact that we track complete coverage by whether the clone
of the QemuOpts still has the key, and the key is not removed until the
list is fully parsed.

>=20
>> @@ -239,7 +241,7 @@ test_opts_range_beyond(void)
>>      error_free_or_abort(&err);
>>      visit_end_list(v, (void **)&list);
>>
>> -    visit_check_struct(v, &error_abort);
>> +    visit_check_struct(v, &err);
>=20
> This looks wrong.  Either you expect an error or not.  If you do,
> error_free_or_abort() seems missing.  If you don't, the hunk needs to b=
e
> dropped.
>=20

=2E..you are correct that this is a spurious hunk, and removing it does
not change the testsuite. v3 coming up.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Il64NOvRIafcehvbWkqOWlD18jNUqWGGa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0nhhAAoJEKeha0olJ0Nq3roH/i/zkwZeW25xlh4Udf88Pvn1
G+sUiZLMeD9nD0MKEaQdtXxKP8Y33PquKM6Y3kHg86NxkzmqB34xT/qLectGGHnl
0Pt0W4IbEzKKhU2IIQTitRWHj/jyemA4zAuD83GIF+im0eJECKNq1uKUe4lKsPbc
uPjYMPCIYhHzVxkuQuOfUInM9+b3hkXE+91NoKf5DKM4h+w262385yffykwg38z+
h6qRm/WYg5jeyiyaqZxtXxI7J9ms/Cch0Rxs4Ae9BR1BQUD3y5MsgOYe1GAX2GBe
GliHKkZIb15iOJkGb6YCUnQuYb7RIbQCYYxgcVxpdLu8Ed7dI1MHdRD8jYG42GU=
=pa8B
-----END PGP SIGNATURE-----

--Il64NOvRIafcehvbWkqOWlD18jNUqWGGa--
