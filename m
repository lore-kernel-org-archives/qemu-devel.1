Received: from eggs.gnu.org ([2001:4830:134:3::10]:44545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvM9v-0005qy-Ut
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvM9s-0003SO-P1
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:34:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fvM9s-0003R0-J3
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:34:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35DF140201BC
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 12:34:44 +0000 (UTC)
Date: Thu, 30 Aug 2018 14:34:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180830143442.01f211f6@redhat.com>
In-Reply-To: <20180830090853.ycnz3auwdfxwfpxe@kamzik.brq.redhat.com>
References: <1535464093-3648-1-git-send-email-imammedo@redhat.com>
	<1535553121-80352-1-git-send-email-imammedo@redhat.com>
	<20180829173301.GC17213@habkost.net>
	<20180830095851.4e3e6a2b@redhat.com>
	<20180830090853.ycnz3auwdfxwfpxe@kamzik.brq.redhat.com>
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
To: Andrew Jones <drjones@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On Thu, 30 Aug 2018 11:08:53 +0200
Andrew Jones <drjones@redhat.com> wrote:

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
> > 
> > diff --git a/vl.c b/vl.c
> > index 7fd700e..6320bdc 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -1208,14 +1208,18 @@ static void smp_parse(QemuOpts *opts)
> >          unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
> >          unsigned threads = qemu_opt_get_number(opts, "threads", 0);
> >  
> > +        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> >          /* compute missing values, prefer sockets over cores over threads */
> > -        if (cpus == 0 || sockets == 0) {
> > +        if (cpus == 0) {
> >              sockets = sockets > 0 ? sockets : 1;
> >              cores = cores > 0 ? cores : 1;
> >              threads = threads > 0 ? threads : 1;
> > -            if (cpus == 0) {
> > -                cpus = cores * threads * sockets;
> > -            }
> > +            cpus = cores * threads * sockets;
> > +            max_cpus = max_cpus > 0 ? max_cpus : cpus;
> > +        } else if (sockets == 0) {
> > +            cores = cores > 0 ? cores : 1;
> > +            threads = threads > 0 ? threads : 1;
> > +            sockets = max_cpus / (cores * threads);
> >          } else if (cores == 0) {
> >              threads = threads > 0 ? threads : 1;
> >              cores = cpus / (sockets * threads);
> > @@ -1231,8 +1235,6 @@ static void smp_parse(QemuOpts *opts)
> >              exit(1);
> >          }
> >  
> > -        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> > -
> >          if (max_cpus < cpus) {
> >              error_report("maxcpus must be equal to or greater than smp");
> >              exit(1);
> >  
> 
> I once made a cleanup similar to the above, but with more more line
> removal. It doesn't look like I ever posted it, and I don't recall
> how much I tested it, but here it is
my main motivation touching this code is to get in deprecation notice
with as little disruption as possible, and when it expires it should be
easier to cleanup as we won't have to worry about invalid then variants.


> diff --git a/vl.c b/vl.c
> index 5ba06adf787b..ad4e389fde48 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1208,30 +1208,22 @@ static void smp_parse(QemuOpts *opts)
>          unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
>          unsigned threads = qemu_opt_get_number(opts, "threads", 0);
>  
> +        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> +
>          /* compute missing values, prefer sockets over cores over threads */
> -        if (cpus == 0 || sockets == 0) {
> -            sockets = sockets > 0 ? sockets : 1;
> +        if (sockets == 0) {
>              cores = cores > 0 ? cores : 1;
>              threads = threads > 0 ? threads : 1;
> -            if (cpus == 0) {
> -                cpus = cores * threads * sockets;
> -            }
> +            sockets = max_cpus > 0 ? max_cpus / (cores * threads) : 1;
>          } else if (cores == 0) {
>              threads = threads > 0 ? threads : 1;
> -            cores = cpus / (sockets * threads);
> -            cores = cores > 0 ? cores : 1;
> +            cores = max_cpus > 0 ? max_cpus / (sockets * threads) : 1;
Is it subject to the same issue why 'cores = cores > 0 ? cores : 1;' where added?
Also s/cpus/maxcpus/ is not equivalent, considering cores are not discarded like sockets

>          } else if (threads == 0) {
> -            threads = cpus / (cores * sockets);
> -            threads = threads > 0 ? threads : 1;
> -        } else if (sockets * cores * threads < cpus) {
> -            error_report("cpu topology: "
> -                         "sockets (%u) * cores (%u) * threads (%u) < "
> -                         "smp_cpus (%u)",
> -                         sockets, cores, threads, cpus);
> -            exit(1);
> +            threads = max_cpus > 0 ? max_cpus / (sockets * cores) : 1;
ditto

>          }
>  
> -        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> +        max_cpus = max_cpus ?: sockets * cores * threads;
> +        cpus = cpus ?: max_cpus;
>  
>          if (max_cpus < cpus) {
>              error_report("maxcpus must be equal to or greater than smp");
> 
> 
> Thanks,
> drew
> 
> >   
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
> >   
