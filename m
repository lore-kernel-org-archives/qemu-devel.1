Received: from eggs.gnu.org ([2001:4830:134:3::10]:33439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej88u-0001Pi-E3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej88t-0001KI-6B
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:38:56 -0500
Date: Tue, 6 Feb 2018 18:38:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180206183836.GF2462@work-vm>
References: <7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
	<79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
	<1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
	<eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
	<1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
	<2e145d8b-855f-9060-1b81-feb515067293@virtuozzo.com>
	<20180126150511.GG2610@work-vm>
	<ac366ae3-d7e0-db65-d5ee-d276a42320da@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac366ae3-d7e0-db65-d5ee-d276a42320da@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 26.01.2018 18:05, Dr. David Alan Gilbert wrote:
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > 17.01.2018 19:03, Eric Blake wrote:
> > > > On 01/17/2018 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > > 
> > > > > > > I have a script (for managing libvirt guest, but it can be adopted for
> > > > > > > qemu or even used for qemu monitor), which allows
> > > > > > > me run qmp commands on vms as easy as:
> > > > > > > 
> > > > > > > |qmp VMNAME query-block-jobs or qmp VMNAME nbd-server-remove name exp1
> > > > > > > mode hard or even |
> > > > > > > 
> > > > > > > |qmp VMNAME blockdev-add id disk driver qcow2 cache {writeback true
> > > > > > > direct true} aio native discard unmap file {driver file filename
> > > > > > > /tmp/somedisk} |||
> > > > > > Yeah, there are various scripting solutions around QMP that can make it
> > > > > > easier; but HMP is often still an easy front-line interface for
> > > > > > experiments.
> > > > > > 
> > > > > isn't it because these solutions are not available directly in monitor,
> > > > > when HMP is?
> > > > QMP can be directly accessed in a monitor; it just requires more typing.
> > > >    If you are developing QMP commands, it may be easier to use
> > > > ./scripts/qmp/qmp-shell (couple it with a readline wrapper, and you can
> > > > even get tab-completion and history across sessions).  There's also
> > > > things like libvirt's 'virsh qmp-monitor-command' for shell-scripting
> > > > access to arbitrary QMP commands, provided your guest is run by libvirt.
> > > > 
> > > > > may be, we need third type of monitor HQMP which is QMP with simplified
> > > > > syntax? Or
> > > > > allow qmp commands in simplified syntax directly in HMP?
> > > > No, I don't think we need either thing.  Wrappers around existing
> > > > monitors is better than bloating qemu proper with a third flavor of
> > > > monitor.  And HMP is for humans, with no restrictions on back-compat
> > > > changes, so if it doesn't do something you want for quick-and-dirty
> > > > testing, you can either add a new HMP command, or just use QMP (or one
> > > > of its wrappers, like qmp-shell) in the first place.  Ultimately, our
> > > > long-term concern is only about the QMP interface; HMP is supposed to be
> > > > convenient.  So if it starts costing too much time to port a QMP
> > > > interface to HMP, then don't worry about it.
> > > > 
> > > most of commands, ported to hmp are done in same style: they just call
> > > corresponding qmp command.
> > > Isn't it better to provide common interface for calling qmp commands through
> > > HMP monitor, to never
> > > create hmp versions of new commands? they will be available automatically.
> > It would be nice to do that, but they're not that consistent in how they
> > convert parameters and options, but I occasionally wonder if we could
> > automate more of it.
> 
> 
> What about allowing some new syntax in hmp, directly mapped to qmp?
> 
> something like
> 
> >>> blockdev-add id disk driver qcow2 cache {writeback true direct true} aio
> native discard unmap file {driver file filename /tmp/somedisk}
> 
> ?

Hmm, I don't particularly find that easy to read either; however the
actual block device specification for HMP should be the same as what we
pass on the command line, so we only have to worry about any extra
things that are part of blockdev_add.
(I'm sure we can find a way of making the one we pass on the commandline
more readable as well, there's so much duplication).

Dave

> Or it may be realized as a separate hmp command "qmp" (looks more safe as a
> first step, however, I think previous variant (direct call) is better):
> 
> >>> qmp blockdev-add id disk driver qcow2 cache {writeback true direct true}
> aio native discard unmap file {driver file filename /tmp/somedisk}
> 
> what do think? This looks simple to implement and should be useful.
> 
> > 
> > Dave
> > 
> > > -- 
> > > Best regards,
> > > Vladimir
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
> -- 
> Best regards,
> Vladimir
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
