Received: from eggs.gnu.org ([2001:4830:134:3::10]:49473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv20e-0005BG-Hm
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv20W-0002uW-Tm
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:03:50 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
	<c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
	<w51r2ih2w5m.fsf@maestria.local.igalia.com>
	<c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
	<w51in3t2pd7.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <737260aa-010e-16e6-b639-46333ed08da6@redhat.com>
Date: Wed, 29 Aug 2018 17:03:26 +0200
MIME-Version: 1.0
In-Reply-To: <w51in3t2pd7.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KbWI88ojkKQZvtSGVG74iNQqmbiSZTmfr"
Subject: Re: [Qemu-devel] [PATCH 5/9] block: Allow child references on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KbWI88ojkKQZvtSGVG74iNQqmbiSZTmfr
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <737260aa-010e-16e6-b639-46333ed08da6@redhat.com>
Subject: Re: [PATCH 5/9] block: Allow child references on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
 <c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
 <w51r2ih2w5m.fsf@maestria.local.igalia.com>
 <c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
 <w51in3t2pd7.fsf@maestria.local.igalia.com>
In-Reply-To: <w51in3t2pd7.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-29 16:56, Alberto Garcia wrote:
> On Wed 29 Aug 2018 02:59:01 PM CEST, Max Reitz wrote:
>>>> Specifically, that means when you don't specify @backing, the defaul=
t
>>>> chain will be opened and may replace the current one.
>>>
>>> At the moment "backing" is the only child option that can be omitted,=

>>> all others must be specified. So if you leave "backing" out on reopen=
()
>>> we have the following possibilities:
>>>
>>>   a) We open the default backing file from disk. I don't think we wan=
t
>>>      to open a new image on reopen(). Plus, what happens if the curre=
nt
>>>      backing image is the default one? Do we need to detect that? And=

>>>      what if it's the default image but has non-default options? The
>>>      whole thing looks like a can of worms.
>>
>> True.
>>
>>>   b) We leave the current backing file untouched.
>>
>> Hm.  That doesn't make sense for blockdev-add, so you could argue that=

>> this behavior works as a default for reopen (because it cannot be
>> "confused" with the blockdev-add default).
>>
>>>   c) We forbid it, and the user has to pass an explicit child, or NUL=
L.
>>
>> That sounds good.
>>
>>> I chose (b) in this series. I suppose (c) could also be an option. Bu=
t
>>> (a) doesn't looke like a good idea.
>>
>> I agree with the last sentiment, but I'd prefer making it an error
>> instead of choosing (b).  Yes, you could argue that choosing (b) as a
>> default makes sense in a way, but in another, it just doesn't make
>> sense.  (Because while (b) makes no sense for blockdev-add, (a) would
>> make sense for both blockdev-add and reopen.  Sure, it's horrible to
>> support, but from a user's POV, it makes sense.  So it's just
>> confusing not to make that the default for reopen as well).
>>
>> But the most important point is that it's trivial for the user to keep=

>> the current backing file.  They just need to give the current
>> backing's node-name.
>=20
> Or NULL if there's no backing file, right?

Ah, right, that case...  Yes.  Or we could make an exception (if
@backing wasn't specified, and there is no default backing file, then we
can suppress the error and handle it like backing=3Dnull).

Right now, I'm not sure whether making an exception is a great idea, but
it's stupid always having to pass backing=3Dnull for all qcow2 nodes that=

do not have a backing file...

> The problem I see with this is that it would make the options quite
> verbose. "backing" is an attribute of all BDSs, also protocol ones. I
> suppose we can make "backing" optional in those, or is there any case
> where it makes sense?

Right.  Making it optional when there is no default backing file maybe
is less bad than always requiring it.

Max


--KbWI88ojkKQZvtSGVG74iNQqmbiSZTmfr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGtb4ACgkQ9AfbAGHV
z0Acfgf9HacrD0n8dx+gtmjRbr3rz/DudvB0a+EhSkmzkaygXi8caQLStU6eRbWm
yl/QycELQHnZsD2TyGkmAuZEKD0rh4/vfBtaUuGdPlwRIjntsw8KsvVaBzNhSfr4
/ArfHfcKRZgxbCqzn1rISV4RrHkkIH5vqMWGeDFoJQT47XiD/GbMlbvbdEw+mcGn
yTznXlsKNMVAhbj247JuaFE5c3YPdSeKPMJJTIvFaqfkleebYSs3T4Rz96eKSX4d
cZreaom1kTc+Fk7dtVkVORuxy8gmKzSGh0ewR/YxH3EJNIJodkxyZmiP2Rcviunk
IFcvD16zl4jVqofRyLhnbMRXwaV+/A==
=Heu1
-----END PGP SIGNATURE-----

--KbWI88ojkKQZvtSGVG74iNQqmbiSZTmfr--
