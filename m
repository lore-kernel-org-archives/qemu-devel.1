Received: from eggs.gnu.org ([2001:4830:134:3::10]:54080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drRw1-0001H9-Eu
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drRvw-0003Nq-Ny
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:51:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:46701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1drRvw-0003NP-HY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:51:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1drRvs-0004g3-Sx
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 16:51:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7A1292E8495
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 16:51:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Sep 2017 16:36:09 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1715700 <1715700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
	<150514652632.16396.5785164464607646073.malone@soybean.canonical.com>
Message-Id: <20170911163609.GE2857@work-vm>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1715700] Re: Windows 7 guest won't boot on
 qemu 2.10 (works on 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

* Aleksei Kovura (alex3kov@zoho.com) wrote:
> Ok, so I cloned from github and am bisecting like this (it's been a while=
, correct me if I'm wrong):
> $ git bisect start
> $ git bisect bad 1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec # 2.10.0 stable=
 commit
> $ git bisect good 359c41abe32638adad503e386969fa428cecff52 # 2.9.0 stable=
 commit
> Bisecting: 1426 revisions left to test after this (roughly 11 steps)
> [269c20b2bbd2aa8531e0cdc741fb166f290d7a2b] tests/qdict: check more get_tr=
y_int() cases
> $ mkdir -p bin/269c20b2bbd2aa8531e0cdc741fb166f290d7a2b
> $ cd bin/269c20b2bbd2aa8531e0cdc741fb166f290d7a2b
> $ ../../configure --target-list=3Dx86_64-softmmu --python=3D/usr/bin/pyth=
on2 --enable-debug
> =

> Compilation fails with this (full log here
> https://pastebin.com/aUYyE6Bb):
> =

>   CC      block/block-backend.o
> /media/usb465gb_232gb_NTFS/compile/qemu/block/blkdebug.c: In function =E2=
=80=98blkdebug_refresh_filename=E2=80=99:
> /media/usb465gb_232gb_NTFS/compile/qemu/block/blkdebug.c:843:31: error: =
=E2=80=98%s=E2=80=99 directive output may be truncated writing up to 4095 b=
ytes into a region of size 4086 [-Werror=3Dformat-truncation=3D]
>                   "blkdebug:%s:%s", s->config_file ?: "",
>                                ^~
> /media/usb465gb_232gb_NTFS/compile/qemu/block/blkdebug.c:842:9: note: =E2=
=80=98snprintf=E2=80=99 output 11 or more bytes (assuming 4106) into a dest=
ination of size 4096
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   "blkdebug:%s:%s", s->config_file ?: "",
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   bs->file->bs->exact_filename);
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/media/usb465gb_232gb_NTFS/compile/qemu/rules.mak:66: block/bl=
kdebug.o] Error 1
> make: *** Waiting for unfinished jobs....
> /media/usb465gb_232gb_NTFS/compile/qemu/block/blkverify.c: In function =
=E2=80=98blkverify_refresh_filename=E2=80=99:
> /media/usb465gb_232gb_NTFS/compile/qemu/block/blkverify.c:305:29: error: =
=E2=80=98%s=E2=80=99 directive output may be truncated writing up to 4095 b=
ytes into a region of size 4086 [-Werror=3Dformat-truncation=3D]
>                   "blkverify:%s:%s",
>                              ^~
> /media/usb465gb_232gb_NTFS/compile/qemu/block/blkverify.c:304:9: note: =
=E2=80=98snprintf=E2=80=99 output between 12 and 8202 bytes into a destinat=
ion of size 4096
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   "blkverify:%s:%s",
>                   ~~~~~~~~~~~~~~~~~~
>                   bs->file->bs->exact_filename,
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   s->test_file->bs->exact_filename);
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/media/usb465gb_232gb_NTFS/compile/qemu/rules.mak:66: block/bl=
kverify.o] Error 1
> =

> Did I hit a commit with a broken build or something? What to do next?

It's just the newer compiler is more fussy than the old one so when you
bisect you're not getting fixes for newer compilers.   You can pass
flags to the configure to use extra clfgas to turn this particular
warning off.

Dave

> -- =

> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1715700
> =

> Title:
>   Windows 7 guest won't boot on qemu 2.10 (works on 2.9)
> =

> Status in QEMU:
>   New
> =

> Bug description:
>   Qemu version: 2.10 stable.
>   Guest: Windows 7 SP1 x64, virtio drivers are already installed in the g=
uest.
>   Command line:
>   qemu-system-x86_64 \
>       -nodefaults \
>       -nodefconfig \
>       -machine type=3Dq35,accel=3Dkvm \
>       -enable-kvm \
>       -cpu host \
>       -m 2048 \
>       -vga virtio \
>       -boot menu=3Don \
>       -smbios file=3D/path/dmidecode_BIOS.bin \
>       -acpitable file=3D/path/acpi_slic.bin \
>       -bios /path/OVMF_CODE.fd \
>       -net none \
>       -drive if=3Dvirtio,media=3Ddisk,file=3D/media/win7.qcow2 \
>       -device pcie-root-port \
>       -device ich9-usb-ehci1 \
>       -device ich9-usb-uhci1 \
>       -device ich9-usb-uhci2 \
>       -device ich9-usb-uhci3
> =

>   Windows hangs at boot with waving flag screen (flag doesn't freeze,
>   keeps waving indefinitely). Same command line boots fine with Qemu
>   2.9. I tried changing machine type to pc-q35-2.9 - same result.
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1715700/+subscriptions
> =

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715700

Title:
  Windows 7 guest won't boot on qemu 2.10 (works on 2.9)

Status in QEMU:
  New

Bug description:
  Qemu version: 2.10 stable.
  Guest: Windows 7 SP1 x64, virtio drivers are already installed in the gue=
st.
  Command line:
  qemu-system-x86_64 \
      -nodefaults \
      -nodefconfig \
      -machine type=3Dq35,accel=3Dkvm \
      -enable-kvm \
      -cpu host \
      -m 2048 \
      -vga virtio \
      -boot menu=3Don \
      -smbios file=3D/path/dmidecode_BIOS.bin \
      -acpitable file=3D/path/acpi_slic.bin \
      -bios /path/OVMF_CODE.fd \
      -net none \
      -drive if=3Dvirtio,media=3Ddisk,file=3D/media/win7.qcow2 \
      -device pcie-root-port \
      -device ich9-usb-ehci1 \
      -device ich9-usb-uhci1 \
      -device ich9-usb-uhci2 \
      -device ich9-usb-uhci3

  Windows hangs at boot with waving flag screen (flag doesn't freeze,
  keeps waving indefinitely). Same command line boots fine with Qemu
  2.9. I tried changing machine type to pc-q35-2.9 - same result.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715700/+subscriptions
