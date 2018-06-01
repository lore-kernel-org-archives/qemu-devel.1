Received: from eggs.gnu.org ([2001:4830:134:3::10]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhDG-0004wQ-1j
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOhDC-0003PU-P7
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:23:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fOhDC-0003PF-Iw
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:23:10 -0400
Date: Fri, 1 Jun 2018 12:23:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180601122307.3e6ade66@redhat.com>
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xuyandong <xuyandong2@huawei.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, 1 Jun 2018 08:17:12 +0000
xuyandong <xuyandong2@huawei.com> wrote:

> Hi there,
> 
> I am doing some test on qemu vcpu hotplug and I run into some trouble.
> An emulation failure occurs and qemu prints the following msg:
> 
> KVM internal error. Suberror: 1
> emulation failure
> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000600
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=0000fff8
> EIP=0000ff53 EFL=00010082 [--S----] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 00000000 0000ffff 00009300
> CS =f000 000f0000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00if
> GDT=     00000000 0000ffff
> IDT=     00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=31 d2 eb 04 66 83 ca ff 66 89 d0 66 5b 66 c3 66 89 d0 66 c3 <cf> 66 68 21 8a 00 00 e9 08 d7 66 56 66 53 66 83 ec 0c 66 89 c3 66 e8 ce 7b ff ff 66 89 c6
> 
> I notice that guest is still running SeabBIOS in real mode when the vcpu has just been pluged.
> This emulation failure can be steadly reproduced if I am doing vcpu hotplug during VM launch process.
> After some digging, I find this KVM internal error shows up because KVM cannot emulate some MMIO (gpa 0xfff53 ).
> 
> So I am confused,
> (1) does qemu support vcpu hotplug even if guest is running seabios ?
There is no code that forbids it, and I would expect it not to trigger error
and be NOP.

> (2) the gpa (0xfff53) is an address of BIOS ROM section, why does kvm confirm it as a mmio address incorrectly?
KVM trace and bios debug log might give more information to guess where to look
or even better would be to debug Seabios and find out what exactly
goes wrong if you could do it.
