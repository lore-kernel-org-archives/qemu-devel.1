Received: from eggs.gnu.org ([2001:4830:134:3::10]:52139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fxUKr-0002Af-As
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fxUKl-0003Ik-Hy
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:42:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fxUKi-00035I-EQ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AD0087A72
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 09:42:42 +0000 (UTC)
Date: Wed, 5 Sep 2018 11:42:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180905114229.3ff9c540@igors-macbook-pro.local>
In-Reply-To: <20180905014049.GJ12698@habkost.net>
References: <1536067356-44609-1-git-send-email-imammedo@redhat.com>
	<1536067356-44609-3-git-send-email-imammedo@redhat.com>
	<20180904151848.ualq7qvcikdsomi3@kamzik.brq.redhat.com>
	<20180905014049.GJ12698@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] vl:c: make sure that sockets are
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
Cc: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Tue, 4 Sep 2018 22:40:49 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Sep 04, 2018 at 05:18:48PM +0200, Andrew Jones wrote:
> > On Tue, Sep 04, 2018 at 03:22:36PM +0200, Igor Mammedov wrote:
> > > commit
> > >   (5cdc9b76e3 vl.c: Remove dead assignment)
> > > removed sockets calculation when 'sockets' weren't provided on CLI
> > > since there wasn't any users for it back then. Exiting checks
> > > are neither reachable
> > >    } else if (sockets * cores * threads < cpus) {
> > > or nor triggable
> > >    if (sockets * cores * threads > max_cpus)
> > > so we weren't noticing wrong topology since then, since users
> > > recalculate sockets adhoc on their own.
> > > 
> > > However with deprecation check it becomes noticable, for example
> > >   -smp 2
> > > will start printing warning:
> > >   "warning: Invalid CPU topology deprecated: sockets (1) * cores (1) * threads (1) != maxcpus (2)"
> > > calculating sockets if they weren't specified.
> > > 
> > > Fix it by returning back sockets calculation if it's omited on CLI.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  vl.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/vl.c b/vl.c
> > > index 7fd700e..333d638 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -1210,11 +1210,14 @@ static void smp_parse(QemuOpts *opts)
> > >  
> > >          /* compute missing values, prefer sockets over cores over threads */
> > >          if (cpus == 0 || sockets == 0) {
> > > -            sockets = sockets > 0 ? sockets : 1;
> > >              cores = cores > 0 ? cores : 1;
> > >              threads = threads > 0 ? threads : 1;
> > >              if (cpus == 0) {
> > > +                sockets = sockets > 0 ? sockets : 1;
> > >                  cpus = cores * threads * sockets;
> > > +            } else {
> > > +                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
> > > +                sockets = !sockets ? max_cpus / (cores * threads) : sockets;
> 
> Why the !sockets check here?  If we have reached this statement
> we know that (cpus == 0 || sockets == 0) is true and
> (cpus == 0) is false, so sockets is guaranteed to be 0.
Indeed, thanks for spotting it
I'll fix it up and respin

> 
> Sorry for not spotting this earlier.
> 
> > >              }
> > >          } else if (cores == 0) {
> > >              threads = threads > 0 ? threads : 1;
> > > -- 
> > > 2.7.4
> > > 
> > >
> >  
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
