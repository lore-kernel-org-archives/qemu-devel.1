Received: from eggs.gnu.org ([2001:4830:134:3::10]:58930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIbA0-0002D7-6C
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIb9z-0005IQ-39
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:38:08 -0400
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
	<20170601091224.GB4987@noname.redhat.com>
	<8baa473d-d756-2a0b-3356-1cc00f31bd25@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b1171a15-72c2-ca25-2d7b-e0abde8a71f3@redhat.com>
Date: Wed, 7 Jun 2017 15:37:56 +0200
MIME-Version: 1.0
In-Reply-To: <8baa473d-d756-2a0b-3356-1cc00f31bd25@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RjTht3hdIftiCwxedEMIuH7Drr5AoXA9I"
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RjTht3hdIftiCwxedEMIuH7Drr5AoXA9I
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <b1171a15-72c2-ca25-2d7b-e0abde8a71f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
 <5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
 <20170601091224.GB4987@noname.redhat.com>
 <8baa473d-d756-2a0b-3356-1cc00f31bd25@openvz.org>
In-Reply-To: <8baa473d-d756-2a0b-3356-1cc00f31bd25@openvz.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-06-01 13:11, Denis V. Lunev wrote:
> On 06/01/2017 12:12 PM, Kevin Wolf wrote:
>> Am 31.05.2017 um 17:03 hat Eric Blake geschrieben:
>>> On 05/31/2017 09:43 AM, Pavel Butsykin wrote:
>>>> This patch adds the reduction of the image file for qcow2. As a resu=
lt, this
>>>> allows us to reduce the virtual image size and free up space on the =
disk without
>>>> copying the image. Image can be fragmented and reduction is done by =
punching
>>>> holes in the image file.
>>>>
>>>> # ./qemu-img create -f qcow2 -o size=3D4G image.qcow2
>>>> Formatting 'image.qcow2', fmt=3Dqcow2 size=3D4294967296 encryption=3D=
off cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>>>
>>>> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
>>> So this is 1G of guest-visible data...
>>>
>>>> # ./qemu-img resize image.qcow2 128M
>>>> Image resized.
>>> ...and you are truncating the image by throwing away guest-visible
>>> content, with no warning or double-checking (such as requiring a -f
>>> force parameter or something) about the data loss.  Shrinking images =
is
>>> something we should allow, but it feels like is a rare enough operati=
on
>>> that you don't want it to be casually easy to throw away data.
>>>
>>> Is it feasible to require that a shrink operation will not be perform=
ed
>>> unless all clusters being eliminated have been previously discarded (=
or
>>> maybe written to zero), as an assurance that the guest did not care
>>> about the tail of the image?
>> I think that ship has sailed long ago because raw images have always
>> supported shrinking images without any special checks or options. We
>> want consistency between raw and qcow2, and we also need to provide
>> backwards compatibility.
>>
>> The only thing I can imagine we could do now is to introduce a --shrin=
k
>> option in qemu-img, print a deprecation warning for shrinking without
>> this option, and then make it mandatory in a few years.

Do I hear a "3.0"?

>> If we want to distinguish based on the block driver, so that we can
>> require --shrink for all drivers that didn't support shrinking until
>> now, we'd have to check the .bdrv_truncate() implementations of all
>> drivers to see whether it already allowed shrinking.

We could have an ugly raw-only hack directly in qemu-img (and
qmp_block_resize) until 3.0.

I'm really concerned about someone mistyping something and accidentally
dropping a digit.

>> Kevin
> Will the solution proposed by Pavel in the answer to Max work:
> - if there are no data blocks in the truncated space, truncate is allow=
ed
>   without additional options
> - if there are data blocks in the truncated space, truncate is allowed
>   with the flag --force or error is generated

I'd be OK with that, but I'm not sure we really need it. It would be
nice to have for convenience, but I don't think it solves the
backwards-compatibility problem (as said by Kevin), and I'm not sure it
makes things that much more convenient: Just specifying --force is
easier than to manually trim the device in the guest (and then maybe
having to specify --force anyway because you didn't do it right).

Max


--RjTht3hdIftiCwxedEMIuH7Drr5AoXA9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOAG0EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDlL
B/9lEto4WspaJrcCJCQidUyP6S96TdNZ7bCUj4ULuiKPGamaQWvF7Kndrqc0rUHm
8kJJ01iRK8x369ycsC2LaBanqobm1u5+bCzCvwLKVjckckxnONasBVhRA9WznEuz
nSNjFnZNlkIanQdzskgg811/SSq57Q9x7XL2CR34JmbiBLZHDCvvpBNve8k33JsF
8Lz1AtpeSNcBEE1sZWjgb2ZlL3IBWyU4MumFcDBIKJYiMLmEIyfeaUxR9mXG5JrE
wDri5p3+7sBRfDKhdPBWaVyi7iLnwkgG+HLFXH/Ocd7YN98p6KperR/tLgVHOIq1
0Mu4PvWyEWvnX+qSaDVOE2wp
=P35w
-----END PGP SIGNATURE-----

--RjTht3hdIftiCwxedEMIuH7Drr5AoXA9I--
