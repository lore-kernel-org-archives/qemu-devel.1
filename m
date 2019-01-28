Received: from eggs.gnu.org ([209.51.188.92]:43483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1go5nM-0007X9-OZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1go5nK-0004KG-Qg
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:13:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1go5nK-0004Jb-4J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:13:42 -0500
Date: Mon, 28 Jan 2019 12:13:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190128121331.GB2939@work-vm>
References: <RO1P152MB1483190501127990FEBFCE9A97940@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <RO1P152MB1483190501127990FEBFCE9A97940@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Crash when booting KDE Neon using qxl-vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonardo Soares =?iso-8859-1?Q?M=FCller?= <leozinho29_eu@hotmail.com>, kraxel@redhat.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Leonardo Soares M=FCller (leozinho29_eu@hotmail.com) wrote:
> With QEMU version 3.1.50 (v3.1.0-1218-gad7a21e812-dirty) (commit
> ad7a21e81231ae64540310384fb0f87ac8758b02) on Xubuntu 18.04 host, a KDE
> Neon guest is crashing on boot. The QEMU command line is:
>=20
> gdb -q -ex "set pagination off" -ex "set print thread-events off" -ex
> "handle SIGUSR1 nostop nopass noprint" -ex "run" --args
> qemu-system-x86_64 -accel kvm -cpu host -smp cores=3D2,threads=3D1 -m 2=
048
> -hda neonbroken.qcow2 -cdrom
> ~/Downloads/neon-useredition-20190124-0530-amd64.iso -device
> qxl-vga,xres=3D1366,yres=3D768,addr=3D2 -display gtk,gl=3Don -monitor v=
c -serial
> vc -device qemu-xhci,addr=3D3 -netdev user,id=3Dnet0 -device
> e1000,netdev=3Dnet0,addr=3D4 -bios /usr/share/ovmf/OVMF.fd
>=20
> The crash is happening pretty frequently but not 100% of the times.
> Using virtio-vga instead of qxl-vga it's possible to use the guest
> normally. Before the crash there are some graphical artifacts on guest
> screen, they can be seen at https://i.imgur.com/rfTmmJ0.png
>=20
> On terminal QEMU prints the following messages:
>=20
> $ qemu-system-x86_64 -accel kvm -cpu host -smp cores=3D2,threads=3D1 -m=
 2048
> -hda neonbroken.qcow2 -cdrom
> ~/Downloads/neon-useredition-20190124-0530-amd64.iso -device
> qxl-vga,xres=3D1366,yres=3D768,addr=3D2 -display gtk,gl=3Don -monitor v=
c -serial
> vc -device qemu-xhci,addr=3D3 -netdev user,id=3Dnet0 -device
> e1000,netdev=3Dnet0,addr=3D4 -bios /usr/share/ovmf/OVMF.fd
>=20
> (qemu-system-x86_64:11683): Gtk-WARNING **: 18:18:34.797: Theme parsing
> error: gtk.css:47:15: negative values are not allowed.
> id 0, group 0, virt start 0, virt end ffffffffffffffff, generation 0,
> delta 0
> id 1, group 1, virt start 7ff31fe00000, virt end 7ff323dfe000,
> generation 0, delta 7ff31fe00000
> id 2, group 1, virt start 7ff31bc00000, virt end 7ff31fc00000,
> generation 0, delta 7ff31bc00000
>=20
> (qemu:11683): Spice-CRITICAL **: 18:39:40.747:
> memslot.c:111:memslot_get_virt: slot_id 255 too big, addr=3Dff000000ff0=
00000

Thanks for the report,

Could you install the debug packages of libspice-server on your system
so that the backtrace you get has symbols?

Dave

> Abortado (imagem do n=FAcleo gravada)
>=20
> Here is the backtrace:
>=20
> (gdb) bt
> #0  0x00007ffff0373e97 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:51
> #1  0x00007ffff0375801 in __GI_abort () at abort.c:79
> #2  0x00007ffff1171cc9 in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #3  0x00007ffff11373b8 in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #4  0x00007ffff11407d0 in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #5  0x00007ffff1140a76 in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #6  0x00007ffff11419a1 in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #7  0x00007ffff11543cd in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #8  0x00007ffff1152d21 in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #9  0x00007ffff11534bf in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #10 0x00007ffff11214f1 in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #11 0x00007ffff1127d7b in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #12 0x00007ffff47931f5 in g_main_context_dispatch () at
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #13 0x00007ffff47935c0 in  () at /usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0
> #14 0x00007ffff47938d2 in g_main_loop_run () at
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #15 0x00007ffff1153b3a in  () at
> /usr/lib/x86_64-linux-gnu/libspice-server.so.1
> #16 0x00007ffff072d6db in start_thread (arg=3D0x7fff3602c700) at
> pthread_create.c:463
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
