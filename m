Received: from eggs.gnu.org ([2001:4830:134:3::10]:54814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fve7v-0001vn-NC
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fve7q-0000h1-JN
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:45:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fve7q-0000gc-B8
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B16F4401EF04
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 07:45:49 +0000 (UTC)
Date: Fri, 31 Aug 2018 09:45:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180831094547.5669389b@redhat.com>
In-Reply-To: <20180830140800.GH8359@habkost.net>
References: <1535464093-3648-1-git-send-email-imammedo@redhat.com>
	<1535553121-80352-1-git-send-email-imammedo@redhat.com>
	<20180829173301.GC17213@habkost.net>
	<20180830095851.4e3e6a2b@redhat.com>
	<20180830140800.GH8359@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl:c: make sure that sockets are
 calculated correctly in '-smp X' case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com

On Thu, 30 Aug 2018 11:08:00 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Aug 30, 2018 at 09:58:51AM +0200, Igor Mammedov wrote:
> > On Wed, 29 Aug 2018 14:33:01 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Wed, Aug 29, 2018 at 04:32:01PM +0200, Igor Mammedov wrote:  
> > > > commit
> > > >   (5cdc9b76e3 vl.c: Remove dead assignment)
> > > > removed sockets calculation when 'sockets' weren't provided on CLI
> > > > since there wasn't any users for it back then. Exiting checks
> > > > are neither reachable
> > > >    } else if (sockets * cores * threads < cpus) {
> > > > or nor triggable
> > > >    if (sockets * cores * threads > max_cpus)
> > > > so we weren't noticing wrong topology since then, since users
> > > > recalculate sockets adhoc on their own.
> > > > 
> > > > However with deprecation check it becomes noticable, for example
> > > >   -smp 2
> > > > will start printing warning:
> > > >   "warning: Invalid CPU topology deprecated: sockets (1) * cores (1) * threads (1) != maxcpus (2)"
> > > > calculating sockets if they weren't specified.
> > > > 
> > > > Fix it by returning back sockets calculation if it's omited on CLI.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  vl.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/vl.c b/vl.c
> > > > index 7fd700e..333d638 100644
> > > > --- a/vl.c
> > > > +++ b/vl.c
> > > > @@ -1210,11 +1210,14 @@ static void smp_parse(QemuOpts *opts)
> > > >  
> > > >          /* compute missing values, prefer sockets over cores over threads */
> > > >          if (cpus == 0 || sockets == 0) {
> > > > -            sockets = sockets > 0 ? sockets : 1;
> > > >              cores = cores > 0 ? cores : 1;
> > > >              threads = threads > 0 ? threads : 1;
> > > >              if (cpus == 0) {
> > > > +                sockets = sockets > 0 ? sockets : 1;
> > > >                  cpus = cores * threads * sockets;
> > > > +            } else {
> > > > +                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);    
> > > 
> > > We already have a "max_cpus = qemu_opt_get_number(...)" line in
> > > this function[1]:
> > > 
> > >         /* compute missing values, prefer sockets over cores over threads */
> > >         if (cpus == 0 || sockets == 0) {
> > >             sockets = sockets > 0 ? sockets : 1;
> > >             cores = cores > 0 ? cores : 1;
> > >             threads = threads > 0 ? threads : 1;
> > >             if (cpus == 0) {
> > >                 cpus = cores * threads * sockets;
> > >             }
> > >         } else if (cores == 0) {
> > >             [...]
> > >         } else if (threads == 0) {
> > >             [...]
> > >         } else if (sockets * cores * threads < cpus) {
> > >             [...]
> > >         }
> > > 
> > >         max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus); /* [1] */
> > > 
> > >         /* [2] */
> > > 
> > >         if (max_cpus < cpus) {
> > >             error_report("maxcpus must be equal to or greater than smp");
> > >             exit(1);
> > >         }
> > > 
> > > Why not move the sockets == 0 check to [2]?  
> > it won't work, since the rest 'else if' depends on sockets being non 0
> > which is ensured by (cpus == 0 || sockets == 0) branch, I can split this in 2
> > equivalent conditions. It's more code but it might be easier to read  
> 
> I like your original patch better.  I wasn't thinking about the
> "cpus == 0 || sockets == 0" check, but about this line:
> 
>    sockets = !sockets ? max_cpus / (cores * threads) : sockets;
> 
> Just moving this line to [2] would be enough, wouldn't it?
it would be, but to me it looks more confusing, since one goes
into a branch on condition sockets == 0 but then does nothing with
socket. 
I'd rather have a duplicate qemu_opt_get_number(opts, "maxcpus", cpus)
at the time when we have all date to set it instead of deferring it
to the later time.

Once deprecation expires we will be able to clean it all up as Drew
suggested.


> [...]
> > > 
> > >   
> > > > +                sockets = !sockets ? max_cpus / (cores * threads) : sockets;    
> > > 
> > > The two patches in this thread make QEMU print a warning on a
> > > case that was never documented as invalid/deprecated: maxcpus now
> > > needs to be a multiple of cores*threads.
> > > 
> > > However, the error message doesn't make it obvious:
> > > 
> > >   $ ./x86_64-softmmu/qemu-system-x86_64 -smp 7,cores=3
> > >   qemu-system-x86_64: warning: Invalid CPU topology deprecated: sockets (2) * cores (3) * threads (1) != maxcpus (7)  
> > to me it look pretty obvious, fix one side of equation to make sure that VM
> > starts in the future.
> >   
> > > I think this would make more sense:
> > > 
> > >   $ ./x86_64-softmmu/qemu-system-x86_64 -smp 7,cores=3
> > >   qemu-system-x86_64: warning: Invalid CPU topology deprecated: maxcpus (7) is not a multiple of cores (3) * threads (1)  
> > I think it will add not necessary warning/code, but if you really
> > think we need it, I can add it to 'vl.c deprecate incorrect CPUs
> > topology' on respin.  
> 
> My main worry is about insufficient documentation: we need to
> clarify that the s*c*t == maxcpus rule applies even if "sockets"
> is omitted in the command-line, and that this indirectly requires
> that maxcpus be a multiple of c*6.
It's not limited to c*t but to any combination, how about adding following:

"
Note: it's assumed that maxcpus value must be multiple of the topology           
options present on command line to avoid creating an invalid topology.           
If maxcpus isn't be multiple of present topology options then the condition      
(sockets * cores * threads == maxcpus) can't be satisfied and it will            
trigger deprecation warning which later will be converted to a error.            
If you get deprecation warning it's recommended to explicitly specify            
a correct topology to make warning go away and ensure that it will               
continue working in the future. 
"

> 
> That said, I won't mind if you keep the existing message in this
> patch for code simplicity, as long as the documentation is
> updated.
> 
> >   
> > > 
> > >   
> > > >              }
> > > >          } else if (cores == 0) {
> > > >              threads = threads > 0 ? threads : 1;
> > > > -- 
> > > > 2.7.4
> > > >     
> > >   
> >   
> 
