Received: from eggs.gnu.org ([2001:4830:134:3::10]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufM4-0003yP-Qn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufM3-0002BI-Jp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:47:56 -0400
References: <20170914144032.14945-1-eblake@redhat.com>
	<20170914144032.14945-4-eblake@redhat.com>
	<20170920095711.GA4058@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c239541-da93-33d0-1c0e-88e29de89e2c@redhat.com>
Date: Wed, 20 Sep 2017 08:47:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170920095711.GA4058@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vSTdDWMLQ4VUTJHdIiRpk9IcPmKB0vMAl"
Subject: Re: [Qemu-devel] [PATCH v3 03/20] file-posix: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vSTdDWMLQ4VUTJHdIiRpk9IcPmKB0vMAl
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <0c239541-da93-33d0-1c0e-88e29de89e2c@redhat.com>
Subject: Re: [PATCH v3 03/20] file-posix: Switch to .bdrv_co_block_status()
References: <20170914144032.14945-1-eblake@redhat.com>
 <20170914144032.14945-4-eblake@redhat.com> <20170920095711.GA4058@lemon.lan>
In-Reply-To: <20170920095711.GA4058@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 04:57 AM, Fam Zheng wrote:
> On Thu, 09/14 09:40, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Update the file protocol driver accordingly.  In mapping
>> mode, note that the entire file is reported as allocated, so we can
>> take a shortcut and skip lseek().
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>>
>> -    ret =3D find_allocation(bs, start, &data, &hole);
>> +    if (!mapping) {
>> +        *pnum =3D bytes;
>> +        *file =3D bs;
>> +        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID |
>> +            (offset & BDRV_BLOCK_OFFSET_MASK);
>> +    }
>=20
> I may be missing something, because the last time I tried to understand=
 the
> rationale behind "mapping" was already some time ago: shouldn't we stil=
l
> distinguish hole and data? What will omitting BDRV_BLOCK_ZERO help?

Hmm, the commit message is slightly off (in part, because I switched the
sense of the bool flag between series revisions, but did not properly
update the commit text to match).  In mapping mode, we want to return as
much information as possible (the client is something like 'qemu-img
map'), including where the holes lie.  But when we are NOT in mapping
mode, we care more about learning which portions of the file are
described in the current layer of the backing chain, rather than
delegating to another layer, regardless of whether the read will see
data or zeroes.  By the time we are at the POSIX file protocol layer, we
know that every byte in the file system/block device has a 1:1 mapping
to the bytes that the guest will read (we do not delegate to any backing
file), so we can simply report the entire remainder of the file as
allocated without worrying about holes.

Here's where the mapping flag was added and semantics documented (in
series 3; whereas the current email is series 4):
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03542.html

So what I really need to do is fix the commit message to read:

In mapping mode, we must report as much information as possible about
where holes can be found; but when we don't care about mapping, the user
is more interested in how much of the guest view will come from the
current layer rather than delegating to some other BDS, and we can take
the shortcut that all of the remainder of the file fits that
description, and therefore take a shortcut and skip lseek() for a larger
*pnum result.

(the same comment probably applies to several other patches in the series=
)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vSTdDWMLQ4VUTJHdIiRpk9IcPmKB0vMAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCcXwACgkQp6FrSiUn
Q2reOgf8Cos6ZyTWOPvb92Vs+CNcb/t3IZWbIbtdKxLua//xBeRpGGmotFNNspSy
pFkBKATq3pIvsTDtzPnatk1QNaFQGPKJHNwagnWjWKuUAZ1xnnH7+R2dlPeJX/jr
ABRmDbJnUxnlb4BwgvJthdcqgYTuQWLpKoCu1OfcyJeVSeT4/NUGFmOjLqUgwZ7w
qo48V18IJIEPuEFgGI3nkvB2VjySjamfde2gqCkk3VV5Ptw6+OCNtPJx8KQkHffQ
hNRmsMeUUQdKXG+ELeTg3vtApAigqH8GC1VQZPQvkEVanm3aVLBQvLKCtQPwlic2
yEOEBG+/8quZXZYvE8GkyGjFH7RFFg==
=JoiP
-----END PGP SIGNATURE-----

--vSTdDWMLQ4VUTJHdIiRpk9IcPmKB0vMAl--
