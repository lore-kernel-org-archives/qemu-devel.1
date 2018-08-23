Received: from eggs.gnu.org ([2001:4830:134:3::10]:40538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fstwv-0006if-5K
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fstwr-0004E8-Qa
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fstwr-0004DY-JI
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:03:09 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4AEA155AC
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 18:03:08 +0000 (UTC)
Date: Thu, 23 Aug 2018 15:03:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180823180307.GQ3778@localhost.localdomain>
References: <1535035877-219196-1-git-send-email-imammedo@redhat.com>
	<fb74bf2d-6973-9c2d-d799-8d16561c0265@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb74bf2d-6973-9c2d-d799-8d16561c0265@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Aug 23, 2018 at 06:32:41PM +0200, Paolo Bonzini wrote:
> On 23/08/2018 16:51, Igor Mammedov wrote:
> > Topology (threads*cores*sockets) must match maxcpus to be valid,
> > otherwise we could start QEMU with invalid topology that throws
> > a error on migration destination side, that should not be reachable:
> > Source:
> >   -smp 8,maxcpus=64,cores=1,threads=8,sockets=1
> > // hotplug cpus upto maxcpus
> > Destination:
> >   -smp 64,maxcpus=64,cores=1,threads=8,sockets=1
> >   qemu: cpu topology: sockets (1) * cores (1) * threads (8) < smp_cpus (64)
> 
> The destination should have sockets=8, shouldn't it?
> 
> It seems to me that, at startup, you should have cpus = s*t*c and cpus
> <= maxcpus.  Currently we check cpus <= s*t*c <= maxcpus, which doesn't
> make much sense.

Most of the incompleteness of input validation at smp_parse() can
be explained by our fear of breaking existing configurations and
making existing running VMs not runnable.

But now we have a deprecation policy.  If we're still afraid of
breaking peoples' existing configurations, we should at least
deprecate those configurations as soon as possible (and make QEMU
at least emit a warning).

-- 
Eduardo
