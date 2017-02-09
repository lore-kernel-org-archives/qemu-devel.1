Received: from eggs.gnu.org ([2001:4830:134:3::10]:50423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1cbnfJ-0002oN-HW
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1cbnfF-0004Qy-Oz
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:17:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1cbnfF-0004Qr-GA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:17:29 -0500
From: Yan Vugenfirer <yvugenfi@redhat.com>
Message-Id: <AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 9 Feb 2017 14:17:23 +0200
In-Reply-To: <589C099A.9090605@huawei.com>
References: <589C099A.9090605@huawei.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hangaohuai <hangaohuai@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

Hi,

First off all to use more than 64 CPUs on Windows you should use CPU =
grouping. Each group can contain maximum 64 CPUs. Here is a good article =
explaining possible configurations:
=
https://msdn.microsoft.com/en-us/windows/hardware/drivers/devtest/boot-par=
ameters-to-test-drivers-for-multiple-processor-group-support =
<https://msdn.microsoft.com/en-us/windows/hardware/drivers/devtest/boot-pa=
rameters-to-test-drivers-for-multiple-processor-group-support> and =
another one on the grouping subject: =
https://blogs.technet.microsoft.com/mlucas/2012/03/15/windows-server-and-p=
rocessor-cores/ =
<https://blogs.technet.microsoft.com/mlucas/2012/03/15/windows-server-and-=
processor-cores/>

Regarding the boot failure - it is quite possible that Windows cannot =
handle more that 64 logical CPUs on one physical CPU.=20

Best regards,
Yan.
> On 9 Feb 2017, at 08:18, hangaohuai <hangaohuai@huawei.com> wrote:
>=20
> Dear all:
> I try to boot windows2012R2 (more than 64 cores)on kvm platform with =
hyper-v on*<relaxed state=3D'on'/>*.
> the guest halts on the starting time.
> Also tested in these cases:
> <topology sockets=3D'64' cores=3D'1' threads=3D'1'/>  - boot sucess
> <topology sockets=3D'1' cores=3D'64' threads=3D'1'/>  - boot sucess
> <topology sockets=3D'1' cores=3D'1' threads=3D'64'/>  - boot sucess
> <topology sockets=3D'1' cores=3D'68' threads=3D'1'/>  - boot failed
> <topology sockets=3D'68' cores=3D'1' threads=3D'1'/>  - boot sucess(in =
Guest we can found 64)
> <topology sockets=3D'1' cores=3D'1' threads=3D'68'/>  - boot failed
>=20
> Environment:
> GUEST:
>  windows2012R2
> HOST:
>    kernel version:4.10.0-rc4
>    QEMU version:QEMU emulator version 2.8.50 =
(v2.8.0-664-gd1c82f7-dirty)
> part of GuestXML:
>  <vcpu placement=3D'static'>68</vcpu>
>  <resource>
>    <partition>/machine</partition>
>  </resource>
>  <os>
>    <type arch=3D'x86_64' machine=3D'pc-i440fx-2.3'>hvm</type>
>    <boot dev=3D'hd'/>
>  </os>
>  <features>
>    <acpi/>
>    <apic/>
>    <pae/>
>    <hyperv>
>      <relaxed state=3D'on'/>
>    </hyperv>
>  </features>
>  <cpu>
>    <topology sockets=3D'1' cores=3D'68' threads=3D'1'/>
>  </cpu>
>=20
> //////////////////////////////////
> debug info:
> virsh qemu-monitor-command win2012 --hmp "info cpus"
>  CPU #61: pc=3D0xfffff8031296a21c thread_id=3D21410
>  CPU #62: pc=3D0xfffff8031296a21c thread_id=3D21411
>  CPU #63: pc=3D0xfffff8031296a21c thread_id=3D21414
>  CPU #64: pc=3D0x00000000000fd31c (halted) thread_id=3D21415
>  CPU #65: pc=3D0x00000000000fd31c (halted) thread_id=3D21416
>  CPU #66: pc=3D0x00000000000fd31c (halted) thread_id=3D21417
>  CPU #67: pc=3D0x00000000000fd31c (halted) thread_id=3D21418
>=20
>=20
> Any suggestions?
>=20
> Thanks a lot.
>=20
> Gaohuai Han
>=20
>=20
