Received: from eggs.gnu.org ([2001:4830:134:3::10]:42411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCtp-00027F-0F
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCtk-0006Hl-Tz
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:25:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQCtk-0006HW-E7
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:25:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1097B402346D
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 14:25:20 +0000 (UTC)
Date: Tue, 5 Jun 2018 16:25:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180605162517.1568aabb@redhat.com>
In-Reply-To: <20180605120109.GD7451@localhost.localdomain>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-2-berrange@redhat.com>
	<2604e5d5-0e56-62e7-91eb-fd207a907ac8@redhat.com>
	<20180605005647.GE3184@localhost.localdomain>
	<20180605103755.34840d5d@redhat.com>
	<20180605120109.GD7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vl: don't use RUN_STATE_PRECONFIG
 as initial state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, 5 Jun 2018 09:01:09 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Jun 05, 2018 at 10:37:55AM +0200, Igor Mammedov wrote:
> > On Mon, 4 Jun 2018 21:56:47 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:  
> > > On Mon, Jun 04, 2018 at 04:21:47PM +0200, Michal Privoznik wrote:
> > > [...]  
> > > > > @@ -3572,7 +3570,12 @@ int main(int argc, char **argv, char **envp)
> > > > >                  }
> > > > >                  break;
> > > > >              case QEMU_OPTION_preconfig:
> > > > > -                preconfig_exit_requested = false;
> > > > > +                if (!runstate_check(RUN_STATE_NONE)) {
> > > > > +                    error_report("'--preconfig' and '--incoming' options are "
> > > > > +                                 "mutually exclusive");
> > > > > +                    exit(EXIT_FAILURE);
> > > > > +                }
> > > > > +                runstate_set(RUN_STATE_PRECONFIG);    
> > > > 
> > > > Specifying --preconfig twice on the command line now fails with a very
> > > > cryptic message (there's no --incoming).
> > > >     
> > > > >                  break;
> > > > >              case QEMU_OPTION_enable_kvm:
> > > > >                  olist = qemu_find_opts("machine");
> > > > > @@ -3768,9 +3771,12 @@ int main(int argc, char **argv, char **envp)
> > > > >                  }
> > > > >                  break;
> > > > >              case QEMU_OPTION_incoming:
> > > > > -                if (!incoming) {
> > > > > -                    runstate_set(RUN_STATE_INMIGRATE);
> > > > > +                if (!runstate_check(RUN_STATE_NONE)) {
> > > > > +                    error_report("'--preconfig' and '--incoming' options are "
> > > > > +                                 "mutually exclusive");
> > > > > +                    exit(EXIT_FAILURE);
> > > > >                  }
> > > > > +                runstate_set(RUN_STATE_INMIGRATE);    
> > > > 
> > > > Same here. Specifying --incoming twice fails with cryptic message. But
> > > > one can argue that specifying --incoming twice is wrong anyway.
> > > >     
> > > 
> > > Initially I was going to suggest simply not changing runstate
> > > during option parsing to avoid this kind of problem, but maybe
> > > this would be a nice way to implement the command-line parsing
> > > rules:  
> > Is there a big reason to try making early incoming transition hack nicer?
> > I'd rather leave it as it is for now and fix it properly later
> > (i.e. postponing the transition after machine_done point, which is on my
> > todo list).  
> 
> Yeah, I'm not sure we want go towards encoding more knowledge in
> the state machine, or keeping the system simple and encoding the
> rules in more straightforward code+variables inside main().
I've tried before to use code+variables for preconfig checks without
introducing a new runstate and it turned out difficult to manage
and the later changes often broke it. With new runstate end result
was much cleaner.

> 
> > > 
> > >     case QEMU_OPTION_preconfig:
> > >         /*
> > >          * A INCOMING -> PRECONFIG transition would call:
> > >          *   error_setg("--preconfig and --incoming options are mutually exclusive");
> > >          */
> > >         try_runstate_set(RUN_STATE_PRECONFIG, &error_fatal);
> > >         break;
> > >     case QEMU_OPTION_incoming:
> > >         /*
> > >          * A PRECONFIG -> INCOMING transition would also call:
> > >          *   error_setg("--preconfig and --incoming options are mutually exclusive");
> > >          *
> > >          * Maybe a INCOMING -> INCOMING transition could
> > >          * result in:
> > >          *   error_setg("--incoming can't be specified twice");
> > >          */
> > >         try_runstate_set(RUN_STATE_INMIGRATE, &error_fatal);
> > >         break;
> > > 
> > >   
> > > > >                  incoming = optarg;
> > > > >                  break;
> > > > >              case QEMU_OPTION_only_migratable:    
> > > > 
> > > > Michal
> > > >     
> > >   
> >   
> 
