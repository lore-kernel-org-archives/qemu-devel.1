Received: from eggs.gnu.org ([2001:4830:134:3::10]:54754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d36hC-0002hJ-1M
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d36h7-0006Zb-13
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d36h6-0006Y6-Ql
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:04:16 -0400
Date: Tue, 25 Apr 2017 17:04:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170425200414.GP3482@thinpad.lan.raisama.net>
References: <20170419201314.GX25239@thinpad.lan.raisama.net>
	<CAJhHMCDpJhRoeGXRvPdqLD7zeVh_dmKX9wDcZcCSFwLj_+Cwkw@mail.gmail.com>
	<20170419205706.GY25239@thinpad.lan.raisama.net>
	<CAJhHMCBN8N27M7H4a3ayv6rezKoc9+UH5xPqE4Pu2MPYKD8RgQ@mail.gmail.com>
	<20170419213349.GC25239@thinpad.lan.raisama.net>
	<CAJhHMCB1GBC6ay4O61gnF8NtHg9+DCVR3dAcVjd253-GX3BoAw@mail.gmail.com>
	<20170420022629.GD25239@thinpad.lan.raisama.net>
	<CAJhHMCAjHsRDwa5sbWeQstLCe3o4nA7-GHAYrewP59H7wYeBBg@mail.gmail.com>
	<20170420184210.GF25239@thinpad.lan.raisama.net>
	<8cf1d4e9-8177-3b09-5400-cb22a929e78b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf1d4e9-8177-3b09-5400-cb22a929e78b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Do not display HT warning for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Fri, Apr 21, 2017 at 11:38:30AM +0200, Paolo Bonzini wrote:
> 
> 
> On 20/04/2017 20:42, Eduardo Habkost wrote:
> >> -smp 4,threads=4 shows 4 cores
> > This means 1 socket with 1 core, 4 threads per core. But if
> > vendor ID is AMD, guests will probably ignore the hyperthreading
> > info and treat each thread as a separate core. That's why we have
> > a warning.
> 
> I'm not sure about the "probably".  As long as the HT bit is 1 and the
> number of threads is > 1 in CPUID[EAX=1].EBX[bits 23:16], I am not sure
> why the OS would care about the vendor.
> 

On my testing, "-cpu qemu64,vendor=AuthenticAMD" and
"-cpu qemu64,vendor=GenuineIntel" gave different results on lscpu
and /proc/cpuinfo in a Fedora 25 guest (Linux 4.8.6-300.fc25).

> x86info does care (it just does not try to detect the topology for
> !Intel processors), but Linux seems not to.  detect_ht is called
> unconditionally.

I see detect_ht() inside a "#ifdef CONFIG_X86_32" in
amd_cpu_dev.c_init (init_amd()), and intel_cpudev.c_init
(init_intel()). It is inside a "#ifdef CONFIG_X86_64" in
identify_cpu(), though, so it looks like it is called at
different places, but always called.

But the logic becomes very confusing after that: the core/sibling
CPU masks are initialized based on phys_proc_id and cpu_core_id,
and detect_ht() isn't the only place where those fields are
initialized (see amd_get_topology(), amd_detect_cmp(),
detect_extended_topology()). It looks like amd_detect_cmp()
and/or amd_get_topology() will undo what detect_ht() did.

-- 
Eduardo
