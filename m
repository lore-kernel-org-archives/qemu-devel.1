Received: from eggs.gnu.org ([2001:4830:134:3::10]:58272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ft8AE-0004ed-Ei
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ft8AD-00012D-Lq
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:13:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ft8AD-00011m-Fh
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:13:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8EC7402170A
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:13:52 +0000 (UTC)
Date: Fri, 24 Aug 2018 11:13:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180824111350.04d10250@redhat.com>
In-Reply-To: <fb74bf2d-6973-9c2d-d799-8d16561c0265@redhat.com>
References: <1535035877-219196-1-git-send-email-imammedo@redhat.com>
	<fb74bf2d-6973-9c2d-d799-8d16561c0265@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, dgilbert@redhat.com

On Thu, 23 Aug 2018 18:32:41 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

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
This destination CLI aren't exactly correct as well since
it should've been exactly the same -smp as on source + a bunch of -device cpufoo...
so we can always say go fix your CLI so it won't trigger error.
  
> The destination should have sockets=8, shouldn't it?
either that or cores=8 or cores=4,sockets=2 ...
 
> It seems to me that, at startup, you should have cpus = s*t*c and cpus
> <= maxcpus.  Currently we check cpus <= s*t*c <= maxcpus, which doesn't
> make much sense.
I think that s*t*c should describe topology of whole machine
including not yet plugged vcpus. "cpus = s*t*c" probably won't work
for partially filled package case:
       -smp 1,cores=1,threads=8,sockets=1
cores/threads should reflect full package configuration
for guest to see an expected topology.


> Paolo
> 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  vl.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/vl.c b/vl.c
> > index 16b913f..2b35e0c 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -1238,10 +1238,10 @@ static void smp_parse(QemuOpts *opts)
> >              exit(1);
> >          }
> >  
> > -        if (sockets * cores * threads > max_cpus) {
> > +        if (sockets * cores * threads != max_cpus) {
> >              error_report("cpu topology: "
> > -                         "sockets (%u) * cores (%u) * threads (%u) > "
> > -                         "maxcpus (%u)",
> > +                         "sockets (%u) * cores (%u) * threads (%u) not equal to"
> > +                         " maxcpus (%u)",
> >                           sockets, cores, threads, max_cpus);
> >              exit(1);
> >          }
> >   
> 
