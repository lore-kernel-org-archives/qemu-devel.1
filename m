Received: from eggs.gnu.org ([2001:4830:134:3::10]:49937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckzYg-0006Ao-PK
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckzYf-0002Af-R1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:48:42 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195434.16782-1-mreitz@redhat.com>
	<ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
	<c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
	<0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d0b3a805-8a05-bfea-2567-1f2cdc7c25e2@redhat.com>
Date: Mon, 6 Mar 2017 21:48:31 +0100
MIME-Version: 1.0
In-Reply-To: <0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0qNme1QHUWl08LmlbL0bokNVDdhQcrpiP"
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0qNme1QHUWl08LmlbL0bokNVDdhQcrpiP
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d0b3a805-8a05-bfea-2567-1f2cdc7c25e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some bdrv_truncate()
 error messages
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195434.16782-1-mreitz@redhat.com>
 <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
 <c694ca93-5c15-40f2-10e5-40fbead92209@redhat.com>
 <0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
In-Reply-To: <0a26ff5c-ab0d-0497-66d0-28098474e531@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 21:21, Eric Blake wrote:
> On 03/06/2017 02:14 PM, Max Reitz wrote:
>=20
>>>>      if (S_ISREG(st.st_mode)) {
>>>>          if (ftruncate(s->fd, offset) < 0) {
>>>> +            /* The generic error message will be fine */
>>>>              return -errno;
>>>
>>> Relying on a generic error message in the caller is awkward. I see it=
 as
>>> evidence of a partial conversion if we have an interface that require=
s a
>>> return of a negative errno value to make up for when errp is not set.=

>>
>> I'm not sure what you mean by this exactly.
>=20
> The ideal conversion would be having .bdrv_truncate switch to a void
> return; then no caller is messing with negative errno values (especiall=
y
> since some of them are just synthesizing errno values, rather than
> actually encountering one, and since some of them are probably using -1=

> when they should be using errno). But such a conversion requires that
> all drivers be updated to properly set errp.

Not sure if that is an ideal conversion. I very much prefer negative
return value + error object because that allows constructs like

if (foo(..., errp) < 0) {
    return;
}

Or:

ret =3D foo(..., errp);
if (ret < 0) {
    return ret;
}

Instead of:

foo(..., &local_err);
if (local_err) {
    error_propagate(errp, local_err);
    return;
}


For me, the most important thing is that errp will always be set if the
function fails.

(Of course, I'd be just fine with a boolean return value, too.)

>> I can agree that it's not
>> nice within a single driver. But I think it's fine to have some driver=
s
>> that generate an Error object and others that do not, as long as the
>> generic interface (bdrv_truncate()) masks this behavior.
>=20
> I agree that as an interim thing, having some drivers that aren't
> converted yet is the best way to make progress. But it's still best if
> every driver is switched on an all-or-none basis, so that we don't
> forget to go back and re-fix drivers that half-heartedly set errp if we=

> eventually reach the point where all other drivers have been fixed.
>=20
> In other words, I view the generic bdrv_truncate() supplying an error
> based on negative errno is a crutch, and not something that we should
> rely on, at least not for the drivers that we fix to set errp directly.=


Well, the more detailed the error messages are the better, but I don't
see any real improvement over a generic message supplied by
bdrv_truncate() if that is good enough.

Of course, I can easily be convinced that the generic message is in fact
not good enough.

>>> know you aren't comfortable converting all drivers, but for the drive=
rs
>>> you do convert, I'd rather guarantee that ALL errors set errp.
>>
>> Can do, I just felt bad that it be would exactly the same as the messa=
ge
>> that would be generated in bdrv_truncate() anyway.
>=20
> There may be some duplication of error messages, but it still seems
> cleaner to consistently set the error within the driver than to rely on=

> the generic crutch.

As I said, I don't necessarily think it's a crutch. :-)

Max


--0qNme1QHUWl08LmlbL0bokNVDdhQcrpiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli9yx8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARrkH/AlK1r2FBS4hjGGQkBsrjCpJzd6xz3uV
kc6RVIozujmwRowBABACE8L2wDjzYB2BJ6aIwWMe//JNbYnV27Jmuc2Lk+FGmMTP
D2UEfPVt6PPE5HPSo9DZ+MlRM14GNcvBz2+xVA9t6+0JHGIiHs/hk9jsSUd29DGK
LrktTg1qKQdIu2KtMl6ON8eOkqaIduwvZlysbapY/ODm6q8/xs2vLhJNGPAD/RO9
hUeT4GNr65PfzeRi18v6EGvjszTnC+2//7bEJs+CrhuxWDMvppjaLLgZ9dENWGrd
J5vefGd3jmihBRNZ/w6qPCmvZsYo3xxuyTLb5bRfC0Q3t0n56TjEH38=
=HZVD
-----END PGP SIGNATURE-----

--0qNme1QHUWl08LmlbL0bokNVDdhQcrpiP--
