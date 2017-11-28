Received: from eggs.gnu.org ([2001:4830:134:3::10]:39039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJmKA-000225-8i
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJmK8-0002sv-TA
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:17:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eJmK8-0002sl-NP
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:17:44 -0500
Date: Tue, 28 Nov 2017 18:05:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171128200529.GS3037@localhost.localdomain>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128205345-mutt-send-email-mst@kernel.org>
	<5837b412-d377-e7ac-9127-4990f8095a99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5837b412-d377-e7ac-9127-4990f8095a99@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, rth@twiddle.net, rkagan@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org

On Tue, Nov 28, 2017 at 08:50:54PM +0100, Paolo Bonzini wrote:
> On 28/11/2017 19:54, Michael S. Tsirkin wrote:
> >> Now there's a downside: with L3 cache the Linux scheduler is more eager
> >> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
> >> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
> >> sched pipe -i 100000" gives
> >>
> >> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
> >> off		200 (no K)	230		0.2 sec
> >> on		400K		330K		0.5 sec
> >>
> >> In a more realistic test, we observe 15% degradation in VM density
> >> (measured as the number of VMs, each running Drupal CMS serving 2 http
> >> requests per second to its main page, with 95%-percentile response
> >> latency under 100 ms) with l3-cache=on.
> >>
> >> We think that mostly-idle scenario is more common in cloud and personal
> >> usage, and should be optimized for by default; users of highly loaded
> >> VMs should be able to tune them up themselves.
> 
> Hi Denis,
> 
> thanks for the report.  I think there are two cases:
> 
> 1) The dedicated pCPU case: do you still get the performance degradation
> with dedicated pCPUs?
> 
> 2) The non-dedicated pCPU case: do you still get the performance
> degradation with threads=1?  If not, why do you have sibling vCPUs at
> all, if you don't have a dedicated physical CPU for each vCPU?

I assume you mean cores=1,threads=1?

Even if the pCPUs are dedicated, I would still like to see a
comparison between cores=1,threads=1,l3-cache=off and
cores=1,threads=1,l3-cache=off.  Maybe configuring cores > 1
isn't really helpful in some use cases.

-- 
Eduardo
