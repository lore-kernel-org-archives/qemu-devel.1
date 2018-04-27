Received: from eggs.gnu.org ([2001:4830:134:3::10]:42327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC2Lu-0007Wd-Ns
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC2Lr-00010G-Id
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:19:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fC2Lr-000104-Di
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:19:47 -0400
Date: Fri, 27 Apr 2018 14:19:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180427141944.7c3288e2@redhat.com>
In-Reply-To: <318e4cfd-22ec-9cb1-a139-07e83a45ed8c@redhat.com>
References: <20180417142739.GV29865@localhost.localdomain>
	<20180417174110.1a7f1daf@redhat.com>
	<20180417204135.GB29865@localhost.localdomain>
	<87d0yx2dqp.fsf@dusky.pond.sub.org>
	<20180419100004.0b560c85@redhat.com>
	<20180419194251.GZ29865@localhost.localdomain>
	<87muxy2xu1.fsf@dusky.pond.sub.org>
	<20180423115016.31b4a302@redhat.com>
	<20180423130554.GL29865@localhost.localdomain>
	<20180423185514.1dcaa223@redhat.com>
	<20180423204531.GR29865@localhost.localdomain>
	<20180426163911.270915c9@redhat.com>
	<318e4cfd-22ec-9cb1-a139-07e83a45ed8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Thu, 26 Apr 2018 09:55:40 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 04/26/2018 09:39 AM, Igor Mammedov wrote:
> 
> >>> I'll try to come up with a text for qemu-doc.texi, not about
> >>> deprecating -S but about when --preconfig should be used vs -S
> >>> and where to get list of commands that could be used at preconfig state.    
> >>
> >> Sounds good to me.  Thanks!  
> > how about something like this:
> > 
> > diff --git a/qemu-tech.texi b/qemu-tech.texi
> > index 52a56ae..6951258 100644
> > --- a/qemu-tech.texi
> > +++ b/qemu-tech.texi
> > @@ -5,6 +5,7 @@
> >  * CPU emulation::
> >  * Translator Internals::
> >  * QEMU compared to other emulators::
> > +* Managed start up options::
> >  * Bibliography::
> >  @end menu
> >  
> > @@ -314,6 +315,44 @@ VirtualBox [9], Xen [10] and KVM [11] are based on QEMU. QEMU-SystemC
> >  [12] uses QEMU to simulate a system where some hardware devices are
> >  developed in SystemC.
> >  
> > +@node Managed start up options
> > +@section Managed start up options
> > +
> > +In system mode emulation, it's possible to create VM in paused state using
> > +-S command line option. In this state the machine is completely initialized
> > +according to command line options and ready to execute VM code but VCPU threads
> > +are not executing any code. VM state in this paused state depends on way QEMU
> > +was started. It could be in:
> > +@table @asis
> > +@item initial state (after reset/power on state)
> > +@item with direct kernel loading initial state could be ammended to execute  
> 
> s/ammended/amended/
> 
> > +code loaded by QEMU in VM's RAM and with incomming migration  
> 
> s/incomming/incoming/
> 
> > +@item with incomming migrartion, initial state will by ammended by the migrated  
> 
> and again, for both words
> s/migrartion/migration/
> 
> > +machine state after migration completes.
> > +@end table
> > +
> > +This paused state is typically used by users to query machine state and/or
> > +additionally configure machine (hotplug devices) in runtime before allowing
> > +VM code to run.
> > +
> > +However at -S pause point it's impossible to configure options that affect
> > +initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. That's
> > +when -preconfig command line option should be used. It allows to pause  
> 
> s/to pause/pausing/
> 
> > +QEMU before initial VM creation in preconfig state, query being created
> > +VM at runtime and configure start up options depending on previous query  
> 
> Reads awkwardly.  Maybe:
> 
> It allows pausing QEMU before the initial VM creation, in a new
> preconfig state, where additional queries and configuration can be
> performed via QMP before moving on to the resulting configuration startup.
> 
> > +results. In preconfig state QEMU allows to configure VM only via QMP monitor
> > +with a limited command set which doesn't depend on completely initialized
> > +machine, which includes but not limited to:  
> 
> In the preconfig state, QEMU only allows a limited set of commands over
> the QMP monitor, where the commands do not depend on an initialized
> machine, including but not limited to:

thanks for review,
I amended patches as you suggested.
I plan to respin v6 today with these changes since exit-preconfig
affected several patches in series.

> 
> > +@table @asis
> > +@item qmp_capabilities
> > +@item query-qmp-schema
> > +@item query-commands
> > +@item query-status
> > +@end table
> > +The full list of commands is in QMP schema which could be queried with
> > +query-qmp-schema, where commands supported at preconfig state have option
> > +'allowed-in-preconfig' set to true.
> > +
> >  @node Bibliography
> >  @section Bibliography
> >   
> 
> >> A separate command would have less room for ambiguity.  
> > I've added following instead of reusing 'cont':
> > 
> > ##                                                                               
> > # @exit-preconfig:                                                                 
> 
> This should definitely be mentioned in the docs section of commands
> permitted during preconfig.
done

> 
> > #                                                                                
> > # Exit from "preconfig" state                                                    
> > #                                                                                
> > # Since 2.13                                                                     
> > #                                                                                
> > # Returns: nothing                                                               
> > #                                                                                
> > # Notes: Command makes QEMU exit from preconfig state and proceeds with          
> > # VM initialization using configuration data provided on command line            
> > # and via QMP monitor at preconfig state. Command is available only at           
> > # preconfig state (i.e. if --preconfig command line option).                     
> > #                                                                                
> > # Example:                                                                       
> > #                                                                                
> > # -> { "execute": "exit-preconfig" }                                             
> > # <- { "return": {} }                                                            
> > #                                                                                
> > ##                                                                               
> > { 'command': 'exit-preconfig', 'allowed-in-preconfig': true } 
> > 
> >   
> 
