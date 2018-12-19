Received: from eggs.gnu.org ([2001:4830:134:3::10]:46253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gZREl-0005Ws-WC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 21:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gZREi-0006Ao-Qt
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 21:05:27 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2747 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1gZREi-00067C-Dy
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 21:05:24 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 19 Dec 2018 02:05:11 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB1D65E6@dggeml531-mbs.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] About live migration rollback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>

Hi Dave,

We discussed some live migration fallback scenarios in this year's KVM foru=
m,=20
and now I can provide another scenario, perhaps the upstream should conside=
r rolling
back for this situation.

Environments information:

host A: cpu E5620(model WestmereEP without flag xsave)
host B: cpu E5-2643(model SandyBridgeEP with flag xsave)

The reproduce steps is :
1. Start a windows 2008 vm with -cpu host(which means host-passthrough).
2. Migrate the vm to host B when cr4.OSXSAVE=3D0.
3. Vm runs on host B for a while so that cr4.OSXSAVE changes to 1.
4. Then migrate the vm to host A successfully, but vm was paused, and qemu =
printed log as followed:

KVM: entry failed, hardware error 0x80000021

If you're running a guest on an Intel machine without unrestricted mode
support, the failure can be most likely due to the guest entering an invali=
d
state for Intel VT. For example, the guest maybe running in big real mode
which is not supported on less recent Intel processors.

EAX=3D019b3bb0 EBX=3D01a3ae80 ECX=3D01a61ce8 EDX=3D00000000
ESI=3D01a62000 EDI=3D00000000 EBP=3D00000000 ESP=3D01718b20
EIP=3D0185d982 EFL=3D00000286 [--S--P-] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00

Problem happened when kvm_put_sregs returns err -22(called by kvm_arch_put_=
registers(qemu)).

Because kvm_arch_vcpu_ioctl_set_sregs(kvm module) checked that=20
guest_cpuid_has no X86_FEATURE_XSAVE but cr4.OSXSAVE=3D1.
We should cancel migration if kvm_arch_put_registers returns error.

Thanks,
-Gonglei
