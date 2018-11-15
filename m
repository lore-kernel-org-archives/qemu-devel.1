Received: from eggs.gnu.org ([2001:4830:134:3::10]:35954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNROx-0006Id-Nr
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNROt-0000Ut-Ga
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:50:23 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gNROr-0000Tq-GH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 18:50:17 -0500
Date: Thu, 15 Nov 2018 18:50:13 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181115235013.GA17566@flamenco>
References: <20181114114400.15577-1-pbonzini@redhat.com>
	<20181114194208.GA500@flamenco>
	<7648aa01-5458-bef1-9b65-f6ef83287e63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7648aa01-5458-bef1-9b65-f6ef83287e63@redhat.com>
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

On Fri, Nov 16, 2018 at 00:15:53 +0100, Paolo Bonzini wrote:
> On 14/11/2018 20:42, Emilio G. Cota wrote:
> > On Wed, Nov 14, 2018 at 12:44:00 +0100, Paolo Bonzini wrote:
> >> This avoids the following deadlock:
> >>
> >> 1) a thread calls run_on_cpu for CPU 2 from a timer, and single_tcg_halt_cond
> >> is signaled
> >>
> >> 2) CPU 1 is running and exits.  It finds no work item and enters CPU 2
> >>
> >> 3) because the I/O thread is stuck in run_on_cpu, the round-robin kick
> >> timer never triggers, and CPU 2 never runs the work item
> >>
> >> 4) run_on_cpu never completes
(snip)
> > I can see though how with an additional CPU the deadlock
> > could happen. For example, the I/O thread does run_on_cpu(cpu3),
> > which kicks cpu1 (i.e. the tcg_current_rr_cpu) and cpu3, but not cpu2.
> > Then cpu1 exits, and cpu2 starts executing; unless cpu2 exits on its
> > own volition, it will run forever.
> 
> Yes, the thread must call run_on_cpu for CPU *3* from a timer.

Thanks! Please add my

Reviewed-by: Emilio G. Cota <cota@braap.org>

tag when fixing up the commit message.

		E.
