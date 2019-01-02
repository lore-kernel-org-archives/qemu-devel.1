Received: from eggs.gnu.org ([208.118.235.92]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1geeiu-00009k-FH
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1geeip-0007Yz-Ni
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:30:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1geeip-0007Wy-GN
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:30:03 -0500
Date: Wed, 2 Jan 2019 11:29:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190102112953.GC2446@work-vm>
References: <33183CC9F5247A488A2544077AF19020DB1D65E6@dggeml531-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB1D65E6@dggeml531-mbs.china.huawei.com>
Subject: Re: [Qemu-devel] About live migration rollback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Juan Quintela <quintela@redhat.com>, "pbonzini@redhat.com peterx@redhat.com" <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>

* Gonglei (Arei) (arei.gonglei@huawei.com) wrote:
> Hi Dave,
> 
> We discussed some live migration fallback scenarios in this year's KVM forum, 
> and now I can provide another scenario, perhaps the upstream should consider rolling
> back for this situation.
> 
> Environments information:
> 
> host A: cpu E5620(model WestmereEP without flag xsave)
> host B: cpu E5-2643(model SandyBridgeEP with flag xsave)
> 
> The reproduce steps is :
> 1. Start a windows 2008 vm with -cpu host(which means host-passthrough).

Well we don't guarantee migration across -cpu host - does this problem
go away if both qemu's are started with matching CPU flags
(corresponding to the Westmere) ?

> 2. Migrate the vm to host B when cr4.OSXSAVE=0.
> 3. Vm runs on host B for a while so that cr4.OSXSAVE changes to 1.
> 4. Then migrate the vm to host A successfully, but vm was paused, and qemu printed log as followed:
> 
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
> Problem happened when kvm_put_sregs returns err -22(called by kvm_arch_put_registers(qemu)).
> 
> Because kvm_arch_vcpu_ioctl_set_sregs(kvm module) checked that 
> guest_cpuid_has no X86_FEATURE_XSAVE but cr4.OSXSAVE=1.
> We should cancel migration if kvm_arch_put_registers returns error.

Do you have a backtrace of when the kvm_arch_put_registers is called
when it fails?
If it's called during the loading of the device state then we should be
able to detect it and fail the migration; however if it's only failing
after the CPU is restarted after the migration then it's a bit too late.

Dave

> Thanks,
> -Gonglei
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
