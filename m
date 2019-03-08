Received: from eggs.gnu.org ([209.51.188.92]:54272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2IMB-00010c-V3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2IMA-0007Cd-1a
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2IM7-00077K-UH
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:28:21 -0500
References: <80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat.com>
	<20190308134211.GG19819@redhat.com>
	<6c704b92-621d-fd5d-ec81-41ad227a0b8c@redhat.com>
	<20190308150612.GM19819@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7c51a064-0c6e-9bbb-c79a-2777da9e41d3@redhat.com>
Date: Fri, 8 Mar 2019 17:28:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190308150612.GM19819@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] bundling edk2 platform firmware images with QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

On 03/08/19 16:06, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 08, 2019 at 03:48:07PM +0100, Laszlo Ersek wrote:
>> On 03/08/19 14:42, Daniel P. Berrang=C3=A9 wrote:
>>>>  pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 =
bytes
>>>>  pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 =
bytes
>>>>  pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 =
bytes
>>>>  pc-bios/edk2-i386-code.fd                      | Bin 0 -> 3653632 b=
ytes
>>>>  pc-bios/edk2-i386-secure-code.fd               | Bin 0 -> 3653632 b=
ytes
>>>>  pc-bios/edk2-i386-vars.fd                      | Bin 0 -> 540672 by=
tes
>>>>  pc-bios/edk2-licenses.txt                      | 209 ++++++++++++++=
+
>>>>  pc-bios/edk2-x86_64-code.fd                    | Bin 0 -> 3653632 b=
ytes
>>>>  pc-bios/edk2-x86_64-secure-code.fd             | Bin 0 -> 3653632 b=
ytes
>>>
>>>
>>> Yikes, am I really reading those sizes right ? The biggest ROMs there
>>> are 64 MB, so this is proposing to add ~206 MB of binaries to the
>>> pc-bios directory ?
>>
>> Sort of.
>>
>> This is because of how the "virt" machine type's pflash chips are size=
d.
>> The edk2 build produces a 2MB firmware executable and a 768KB varstore
>> template for each of aarch64 and arm, but (a) QEMU doesn't auto-pad
>> either [*], and (b) if we used qcow2 with compression, then libvirt
>> couldn't deal with the images [**]. Hence we have to pad the files
>> manually, after the edk2 build completes.
>>
>> [*] We've just been discussing auto-padding in a parallel patch from
>> Alex and Markus (the latest version is "[PATCH v7] pflash: Require
>> backend size to match device, improve errors", in which the padding ha=
s
>> already been dropped). But such padding would only work for read-only
>> pflash mappings anyway, not for variable store files.
>>
>> [**] The root cause for not using qcow2 with pflash images is that qco=
w2
>> would make them candidates for "savevm" to dump live memory contents
>> into them, which is Very Bad (TM).
>=20
> If using  qcow2 compressed images for ROMs is the desired best answer,
> then surely we can figure out a way to fix this savevm problem ? Even
> if it is just an internal hack there must be a way we can mark a qcow2
> file as being used by the ROM so savevm ignores it.

This was one of the first ideas (if not "the" first one) that came up yea=
rs ago (in January 2016), and it was rejected. I'm not saying it's wrong,=
 but it was rejected.

* [Qemu-devel] [PATCH 1/1] blk: do not select PFLASH device for internal =
snapshot
  https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg01824.html
  http://mid.mail-archive.com/1452578622-4492-1-git-send-email-den@openvz=
.org

* https://bugzilla.redhat.com/show_bug.cgi?id=3D1180955

* https://bugzilla.redhat.com/show_bug.cgi?id=3D1214187

> We've not been very motivated to solve this before

We gave up in frustration, not because we didn't care.

The kludge that we put in place (in libvirtd) simply prevents us from "go=
ing there" now, through libvirt anyway:

* https://bugzilla.redhat.com/show_bug.cgi?id=3D1431852
* commit 9e2465834f4b ("qemu: snapshot: Forbid internal snapshots with pf=
lash firmware", 2017-03-01)

> since "savevm" command
> is supposedly deprecated to be replaced by a sane QMP variant, but we'v=
e
> been waiting 5 years for that to happen, so in the mean time a hack to
> resolve the problem with firmware images feels prudent.

I've attempted this route multiple times in the past, speaking in general=
. Folks generally keep rejecting patches they have rejected  before.

(And if they do change their minds, just because a number of years have p=
assed, then I'm left wondering how that is reasonable.

That's not to say that I wouldn't be happy about it, of course -- I just =
don't have capacity for likely futile tries.)

>>> Consider that we'll need to refresh those ROMs multiple times a year =
to
>>> track updates or security fixes. It will result in our .git repo size
>>> growing massively over time.
>>
>> Actually, it's not *that* bad. Earlier I investigated how the formatte=
d
>> variant of the patch (adding these blobs) would look like.
>>
>> First, I compressed all the "edk2-*fd" files (individually) with "gzip
>> --best", just to get a byte count. That yielded almost precisely 9MB, =
in
>> total.
>>
>> Second, the formatted patch, adding these blobs, is 12.6MB. Taking the
>> 4/3 blowup factor from base64 encoding, the "unexplained overhead" is
>> not that huge (0.6 MB).
>=20
> Ok, that's less alarming.
>=20
> Though we're still basically doubling the size of the pc-bios dir
> which is already significant.
>=20
> I wonder how much of out .git/objects 230 MB size is due to the current
> ROMs.

I think it would be awesome if git provided some statistics like this! "W=
hat is the footprint of the full history of this set of files?"

>=20
>> - "git checkout" is smart enough to punch holes into the files in the
>> working directory.
>>
>> $ du -csh edk2-{arm,aarch64}-code.fd edk2-arm-vars.fd
>> 2.1M    edk2-arm-code.fd
>> 2.1M    edk2-aarch64-code.fd
>> 772K    edk2-arm-vars.fd
>> 4.8M    total
>=20
> That's nice.
>=20
>> This happens despite the fact that the Makefile performs the padding
>> with "cat /dev/zero" and "head".
>=20
> You can resize a file using holes with dd if you set count=3D0 and
> tell it to seek in output eg something like this probably works:
>=20
>   dd if=3D/dev/zero of=3Dfirmware.img seek=3D64 bs=3D1M count=3D0

Well the actual command I use is

  cat FILE-TO-PAD /dev/zero | head -c 64M > PADDED-FILE

Maybe this can be reworked to

  cp FILE-TO-PAD PADDED-FILE
  [dd command with conv=3Dnotrunc?]

It would be even easier with the "truncate" utility:

  cp FILE-TO-PAD PADDED-FILE
  truncate --size=3D64M PADDED-FILE

"truncate" is part of GNU coreutils, so maybe I should use "truncate" aft=
er all.

I'll work this into the series.

>> I'm 100% fine with not bundling any firmware binaries for end-users;
>> however I've been doing this work because Igor needs full platform
>> firmware binaries for ACPI unit tests. In particular, in aarch64 guest=
s,
>> there is no ACPI without UEFI, and in UEFI guests, finding the ACPI
>> entry point (RSD PTR) is convoluted enough that it needs dedicated gue=
st
>> support.
>=20
> Yes tricky. I don't have a particularly good answer for that, especiall=
y
> if it is a test that you'd expect all developers to run every time. If
> it is a rarely run test then it could be justified in having it downloa=
d
> large blobs from a lookaside cache similar to how we download disk imag=
es
> for *BSD tests.

I think it would be part of "make check".

Thanks
Laszlo
