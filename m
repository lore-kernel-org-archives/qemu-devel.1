Received: from eggs.gnu.org ([2001:4830:134:3::10]:42315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ftCWw-0001d6-2b
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ftCWs-0000iU-To
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:53:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ftCWs-0000i6-Mz
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF689C05B008
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 13:53:33 +0000 (UTC)
Date: Fri, 24 Aug 2018 10:53:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180824135332.GY3778@localhost.localdomain>
References: <1535035877-219196-1-git-send-email-imammedo@redhat.com>
	<fb74bf2d-6973-9c2d-d799-8d16561c0265@redhat.com>
	<20180824111350.04d10250@redhat.com>
	<20180824111148.GX3778@localhost.localdomain>
	<20180824132654.63fb9047@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824132654.63fb9047@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, libvir-list@redhat.com

On Fri, Aug 24, 2018 at 01:26:54PM +0200, Igor Mammedov wrote:
> On Fri, 24 Aug 2018 08:11:48 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Fri, Aug 24, 2018 at 11:13:50AM +0200, Igor Mammedov wrote:
> > > On Thu, 23 Aug 2018 18:32:41 +0200
> > > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >   
> > > > On 23/08/2018 16:51, Igor Mammedov wrote:  
> > > > > Topology (threads*cores*sockets) must match maxcpus to be valid,
> > > > > otherwise we could start QEMU with invalid topology that throws
> > > > > a error on migration destination side, that should not be reachable:
> > > > > Source:
> > > > >   -smp 8,maxcpus=64,cores=1,threads=8,sockets=1
> > > > > // hotplug cpus upto maxcpus
> > > > > Destination:
> > > > >   -smp 64,maxcpus=64,cores=1,threads=8,sockets=1
> > > > >   qemu: cpu topology: sockets (1) * cores (1) * threads (8) < smp_cpus (64)  
> > > This destination CLI aren't exactly correct as well since
> > > it should've been exactly the same -smp as on source + a bunch of -device cpufoo...
> > > so we can always say go fix your CLI so it won't trigger error.
> > >     
> > > > The destination should have sockets=8, shouldn't it?  
> > > either that or cores=8 or cores=4,sockets=2 ...
> > >    
> > > > It seems to me that, at startup, you should have cpus = s*t*c and cpus
> > > > <= maxcpus.  Currently we check cpus <= s*t*c <= maxcpus, which doesn't
> > > > make much sense.  
> > > I think that s*t*c should describe topology of whole machine
> > > including not yet plugged vcpus. "cpus = s*t*c" probably won't work
> > > for partially filled package case:
> > >        -smp 1,cores=1,threads=8,sockets=1
> > > cores/threads should reflect full package configuration
> > > for guest to see an expected topology.  
> > 
> > Oh, now I remember: that's the reason we don't enforce
> > s*t*c == smp_cpus nor s*t*c == max_cpus.
> > 
> > Both "-smp 4,maxcpus=8,cores=2,threads=2,sockets=1" and
> >      "-smp 4,maxcpus=8,cores=2,threads=2,sockets=2"
> > worked since maxcpus was introduced, making the semantics of
> > "sockets" unclear and hard to change without breaking existing
> > configs.
> Should we go with deprication thingy then,
> so we could make it clear in the future?

Yes, but I'm not sure which option we should adopt
(s*t*c == smp_cpus or s*t*c == max_cpus).

Does anybody know what's the semantics expected by libvirt today?

-- 
Eduardo
