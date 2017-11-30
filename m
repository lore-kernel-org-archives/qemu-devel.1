Received: from eggs.gnu.org ([2001:4830:134:3::10]:52584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eKIKw-0002hG-LE
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eKIKt-0000SA-BT
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:28:42 -0500
Received: from mail-db5eur01on0107.outbound.protection.outlook.com
	([104.47.2.107]:37542
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eKIKs-0000Qk-Fr
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:28:39 -0500
Date: Thu, 30 Nov 2017 09:28:29 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171130062827.GA12690@rkaganip.lan>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<5A1E43A6.1010607@huawei.com>
	<20171129104122.GY3037@localhost.localdomain>
	<5A1EA0DB.60303@huawei.com> <20171129133524.GA2279@rkaganb.sw.ru>
	<4ebcd22a-4c6c-8260-c94c-26810d6a24cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebcd22a-4c6c-8260-c94c-26810d6a24cd@redhat.com>
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
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, rth@twiddle.net, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, zhaoshenglong <zhaoshenglong@huawei.com>

On Wed, Nov 29, 2017 at 06:15:05PM +0100, Paolo Bonzini wrote:
> On 29/11/2017 14:35, Roman Kagan wrote:
> >>
> >>> IMO, the long term solution is to make Linux guests not misbehave
> >>> when we stop lying about the L3 cache.  Maybe we could provide a
> >>> "IPIs are expensive, please avoid them" hint in the KVM CPUID
> >>> leaf?
> > We already have it, it's the hypervisor bit ;)  Seriously, I'm unaware
> > of hypervisors where IPIs aren't expensive.
> > 
> 
> In theory, AMD's AVIC should optimize IPIs to running vCPUs.  Amazon's
> recently posted patches to disable HLT and MWAIT exits might tilt the
> balance in favor of IPIs even for Intel APICv (where sending the IPI is
> expensive, but receiving it isn't).
> 
> Being able to tie this to Amazon's other proposal, the "DEDICATED" CPUID
> bit, would be nice.  My plan was to disable all three of MWAIT/HLT/PAUSE
> when setting the dedicated bit.

Yes the IPI cost can hopefully be mitigated in the case of dedicated and
busy vCPUs.

However, in the max density scenario this doesn't help.

Obviously, in the pipe benchmark scheduling the two ends of the pipe on
different cores is detrimental for performance even on a physical
machine; however, IIUC it was a conscious decision by the scheduler
folks because it provides acceptable latency for mostly-idle systems and
decent performance in more loaded cases.

We wouldn't care about this pipe benchmark numbers per se, because the
latencies are still good for practical purposes.  However, in case of
virtual machines, this extra overhead of remote scheduling in the guest
results in a slight -- circa 15% in our Drupal-based test -- increase of
the host cpu consumption by vcpu threads.  That, in turn, makes the host
cpu overcommit being reached with 15% less VMs (and, once overcommit is
reached, the drupal response latency goes into the sky, so it's
effectively a cut-off for density).

Roman.
