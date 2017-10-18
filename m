Received: from eggs.gnu.org ([2001:4830:134:3::10]:52558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4qGH-0004w3-5P
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4qGD-0000Hu-Lw
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:28:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4qGD-0000G6-Dr
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:27:57 -0400
Date: Wed, 18 Oct 2017 16:27:47 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171018152747.GK9719@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
	<20171017160926.GJ31897@redhat.com>
	<20171017181859.666cd9d0@nial.brq.redhat.com>
	<20171018125911.GB2942@localhost.localdomain>
	<20171018164435.5290db6a@nial.brq.redhat.com>
	<20171018144936.GJ9719@redhat.com>
	<20171018172412.58638543@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171018172412.58638543@nial.brq.redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, Oct 18, 2017 at 05:24:12PM +0200, Igor Mammedov wrote:
> On Wed, 18 Oct 2017 15:49:36 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> 
> > On Wed, Oct 18, 2017 at 04:44:35PM +0200, Igor Mammedov wrote:
> > > not sure I parse question but looking at libvirt's domain docs
> > > it mentions
> > >   <numa>
> > >     <cell id='0' cpus='0-3' memory='512000' unit='KiB'/>
> > >     <cell id='1' cpus='4-7' memory='512000' unit='KiB' memAccess='shared'/>
> > >   </numa>
> > > 
> > > here libvirt assumes that there are cpus with cpu-index in range 0-7
> > > /and probably duplicates logic that calculates cpu-index/
> > > If libvirt would continue to duplicate logic we could skip on
> > > implementing early runtime QMP in QEMU and also drop support for
> > > query-hotpluggable-cpus as libvirt would be able to compute
> > > properties/values on it's own.  
> > 
> > From the POV of the XML, these CPU numbers are *not* required to be
> > the same as any QEMU CPU index. This is just saying that we've got
> > a <vcpus>8</vcpu> element, and we want the first 4 CPUs in one node
> > and the second 4 in the second node. 
> > 
> > If QEMU assigns CPU indexes 70-77 internally, that's not relevant to
> > the XML POV, which uses 0-7 regardless. If there ever was such a
> > disjoint representation of CPU indexes libvirt would have to remap
> > whats in the XML to match whats in QEMU
> that's what I'm saying, libvirt has to knows which cpu-indexes are valid
> to use so it is able to build CLI which works:
>   "-numa node,nodeid=0,cpus=0-3 -numa node,nodeid=1cpus=4-7"
> and if algoritm that assigns cpu-indexes would change on QEMU side
> it would break libvirt.

That's why I think QEMU should libvirt assign 'id' values to each
CPU, just like we do for other devices/object. That way QEMU can
have whatever CPU index numbering scheme it likes and it has no
effect on the mgmt app.

> now to newer interface
>   "-numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1"
> libvirt would had to know that socket-id and values 0-1 are valid,
> now moving to spapr
>   "-numa cpu,node-id=0,core-id=0 -numa cpu,node-id=1,core-id=8"
> here valid values are not so obvious, core-id values are function
> of "-smp"
> 
> this series was written so that mgmt won't have to duplicate logic
> to match the same logic in qemu as libvirt didn't want to maintain
> it, I'd assume because it's fragile. If libvirt would make up valid
> properties/values on it's own we can forget about this series.

>From libvirt POV we all we want to say is have N sockets, each with M
cores, each with O threads. That is architecture agnostic and what I
was trying to illustrate with my earlier proposed CLI syntax.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
