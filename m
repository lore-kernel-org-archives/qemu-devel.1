Received: from eggs.gnu.org ([209.51.188.92]:45975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hL0vw-0007am-H2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hL0hP-000725-P0
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:27:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1hL0hP-00070y-GR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:27:39 -0400
Date: Mon, 29 Apr 2019 09:27:34 +0200
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20190429072734.GC8818@wheatley>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
	<aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
	<20190424071917.GA15891@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20190424071917.GA15891@linux.fritz.box>
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 24, 2019 at 09:19:17AM +0200, Kevin Wolf wrote:
>Am 24.04.2019 um 08:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 23.04.2019 18:08, Kevin Wolf wrote:
>> > Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
>> >> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>> >>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>> >>>> Hi,
>> >>>>
>> >>>> I am using qemu-img with nbdkit to transfer a disk image and the update it with
>> >>>> extra data from newer snapshots.  The end image cannot be transferred because
>> >>>> the snapshots will be created later than the first transfer and we want to save
>> >>>> some time up front.  You might think of it as a continuous synchronisation.  It
>> >>>> looks something like this:
>> >>>>
>> >>>> I first transfer the whole image:
>> >>>>
>> >>>>   qemu-img convert -p $nbd disk.raw
>> >>>>
>> >>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=nbdkit.sock`
>> >>>>
>> >>>> Then, after the next snapshot is created, I can update it thanks to the `-n`
>> >>>> parameter (the $nbd now points to the newer snapshot with unchanged data looking
>> >>>> like holes in the file):
>> >>>>
>> >>>>   qemu-img convert -p -n $nbd disk.raw
>> >>>>
>> >>>> This is fast and efficient as it uses block status nbd extension, so it only
>> >>>> transfers new data.
>> >>>
>> >>> This is an implementation detail. Don't rely on it. What you're doing is
>> >>> abusing 'qemu-img convert', so problems like what you describe are to be
>> >>> expected.
>> >>>
>> >>>> This can be done over and over again to keep the local
>> >>>> `disk.raw` image up to date with the latest remote snapshot.
>> >>>>
>> >>>> However, when the guest OS zeroes some of the data and it gets written into the
>> >>>> snapshot, qemu-img scans for those zeros and does not write them to the
>> >>>> destination image.  Checking the output of `qemu-img map --output=json $nbd`
>> >>>> shows that the zeroed data is properly marked as `data: true`.
>> >>>>
>> >>>> Using `-S 0` would write zeros even where the holes are, effectively overwriting
>> >>>> the data from the last snapshot even though they should not be changed.
>> >>>>
>> >>>> Having gone through some workarounds I would like there to be another way.  I
>> >>>> know this is far from the typical usage of qemu-img, but is this really the
>> >>>> expected behaviour or is this just something nobody really needed before?  If it
>> >>>> is the former, would it be possible to have a parameter that would control this
>> >>>> behaviour?  If the latter is the case, can that behaviour be changed so that it
>> >>>> properly replicates the data when `-n` parameter is used?
>> >>>>
>> >>>> Basically the only thing we need is to either:
>> >>>>
>> >>>> 1) write zeros where they actually are or
>> >>>>
>> >>>> 2) turn off explicit sparsification without requesting dense image (basically
>> >>>>     sparsify only the par that is reported as hole on the source) or
>> >>>>
>> >>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did report data,
>> >>>>     but qemu-img found they are all zeros (or source reported HOLE+ZERO which, I
>> >>>>     believe, is effectively the same)
>> >>>>
>> >>>> If you want to try this out, I found the easiest reproducible way is using
>> >>>> nbdkit's data plugin, which can simulate whatever source image you like.
>> >>>
>> >>> I think what you _really_ want is a commit block job. The problem is
>> >>> just that you don't have a proper backing file chain, but just a bunch
>> >>> of NBD connections.
>> >>>
>> >>> Can't you get an NBD connection that already provides the condensed form
>> >>> of the whole snapshot chain directly at the source? If the NBD server
>> >>> was QEMU, this would actually be easier than providing each snapshot
>> >>> individually.
>> >>>
>> >>> If this isn't possible, I think you need to replicate the backing chain
>> >>> on the destination instead of converting into the same image again and
>> >>> again so that qemu-img knows that it must take existing data of the
>> >>> backing file into consideration:
>> >>>
>> >>>     qemu-img convert -O qcow2 nbd://... base.qcow2
>> >>>     qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1.qcow2
>> >>>     qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... overlay2.qcow2
>> >>>     ...
>>

So I spoke too soon.  This approach fixed the one thing that I was struggling with, but broke the rest, because it completely replicates the last image even when the source provides proper allocation data.  Best to show with an illustration:

  $ rm -f disk.img snap.img
  $ dd if=/dev/urandom of=disk.img bs=2M count=1
  $ dd if=/dev/zero of=snap.img bs=1M count=1
  $ truncate -s 2M snap.img
  $ qemu-img map --output=json snap.img
  [{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true, "offset": 0},
  { "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": 1048576}]
  $ qemu-img convert -f raw -O qcow2 disk.img disk.qcow2
  $ qemu-img convert -f raw -O qcow2 -B disk.qcow2 snap.img snap.qcow2
  $ qemu-img convert -f qcow2 -O raw snap.qcow2 output.raw
  $ hexdump -C output.raw
  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  00200000

And qemu-img convert from qcow2 to raw is not broken

So it looks like either we add support for this specific feature in qemu-img or
we need to use our own client that does that.

Unless someone has other ideas, that is.

Martin

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAlzGp2YACgkQCB/CnyQX
ht0m0xAAhQMSPQFZAilRTr3WeoaiAjzk+ugbPJhebhFGzisnBHUCFJW55BMj88NE
uNsUa/NNwdwj26MDWKIz69V3NMcQd4yR2hzThZWzg8yipJzBLxIQI1hYIMx2HQid
gYL2qnKG9WjKo0BE4zO/Lg8T/nICnyQLH3gfiQAEvUTwEyp0gQiMdL91WZdrK16l
UUcwtYcg1Mn2sljwAJ4L+gpBZCRmRsx2dAlRaAyHKLb6/fE8OCpPEMMAv8TfBdUf
NHShd2FZSB6V7yhg9atAjdxTlApw9RH27Y6ibDfe6B4PVrWtE3hEUG9pYHEKi+xp
PkzsjtpJ3Bo5vnakn/QnpoDb1q10Wm/vIESEQ+k/JpP3iwhFmt5ckwOrAjrpwX3h
LqLtzqtVxO6wmtMAC93/mqROgM8xzkv7MaddIMnp+G/ZvgQRXmSuVa7Y8zuyU5gS
La0r/LtMY21N9vjTAKJK8Itl9f4+nqdEvv70DQvxb5W/bI8Q8KICuVnyJ87Jr2kl
1UgAu+IyFFJio8HSqdjci9jF+6n2X0XJQNA990K0e9X4lsUuul8lCOMujcBhHGPU
rz6BtsuBRnTV/2yrXncGLG+fFfXWEcdUhf0bOshlgaR4lP/culytEPwk/PlPDqfl
qPE1iBHPbo1DA7ii1ipZWBnkXam6SLNdTcbjrGdah2LgKuRAQSA=
=L6Cz
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
