Received: from eggs.gnu.org ([209.51.188.92]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3II1-0004IH-Ak
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3IHy-0005Jg-NR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h3IHv-0005Hl-SO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:36:08 -0400
Date: Mon, 11 Mar 2019 10:35:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190311103553.GN12393@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309225457-mutt-send-email-mst@kernel.org>
	<520f2da6-5850-bfdc-a77e-86d26f271fdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <520f2da6-5850-bfdc-a77e-86d26f271fdf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/10] bundle edk2 platform firmware with
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, kraxel@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, imammedo@redhat.com, qemu-devel@nongnu.org

On Sun, Mar 10, 2019 at 12:21:55PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 3/10/19 4:56 AM, Michael S. Tsirkin wrote:
> > On Sat, Mar 09, 2019 at 01:48:16AM +0100, Laszlo Ersek wrote:
> >> Repo:   https://github.com/lersek/qemu.git
> >> Branch: edk2_build
> >>
> >> This series advances the roms/edk2 submodule to the "edk2-stable2019=
03"
> >> release, and builds and captures platform firmware binaries from tha=
t
> >> release. At this point they are meant to be used by both end-users a=
nd
> >> by Igor's ACPI unit tests in qtest ("make check").
> >>
> >> Previous discussion:
> >>
> >>   [Qemu-devel] bundling edk2 platform firmware images with QEMU
> >>   http://mid.mail-archive.com/80f0bae3-e79a-bb68-04c4-1c9c684d95b8@r=
edhat.com
> >>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02601.htm=
l
>=20
> There David raised a concern about "[adding] ~206 MB of binaries to the
> pc-bios directory". I'm also worried.
>=20
> GitHub kindly suggest to use git-lfs. It is an extra dependency I'd
> rather strongly avoid (because we support a wide range of host OS, each
> using a wide types of filesystems).
>=20
> What about storing those binaries on a file server (http/ftp) altogethe=
r
> with a file containing its hashed digest (SHA1/SHA256)? Then we already
> have all the required tools to fetch and verify those blob roms with th=
e
> build system.
> Or we could store the hashes in the QEMU repository too.

A simple approach would simply be to 'xz' compress all the edk*.fd
files but still store them in git. They're already opaque binary
files, so replacing one binary format with another binary format
is no big deal IMHO

$ ls -alsh edk2-*
1.1M -rw-rw-r--. 1 berrange berrange 1.1M Mar 11 10:29 edk2-aarch64-code.=
fd.xz
2.1M -rw-rw-r--. 1 berrange berrange  64M Mar 11 10:29 edk2-arm-code.fd
772K -rw-rw-r--. 1 berrange berrange  64M Mar 11 10:29 edk2-arm-vars.fd
3.5M -rw-rw-r--. 1 berrange berrange 3.5M Mar 11 10:29 edk2-i386-code.fd
3.5M -rw-rw-r--. 1 berrange berrange 3.5M Mar 11 10:29 edk2-i386-secure-c=
ode.fd
528K -rw-rw-r--. 1 berrange berrange 528K Mar 11 10:29 edk2-i386-vars.fd
 12K -rw-rw-r--. 1 berrange berrange  11K Mar 11 10:29 edk2-licenses.txt
3.5M -rw-rw-r--. 1 berrange berrange 3.5M Mar 11 10:29 edk2-x86_64-code.f=
d
3.5M -rw-rw-r--. 1 berrange berrange 3.5M Mar 11 10:29 edk2-x86_64-secure=
-code.fd

This gives a 50% disk space saving over the sparse size:

$ ls -alsh edk2-*
1.1M -rw-rw-r--. 1 berrange berrange 1.1M Mar 11 10:29 edk2-aarch64-code.=
fd.xz
1.1M -rw-rw-r--. 1 berrange berrange 1.1M Mar 11 10:29 edk2-arm-code.fd.x=
z
 12K -rw-rw-r--. 1 berrange berrange 9.8K Mar 11 10:29 edk2-arm-vars.fd.x=
z
1.6M -rw-rw-r--. 1 berrange berrange 1.6M Mar 11 10:29 edk2-i386-code.fd.=
xz
1.8M -rw-rw-r--. 1 berrange berrange 1.8M Mar 11 10:29 edk2-i386-secure-c=
ode.fd.xz
4.0K -rw-rw-r--. 1 berrange berrange  320 Mar 11 10:29 edk2-i386-vars.fd.=
xz
 12K -rw-rw-r--. 1 berrange berrange  11K Mar 11 10:29 edk2-licenses.txt
1.6M -rw-rw-r--. 1 berrange berrange 1.6M Mar 11 10:29 edk2-x86_64-code.f=
d.xz
1.9M -rw-rw-r--. 1 berrange berrange 1.9M Mar 11 10:29 edk2-x86_64-secure=
-code.fd.xz

So about 9 MB compressed, instead of 20MB for the uncompressed sparse
files, which is on a par with the existing ROM sizes.

We would then need a "make" rule that runs  unxz to "build" the firmware
files. Wouldn't need to be more complicated that this:

   edk2-%.fd: edk2-%.fd.xz
         unzx -c $< > $@

   CLEANFILES +=3D $(wildcard edk2*.fd)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
