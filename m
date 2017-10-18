Received: from eggs.gnu.org ([2001:4830:134:3::10]:57151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4nRV-0003nN-IT
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4nRR-00083n-KZ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:27:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4nRR-000837-Eh
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:27:21 -0400
Date: Wed, 18 Oct 2017 13:27:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171018122715.GF9719@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<32e47d96-0292-4511-adb2-24a4766b3027@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32e47d96-0292-4511-adb2-24a4766b3027@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, david@gibson.dropbear.id.au

On Wed, Oct 18, 2017 at 02:19:54PM +0200, Paolo Bonzini wrote:
> On 17/10/2017 17:07, Daniel P. Berrange wrote:
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
> > 
> > (perhaps -device instead of -object above, but that's a minor detail)
> 
> I understand that this is just an example, but wasn't this what is solved by
> 
>   -smp 8,sockets=4,cores=2,thread=1
>   -numa node,nodeid=0 -numa cpu,node-id=0,socket-id=0-1
>   -numa node,nodeid=1 -numa cpu,node-id=0,socket-id=2-3

IIUC, that lets you associate CPUs with NUMA nodes without having to know
the internal QEMU indexes. It won't help you with any monitor commands you
need to run later that expect the CPU index as input value.  My example
where lets you assign IDs to each CPU, which can then be used for montor
commands too - i should have illustrated that bit of it too.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
