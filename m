Received: from eggs.gnu.org ([2001:4830:134:3::10]:53704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsEOi-0003xM-K5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsEOh-0002tJ-Jb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:36:36 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-22-eblake@redhat.com>
	<bffcf3f2-86a5-388e-0ad3-a1fbcec51c7a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3643e882-0a39-99f2-24ac-8e9ac502e9f7@redhat.com>
Date: Wed, 13 Sep 2017 15:36:21 -0500
MIME-Version: 1.0
In-Reply-To: <bffcf3f2-86a5-388e-0ad3-a1fbcec51c7a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mt0jCBh61VPiwvKolUSsTB6aiPTOttGp1"
Subject: Re: [Qemu-devel] [PATCH v4 21/23] block: Align block status requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mt0jCBh61VPiwvKolUSsTB6aiPTOttGp1
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 jsnow@redhat.com
Message-ID: <3643e882-0a39-99f2-24ac-8e9ac502e9f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 21/23] block: Align block status requests
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-22-eblake@redhat.com>
 <bffcf3f2-86a5-388e-0ad3-a1fbcec51c7a@redhat.com>
In-Reply-To: <bffcf3f2-86a5-388e-0ad3-a1fbcec51c7a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 02:26 PM, Eric Blake wrote:
> On 09/13/2017 11:03 AM, Eric Blake wrote:
>> Any device that has request_alignment greater than 512 should be
>> unable to report status at a finer granularity; it may also be
>> simpler for such devices to be guaranteed that the block layer
>> has rounded things out to the granularity boundary (the way the
>> block layer already rounds all other I/O out).  Besides, getting
>> the code correct for super-sector alignment also benefits us
>> for the fact that our public interface now has byte granularity,
>> even though none of our drivers have byte-level callbacks.
>>
>> Add an assertion in blkdebug that proves that the block layer
>> never requests status of unaligned sections, similar to what it
>> does on other requests (while still keeping the generic helper
>> in place for when future patches add a throttle driver).  Note
>> that iotest 177 already covers this (it would fail if you use
>> just the blkdebug.c hunk without the io.c changes).  Meanwhile,
>> we can drop assertions in callers that no longer have to pass
>> in sector-aligned addresses.
>=20
> Bummer - 'git bisect' says this patch causes iotests 190 to hang.  I'm
> investigating root cause, but I'll have to post a fixup once I figure i=
t
> out.

Found it:

> +    /* Round out to request_alignment boundaries */
> +    align =3D MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
> +    aligned_offset =3D QEMU_ALIGN_DOWN(offset, align);
> +    aligned_bytes =3D ROUND_UP(offset + bytes, align) - aligned_offset=
;

ROUND_UP(64-bit, 32-bit) has a subtle bug: it truncates the operation at
32 bits, instead of producing a 64-bit result.  Using QEMU_ROUND_UP
instead does NOT have the bug.

That's a ticking time bomb, so I'll patch ROUND_UP() directly as a
pre-requisite, then reply to the cover letter with a Based-on tag.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mt0jCBh61VPiwvKolUSsTB6aiPTOttGp1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5lsUACgkQp6FrSiUn
Q2rRbQf+JszQXWVYQ0E2je0tAH9lydfMYv1DoCokO5KU/wfqQmwI623PGUBS9iO/
bzBKK44m6dcOvaq1pgudRV4KZNot70YG9C+QaQRr7X1UWqU/GtwQSQMyQqIfIAte
5swWq9RrTfBCpFJyo1yp5tf+pAQZK95QGxnVW5CQ3n1Yy6/xETkVJZSRi9jjHT+t
9GVJnW+zwpTKR1qUb0LrC8ukP7Z0Gt+mt4/WLlLQPkVOhr+oFbPktjBU8BEDfOJu
du4OblrXzVXMxuARNw7assVkL/HKkY5iqwUQQBLEQ6Yq0oMW0V3q1r4ZkxiBpkPU
T2Yn3oATw2erD6TRZ+BU/FwjEyyHBw==
=jHOu
-----END PGP SIGNATURE-----

--mt0jCBh61VPiwvKolUSsTB6aiPTOttGp1--
