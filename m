Received: from eggs.gnu.org ([2001:4830:134:3::10]:53046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4qIV-00069Y-RE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4qIS-0001ZM-KD
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:30:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4qIS-0001XZ-89
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:30:16 -0400
Date: Wed, 18 Oct 2017 16:30:10 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171018153010.GL9719@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171017180635.6a900616@nial.brq.redhat.com>
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
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Tue, Oct 17, 2017 at 06:06:35PM +0200, Igor Mammedov wrote:
> On Tue, 17 Oct 2017 16:07:59 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> 
> > On Tue, Oct 17, 2017 at 09:27:02AM +0200, Igor Mammedov wrote:
> > > On Mon, 16 Oct 2017 17:36:36 +0100
> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > >   
> > > > On Mon, Oct 16, 2017 at 06:22:50PM +0200, Igor Mammedov wrote:  
> > > > > Series allows to configure NUMA mapping at runtime using QMP/HMP
> > > > > interface. For that to happen it introduces a new '-paused' CLI option
> > > > > which allows to pause QEMU before machine_init() is run and
> > > > > adds new set-numa-node HMP/QMP commands which in conjuction with
> > > > > info hotpluggable-cpus/query-hotpluggable-cpus allow to configure
> > > > > NUMA mapping for cpus.    
> > > > 
> > > > What's the problem we're seeking solve here compared to what we currently
> > > > do for NUMA configuration ?  
> > > From RHBZ1382425
> > > "
> > > Current -numa CLI interface is quite limited in terms that allow map
> > > CPUs to NUMA nodes as it requires to provide cpu_index values which 
> > > are non obvious and depend on machine/arch. As result libvirt has to
> > > assume/re-implement cpu_index allocation logic to provide valid 
> > > values for -numa cpus=... QEMU CLI option.  
> > 
> > In broad terms, this problem applies to every device / object libvirt
> > asks QEMU to create. For everything else libvirt is able to assign a
> > "id" string, which is can then use to identify the thing later. The
> > CPU stuff is different because libvirt isn't able to provide 'id'
> > strings for each CPU - QEMU generates a psuedo-id internally which
> > libvirt has to infer. The latter is the same problem we had with
> > devices before '-device' was introduced allowing 'id' naming.
> > 
> > IMHO we should take the same approach with CPUs and start modelling 
> > the individual CPUs as something we can explicitly create with -object
> > or -device. That way libvirt can assign names and does not have to 
> > care about CPU index values, and it all works just the same way as
> > any other devices / object we create
> > 
> > ie instead of:
> > 
> >   -smp 8,sockets=4,cores=2,threads=1
> >   -numa node,nodeid=0,cpus=0-3
> >   -numa node,nodeid=1,cpus=4-7
> > 
> > we could do:
> > 
> >   -object numa-node,id=numa0
> >   -object numa-node,id=numa1
> >   -object cpu,id=cpu0,node=numa0,socket=0,core=0,thread=0
> >   -object cpu,id=cpu1,node=numa0,socket=0,core=1,thread=0
> >   -object cpu,id=cpu2,node=numa0,socket=1,core=0,thread=0
> >   -object cpu,id=cpu3,node=numa0,socket=1,core=1,thread=0
> >   -object cpu,id=cpu4,node=numa1,socket=2,core=0,thread=0
> >   -object cpu,id=cpu5,node=numa1,socket=2,core=1,thread=0
> >   -object cpu,id=cpu6,node=numa1,socket=3,core=0,thread=0
> >   -object cpu,id=cpu7,node=numa1,socket=3,core=1,thread=0
> the follow up question would be where do "socket=3,core=1,thread=0"
> come from, currently these options are the function of
> (-M foo -smp ...) and can be queried vi query-hotpluggble-cpus at
> runtime after qemu parses -M and -smp options.

NB, I realize my example was open to mis-interpretation. The values I'm
illustrating here for socket=3,core=1,thread=0 and *not* ID values, they
are a plain enumeration of values. ie this is saying the 4th socket, the
2nd core and the 1st thread.  Internally QEMU might have the 2nd core
with a core-id of 8, or 7038 or whatever architecture specific numbering
scheme makes sense, but that's not what the mgmt app gives at the CLI
level


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
