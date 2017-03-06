Received: from eggs.gnu.org ([2001:4830:134:3::10]:41846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckz8C-0006X3-DM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckz8B-0002rf-A5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:21:20 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195434.16782-1-mreitz@redhat.com>
	<ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
	<c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
Date: Mon, 6 Mar 2017 14:21:11 -0600
MIME-Version: 1.0
In-Reply-To: <c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OJLNG5mORN4CwtI0HtmPIJBCh584M2CxA"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some
 bdrv_truncate() error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OJLNG5mORN4CwtI0HtmPIJBCh584M2CxA
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some bdrv_truncate()
 error messages
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195434.16782-1-mreitz@redhat.com>
 <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
 <c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
In-Reply-To: <c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 02:14 PM, Max Reitz wrote:

>>>      if (S_ISREG(st.st_mode)) {
>>>          if (ftruncate(s->fd, offset) < 0) {
>>> +            /* The generic error message will be fine */
>>>              return -errno;
>>
>> Relying on a generic error message in the caller is awkward. I see it =
as
>> evidence of a partial conversion if we have an interface that requires=
 a
>> return of a negative errno value to make up for when errp is not set.
>=20
> I'm not sure what you mean by this exactly.

The ideal conversion would be having .bdrv_truncate switch to a void
return; then no caller is messing with negative errno values (especially
since some of them are just synthesizing errno values, rather than
actually encountering one, and since some of them are probably using -1
when they should be using errno). But such a conversion requires that
all drivers be updated to properly set errp.


> I can agree that it's not
> nice within a single driver. But I think it's fine to have some drivers=

> that generate an Error object and others that do not, as long as the
> generic interface (bdrv_truncate()) masks this behavior.

I agree that as an interim thing, having some drivers that aren't
converted yet is the best way to make progress. But it's still best if
every driver is switched on an all-or-none basis, so that we don't
forget to go back and re-fix drivers that half-heartedly set errp if we
eventually reach the point where all other drivers have been fixed.

In other words, I view the generic bdrv_truncate() supplying an error
based on negative errno is a crutch, and not something that we should
rely on, at least not for the drivers that we fix to set errp directly.

>=20
>>                                                                       =
 I
>> know you aren't comfortable converting all drivers, but for the driver=
s
>> you do convert, I'd rather guarantee that ALL errors set errp.
>=20
> Can do, I just felt bad that it be would exactly the same as the messag=
e
> that would be generated in bdrv_truncate() anyway.

There may be some duplication of error messages, but it still seems
cleaner to consistently set the error within the driver than to rely on
the generic crutch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OJLNG5mORN4CwtI0HtmPIJBCh584M2CxA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcS3AAoJEKeha0olJ0NqaC0H/i9A4t+gZGAsiN/nUn6s1N2z
HBoS+g9e6reNbKq3hYgKJbX/sM5I47/7SKcNhB9RjuOr5XtcAVvnWRy0InMbTZIH
oy0/ZGO7lKaRhfB/GrpP+7WasvcvKPpK55bzhQM2/W4Gufs1PRJYdD8J8cR8lQpG
W91Q6q13pHOS+FXpu1xmCPc9tJ697SNFP27+b7wvTH61UINaYzywVfj8/iu7vbmU
2BcqIc6HdOi19Z1DtocVoC1iuDqfRS6hT+mfbIWHgBqsMapB9u93w9Z/rBlHuU54
9r6QkV90JcpaX0iVcv2lb5TT8mD41UxxGmAUjCkZeEvQdxuqNI7lBX7WNMJVxHc=
=6uoF
-----END PGP SIGNATURE-----

--OJLNG5mORN4CwtI0HtmPIJBCh584M2CxA--
