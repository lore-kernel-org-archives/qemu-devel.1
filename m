Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1ceJM3-0000j5-22
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1ceJLy-0001ju-Gp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:32:03 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1ceJLy-0001jY-6y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:31:58 -0500
Received: by mail-wr0-x235.google.com with SMTP id i10so8517761wrb.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 02:31:57 -0800 (PST)
Date: Thu, 16 Feb 2017 11:31:54 +0100
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Message-ID: <20170216103154.GA15993@vader>
References: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
	<87k28qlca9.fsf@dusky.pond.sub.org> <20170216095322.GB2525@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216095322.GB2525@work-vm>
Subject: Re: [Qemu-devel] [PATCH 0/2] add writeconfig command on monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Thu, Feb 16, 2017 at 09=53=22AM +0000, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
> > Eduardo Otubo <eduardo.otubo@profitbricks.com> writes:
> > 
> > > This first patch extends the command line option `-writeconfig <file>' to a
> > > command on HMP and QMP monitors. This is useful when live migrating after a
> > > series of device hot plug events. One can just generate an updated config file
> > > for the vm, transport it to the target host and start the vm with `-readconfig
> > > <file>'.
> > >
> > > The second patch re-includes the reference of the memory object on the config
> > > file generated.
> > 
> > The high-level idea of having QEMU regurgitate its configuration for the
> > migration target sounds nice, but there are several issues with
> > regurgitating QemuOpts state with writeconfig:
> > 
> > 1. Our needs have outgrown QemuOpts' design.  We have accumulated
> >    various hacks and work-arounds to make do, and it's still not enough.
> >    Instead of adding more, I want to revise its design.  The work has
> >    started, but it'll take some time.  Adding creative new uses of
> >    QemuOpts while this work is in progress can only make it harder.
> > 
> >    If this issue was the only one, I'd take the hit for the team.

Certainly this series is part of the QemuOpts refactoring, right?
[PATCH 00/24] QemuOpts util/cutils: Fix and clean up number conversions

I'm not sure what's the big picture you have in mind, but I can help you
out.

> > 
> > 2. Transmitting configuration at the beginning of migration doesn't
> >    fully solve the problem.  What about configuration changes during
> >    migration?  Think of hot plug.  Doesn't mean transmitting
> >    configuration is a bad idea, only means there's more to the problem
> >    than a naive observer might think.
> > 
> >    In my opinion, the proper solution is to transmit configuration
> >    information in the migration stream, complete with updates as it
> >    changes.  Hard to do, which is why it hasn't been done.
> > 
> >    If we can't have the proper solution now, a less-than-ideal partial
> >    solution may still be better than nothing.
> 
> That's a separate problem from the one Eduardo is trying to solve;
> I wouldn't trust migration to survive a device hotplugged during the migration
> as it is.  So I wouldn't worry about it as a reason against this series.
> 

Can't we lock hotplug operations while a live migration is being
performed? Not exactly return an error, but perhaps delay the hotplug
until the migration is finished.

> > 3. The accuracy of QemuOpts information is doubtful.
> > 
> >    Completeness: only certain kinds of configuration are done with
> >    QemuOpts.  Incompleteness makes -writeconfig less useful than it
> >    could be, but it's still useful.  Monitor command writeconfig could
> >    be similarly useful.
> > 
> >    Correctness: configuration gets stored in QemuOpts when we parse
> >    KEY=VALUE,... strings.  It can also be constructed and updated
> >    manually.  At certain points in time, bits from QemuOpts are used to
> >    actually configure stuff.
> > 
> >    Example: -device creates an entry in the "device" configuration
> >    group, which is later used to actually create and configure a device
> >    object.
> > 
> >    My point is: whenever we manipulate the actual objects, we may
> >    invalidate information stored in QemuOpts.  We can try to keep it in
> >    sync, and we do at least sometimes.  But this is a game we can only
> >    lose, except for the period(s) of time where QemuOpts is all there
> >    is, i.e. before actual objects get created.  Note that -writeconfig
> >    runs before objects get created, so it's not affected by this issue.
> > 
> >    Out-of-sync QemuOpts is harmless unless something relies on it being
> >    accurate.  I know we currently rely on QemuOpts IDs to catch
> >    duplicate IDs for some of the configuration groups.  I doubt there's
> >    much else.
> > 
> >    If we add your monitor command, out-of-sync QemuOpts goes from
> >    harmless to serious bug.  In other words, we'd create a new class of
> >    bugs, with an unknown number of existing instances that are probably
> >    hard to find and fix.  Probably a perpetual source of new instances,
> >    too.
> > 
> >    Feels like a show stopper to me.
> 
> Hmm this does seem a bigger problem.
> 

Yes, this looks bad. Does your QemuOpts redesign considers these
problems as well? I mean, proper work with devices and objects to
actually update QemuOpts as soon as they change, etc.

-- 
Eduardo Otubo
ProfitBricks GmbH
