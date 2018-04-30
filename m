Received: from eggs.gnu.org ([2001:4830:134:3::10]:35076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDEDu-0005Tb-8Z
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 15:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDEDq-0002Mu-9n
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 15:12:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDEDq-0002MH-3l
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 15:12:26 -0400
Date: Mon, 30 Apr 2018 20:12:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180430191208.GA2511@work-vm>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
	<20180323212508.GF28161@localhost.localdomain>
	<20180327170541.295fc29a@redhat.com>
	<20180328191732.GQ5046@localhost.localdomain>
	<20180329150112.2e1d3030@redhat.com>
	<20180329165754.GZ5046@localhost.localdomain>
	<20180403154907.2231a5d7@redhat.com>
	<20180403135210.GT5046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403135210.GT5046@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 3/9] cli: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Tue, Apr 03, 2018 at 03:49:07PM +0200, Igor Mammedov wrote:
> > On Thu, 29 Mar 2018 13:57:54 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> > [...]
> > > > As for the future, I agree it would be much more flexible
> > > > to allow both -preconfig and -incoming at the same time,
> > > > so we could start target with empty CLI, and then feed it
> > > > options from source. It would require audit/refactoring of
> > > > INMIGRATE state and making 'all' current CLI options
> > > > available via QMP interface.
> > > > 
> > > > But for now I'd prefer to keep using old way to start target.  
> > > 
> > > Well, if management software developers tell us that -preconfig
> > > will be already useful without -incoming support, I won't object.
> > As Peter said, mgmt can/will use -preconfig even without -incoming,
> > since it lets deal with initial (source) start-up problem (i.e.
> > avoid restarting QEMU) and lets us make numa configuration work
> > in qemu/libvirt stack without guess work. (that's the end goal of
> > the series)
> > 
> > > But it would be very nice for management software if they can
> > > simply assume that -preconfig and -incoming will work together
> > > since the first version.  Can we have this as a goal for 2.13?
> > I can't promise to refactor -incoming in near future, as I'm working
> > on ARM cpu-hotplug currently and next in queue is ARM memory hotplug.
> > 
> > Peter suggested an alternative idea, to abandon -incoming and
> > enable incoming migration from QMP after all configuration is done.
> > Amount of refactoring need probably would be the same but at least
> > interface and runstate transitions wise it looks cleaner.
> 
> Also, support for the "start incoming migration" QMP command
> would be very easy to probe using existing mechanisms.  Sounds
> good to me.

You could stick to -incoming defer,   that already says that you want
to do an inward migration but doesn't say where from until later.

Note there are some other bits of code scattered around for
checking whether we're in -incoming mode, for example to stop you
do an outwards migration while waiting for an incoming one, or
to stop you doing a migrate-incoming while you're already waiting
for one.

Dave

> -- 
> Eduardo
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
