Received: from eggs.gnu.org ([2001:4830:134:3::10]:58715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ft8Bu-0006QK-QI
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ft8Bt-0002cT-EX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:15:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ft8Bt-0002c8-9M
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F09B87DAC9
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:15:36 +0000 (UTC)
Date: Fri, 24 Aug 2018 11:15:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180824111534.7e833a0b@redhat.com>
In-Reply-To: <20180823180307.GQ3778@localhost.localdomain>
References: <1535035877-219196-1-git-send-email-imammedo@redhat.com>
	<fb74bf2d-6973-9c2d-d799-8d16561c0265@redhat.com>
	<20180823180307.GQ3778@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: make sure maxcpus matches topology
 to prevent migration failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, 23 Aug 2018 15:03:07 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Aug 23, 2018 at 06:32:41PM +0200, Paolo Bonzini wrote:
> > On 23/08/2018 16:51, Igor Mammedov wrote:  
> > > Topology (threads*cores*sockets) must match maxcpus to be valid,
> > > otherwise we could start QEMU with invalid topology that throws
> > > a error on migration destination side, that should not be reachable:
> > > Source:
> > >   -smp 8,maxcpus=64,cores=1,threads=8,sockets=1
> > > // hotplug cpus upto maxcpus
> > > Destination:
> > >   -smp 64,maxcpus=64,cores=1,threads=8,sockets=1
> > >   qemu: cpu topology: sockets (1) * cores (1) * threads (8) < smp_cpus (64)  
> > 
> > The destination should have sockets=8, shouldn't it?
> > 
> > It seems to me that, at startup, you should have cpus = s*t*c and cpus
> > <= maxcpus.  Currently we check cpus <= s*t*c <= maxcpus, which doesn't
> > make much sense.  
> 
> Most of the incompleteness of input validation at smp_parse() can
> be explained by our fear of breaking existing configurations and
> making existing running VMs not runnable.
> 
> But now we have a deprecation policy.  If we're still afraid of
> breaking peoples' existing configurations, we should at least
> deprecate those configurations as soon as possible (and make QEMU
> at least emit a warning).
Sure, I can send a deprecation patch first.
