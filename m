Received: from eggs.gnu.org ([2001:4830:134:3::10]:55550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1f6aQK-0001IV-51
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1f6aQG-0003wT-72
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:29:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2266 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1f6aQF-0003sp-K5
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:29:48 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 12 Apr 2018 11:29:09 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C69E5E@dggemm509-mbx.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [Bug Report] vm paused after succeeding to migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "quintela@redhat.com" <quintela@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

Hi, all
I encounterd a bug when I try to migrate a windows vm.

Enviroment information:
host A: cpu E5620(model WestmereEP without flag xsave)
host B: cpu E5-2643(model SandyBridgeEP with xsave)

The reproduce steps is :
1. Start a windows 2008 vm with -cpu host(which means host-passthrough).
2. Migrate the vm to host B when cr4.OSXSAVE=3D0 (successfully).
3. Vm runs on host B for a while so that cr4.OSXSAVE changes to 1.
4. Then migrate the vm to host A (successfully), but vm was paused, and qem=
u printed log as followed:

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

I have found that problem happened when kvm_put_sregs returns err -22(calle=
d by kvm_arch_put_registers(qemu)).
Because kvm_arch_vcpu_ioctl_set_sregs(kvm-mod) checked that guest_cpuid_has=
 no X86_FEATURE_XSAVE but cr4.OSXSAVE=3D1.
So should we cancel migration when kvm_arch_put_registers returns error?
