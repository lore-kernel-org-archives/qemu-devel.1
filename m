Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g00I0-0007ef-PX
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g00Hv-0004xW-Nw
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:14:20 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55268)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g00Hv-0004xH-EH
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:14:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 12 Sep 2018 11:14:13 +0300
From: dovgaluk <dovgaluk@ispras.ru>
In-Reply-To: <CAFXrp_dgDh+YG2_3rF9sqWr4Tr15Mc7yip=0rQzAYGTcOeyMOw@mail.gmail.com>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<CAFXrp_dgDh+YG2_3rF9sqWr4Tr15Mc7yip=0rQzAYGTcOeyMOw@mail.gmail.com>
Message-ID: <0dd4092203876a1e5bf586e837bf760e@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/24] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ciro Santilli <ciro.santilli@gmail.com>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi, Ciro!

I found several issues in your command lines.

Ciro Santilli =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-08-08 02:13:
> OK, finally got some time to try it out, I'm using
> c42634d8e3428cfa60672c3ba89cabefc720cde9 from rr-180725.
>=20
> Replay works well as far as I can tell, so I moved to the reverse
> debugging:
>=20
> /home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/build=
/host-qemu-custom.rr/x86_64-softmmu/qemu-system-x86_64
> \
> -M pc \
> -append 'root=3D/dev/sda nopat console_msg_format=3Dsyslog nokaslr
> norandmaps printk.devkmsg=3Don printk.time=3Dy console=3DttyS0 -
> lkmc_eval_base64=3D"L3JhbmRfY2hlY2sub3V0Oy9wb3dlcm9mZi5vdXQ7"' \
> -kernel
> '/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/buil=
d/linux-custom.default/arch/x86/boot/bzImage'
> \
> -m '256M' \
> -monitor 'telnet::45454,server,nowait' \
> -nographic \
> -serial mon:stdio \
> -smp '1' \
> \
> -drive
> 'file=3D/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildro=
ot/images/rootfs.ext2.qcow2,format=3Dqcow2,if=3Dnone,id=3Dimg-direct'

You'll probably need an overlay, it you want this file to be unchanged=20
by VM.

Can you also provide this file for testing? I found only bzImage.

> \
> -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkrepl=
ay \
> -device ide-hd,drive=3Dimg-blkreplay \
> \
> -object filter-replay,id=3Dreplay,netdev=3Dnet0 \
> -device rtl8139,netdev=3Dnet0 \
> -netdev
> 'user,hostfwd=3Dtcp::45455-:45455,hostfwd=3Dtcp::45456-:22,id=3Dnet0' \
> \
> -icount
> 'shift=3D7,rr=3Drecord,rrfile=3D/home/ciro/bak/git/linux-kernel-module-=
cheat/out/x86_64/qemu/0/rrfile'

You need to specify rrsnapshot=3D<name> option for creating the initial V=
M=20
snapshot.
This option creates snapshot at record and loads it at replay. GDB can=20
also use this snapshot for reverse execution.

> \
>=20
> and replay with:
>=20
> -icount
> 'shift=3D7,rr=3Dreplay,rrfile=3D/home/ciro/bak/git/linux-kernel-module-=
cheat/out/x86_64/qemu/0/rrfile'
> \
> -gdb 'tcp::45457' \
> -S \
>=20
> Then, I do
>=20
> /home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/=
usr/bin/x86_64-linux-gdb
> \
>  -q \
> -ex 'add-auto-load-safe-path
> /home/ciro/bak/git/linux-kernel-module-cheat' \
> -ex 'file vmlinux' \
> -ex 'target remote localhost:45457' \
> -ex 'break start_kernel' \
>   -ex continue \
> -ex 'lx-symbols ../kernel_module-1.0/' \
>=20
> Then in GDB:
>=20
> n
> n
> n
> n
> reverse-continue
>=20
> expecting it to return me to start_kernel, but instead it left me in
> the same place that I'm at.

Right, because there were no checkpoints. The initial one must be=20
created at recording phase.



Pavel Dovgalyuk
