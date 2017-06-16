Received: from eggs.gnu.org ([2001:4830:134:3::10]:48796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dLtdu-0002Zk-8L
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dLtdp-0006RT-Kx
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:58:38 -0400
Date: Fri, 16 Jun 2017 17:58:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170616175823.3308616c@nial.brq.redhat.com>
In-Reply-To: <20170616144053.GH30484@umbus>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
	<149748643237.3448.7122634958390452661@loki>
	<20170616155312.623f859e@nial.brq.redhat.com>
	<20170616144053.GH30484@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Fri, 16 Jun 2017 22:40:53 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jun 16, 2017 at 03:53:12PM +0200, Igor Mammedov wrote:
> > On Wed, 14 Jun 2017 19:27:12 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> >   
> > > Quoting Igor Mammedov (2017-06-14 04:00:01)  
> > > > On Tue, 13 Jun 2017 16:42:45 -0500
> > > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > > >     
> > > > > Quoting Igor Mammedov (2017-06-09 03:27:33)    

[...]

> > > > 
> > > > May be we should
> > > >  1. make DeviceState:hotpluggable property write-able again
> > > >  2. transmit DeviceState:hotpluggable as part of migration stream
> > > >  3. add generic migration hook which will check if target and
> > > >     source value match, if value differs => fail/abort migration.
> > > >  4. in case values mismatch mgmt will be forced to explicitly
> > > >     provide hotplugged property value on -device/device_add
> > > > That would enforce consistent DeviceState:hotpluggable value
> > > > on target and source.
> > > > We can enforce it only for new machine types so it won't break
> > > > old mgmt tools with old machine types but would force mgmt
> > > > for new machines to use hotplugged property on target
> > > > so QEMU could rely on its value for migration purposes.
> > > >     
> > > 
> > > That would work, and generalizing this beyond spapr seems
> > > appropriate.
> > > 
> > > It also has reasonable semantics, and it would work for us
> > > *provided that* we always send DRC state for hotplugged devices
> > > and not just DRCs in a transitional state:
> > > 
> > > SRC1: device_add $cpu  
> > >  -> dev->hotplugged == true
> > >  -> device starts in pre-hotplug, ends up in post-hotplug state    
> > >     after guest onlines it
> > > <migrate>
> > > DST1: device_add $cpu,hotplugged=true  
> > >  -> dev->hotplugged == true
> > >  -> device starts in pre-hotplug state. guest sends updated state    
> > >     to transition DRC to post-hotplug
> > > 
> > > But what about stuff like mem/pci? Currently, migration works for
> > > cases like:
> > > 
> > > SRC1: device_add virtio-net-pci
> > > DST1: qemu -device virtio-net-pci
> > > 
> > > Even though DST1 has dev->hotplugged == false, and SRC1 has the
> > > opposite. So for new machines, checking SRC1:dev->hotplugged ==
> > > DST1:dev->hotplugged would fail, even though the migration
> > > scenario is unchanged from before.
> > > 
> > > So management would now have to do:
> > > 
> > > SRC1: device_add virtio-net-pci
> > > DST1: qemu -device virtio-net-pci,hotplugged=true
> > > 
> > > But the code behavior is a bit different then, since we now get
> > > an ACPI hotplug event via the hotplug handler. Maybe the
> > > migration stream fixes that up for us, but I think we would need
> > > to audit this and similar cases to be sure.
> > > 
> > > That's all fine if it's necessary, but I feel like this is
> > > the hard way to address what's actually a much more specific
> > > issue: that device_add before machine-start doesn't currently
> > > match the behavior for a device started via cmdline. i.e.
> > > dev->hotplugged in the former vs. !dev->hotplugged in the
> > > latter. I don't really see a good reason these 2 cases should
> > > be different, and we can bring them to parity by doing
> > > something like:
> > > 
> > > 1. For device_adds after qdev_machine_creation_done(), but
> > >    before machine start, set a flag: reset_before_start.
> > > 2. At the start of processing migration stream, or unpausing
> > >    a -S guest (in the non-migration case), issue a system-wide
> > >    reset if reset_before_start is set.
> > > 3. reset handlers will already unset dev->hotplugged at that
> > >    point and re-execute all the hotplug hooks with
> > >    dev->hotplugged == false. This should put everything in
> > >    a state that's identical to cmdline-created devices.  
> > instead of flag for non migration case we could use
> >  RUN_STATE_PRELAUNCH -> RUN_STATE_RUNNING
> > transition to reset all devices or
> > maybe do something like this:  
> 
> Hrm, does the general reset call happen now before or after this
> transition?  Resetting DRCs at CAS time should accomplish the same thing.
currently it's before, see vl.c

    qdev_machine_creation_done();                                                
                                                                                                                         
    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());                
    qemu_run_machine_init_done_notifiers();
...                                        
    qemu_system_reset(SHUTDOWN_CAUSE_NONE);                                      
    register_global_state();                                                     
    if (replay_mode != REPLAY_MODE_NONE) {                                       
        replay_vmstate_init();                                                   
    } else if (loadvm) {                                                         
        Error *local_err = NULL;                                                 
        if (load_snapshot(loadvm, &local_err) < 0) {                             
            error_report_err(local_err);                                         
            autostart = 0;                                                       
        }                                                                        
    }                                                                            
...                                                                   
    } else if (autostart) {                                                      
        vm_start();                                                           
    }         
...
main_loop(); <-- currently device_add works here


simplified version:
without migration and with -S option 'autostart = 0'
so we get monitor/qmp prompt with RUN_STATE_PRELAUNCH

and when command 'cont' is issued,
  RUN_STATE_PRELAUNCH -> RUN_STATE_RUNNING



> 
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 0ce45a2..cdeb8f8 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > 
> > @@ -1020,7 +1010,7 @@ static void device_initfn(Object *obj)
> >      ObjectClass *class;
> >      Property *prop;
> >  
> > -    if (qdev_hotplug) {
> > +    if (runstate_check(RUN_STATE_RUNNING) || ...) {
> >          dev->hotplugged = 1;
> >          qdev_hot_added = true;
> >      }
> >   
> > > 4. Only allow management to do device_add before it sends
> > >    the migration stream (if management doesn't already guard
> > >    against this then it's probably a bug anyway)  
> > seems like Juan already took care of it.
> >   
> > > This allows management to treat device_add/cmdline as being
> > > completely synonymous for guests that haven't started yet,
> > > both for -incoming and -S in general, and it maintains
> > > the behavior that existing migration code expects of
> > > cmdline-specified devices.  
> > 
> >   
> 
