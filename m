Received: from eggs.gnu.org ([2001:4830:134:3::10]:49358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6Zpf-0005FC-Tt
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6Zpb-0001uF-Aj
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:19:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6Zpb-0001tv-1E
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:19:39 -0400
Date: Mon, 23 Oct 2017 11:19:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023101925.GE16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
	<20171018153010.GL9719@redhat.com>
	<592659564.17712286.1508426482283.JavaMail.zimbra@redhat.com>
	<20171019152859.GV8408@redhat.com>
	<20171019195649.GJ2942@localhost.localdomain>
	<20171020090726.GD21172@redhat.com>
	<20171023120417.3ef1b74c@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023120417.3ef1b74c@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, peter maydell <peter.maydell@linaro.org>, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, Laine Stump <laine@redhat.com>, libvir-list@redhat.com

On Mon, Oct 23, 2017 at 12:04:17PM +0200, Igor Mammedov wrote:
> On Fri, 20 Oct 2017 10:07:27 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> 
> > On Thu, Oct 19, 2017 at 05:56:49PM -0200, Eduardo Habkost wrote:
> > > On Thu, Oct 19, 2017 at 04:28:59PM +0100, Daniel P. Berrange wrote:  
> > > > On Thu, Oct 19, 2017 at 11:21:22AM -0400, Igor Mammedov wrote:  
> > > > > ----- Original Message -----  
> > > > > > From: "Daniel P. Berrange" <berrange@redhat.com>
> > > > > > To: "Igor Mammedov" <imammedo@redhat.com>
> > > > > > Cc: "peter maydell" <peter.maydell@linaro.org>, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
> > > > > > qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au
> > > > > > Sent: Wednesday, October 18, 2017 5:30:10 PM
> > > > > > Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before machine_init() from HMP/QMP
> > > > > > 
> > > > > > On Tue, Oct 17, 2017 at 06:06:35PM +0200, Igor Mammedov wrote:  
> > > > > > > On Tue, 17 Oct 2017 16:07:59 +0100
> > > > > > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > > > > > >   
> > > > > > > > On Tue, Oct 17, 2017 at 09:27:02AM +0200, Igor Mammedov wrote:  
> > > > > > > > > On Mon, 16 Oct 2017 17:36:36 +0100
> > > > > > > > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > > > > > > > >     
> > > > > > > > > > On Mon, Oct 16, 2017 at 06:22:50PM +0200, Igor Mammedov wrote:  
> > > > > > > > > > > Series allows to configure NUMA mapping at runtime using QMP/HMP
> > > > > > > > > > > interface. For that to happen it introduces a new '-paused' CLI
> > > > > > > > > > > option
> > > > > > > > > > > which allows to pause QEMU before machine_init() is run and
> > > > > > > > > > > adds new set-numa-node HMP/QMP commands which in conjuction with
> > > > > > > > > > > info hotpluggable-cpus/query-hotpluggable-cpus allow to configure
> > > > > > > > > > > NUMA mapping for cpus.  
> > > > > > > > > > 
> > > > > > > > > > What's the problem we're seeking solve here compared to what we
> > > > > > > > > > currently
> > > > > > > > > > do for NUMA configuration ?  
> > > > > > > > > From RHBZ1382425
> > > > > > > > > "
> > > > > > > > > Current -numa CLI interface is quite limited in terms that allow map
> > > > > > > > > CPUs to NUMA nodes as it requires to provide cpu_index values which
> > > > > > > > > are non obvious and depend on machine/arch. As result libvirt has to
> > > > > > > > > assume/re-implement cpu_index allocation logic to provide valid
> > > > > > > > > values for -numa cpus=... QEMU CLI option.  
> > > > > > > > 
> > > > > > > > In broad terms, this problem applies to every device / object libvirt
> > > > > > > > asks QEMU to create. For everything else libvirt is able to assign a
> > > > > > > > "id" string, which is can then use to identify the thing later. The
> > > > > > > > CPU stuff is different because libvirt isn't able to provide 'id'
> > > > > > > > strings for each CPU - QEMU generates a psuedo-id internally which
> > > > > > > > libvirt has to infer. The latter is the same problem we had with
> > > > > > > > devices before '-device' was introduced allowing 'id' naming.
> > > > > > > > 
> > > > > > > > IMHO we should take the same approach with CPUs and start modelling
> > > > > > > > the individual CPUs as something we can explicitly create with -object
> > > > > > > > or -device. That way libvirt can assign names and does not have to
> > > > > > > > care about CPU index values, and it all works just the same way as
> > > > > > > > any other devices / object we create
> > > > > > > > 
> > > > > > > > ie instead of:
> > > > > > > > 
> > > > > > > >   -smp 8,sockets=4,cores=2,threads=1
> > > > > > > >   -numa node,nodeid=0,cpus=0-3
> > > > > > > >   -numa node,nodeid=1,cpus=4-7
> > > > > > > > 
> > > > > > > > we could do:
> > > > > > > > 
> > > > > > > >   -object numa-node,id=numa0
> > > > > > > >   -object numa-node,id=numa1
> > > > > > > >   -object cpu,id=cpu0,node=numa0,socket=0,core=0,thread=0
> > > > > > > >   -object cpu,id=cpu1,node=numa0,socket=0,core=1,thread=0
> > > > > > > >   -object cpu,id=cpu2,node=numa0,socket=1,core=0,thread=0
> > > > > > > >   -object cpu,id=cpu3,node=numa0,socket=1,core=1,thread=0
> > > > > > > >   -object cpu,id=cpu4,node=numa1,socket=2,core=0,thread=0
> > > > > > > >   -object cpu,id=cpu5,node=numa1,socket=2,core=1,thread=0
> > > > > > > >   -object cpu,id=cpu6,node=numa1,socket=3,core=0,thread=0
> > > > > > > >   -object cpu,id=cpu7,node=numa1,socket=3,core=1,thread=0  
> > > > > > > the follow up question would be where do "socket=3,core=1,thread=0"
> > > > > > > come from, currently these options are the function of
> > > > > > > (-M foo -smp ...) and can be queried vi query-hotpluggble-cpus at
> > > > > > > runtime after qemu parses -M and -smp options.  
> > > > > > 
> > > > > > NB, I realize my example was open to mis-interpretation. The values I'm
> > > > > > illustrating here for socket=3,core=1,thread=0 and *not* ID values, they
> > > > > > are a plain enumeration of values. ie this is saying the 4th socket, the
> > > > > > 2nd core and the 1st thread.  Internally QEMU might have the 2nd core
> > > > > > with a core-id of 8, or 7038 or whatever architecture specific numbering
> > > > > > scheme makes sense, but that's not what the mgmt app gives at the CLI
> > > > > > level  
> > > > > Even though fixed properties/values simplicity is tempting and it might even
> > > > > work for what we have implemented in qemu currently (well, SPAPR will need
> > > > > refactoring (if possible) to meet requirements + compat stuff for current
> > > > > machines with sparse IDs).
> > > > > But I have to disagree here and try to oppose it.
> > > > > 
> > > > > QEMU models concrete platforms/hw with certain non abstract properties
> > > > > and it's libvirt's domain to translate platform specific devices into
> > > > > 'spherical' devices with abstract properties.
> > > > > 
> > > > > Now back to cpus and suggestion to fix the set of 'address' properties
> > > > > and their values into continuous enumeration range [0..N). That would
> > > > >   1. put a burden of hiding platform/device details on QEMU
> > > > >       (which is already bad as QEMU's job is to emulate it)
> > > > >   2. with abstract 'address' properties and values, user won't have
> > > > >      a clue as to where device is being attached (as qemu would magically
> > > > >      remap that to fit specific machine needs)
> > > > >   2.1. if abstract 'address' properties and values we can do away with
> > > > >      socket/core/thread/whatnot since they won't mean the same when considered
> > > > >      from platform point of view, so we can just drop all these nonsense
> > > > >      and go back to cpu-index that has all the properties you've suggested
> > > > >      /abstract, [0..N]/.
> > > > >   3. we currently stopped with socket|core|thread-id properties as they are
> > > > >      applicable to machines that support -device cpu, but it's up to machine
> > > > >      to pick witch of these to use (x86: uses all, spar: uses core-id only),
> > > > >      but current property set is open for extension if need arises without
> > > > >      need to redefine interface. So fixed list of properties [even ignoring
> > > > >      values impact] doesn't scale.  
> > > > 
> > > > Note from the libvirt POV, we don't expose socket-id/core-id/thread-id in our
> > > > guest XML, we just provide an overall count of sockets/cores/threads which is
> > > > portable. The only arch specific thing we would have todo is express constraints
> > > > about ratios of these - eg indicate in some way that ppc doesn't allow mutliple
> > > > threads per core for example.
> > > >   
> > > > > We even have cpu-add command which takes cpu-index as argument and
> > > > > -numa node,cpus=0..X CLI option, good luck with figuring out which cpu goes
> > > > > where and if it makes any sense from platform point of view.
> > > > > 
> > > > > That's why when designing hot plug for 'device_add cpu' interface, we ended up
> > > > > with new query-hotpluggble-cpus QMP command, which is currently used by libvirt
> > > > > for hot-plug:
> > > > > 
> > > > > Approach allows 
> > > > >    1: machine to publish properties/values that make sense from emulated
> > > > >       platform point of view but still understandable by user of given hw.
> > > > >    2: user may use them as opaque mandatory properties to create cpu device if
> > > > >       he/she doesn't care about where it's plugged.
> > > > >    3: if user cares about which cpu goes where, properties defined by machine
> > > > >       provide that info from emulated hw point of view including platform specific
> > > > >       details.
> > > > >    4: it's easy to extend set of properties/values if need arises without
> > > > >       breaking users (provided user will put them all in -device/device_add
> > > > >       options as it's supposed to)
> > > > > 
> > > > > But current approach has drawback, to call query-hotpluggble-cpus, machine has to
> > > > > be started first, which is fine for hot plug but not for specifying CLI options.
> > > > > 
> > > > > Currently that could be solved by starting qemu twice when 'defining domain',
> > > > > where on the first run mgmt queries board layout and caches it for all the next
> > > > > times the defined machine is started (change in machine/version/-smp/-cpu will
> > > > > invalidate, cache).
> > > > > 
> > > > > This series allows to avoid this 1st time restart, when creating domain for
> > > > > the first time, mgmt can query layout and then specify numa mapping without
> > > > > restarting, it can cache defined mapping as commands exactly match corresponding
> > > > > CLI options and reuse cached options on the next domain starts.
> > > > > 
> > > > > This approach could be extended further with "device_add cpu" command
> > > > > so it would be possible to start qemu with -smp 0,... and allow mgmt to
> > > > > create cpus with explicit IDs controlled by mgmt, and again mgmt may cache
> > > > > these commands and reuse them on CLI next time machine is started
> > > > > 
> > > > > I think Eduardo's work on query-slots is superset of query-hotpluggble-cpus,
> > > > > but working to the same goal to allow mgmt discover which hw is provided by
> > > > > specific machine and where/which hw could be plugged (like which slot supports
> > > > > which kind of device and which 'address' should be used to attach device
> > > > > (socket|core... - for cpus, bus/function - for pic, ...)  
> > > > 
> > > > As mentioned elsewhere in the thread, the approach of defining the VM config
> > > > incrementally via the monitor has significant downsides, by making the config
> > > > invisible in any logs of the ARGV, and has likely performance impact when
> > > > starting up QEMU, particularly if it is used for more things going forward. To
> > > > me these downsides are enough to make the suggested approach for CPUs impractical
> > > > for libvirt to use.  
> > > 
> > > Those downsides do exist, but we should weight them against the
> > > downsides of not allowing any information at all to flow from
> > > QEMU to libvirt when starting a VM.
> > > 
> > > I believe the code in libvirt/src/qemu/qemu_domain_address.c is
> > > a good illustration of those downsides.  
> > 
> > Right, but for this NUMA / CPU scenario I don't think we're going to end up
> > with complexity like this. I still believe we are able to come up with a
> > way to represent it at the CLI without so much architecture specific
> > knowledge.
> Unfortunately cpu to node mapping isn't arch agnostic and requires
> understanding from upper layers when they compose QEMU CLI with it.

In terms of the guest config it manages, Libvirt doesn't care about the 
low level core-id, socket-id, thread-id values. It just knows from the
application it has to request 4 sockets, with 4 cores, with 2 threads.
Whether the cores get given core-id 0, 1, 2, 3 vs 1, 2, 16, 17 does not
matter to libvirt, nor the application using libvirt. So to avoid 
architecture differences at startup we just need to be able to configure
 the topology without referring to the arhitecture-specific integer ID 
values.

There are also some architecture constraints in respect of what combination
of sockets/core/threads are available with given CPU models. If we are to
avoid arch specific code, these constraints need to be exposed to libvirt,
which would in turn expose them to the application, to let the application
decide how to best setup the CPU topology when it creates the guest. For
this to be useful to the application it has to be provided separately from
guest startup, because eg, OpenStack decides this aspect of guest
configuration before it even decides what host to run the guest on, let
alone try to start the guest.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
