Received: from eggs.gnu.org ([209.51.188.92]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2H4s-0004di-BK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2H4q-0005TT-VQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:06:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h2H4q-0005FL-Kb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:06:24 -0500
Date: Fri, 8 Mar 2019 15:06:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190308150612.GM19819@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat.com>
	<20190308134211.GG19819@redhat.com>
	<6c704b92-621d-fd5d-ec81-41ad227a0b8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c704b92-621d-fd5d-ec81-41ad227a0b8c@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

On Fri, Mar 08, 2019 at 03:48:07PM +0100, Laszlo Ersek wrote:
> On 03/08/19 14:42, Daniel P. Berrang=C3=A9 wrote:
> >>  pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 =
bytes
> >>  pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 =
bytes
> >>  pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 =
bytes
> >>  pc-bios/edk2-i386-code.fd                      | Bin 0 -> 3653632 b=
ytes
> >>  pc-bios/edk2-i386-secure-code.fd               | Bin 0 -> 3653632 b=
ytes
> >>  pc-bios/edk2-i386-vars.fd                      | Bin 0 -> 540672 by=
tes
> >>  pc-bios/edk2-licenses.txt                      | 209 ++++++++++++++=
+
> >>  pc-bios/edk2-x86_64-code.fd                    | Bin 0 -> 3653632 b=
ytes
> >>  pc-bios/edk2-x86_64-secure-code.fd             | Bin 0 -> 3653632 b=
ytes
> >=20
> >=20
> > Yikes, am I really reading those sizes right ? The biggest ROMs there
> > are 64 MB, so this is proposing to add ~206 MB of binaries to the
> > pc-bios directory ?
>=20
> Sort of.
>=20
> This is because of how the "virt" machine type's pflash chips are sized=
.
> The edk2 build produces a 2MB firmware executable and a 768KB varstore
> template for each of aarch64 and arm, but (a) QEMU doesn't auto-pad
> either [*], and (b) if we used qcow2 with compression, then libvirt
> couldn't deal with the images [**]. Hence we have to pad the files
> manually, after the edk2 build completes.
>=20
> [*] We've just been discussing auto-padding in a parallel patch from
> Alex and Markus (the latest version is "[PATCH v7] pflash: Require
> backend size to match device, improve errors", in which the padding has
> already been dropped). But such padding would only work for read-only
> pflash mappings anyway, not for variable store files.
>=20
> [**] The root cause for not using qcow2 with pflash images is that qcow=
2
> would make them candidates for "savevm" to dump live memory contents
> into them, which is Very Bad (TM).

If using  qcow2 compressed images for ROMs is the desired best answer,
then surely we can figure out a way to fix this savevm problem ? Even
if it is just an internal hack there must be a way we can mark a qcow2
file as being used by the ROM so savevm ignores it.

We've not been very motivated to solve this before since "savevm" command
is supposedly deprecated to be replaced by a sane QMP variant, but we've
been waiting 5 years for that to happen, so in the mean time a hack to
resolve the problem with firmware images feels prudent.

> > Consider that we'll need to refresh those ROMs multiple times a year =
to
> > track updates or security fixes. It will result in our .git repo size
> > growing massively over time.
>=20
> Actually, it's not *that* bad. Earlier I investigated how the formatted
> variant of the patch (adding these blobs) would look like.
>=20
> First, I compressed all the "edk2-*fd" files (individually) with "gzip
> --best", just to get a byte count. That yielded almost precisely 9MB, i=
n
> total.
>=20
> Second, the formatted patch, adding these blobs, is 12.6MB. Taking the
> 4/3 blowup factor from base64 encoding, the "unexplained overhead" is
> not that huge (0.6 MB).

Ok, that's less alarming.

Though we're still basically doubling the size of the pc-bios dir
which is already significant.

I wonder how much of out .git/objects 230 MB size is due to the current
ROMs.

> - "git checkout" is smart enough to punch holes into the files in the
> working directory.
>=20
> $ du -csh edk2-{arm,aarch64}-code.fd edk2-arm-vars.fd
> 2.1M    edk2-arm-code.fd
> 2.1M    edk2-aarch64-code.fd
> 772K    edk2-arm-vars.fd
> 4.8M    total

That's nice.

> This happens despite the fact that the Makefile performs the padding
> with "cat /dev/zero" and "head".

You can resize a file using holes with dd if you set count=3D0 and
tell it to seek in output eg something like this probably works:

  dd if=3D/dev/zero of=3Dfirmware.img seek=3D64 bs=3D1M count=3D0



> I'm 100% fine with not bundling any firmware binaries for end-users;
> however I've been doing this work because Igor needs full platform
> firmware binaries for ACPI unit tests. In particular, in aarch64 guests=
,
> there is no ACPI without UEFI, and in UEFI guests, finding the ACPI
> entry point (RSD PTR) is convoluted enough that it needs dedicated gues=
t
> support.

Yes tricky. I don't have a particularly good answer for that, especially
if it is a test that you'd expect all developers to run every time. If
it is a rarely run test then it could be justified in having it download
large blobs from a lookaside cache similar to how we download disk images
for *BSD tests.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
