Received: from eggs.gnu.org ([2001:4830:134:3::10]:35777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4pE2-0003XQ-MI
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4pDy-0002XD-HW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4pDy-0002WS-8s
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:21:34 -0400
Date: Wed, 18 Oct 2017 16:21:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171018162125.7dcf0b15@nial.brq.redhat.com>
In-Reply-To: <20171018122715.GF9719@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<32e47d96-0292-4511-adb2-24a4766b3027@redhat.com>
	<20171018122715.GF9719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, david@gibson.dropbear.id.au

On Wed, 18 Oct 2017 13:27:15 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Wed, Oct 18, 2017 at 02:19:54PM +0200, Paolo Bonzini wrote:
> > On 17/10/2017 17:07, Daniel P. Berrange wrote:  
> > > ie instead of:
> > > 
> > >   -smp 8,sockets=4,cores=2,threads=1
> > >   -numa node,nodeid=0,cpus=0-3
> > >   -numa node,nodeid=1,cpus=4-7
> > > 
> > > we could do:
> > > 
> > >   -object numa-node,id=numa0
> > >   -object numa-node,id=numa1
> > >   -object cpu,id=cpu0,node=numa0,socket=0,core=0,thread=0
> > >   -object cpu,id=cpu1,node=numa0,socket=0,core=1,thread=0
> > >   -object cpu,id=cpu2,node=numa0,socket=1,core=0,thread=0
> > >   -object cpu,id=cpu3,node=numa0,socket=1,core=1,thread=0
> > >   -object cpu,id=cpu4,node=numa1,socket=2,core=0,thread=0
> > >   -object cpu,id=cpu5,node=numa1,socket=2,core=1,thread=0
> > >   -object cpu,id=cpu6,node=numa1,socket=3,core=0,thread=0
> > >   -object cpu,id=cpu7,node=numa1,socket=3,core=1,thread=0
> > > 
> > > (perhaps -device instead of -object above, but that's a minor detail)  
> > 
> > I understand that this is just an example, but wasn't this what is solved by
> > 
> >   -smp 8,sockets=4,cores=2,thread=1
> >   -numa node,nodeid=0 -numa cpu,node-id=0,socket-id=0-1
> >   -numa node,nodeid=1 -numa cpu,node-id=0,socket-id=2-3  
> 
> IIUC, that lets you associate CPUs with NUMA nodes without having to know
> the internal QEMU indexes. 
yep with -numa cpu, user don't need to know cpu_index-es anymore,
but the next thing to know for user is:
  1: set of properties machine supports
      x86: "{socket|core|thread}-id"
      spapr: "core-id"
      s390: ...
  2: what values to use for above properties,
     they might be 0..n interval but also might be sparse
     (spapr for example), in other words values owned by machine
     and might also depend on its version.

above 2 points were a reason why query-hotpluggable-cpus
had been introduced so that mgmt would query qemu for valid set
of properties/values for a given set of options so it could
compose a valid device_add command for hotplug.

I'm not opposed to adding
  -smp 0 -device foo-cpu,id=cpuX,...
as Daniel suggests but libvirt would have to implement logic that
makes up #1+#2 (which probably means duplicating it from qemu)


>It won't help you with any monitor commands you
> need to run later that expect the CPU index as input value.  My example
> where lets you assign IDs to each CPU, which can then be used for montor
> commands too - i should have illustrated that bit of it too.
monitor commands that take cpu-index is a separate not related story though.
They needs to be worked on to use socket|core|thread-id where it makes
sense.
(
For ex: spapr core can't be used as address with 'cpu' command as it
expects to thread level object stored and other commands would operate on/
expect CPUState being pointed out. Introducing explicit ID set by mgmt
won't be of use here either is it will set for core object while children
threads will be name-less.
In such usecases we can use qom path to thread of interest which
could be queried in runtime with query-cpus that gives thread level view.
)
 
> Regards,
> Daniel
