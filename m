Received: from eggs.gnu.org ([2001:4830:134:3::10]:40829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6bTu-0004vc-KD
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6bTq-0006cM-85
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:37:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6bTq-0006Ys-1w
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:37:34 -0400
Date: Thu, 12 Apr 2018 13:37:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180412123718.GA2712@work-vm>
References: <D9DE8DBB19F2A24080482022C1DE758302C69E5E@dggemm509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302C69E5E@dggemm509-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] [Bug Report] vm paused after succeeding to migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, pbonzini@redhat.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "quintela@redhat.com" <quintela@redhat.com>

* linzhecheng (linzhecheng@huawei.com) wrote:
> Hi, all
> I encounterd a bug when I try to migrate a windows vm.
> 
> Enviroment information:
> host A: cpu E5620(model WestmereEP without flag xsave)
> host B: cpu E5-2643(model SandyBridgeEP with xsave)
> 
> The reproduce steps is :
> 1. Start a windows 2008 vm with -cpu host(which means host-passthrough).
> 2. Migrate the vm to host B when cr4.OSXSAVE=0 (successfully).
> 3. Vm runs on host B for a while so that cr4.OSXSAVE changes to 1.
> 4. Then migrate the vm to host A (successfully), but vm was paused, and qemu printed log as followed:

Remember that migrating using -cpu host  across different CPU models is NOT
expected to work.

> KVM: entry failed, hardware error 0x80000021
> 
> If you're running a guest on an Intel machine without unrestricted mode
> support, the failure can be most likely due to the guest entering an invalid
> state for Intel VT. For example, the guest maybe running in big real mode
> which is not supported on less recent Intel processors.
> 
> EAX=019b3bb0 EBX=01a3ae80 ECX=01a61ce8 EDX=00000000
> ESI=01a62000 EDI=00000000 EBP=00000000 ESP=01718b20
> EIP=0185d982 EFL=00000286 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 00000000 0000ffff 00009300
> CS =f000 ffff0000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00
> GDT=     00000000 0000ffff
> IDT=     00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> I have found that problem happened when kvm_put_sregs returns err -22(called by kvm_arch_put_registers(qemu)).
> Because kvm_arch_vcpu_ioctl_set_sregs(kvm-mod) checked that guest_cpuid_has no X86_FEATURE_XSAVE but cr4.OSXSAVE=1.
> So should we cancel migration when kvm_arch_put_registers returns error?

It would seem good if we can make the migration fail there rather than
hitting that KVM error.
It looks like we need to do a bit of plumbing to convert the places that
call it to return a bool rather than void.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
