Received: from eggs.gnu.org ([209.51.188.92]:39119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nuxi@vault24.org>) id 1gnDKR-0004ZF-LY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 21:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nuxi@vault24.org>) id 1gnDKQ-0003Hj-Lr
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 21:04:15 -0500
Received: from pinero.vault24.org ([2600:3c03::f03c:91ff:fe96:b31a]:43562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nuxi@vault24.org>) id 1gnDKQ-0003EZ-Gi
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 21:04:14 -0500
Date: Fri, 25 Jan 2019 21:04:10 -0500
From: Jon DeVree <nuxi@vault24.org>
Message-ID: <20190126020410.GB3796@feynman.vault24.org>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
	<20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
	<20190102202032.GA1034@eldamar.local>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
	<20190103234339.GA17457@nautica>
	<CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
	<20190107234839.GA15269@nautica>
	<CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v15 23/26] sched: early boot clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Salvatore Bonaccorso <carnil@debian.org>, Steven Sistare <steven.sistare@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Mon, Jan 07, 2019 at 20:04:41 -0500, Pavel Tatashin wrote:
> I did exactly the same sequence on Kaby Lake CPU and could not
> reproduce it. What is your host CPU?
> 

I have some machines which display this bug and others that don't, so I
was able to figure out the difference between their configurations.

TL;DR the bug appears to be based on wther or not
/sys/devices/system/clocksource/clocksource0/current_clocksource is set
to TSC in the hypervisor

This is the log from a machine with the bug:

[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 12 and 11
[1162908.013830] kvm-clock: cpu 0, msr 3e0fea001, primary cpu clock
[1162908.013830] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[1162908.013834] tsc: Detected 1899.888 MHz processor

This is the log from a machine without the bug:

[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 149fea001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 1558436482528906 cycles
[    0.000002] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004] tsc: Detected 2097.570 MHz processor

Note the additional line of output on the machine without the bug:

[    0.000000] kvm-clock: using sched offset of 1558436482528906 cycles

This is printed from kvm_sched_clock_init() in
arch/x86/kernel/kvmclock.c based on whether or not the clock is stable.
For the clock to be stable both KVM_FEATURE_CLOCKSOURCE_STABLE_BIT and
PVCLOCK_TSC_STABLE_BIT have to be set.  Both of these are controlled by
the hypervisor kernel.

* KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is always set by the hypervisor
  starting with Linux v2.6.35 - 371bcf646d17 ("KVM: x86: Tell the guest
  we'll warn it about tsc stability")
* PVCLOCK_TSC_STABLE_BIT is set starting in Linux v3.8 but only if the
  clocksource is the TSC - d828199e8444 ("KVM: x86: implement
  PVCLOCK_TSC_STABLE_BIT pvclock flag")

I changed the clocksource of a hypervisor that wasn't having issues from
TSC to HPET and when I started up a guest VM the bug suddenly appeared.
I shut down the guest, set the hypervisor's clocksource back to TSC,
started up the guest and the bug went away again.

You don't actually have to reboot the guest before the bug is visible
either, just letting the guest sit at the GRUB menu for a minute or two
before loading Linux is enough to make the bug plainly visible in the
printk timestamps.

I don't know enough to actually fix the bug, but hopefully this is
enough to allow everyone else to reproduce it and come up with a fix.

-- 
Jon
X(7): A program for managing terminal windows. See also screen(1) and tmux(1).
