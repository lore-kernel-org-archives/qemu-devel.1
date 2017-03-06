Received: from eggs.gnu.org ([2001:4830:134:3::10]:51220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzdv-0007hn-UJ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzdu-0003ir-SO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:54:08 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195434.16782-1-mreitz@redhat.com>
	<ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
	<c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
	<0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
	<d0b3a805-8a05-bfea-2567-1f2cdc7c25e2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2efea3b9-8372-8f43-a357-5f79f430724d@redhat.com>
Date: Mon, 6 Mar 2017 14:53:57 -0600
MIME-Version: 1.0
In-Reply-To: <d0b3a805-8a05-bfea-2567-1f2cdc7c25e2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DbwXtjPSN4wWSbta9M5qImUwOSGKegSAD"
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
--DbwXtjPSN4wWSbta9M5qImUwOSGKegSAD
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2efea3b9-8372-8f43-a357-5f79f430724d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some bdrv_truncate()
 error messages
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195434.16782-1-mreitz@redhat.com>
 <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
 <c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
 <0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
 <d0b3a805-8a05-bfea-2567-1f2cdc7c25e2@redhat.com>
In-Reply-To: <d0b3a805-8a05-bfea-2567-1f2cdc7c25e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 02:48 PM, Max Reitz wrote:
> On 06.03.2017 21:21, Eric Blake wrote:
>> On 03/06/2017 02:14 PM, Max Reitz wrote:
>>
>>>>>      if (S_ISREG(st.st_mode)) {
>>>>>          if (ftruncate(s->fd, offset) < 0) {
>>>>> +            /* The generic error message will be fine */
>>>>>              return -errno;
>>>>
>>>> Relying on a generic error message in the caller is awkward. I see i=
t as
>>>> evidence of a partial conversion if we have an interface that requir=
es a
>>>> return of a negative errno value to make up for when errp is not set=
=2E
>>>
>>> I'm not sure what you mean by this exactly.
>>
>> The ideal conversion would be having .bdrv_truncate switch to a void
>> return; then no caller is messing with negative errno values (especial=
ly
>> since some of them are just synthesizing errno values, rather than
>> actually encountering one, and since some of them are probably using -=
1
>> when they should be using errno). But such a conversion requires that
>> all drivers be updated to properly set errp.
>=20
> Not sure if that is an ideal conversion. I very much prefer negative
> return value + error object because that allows constructs like
>=20
> if (foo(..., errp) < 0) {
>     return;
> }

Fair point - Markus has argued that we should convert functions from
void to easy-to-spot return sentinels for easier logic (less boilerplate
in creating a local error, checking it, and propagating it).

But the point remains that returning -1 is simpler to code than
returning negative errno, when some of the existing drivers are already
synthesizing errno.  And (temporarily) forcing a void return would make
it easy to spot who still needs conversion, even if we then go back to
returning int (but this time, with the simpler -1 for error, rather than
negative errno).

> For me, the most important thing is that errp will always be set if the=

> function fails.

Yes, that's what you are guaranteed with a void return, and what we
would also have with a (sane) integer return.

>=20
> (Of course, I'd be just fine with a boolean return value, too.)

boolean works too, except it's a little harder to remember when 'true'
means success, compared to other code where '0' is success and negative
is failure.

>> In other words, I view the generic bdrv_truncate() supplying an error
>> based on negative errno is a crutch, and not something that we should
>> rely on, at least not for the drivers that we fix to set errp directly=
=2E
>=20
> Well, the more detailed the error messages are the better, but I don't
> see any real improvement over a generic message supplied by
> bdrv_truncate() if that is good enough.

Maybe Markus has some opinions, since error reporting is his area.

>=20
> Of course, I can easily be convinced that the generic message is in fac=
t
> not good enough.

Maybe it's hard to argue that from the quality-of-message standpoint,
but that's exactly what I'm arguing from the ease-of-maintenance
standpoint.  Relying on the generic message is harder to maintain.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DbwXtjPSN4wWSbta9M5qImUwOSGKegSAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcxlAAoJEKeha0olJ0Nql3UH+wbP3Oh74B5uIPeu+hV43y7X
rJMmvxiBme0M3U1UIf3pFqFHhKOIggtpJXJuxQ5Sl3tlGD99DkZqCz3v/Mopx3K6
7jGKv0o5anMePsTJmuNRtJAKd/4K/k4Npj1RYIpFwRGoH8IB7PHUTpAHYSM6luQx
b2o40zdwGNK1n+1AwmmAeYslpgvkhismzsAeA3xE+Aot8nIKk0chALwoL3uxzK9s
n2kELw9rda/dSYZnSfTgZQi1yA89XSIHM4QU+v8hZ1dr6QDGVwPOAoqiM3dLB8SV
Eo8HbKsTXyU4bbe/kO27Fs/lz+G6NdVccVOJDxgpoUE3MJ0r5dWhEh2rtiz2SFg=
=DBfu
-----END PGP SIGNATURE-----

--DbwXtjPSN4wWSbta9M5qImUwOSGKegSAD--
