Received: from eggs.gnu.org ([209.51.188.92]:45658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpZ01-0004SL-Gw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpYzz-0008OC-9e
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:36:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gpYzx-0008Mc-8l
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:36:51 -0500
Date: Fri, 1 Feb 2019 13:36:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190201133639.GE3150@work-vm>
References: <RO1P152MB1483190501127990FEBFCE9A97940@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190128121331.GB2939@work-vm>
	<RO1P152MB1483C38DCFD740BD8982F39597960@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190128173536.GE2585@work-vm>
	<RO1P152MB14834BE5D9747719CD493C5297960@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <RO1P152MB14834BE5D9747719CD493C5297960@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
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
To: Leonardo Soares =?iso-8859-1?Q?M=FCller?= <leozinho29_eu@hotmail.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Leonardo Soares M=FCller (leozinho29_eu@hotmail.com) wrote:
> libspice-server1 on host: 0.14.0-1ubuntu2.2
> spice-vdagent (the only package) on guest: 0.17.0-1ubuntu2
> Guest kernel version: 4.15.0-44-generic

Hmm, I'm also getting a crash, but I think it's very different from
yours:

./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=3Dkvm -smp 3 -m 8G -cdrom=
 /home/vmimages/neon-useredition-current.iso -drive if=3Dvirtio,file=3D/h=
ome/vmimages/kde-neon.qcow2 -vga qxl

kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device
Aborted (core dumped)

#2  0x0000555555893ee6 in kvm_mem_ioeventfd_add (listener=3D<optimized ou=
t>, section=3D0x7fffdbffb9d0, match_data=3D<optimized out>, data=3D0, e=3D=
<optimized out>)
    at /home/dgilbert/git/qemu/accel/kvm/kvm-all.c:866
#3  0x000055555588123d in address_space_add_del_ioeventfds
    (fds_old_nb=3D0, fds_old=3D0x0, fds_new_nb=3D1, fds_new=3D0x7fffd0944=
570, as=3D0x5555563bbea0 <address_space_memory>) at /home/dgilbert/git/qe=
mu/memory.c:793
#4  0x000055555588123d in address_space_update_ioeventfds (as=3Das@entry=3D=
0x5555563bbea0 <address_space_memory>) at /home/dgilbert/git/qemu/memory.=
c:843
#5  0x00005555558816c8 in memory_region_transaction_commit () at /home/dg=
ilbert/git/qemu/memory.c:1087
#6  0x00005555558816c8 in memory_region_transaction_commit () at /home/dg=
ilbert/git/qemu/memory.c:1071
#7  0x0000555555aab425 in pci_update_mappings (d=3Dd@entry=3D0x555557617c=
e0) at /home/dgilbert/git/qemu/hw/pci/pci.c:1357
#8  0x0000555555aaba89 in pci_default_write_config (d=3Dd@entry=3D0x55555=
7617ce0, addr=3Daddr@entry=3D4, val_in=3D263, l=3Dl@entry=3D2)
    at /home/dgilbert/git/qemu/hw/pci/pci.c:1413
#9  0x0000555555b216c1 in virtio_write_config (pci_dev=3D0x555557617ce0, =
address=3D4, val=3D<optimized out>, len=3D2)
    at /home/dgilbert/git/qemu/hw/virtio/virtio-pci.c:598
#10 0x0000555555ab26bf in pci_host_config_write_common (pci_dev=3D0x55555=
7617ce0, addr=3D4, limit=3D<optimized out>, val=3D263, len=3D2)
    at /home/dgilbert/git/qemu/hw/pci/pci_host.c:87
#11 0x000055555587f721 in memory_region_write_accessor
    (mr=3D0x555556a0bf80, addr=3D0, value=3D<optimized out>, size=3D2, sh=
ift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...)
    at /home/dgilbert/git/qemu/memory.c:502
#12 0x000055555587d276 in access_with_adjusted_size
    (addr=3Daddr@entry=3D0, value=3Dvalue@entry=3D0x7fffdbffbce8, size=3D=
size@entry=3D2, access_size_min=3D<optimized out>, access_size_max=3D<opt=
imized out>, access_fn=3Daccess_fn@entry=3D0x55555587f6a0 <memory_region_=
write_accessor>, mr=3D0x555556a0bf80, attrs=3D...) at /home/dgilbert/git/=
qemu/memory.c:568
#13 0x0000555555881bfc in memory_region_dispatch_write (mr=3Dmr@entry=3D0=
x555556a0bf80, addr=3D0, data=3D<optimized out>, size=3D2, attrs=3Dattrs@=
entry=3D...)
    at /home/dgilbert/git/qemu/memory.c:1499
#14 0x0000555555828923 in flatview_write_continue
    (fv=3Dfv@entry=3D0x7fffd0847c00, addr=3Daddr@entry=3D3324, attrs=3D..=
., buf=3Dbuf@entry=3D0x7ffff7fc5000 "\a\001", len=3Dlen@entry=3D2, addr1=3D=
<optimized out>, l=3D<optimized out>, mr=3D0x555556a0bf80) at /home/dgilb=
ert/git/qemu/exec.c:3247
#15 0x0000555555828b49 in flatview_write (fv=3D0x7fffd0847c00, addr=3D332=
4, attrs=3D..., buf=3D0x7ffff7fc5000 "\a\001", len=3D2)
    at /home/dgilbert/git/qemu/exec.c:3286
#16 0x000055555582cc7f in address_space_write (as=3D<optimized out>, addr=
=3Daddr@entry=3D3324, attrs=3D..., buf=3D<optimized out>, len=3Dlen@entry=
=3D2)
    at /home/dgilbert/git/qemu/exec.c:3376
#17 0x000055555582cd0a in address_space_rw (as=3D<optimized out>, addr=3D=
addr@entry=3D3324, attrs=3D...,=20
    attrs@entry=3D..., buf=3D<optimized out>, len=3Dlen@entry=3D2, is_wri=
te=3Dis_write@entry=3Dtrue) at /home/dgilbert/git/qemu/exec.c:3387
#18 0x0000555555894e45 in kvm_handle_io (count=3D1, size=3D2, direction=3D=
<optimized out>, data=3D<optimized out>, attrs=3D..., port=3D3324)
    at /home/dgilbert/git/qemu/accel/kvm/kvm-all.c:1775
#19 0x0000555555894e45 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55555670f6f0)=
 at /home/dgilbert/git/qemu/accel/kvm/kvm-all.c:2021
#20 0x000055555586a6be in qemu_kvm_cpu_thread_fn (arg=3D0x55555670f6f0) a=
t /home/dgilbert/git/qemu/cpus.c:1281
#21 0x000055555586a6be in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x555=
55670f6f0) at /home/dgilbert/git/qemu/cpus.c:1254
#22 0x0000555555ca0e7a in qemu_thread_start (args=3D<optimized out>) at /=
home/dgilbert/git/qemu/util/qemu-thread-posix.c:502
#23 0x00007ffff536258e in start_thread () at /lib64/libpthread.so.0

(gdb) p section->offset_within_address_space
$3 =3D 4273991680
(gdb) p/x section->offset_within_address_space
$4 =3D 0xfebff000
(gdb) p section
$5 =3D (MemoryRegionSection *) 0x7fffdbffb9d0
(gdb) p *section
$6 =3D {mr =3D 0x0, fv =3D 0x7fffd08fe680, offset_within_region =3D 0, si=
ze =3D 0, offset_within_address_space =3D 4273991680, readonly =3D false,=
 nonvolatile =3D false}

Dave

> >=20
> > OK, great;  can can you confirm the version of the spice packages
> > on both the guest and host, and the kernel on the guest.
> >=20
> > Dave
> >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
