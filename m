Received: from eggs.gnu.org ([2001:4830:134:3::10]:44526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gN13O-0005Vp-9q
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gN13F-0000pq-1u
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:42:17 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gN13E-0000pL-Nr
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:42:12 -0500
Date: Wed, 14 Nov 2018 14:42:08 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114194208.GA500@flamenco>
References: <20181114114400.15577-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114114400.15577-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cpus: run work items for all vCPUs if
 single-threaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, alex.bennee@linaro.org

On Wed, Nov 14, 2018 at 12:44:00 +0100, Paolo Bonzini wrote:
> This avoids the following deadlock:
> 
> 1) a thread calls run_on_cpu for CPU 2 from a timer, and single_tcg_halt_cond
> is signaled
> 
> 2) CPU 1 is running and exits.  It finds no work item and enters CPU 2
> 
> 3) because the I/O thread is stuck in run_on_cpu, the round-robin kick
> timer never triggers, and CPU 2 never runs the work item
> 
> 4) run_on_cpu never completes

I'm having trouble understanding (2)->(3).

When the vCPU thread enters CPU 2, shouldn't it detect that work is
pending? As in:

	/* assume cpu == cpu2 in the example above */
	while (cpu && !cpu->queued_work_first && !cpu->exit_request) {

Both cpu->queued_work_first and cpu->exit_request will be set for cpu2.

I can see though how with an additional CPU the deadlock
could happen. For example, the I/O thread does run_on_cpu(cpu3),
which kicks cpu1 (i.e. the tcg_current_rr_cpu) and cpu3, but not cpu2.
Then cpu1 exits, and cpu2 starts executing; unless cpu2 exits on its
own volition, it will run forever.

Thanks,

		Emilio
