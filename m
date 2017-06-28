Received: from eggs.gnu.org ([2001:4830:134:3::10]:37540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQJez-0002XU-MI
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQJey-0006z3-03
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:34:01 -0400
References: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
	<1498661881-9605-2-git-send-email-kchamart@redhat.com>
	<w51fuejq36o.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f55056ef-6da8-09d3-a11a-0c97c3fc21ca@redhat.com>
Date: Wed, 28 Jun 2017 15:33:49 -0500
MIME-Version: 1.0
In-Reply-To: <w51fuejq36o.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="759arVputv9JSNrU05XMc91ROc7HOQ0Vt"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 1/2] live-block-ops.txt:
 Rename, rewrite, and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stephen@that.guru, armbru@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--759arVputv9JSNrU05XMc91ROc7HOQ0Vt
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Kashyap Chamarthy
 <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stephen@that.guru, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <f55056ef-6da8-09d3-a11a-0c97c3fc21ca@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 1/2] live-block-ops.txt:
 Rename, rewrite, and improve it
References: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
 <1498661881-9605-2-git-send-email-kchamart@redhat.com>
 <w51fuejq36o.fsf@maestria.local.igalia.com>
In-Reply-To: <w51fuejq36o.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 03:15 PM, Alberto Garcia wrote:
> On Wed 28 Jun 2017 04:58:00 PM CEST, Kashyap Chamarthy wrote:
>> This patch documents (including their QMP invocations) all the four
>> major kinds of live block operations:
>>
>>   - `block-stream`
>>   - `block-commit`
>>   - `drive-mirror` (& `blockdev-mirror`)
>>   - `drive-backup` (& `blockdev-backup`)
>=20
> This is excellent work, thanks for doing this!
>=20
> I haven't had the time to review the complete document yet, but here ar=
e
> my comments from the first half:
>=20
>> +Disk image backing chain notation
>> +---------------------------------
>   [...]
>> +.. important::
>> +    The base disk image can be raw format; however, all the overlay
>> +    files must be of QCOW2 format.
>=20
> This is not quite like that: overlay files must be in a format that
> supports backing files. QCOW2 is the most common one, but there are
> others (qed). Grep for 'supports_backing' in the source code.

At the same time, other image formats are not as frequently tested, or
may be read-only.  Maybe a compromise of "The overlay files can
generally be any format that supports a backing file, although qcow2 is
the preferred format and the one used in this document".

>=20
>> +(1) ``block-stream``: Live copy of data from backing files into overl=
ay
>> +    files (with the optional goal of removing the backing file from t=
he
>> +    chain).
>=20
> optional? The backing file is removed from the chain as soon as the
> operation finishes, although the image file is not removed from the
> disk. Maybe you meant that?

Hmm, you're right. In this case, qemu ALWAYS rewrites the backing chain
to get rid of the (now-streamed) backing image.

>=20
>> +(2) ``block-commit``: Live merge of data from overlay files into back=
ing
>> +    files (with the optional goal of removing the overlay file from t=
he
>> +    chain).  Since QEMU 2.0, this includes "active ``block-commit``"
>> +    (i.e.  merge the current active layer into the base image).
>=20
> Same question about the 'optional' here.

Here, optional is a bit more correct. With non-active (intermediate)
commit, qemu ALWAYS rewrites the backing chain to be shorter; but with
live commit, you can chose whether to pivot to the now-shorter chain
(job-complete) or whether to keep the active image intact (starting to
collect a new delta from the point-in-time of the just-completed commit,
by job-cancel).

>=20
>> +writing to it.  (The rule of thumb is: live QEMU will always be point=
ing
>> +to the right-most image in a disk image chain.)
>=20
> I think it's 'rightmost', without the hyphen.

Sadly, I think this is one case where both spellings work to a native
reader, and where I don't know of a specific style-guide preference.  I
probably would have written with the hyphen.

>=20
>> +(3) Intermediate streaming (available since QEMU 2.8): Starting afres=
h
>> +    with the original example disk image chain, with a total of four
>> +    images, it is possible to copy contents from image [B] into image=

>> +    [C].  Once the copy is finished, image [B] can now be (optionally=
)
>> +    discarded; and the backing file pointer of image [C] will be
>> +    adjusted to point to [A].
>=20
> The 'optional' usage again. [B] will be removed from the chain and can
> be (optionally) removed from the disk, but that you have to do yourself=
,
> QEMU won't do that.

Indeed, we may need to be specifically clear of the cases where qemu
shortens the chain, but where disk images that are no longer used by the
chain (whether they are still viable [as in stream], or invalidated [as
in commit crossing more than one element of the chain]) are still left
on the disk for the user to discard separately from qemu.

>=20
>> +The ``block-commit`` command lets you to live merge data from overlay=

>> +images into backing file(s).
>=20
> I don't think "lets you to live merge data" is correct English.

Probably better as "lets you merge live data from overlay..."

>=20
>> +The disk image chain can be shortened in one of the following ways:
>> +
>> +.. _`block-commit_Case-1`:
>> +
>> +(1) Commit content from only image [B] into image [A].  The resulting=

>> +    chain is the following, where image [C] is adjusted to point at [=
A]
>> +    as its new backing file::
>> +
>> +        [A] <-- [C] <-- [D]
>> +
>> +(2) Commit content from images [B] and [C] into image [A].  The
>> +    resulting chain, where image [D] is adjusted to point to image [A=
]
>> +    as its new backing file::
>> +
>> +        [A] <-- [D]
>=20
> Aren't these two just different variants of the same case?

Almost. But in case 1, image [B] is still viable (from a guest point of
view, the contents of [B] have not changed); in case 2, image [B] is
most likely corrupted (any changes propagated from [C] into [A] that
were not already overridden in [B] now read differently, making image
[B] no longer match anything the guest ever saw at any point in past time=
).

>=20
>> +
>> +.. _`block-commit_Case-3`:
>> +
>> +(3) Commit content from images [B], [C], and the active layer [D] int=
o
>> +    image [A].  The resulting chain (in this case, a consolidated sin=
gle
>> +    image)::
>> +
>> +        [A]
>> +
>> +(4) Commit content from image only image [C] into image [B].  The
>> +    resulting chain::
>> +
>> +	[A] <-- [B] <-- [D]
>> +
>> +(5) Commit content from image [C] and the active layer [D] into image=

>> +    [B].  The resulting chain::
>> +
>> +	[A] <-- [B]
>=20
> Same here.

4 and 5 indeed are variants of 1 and 2.

>=20
> I mean, it's fine to have several different examples, but I think
> there's really two main cases here (as you correctly explain later).
>=20
>> +    (QEMU) block-commit device=3Dnode-D base=3Da.qcow2 top=3Dd.qcow2 =
job-id=3Djob0
>> +    {
>> +        "execute": "block-commit",
>> +        "arguments": {
>> +            "device": "node-D",
>> +            "job-id": "job0",
>> +            "top": "d.qcow2",
>> +            "base": "a.qcow2"
>> +        }
>> +    }
>=20
> This is correct, but I don't know if it's worth mentioning that if you
> omit the 'top' parameter it defaults to the active layer (node-D in thi=
s
> example).

I think it's better to be explicit in the examples (always provide all
parameters, even if what you provide would also be the default when
omitted), and then maybe the prose can mention which parameters have
defaults.

>=20
> Same with 'base'.
>=20
> Else this part looks good! I'll check the rest of the document tomorrow=

> and give you my feedback.
>=20
> Berto
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--759arVputv9JSNrU05XMc91ROc7HOQ0Vt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVBKtAAoJEKeha0olJ0Nq5SsIAKCgSg2gB3Tr3GiN5Myd/cU9
WWufO85v51TiLVJ4aZcDp5Mq5gZGlIormtRqIOPGCZ1u0VDUlwndLDyQ9oXGL+oX
2VjXDNxUNsaqj9e6Fn8liydvBUehMLRPhijQWp2O9/iMYeHMWXky2E6GHy06v3oG
veQTXxzwDAjvzWiRao/Jy7iHp7MYqDxQ7wigs6aeZowugUkpDG/eNErXYu+Yu89t
5dXda5ZhxZjXTXi+iZzQ5dc9crpddqmHO2caQnSoNdngLBHTYhPMWdgsQ5fEc/aL
7cB2T6ykBT/PO4fz16PH5U2EhhWwgglce5kYre/ZiVlHfXIVYudb4h72na+UnLA=
=7NZe
-----END PGP SIGNATURE-----

--759arVputv9JSNrU05XMc91ROc7HOQ0Vt--
