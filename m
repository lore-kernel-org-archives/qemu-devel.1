Received: from eggs.gnu.org ([2001:4830:134:3::10]:37544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJBt-00078C-LK
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJBs-0000CY-Mg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:59:49 -0500
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-6-mreitz@redhat.com>
	<w51y3mh5mpz.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <666b3e59-9c51-258d-eff4-71e540275c4e@redhat.com>
Date: Fri, 8 Dec 2017 14:59:35 +0100
MIME-Version: 1.0
In-Reply-To: <w51y3mh5mpz.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cSBcqQXVLtDneaiV7epmXTJ3CIhpUNeW6"
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 05/25] block: Respect backing
 bs in bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cSBcqQXVLtDneaiV7epmXTJ3CIhpUNeW6
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <666b3e59-9c51-258d-eff4-71e540275c4e@redhat.com>
Subject: Re: [PATCH v7 for-2.12 05/25] block: Respect backing bs in
 bdrv_refresh_filename
References: <20171120201004.14999-1-mreitz@redhat.com>
 <20171120201004.14999-6-mreitz@redhat.com>
 <w51y3mh5mpz.fsf@maestria.local.igalia.com>
In-Reply-To: <w51y3mh5mpz.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-05 14:27, Alberto Garcia wrote:
> On Mon 20 Nov 2017 09:09:44 PM CET, Max Reitz wrote:
>> @@ -5016,6 +5016,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)=

>> =20
>>          opts =3D qdict_new();
>>          has_open_options =3D append_open_options(opts, bs);
>> +        has_open_options |=3D bs->backing_overridden;
>> =20
>>          /* If no specific options have been given for this BDS, the f=
ilename of
>>           * the underlying file should suffice for this one as well */=

>> @@ -5027,11 +5028,20 @@ void bdrv_refresh_filename(BlockDriverState *b=
s)
>>           * file BDS. The full options QDict of that file BDS should s=
omehow
>>           * contain a representation of the filename, therefore the fo=
llowing
>>           * suffices without querying the (exact_)filename of this BDS=
=2E */
>> -        if (bs->file->bs->full_open_options) {
>> +        if (bs->file->bs->full_open_options &&
>> +            (!bs->backing || bs->backing->bs->full_open_options))
>> +        {
>=20
> Does this mean that both file. and backing. have to be overriden?

The bs->file->bs->full_open_options is not a check whether anything has
been overridden but just whether we have a QDict of runtime options for
file (and we should always have one).  After this series, that check
therefore disappears.

> Shouldn't that be a || instead of a && ??

The block under this if condition automatically constructs
bs->full_open_options -- but it can only do so if all of the relevant
children's options are known (because their options need to be put into
bs->full_open_options).

Previously, that was only the file child.  This patch adds support for
the backing child: Whenever there is a backing child node, we need to
include its options under the "backing" key.

So that's where the condition comes from: For all children that this
node has, we need their full_open_options or we cannot construct this
node's full_open_options.

We do have bs->file (because that is the condition for the block this
condition is in), so we need bs->file->bs->full_open_options.  And if we
have bs->backing, we also need bs->backing->bs->full_open_options.

>>              qdict_put_str(opts, "driver", drv->format_name);
>>              QINCREF(bs->file->bs->full_open_options);
>>              qdict_put(opts, "file", bs->file->bs->full_open_options);=

>> =20
>> +            if (bs->backing) {
>> +                QINCREF(bs->backing->bs->full_open_options);
>> +                qdict_put(opts, "backing", bs->backing->bs->full_open=
_options);
>> +            } else if (bs->backing_overridden && !bs->backing) {
>> +                qdict_put(opts, "backing", qstring_new());
>> +            }
>=20
> You don't need the !bs->backing in the second if, it's implied from the=

> previous one.

Maybe that was intentional (to be more explicit, and because after this
series only this branch remains), maybe it wasn't.  I don't know
anymore, so I'll just drop it (even though I'll have to re-add it later,
because as I said, only this else if branch will remain).

Max


--cSBcqQXVLtDneaiV7epmXTJ3CIhpUNeW6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloqmscSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYzoH+wanG2MIvHuBSTkSINdcuFftAnSr22JW
LyfeKDQgnEqQZ4dzQqC/6lwrB4VaBpu2IcZwrI0/kOz8SwhZ1PZrCpfO+VMTOamT
tzR/H8jw4XyRz2qpEwZCbogAduc5Wf9rpt4iZZs/o0uNV/pccdGi0uFlkZKsaipN
TKZIRQ0vPmRmd4kqIX7Xq6Y6AEPB06GUBpKKGdbul0cdc4yJZCxvEIRg05bAaNxg
0BjH+b5kdv3Qkuem5FCnMbl1Q7Xkba0JJ/1f3CLRP5AHcwj3aAZI1OQln2K+MJSo
ikk2fwSGbIEgLegEFwQWqsiTfbkSueP3mcX7YsiN6Ug9o+TKBvwbpb4=
=Fzug
-----END PGP SIGNATURE-----

--cSBcqQXVLtDneaiV7epmXTJ3CIhpUNeW6--
