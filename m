Received: from eggs.gnu.org ([2001:4830:134:3::10]:33375)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1chLx0-0006GT-CF
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1chLwx-00014a-8z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:54:46 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47862 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1chLww-00012q-VR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:54:43 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <3f2dd35f-aed2-087e-6ed5-0b1ae47c0ff0@redhat.com>
Date: Fri, 24 Feb 2017 20:54:36 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <12913D3E-C367-4D6E-BD35-594A8F114ED6@kamp.de>
References: <764ca07c-af5e-55e3-18c5-7870b9103ba4@kamp.de>
	<3f2dd35f-aed2-087e-6ed5-0b1ae47c0ff0@redhat.com>
Subject: Re: [Qemu-devel] RFC QCOW2 compression speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


> Am 24.02.2017 um 12:36 schrieb Laszlo Ersek <lersek@redhat.com>:
>=20
> On 02/24/17 10:33, Peter Lieven wrote:
>> Hi,
>>=20
>>=20
>> i have been experimenting with deflate compression paramters in the =
past and found that the values chosen
>>=20
>> in QCOW2 are not that optimal. In fact creation of compressed QCOW2 =
is very slow.
>=20
> I agree, I find it slow as well.
>=20
>> And especially for backups
>>=20
>> compression would be good, but its so slow thats almost infeasible to =
use.
>>=20
>>=20
>> The current settings to inflateinit2 are compression level 6 =
(Z_DEFAULT_COMPRESSION) and windowBits 12.
>>=20
>> Increasing windowBits increases speed and yields better compression. =
Lowering the compression level increases
>>=20
>> speed, but results in worse compression.
>>=20
>>=20
>> The issue here is that changing windowBits would (in theory) require =
a change of the parameters to deflateInit2 in
>>=20
>> decompression which means that this change would make QCOW2 images =
incompatible.
>>=20
>>=20
>> As for discussion here is my experiment of compression a Ubuntu1604 =
installation in ram.
>>=20
>> level 6, windowBits 12   -> 42 seconds, 470MB size
>>=20
>> level 6, windowBits 15   -> 35 seconds, 448MB size
>>=20
>> level 1, windowBits 12   -> 30 seconds, 500MB size
>>=20
>> level 1, windowBits 15   -> 15 seconds, 483MB size
>>=20
>>=20
>> Strange enough decompression works with unchanged parameters for all =
files. But the documentation of zlib claims
>>=20
>> it should produce an error if a windowBits 15 stream is deflated with =
a smaller windowBits parameter.
>>=20
>>=20
>> What are your thoughts in introducing a switch and/or feature to use =
alternate settings for inflate?
>>=20
>> If we need to introduce an incompatible feature for the bigger =
windowBits might it be worth thinking of using
>>=20
>> an alternate compression algorithm like LZ4?
>=20
> If the compression level was exposed with a command line option =
(and/or
> an environment variable, a la $GZIP), I would welcome it. I have
> frequently missed this feature, but I always figured it wouldn't be
> important enough to bother block people with it.

Changing the compression level via environment or a QCOW2 parameter is =
not a big deal. However, it helps not that much regarding speed. What =
helps is increasing the window size, but this is an incompatible change. =
And if we go for an incompatible change I would think about using a =
better compression algorithm than zlib deflate.

Peter=
