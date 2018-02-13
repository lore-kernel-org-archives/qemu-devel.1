Received: from eggs.gnu.org ([2001:4830:134:3::10]:50724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elUQe-00076q-Pc
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 01:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elUQa-0002Wg-DA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 01:51:00 -0500
Received: from mail.ispras.ru ([83.149.199.45]:36002)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elUQa-0002VC-0j
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 01:50:56 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
	<CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
	<001b01d3a3c5$032e09f0$098a1dd0$@ru>
	<CAFXrp_dNj+BSYo+0rpv5d4PxdjJ1RL_cROaDWRvjQTLziFtO_Q@mail.gmail.com>
In-Reply-To: <CAFXrp_dNj+BSYo+0rpv5d4PxdjJ1RL_cROaDWRvjQTLziFtO_Q@mail.gmail.com>
Date: Tue, 13 Feb 2018 09:50:51 +0300
Message-ID: <000c01d3a496$fd2bc470$f7834d50$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ciro Santilli' <ciro.santilli@gmail.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, 'Peter Maydell' <peter.maydell@linaro.org>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, kraxel@redhat.com, 'Thomas Dullien' <thomas.dullien@googlemail.com>, pbonzini@redhat.com, =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

Your command line looks wrong, because you forgot =E2=80=93icount, but =
specified other replay options.

I tried recording and replaying with your command line and the execution =
hangs at some moment of replay.

The problem may be hidden in =E2=80=93dtb option, because it may add the =
devices without configuring replay for them.

Can you specify the whole hardware configuration in the command line?

=20

Pavel Dovgalyuk

=20

From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
Sent: Tuesday, February 13, 2018 8:58 AM
To: Pavel Dovgalyuk
Cc: Pavel Dovgalyuk; qemu-devel@nongnu.org; kwolf@redhat.com; Peter =
Maydell; war2jordan@live.com; Igor R; quintela@redhat.com; =
jasowang@redhat.com; mst@redhat.com; Aleksandr Bezzubikov; =
maria.klimushenkova@ispras.ru; kraxel@redhat.com; Thomas Dullien; =
pbonzini@redhat.com; Alex Benn=C3=A9e
Subject: Re: [RFC PATCH v6 00/20] replay additions

=20

=20

=20

On Mon, Feb 12, 2018 at 5:47 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:

I tested ARM only with =E2=80=93kernel and =E2=80=93initrd.

Can you provide the full command line and the disk image?

=20

=20

The command I tried was:

=20

time ./buildroot/output.arm~/host/usr/bin/qemu-system-arm -M versatilepb =
-append 'root=3D/dev/sda nokaslr norandmaps printk.devkmsg=3Don =
printk.time=3Dy - lkmc_eval=3D"/rand_check.out;wget -S =
google.com;/poweroff.out;"' -kernel =
./buildroot/output.arm~/images/zImage -dtb =
./buildroot/output.arm~/images/versatile-pb.dtb -nographic -drive =
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,id=3Dimg-dire=
ct,format=3Draw -drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay =
-device scsi-hd,drive=3Dimg-blkreplay -netdev user,id=3Dnet1 -device =
rtl8139,netdev=3Dnet1 -object filter-replay,id=3Dreplay,netdev=3Dnet1=20

=20

and the required files can be downloaded from:

=20

https://github.com/cirosantilli/linux-kernel-module-cheat/releases/downlo=
ad/test-replay-arm/images.zip

=20

They were generated with:

=20

./build -a arm

=20

on that repo.

=20

=20

Pavel Dovgalyuk

=20

From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
Sent: Saturday, February 10, 2018 3:09 AM
To: Pavel Dovgalyuk
Cc: Pavel Dovgalyuk; qemu-devel@nongnu.org; kwolf@redhat.com; Peter =
Maydell; war2jordan@live.com; Igor R; quintela@redhat.com; =
jasowang@redhat.com; mst@redhat.com; Aleksandr Bezzubikov; =
maria.klimushenkova@ispras.ru; kraxel@redhat.com; Thomas Dullien; =
pbonzini@redhat.com; Alex Benn=C3=A9e
Subject: Re: [RFC PATCH v6 00/20] replay additions

=20

Also, what command do you use to test on ARM? I'm a bit stuck to get the =
drive part right, e.g.:

=20

-drive =
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,id=3Dimg-dire=
ct,format=3Draw \

-drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay \

-device scsi-hd,drive=3Dimg-blkreplay \

=20

fails with: qemu-system-arm: -device scsi-hd,drive=3Dimg-blkreplay: =
Conflicts with use by img-direct as 'root', which does not allow 'write' =
on #block968

=20

=20
