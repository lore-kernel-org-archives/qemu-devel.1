Received: from eggs.gnu.org ([2001:4830:134:3::10]:54578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cFGE5-0006NA-FT
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 03:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cFGDz-0006og-Lu
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 03:08:17 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1cFGDz-0006o7-DT
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 03:08:11 -0500
Date: Fri, 9 Dec 2016 03:07:55 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1560317871.2551833.1481270875346.JavaMail.zimbra@redhat.com>
In-Reply-To: <CA+scX6ktntUQ3+0WF7xaEGBgCBzYdKB1KhWNXBJJUCJgcje4Bw@mail.gmail.com>
References: <CA+scX6ktntUQ3+0WF7xaEGBgCBzYdKB1KhWNXBJJUCJgcje4Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Timeslice of vCPU thread in QEMU/KVM is not stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org, mingo@redhat.com, efault@gmx.de, dmitry adamushko <dmitry.adamushko@gmail.com>, vatsa@linux.vnet.ibm.com, tglx@linutronix.de, pzijlstr@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org

Hello,

> 
> Hi everyone,
> 
> I am testing the timeslice of vCPU thread in QEMU/KVM. In principle,
> the timeslice should be stable under following workload but it is
> unstable after I do experiments with following workload. I appreciate
> it if you can give me some suggestions. Thanks in advance.
> 
> Workload settings:
> In VMM, there are 6 pCPUs which are pCPU0, pCPU1, pCPU2, pCPU3, pCPU4,
> pCPU5. There are two Kernel Virtual Machines (VM1 and VM2) upon VMM.
> In each VM, there are 5 vritual CPUs (vCPU0, vCPU1, vCPU2, vCPU3,
> vCPU4). vCPU0 in VM1 and vCPU0 in VM2 are pinned to pCPU0 and pCPU5
> separately to handle interrupts dedicatedly. vCPU1 in VM1 and vCPU1 in
> VM2 are pinned to pCPU1; vCPU2 in VM1 and vCPU2 in VM2 are pinned to
> pCPU2; vCPU3 in VM1 and vCPU3 in VM2 are pinned to pCPU3; vCPU4 in VM1
> and vCPU4 in VM2 are pinned to pCPU4. There is one CPU intensive
> thread (while(1){i++}) upon each vCPU in VM1 and VM2 to avoid the vCPU
> to be idle. In VM1, I start one I/O thread on vCPU2, which the I/O
> thread reads 4KB from disk each time (reads 8GB in total). The I/O
> scheduler in VM1 and VM2 is Noop. The I/O scheduler in VMM is CFQ.
> "/proc/sys/kernel/sched_min_granularity_ns" is set to be 100
> microseconds in VM1 and VM2. "/proc/sys/kernel/sched_latency_ns" is
> set to be 100 microseconds in VM1 and VM2.
> "/proc/sys/kernel/sched_wakeup_granularity_ns" is set to be 0
> microseconds in VM1 and VM2.
> "/proc/sys/kernel/sched_min_granularity_ns" is set to be 2.25
> milliseconds in VMM. "/proc/sys/kernel/sched_latency_ns" is set to be
> 18 milliseconds in VMM. "/proc/sys/kernel/sched_wakeup_granularity_ns"
> is set to be 0 microseconds in VMM. I also pinned the I/O worker
> threads started by QEMU to pCPU5. The process scheduling class I use
> is CFS.
> 
> Linux Kernel version for VMM is: 3.16.39
> Linux Kernel version for VM1 and VM2 is: 4.7.4
> QEMU emulator version is: 2.0.0
> 
> I test the timeslice of vCPU2 thread of VM1 in VMM according to above
> workload settings and the experiment shows that the timeslice is not
> stable. I also find that after the I/O thread on vCPU2 in VM1 is
> finished, the timeslice of vCPU2 thread of VM1 will be stable. From
> the experiment, it seems that the unstable timeslice of vCPU2 thread
> of VM1 is caused by the I/O thread on it in VM1. However, I think the
> I/O thread on vCPU2 in VM1 should not affect its timeslice since each
> vCPU in VM1 and VM2 has one CPU intensive thread (while(1){i++}).
> Please give me some suggestions if you have. Thank you.

I think you need to check what else is scheduling on pCPU2(physical cpu).
If you want to avoid any other task to be scheduled at pCPU2, you need
to isolate the pCPU2 core to avoid scheduler to run any other task on it.

> 
> Best,
> Harry
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
