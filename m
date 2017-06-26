Received: from eggs.gnu.org ([2001:4830:134:3::10]:33817)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPb1x-0005iI-Jm
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPb1t-00006z-3V
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:54:45 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34604 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPb1s-00005O-QO
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:54:41 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <5a22e3c4-040f-52e0-caad-51ba186be2e5@openvz.org>
Date: Mon, 26 Jun 2017 22:54:35 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <384D2941-2FCC-41FD-B9BE-8C6EE1F5FACD@kamp.de>
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
	<5a22e3c4-040f-52e0-caad-51ba186be2e5@openvz.org>
Subject: Re: [Qemu-devel] QCOW2 support for LZO compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org



> Am 26.06.2017 um 22:30 schrieb Denis V. Lunev <den@openvz.org>:
>=20
>> On 06/26/2017 11:28 AM, Kevin Wolf wrote:
>> [ Cc: qemu-devel; don't post to qemu-block only! ]
>>=20
>> Am 26.06.2017 um 09:57 hat Peter Lieven geschrieben:
>>> Hi,
>>>=20
>>> I am currently working on optimizing speed for compressed QCOW2
>>> images. We use them for templates and would also like to use them for
>>> backups, but the latter is almost infeasible because using gzip for
>>> compression is horribly slow. I tried to experiment with different
>>> options to deflate, but in the end I think its better to use a
>>> different compression algorithm for cases where speed matters. As we
>>> already have probing for it in configure and as it is widely used I
>>> would like to use LZO for that purpose. I think it would be best to
>>> have a flag to indicate that compressed blocks use LZO compression,
>>> but I would need a little explaination which of the feature fields I
>>> have to use to prevent an older (incompatible) Qemu opening LZO
>>> compressed QCOW2 images.
>>>=20
>>> I also have already some numbers. I converted a fresh Debian 9 Install
>>> which has an uncomressed QCOW2 size of 1158 MB with qemu-img to a
>>> compressed QCOW2.  With GZIP compression the result is 356MB whereas
>>> the LZO version is 452MB. However, the current GZIP variant uses 35
>>> seconds for this operation where LZO only needs 4 seconds. I think is
>>> is a good trade in especially when its optional so the user can
>>> choose.
>>>=20
>>> What are your thoughts?
>> We had a related RFC patch by Den earlier this year, which never
>> received many comment and never got out of RFC:
>>=20
>> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04682.html
>>=20
>> So he chose a different algorithm (zstd). When I asked, he posted a
>> comparison of algorithms (however a generic one and not measured in the
>> context of qemu) that suggests that LZO would be slightly faster, but
>> have a considerable worse compression ratio with the settings that were
>> benchmarked.
>>=20
>> I think it's clear that if there is any serious interest in compression,
>> we'll want to support at least one more algorithm. What we still need to
>> evaluate is which one(s) to take, and whether a simple incompatible flag
>> in the header like in Den's patch is enough or whether we should add a
>> whole new header field for the compression algorithm (like we already
>> have for encryption).
>>=20
>> Kevin
> I have been contacted today Yann Collet who is ZSTD maintainer, he has
> dropped
> nowadays status of ZSTD, which could be useful for the discussion:
>=20
> "_1. zstd package availability_
>=20
> We have been tracking distribution availability since Zstandard official
> release, in September 2016 :
> https://github.com/facebook/zstd/issues/320
> There is also this tool which tracks availability of packages :
> https://repology.org/metapackage/zstd/versions
>=20
> zstd seems now available as a package in most recent distributions.
> It=E2=80=99s even part of =E2=80=9Ccore=E2=80=9D for recent BSD releases.
> Zstandard v1.0 is still less than 1 year old, so older distributions
> typically do not have it (or support a development version).
> That=E2=80=99s the main limitation currently. We expect things to improve o=
ver time.
>=20
> 2.
>=20
>    _Compression speed is good but does not matter
>    _For such scenarios, it=E2=80=99s possible to trade speed for more comp=
ression.
>    At its maximum compression level (--ultra -22), zstd compression
>    ratio (and speed) is close to lzma.
>    A nice property though is that decompression speed remains roughly
>    the same at all compression levels,
>    about 10x faster than lzma decompression speed (about 1 GB/s on
>    modern CPU).
>=20
> 3.
>=20
>    _zstd is multi-threaded, and it=E2=80=99s dangerous_
>=20
> libzstd is single-threaded.
> There is a multi-thread extension, which is enabled in the CLI, but not
> in the library.
> There is also an experimental target which makes it possible to produce
> a MT-enabled library.
> Even in this case, the API remains single-threaded by default.
> It=E2=80=99s necessary to use dedicated entry points to enable multi-threa=
ding.
> TL;DR : zstd supports multithreading, but is single threaded by default.
>=20
>=20
>=20
> 4.
>=20
>    _How to identify gz format from zstd one ?
>    _Many implementations assume they require to add some custom header
>    in order to identify gz from zstd.
>    That=E2=80=99s not the case: well-formed compression format already pro=
vide
>    a header with enough information to guarantee their identity.
>    Such =E2=80=9Cgood=E2=80=9D compression format include gz, zstd, xz, lz=
4-frame, to
>    name a few.
>    For zstd, the identifier is a 4-bytes value, documented in the
>    compression format :
>    https://github.com/facebook/zstd/blob/dev/doc/zstd_compression_format.m=
d#zstandard-frames
>    As an example, zstd project provides a zlib-wrapper which is able to
>    dynamically recognize an input as gz or zstd, and route to
>    appropriate decoder, without any special header :
>    https://github.com/facebook/zstd/tree/dev/zlibWrapper
>=20
>=20
> Unfortunately, not all compression algorithm do provide unambiguous
> standard header.
> LZO, for example, does not by default.
> Behind a single name, lzo effectively groups multiple incompatible
> variants, which must be correctly identified for proper decoding."
>=20
> Den
>=20

Hi Den,

thanks for the update.

I am about to have an RFC patchset ready for addition of the compression alg=
orithm header. It will be easy to add support for zstd on top of that.

I would prefer to have the same algorithm for all compressed clusters and av=
oid detecting for each cluster. If you want to change the algorithm you woul=
d have to recode. This way you can also easily detect at open time of the im=
age if you support the compression algorithm and fail directly if necessary.=


Peter=
