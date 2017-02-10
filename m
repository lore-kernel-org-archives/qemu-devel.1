Received: from eggs.gnu.org ([2001:4830:134:3::10]:58510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cc7cZ-0000Jj-AM
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cc7cV-0001Zt-Ao
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:36:03 -0500
Received: from [45.249.212.189] (port=2389 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cc7bs-0001Cv-QB
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:35:59 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 10 Feb 2017 09:31:48 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
In-Reply-To: <AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, "vrozenfe@redhat.com" <vrozenfe@redhat.com>

Hi,

> Behalf Of Yan Vugenfirer
>=20
> Hi,
>=20
> First off all to use more than 64 CPUs on Windows you should use CPU grou=
ping.
> Each group can contain maximum 64 CPUs. Here is a good article explaining
> possible configurations:
> https://msdn.microsoft.com/en-us/windows/hardware/drivers/devtest/boot-p
> arameters-to-test-drivers-for-multiple-processor-group-support
> <https://msdn.microsoft.com/en-us/windows/hardware/drivers/devtest/boot-
> parameters-to-test-drivers-for-multiple-processor-group-support> and anot=
her
> one on the grouping subject:
> https://blogs.technet.microsoft.com/mlucas/2012/03/15/windows-server-and-
> processor-cores/
> <https://blogs.technet.microsoft.com/mlucas/2012/03/15/windows-server-an
> d-processor-cores/>
>=20
> Regarding the boot failure - it is quite possible that Windows cannot han=
dle
> more that 64 logical CPUs on one physical CPU.
>=20

Thanks for your reply. :)

But We tested the same cases on Xen platform and VMware, and
the guest booted successfully.

Today I also tested on tcg, the guest also boots successfully.

BTW, if we disable hyper-v, there isn't problem on boot for the case.

QEMU command line (enable hyper-v with hv_relaxed):

# ./qemu-system-x86_64 -name win2012 -machine accel=3Dkvm,usb=3Doff -cpu qe=
mu64,hv_relaxed -m 4001 -realtime mlock=3Doff -smp 68,sockets=3D1,cores=3D6=
8,threads=3D1 \
-drive file=3D/mnt/sdb/gonglei/win2012_r2_dc_64_raw,if=3Dnone,id=3Ddrive-id=
e0-0-0 -device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0=
-0-0,bootindex=3D1 \
-boot menu=3Don -device piix3-usb-uhci,id=3Duhci -chardev file,id=3Dseabios=
,path=3D/home/seabios.log -device isa-debugcon,iobase=3D0x402,chardev=3Dsea=
bios \
-monitor stdio -device cirrus-vga,id=3Dvideo0,vgamem_mb=3D16 -vnc 0.0.0.0:1=
0

So, I think it's possible a KVM bug on Hyper-V enlightenments support.=20

Any help will be appreciated!

CC'ing Paolo, Radim and Vadim.

Thanks,
-Gonglei

> Best regards,
> Yan.
> > On 9 Feb 2017, at 08:18, hangaohuai <hangaohuai@huawei.com> wrote:
> >
> > Dear all:
> > I try to boot windows2012R2 (more than 64 cores)on kvm platform with
> hyper-v on*<relaxed state=3D'on'/>*.
> > the guest halts on the starting time.
> > Also tested in these cases:
> > <topology sockets=3D'64' cores=3D'1' threads=3D'1'/>  - boot sucess
> > <topology sockets=3D'1' cores=3D'64' threads=3D'1'/>  - boot sucess
> > <topology sockets=3D'1' cores=3D'1' threads=3D'64'/>  - boot sucess
> > <topology sockets=3D'1' cores=3D'68' threads=3D'1'/>  - boot failed
> > <topology sockets=3D'68' cores=3D'1' threads=3D'1'/>  - boot sucess(in =
Guest we
> can found 64)
> > <topology sockets=3D'1' cores=3D'1' threads=3D'68'/>  - boot failed
> >
> > Environment:
> > GUEST:
> >  windows2012R2
> > HOST:
> >    kernel version:4.10.0-rc4
> >    QEMU version:QEMU emulator version 2.8.50
> (v2.8.0-664-gd1c82f7-dirty)
> > part of GuestXML:
> >  <vcpu placement=3D'static'>68</vcpu>
> >  <resource>
> >    <partition>/machine</partition>
> >  </resource>
> >  <os>
> >    <type arch=3D'x86_64' machine=3D'pc-i440fx-2.3'>hvm</type>
> >    <boot dev=3D'hd'/>
> >  </os>
> >  <features>
> >    <acpi/>
> >    <apic/>
> >    <pae/>
> >    <hyperv>
> >      <relaxed state=3D'on'/>
> >    </hyperv>
> >  </features>
> >  <cpu>
> >    <topology sockets=3D'1' cores=3D'68' threads=3D'1'/>
> >  </cpu>
> >
> > //////////////////////////////////
> > debug info:
> > virsh qemu-monitor-command win2012 --hmp "info cpus"
> >  CPU #61: pc=3D0xfffff8031296a21c thread_id=3D21410
> >  CPU #62: pc=3D0xfffff8031296a21c thread_id=3D21411
> >  CPU #63: pc=3D0xfffff8031296a21c thread_id=3D21414
> >  CPU #64: pc=3D0x00000000000fd31c (halted) thread_id=3D21415
> >  CPU #65: pc=3D0x00000000000fd31c (halted) thread_id=3D21416
> >  CPU #66: pc=3D0x00000000000fd31c (halted) thread_id=3D21417
> >  CPU #67: pc=3D0x00000000000fd31c (halted) thread_id=3D21418
> >
> >
> > Any suggestions?
> >
> > Thanks a lot.
> >
> > Gaohuai Han
> >
> >
