Received: from eggs.gnu.org ([2001:4830:134:3::10]:55828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5Kyk-0005Z1-56
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5Kyg-0008Cx-3m
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e5Kyf-0008CV-Qv
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 20:15:54 -0400
Date: Thu, 19 Oct 2017 22:15:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171020001548.GK2942@localhost.localdomain>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016165916.GI3246@localhost.localdomain>
	<20171019104218.GB13245@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019104218.GB13245@umbus>
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

On Thu, Oct 19, 2017 at 09:42:18PM +1100, David Gibson wrote:
> On Mon, Oct 16, 2017 at 02:59:16PM -0200, Eduardo Habkost wrote:
> > On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  include/sysemu/sysemu.h |  1 +
> > >  qemu-options.hx         | 15 ++++++++++++++
> > >  qmp.c                   |  5 +++++
> > >  vl.c                    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  4 files changed, 74 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > > index b213696..3feb94f 100644
> > > --- a/include/sysemu/sysemu.h
> > > +++ b/include/sysemu/sysemu.h
> > > @@ -66,6 +66,7 @@ typedef enum WakeupReason {
> > >      QEMU_WAKEUP_REASON_OTHER,
> > >  } WakeupReason;
> > >  
> > > +void qemu_exit_preconfig_request(void);
> > >  void qemu_system_reset_request(ShutdownCause reason);
> > >  void qemu_system_suspend_request(void);
> > >  void qemu_register_suspend_notifier(Notifier *notifier);
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 39225ae..bd44db8 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -3498,6 +3498,21 @@ STEXI
> > >  Run the emulation in single step mode.
> > >  ETEXI
> > >  
> > > +DEF("paused", HAS_ARG, QEMU_OPTION_paused, \
> > > +    "-paused [state=]postconf|preconf\n"
> > > +    "                postconf: pause QEMU after machine is initialized\n"
> > > +    "                preconf: pause QEMU before machine is initialized\n",
> > > +    QEMU_ARCH_ALL)
> > 
> > I would like to allow pausing before machine-type is selected, so
> > management could run query-machines before choosing a
> > machine-type.  Would that need a third "-pause" mode, or will we
> > be able to change "preconf" to pause before select_machine() is
> > called?
> > 
> > The same probably applies to other things initialized before
> > machine_run_board_init() that could be configurable using QMP,
> > including but not limited to:
> > * Accelerator configuration
> > * Registering global properties
> > * RAM size
> > * SMP/CPU configuration
> 
> Yeah.. having a bunch of different possible pause stages to select
> doesn't sound great.

I agree.  The number of externally visible pause states should be
as small as possible.


>                       Could we avoid this by instead changing -S to
> pause at the earliest possible spot, but having any monitor commands
> that require a later stage automatically "fast forwarding" to the
> right phase?

That would hide the internal details from the outside.  Sounds
nice, but adding new machine/device configuration QMP commands
while hiding the QEMU state from the outside sounds impossible.

For example, if we use -S today, this works:

  $ qemu-system-x86_64 -S -qmp stdio
  <- {"QMP": {"version": {"qemu": {"micro": 0, "minor": 10, "major": 2}, "package": " (v2.10.0-83-g9375da7831)"}, "capabilities": []}}
  -> {"execute":"qmp_capabilities"}
  <- {"return": {}}
  -> {"execute":"query-cpus"}
  <- {"return": [{"arch": "x86", "current": true, "props": {"core-id": 0, "thread-id": 0, "socket-id": 0}, "CPU": 0, "qom_path": "/machine/unattached/device[0]", "pc": 4294967280, "halted": false, "thread_id": 4038}]}

This means "query-cpus" needs to fast-forward to the CPU creation
stage if we want to keep compatibility.

Now, assume we add a set-numa-node command like the one in this
series.  e.g.:

  $ qemu-system-x86_64 -S -qmp stdio
  <- {"QMP": {"version": {"qemu": {"micro": 0, "minor": 10, "major": 2}, "package": " (v2.10.0-83-g9375da7831)"}, "capabilities": []}}
  -> {"execute":"qmp_capabilities"}
  <- {"return": {}}
  -> {"execute":"set-numa-node" ... }
  <- {"return": ...}

The command will work only if machine initialization didn't run
yet.

But now an innocent-looking query command would change QEMU state
in an unexpected way:

  $ qemu-system-x86_64 -S -qmp stdio
  <- {"QMP": {"version": {"qemu": {"micro": 0, "minor": 10, "major": 2}, "package": " (v2.10.0-83-g9375da7831)"}, "capabilities": []}}
  -> {"execute":"qmp_capabilities"}
  <- {"return": {}}
  -> {"execute":"query-cpus"}  [will silently fast-forward QEMU state]
  <- {"return": [{"arch": "x86", "current": true, "props": {"core-id": 0, "thread-id": 0, "socket-id": 0}, "CPU": 0, "qom_path": "/machine/unattached/device[0]", "pc": 4294967280, "halted": false, "thread_id": 4038}]}
  -> {"execute":"set-numa-node" ... }
  <- {"error": ...}  [the command will fail because the machine was already created]

This means we do have a externally visible "too late to use
set-numa-node" QEMU state, and query-cpus will have a externally
visible side effect.  Every QMP command would need to document
how it affects QEMU state in a externally visible way.

If QEMU pause state is still going to be externally visible this
way, I would prefer to let the client to explicitly tell what's
the state they want QEMU to be, instead of making QEMU change
state silently as a side effect of QMP commands.

> 
[...]


-- 
Eduardo
