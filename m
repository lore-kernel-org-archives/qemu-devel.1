Received: from eggs.gnu.org ([209.51.188.92]:46767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0qRO-0007lp-KI
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0qRH-0005wu-LY
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:27:46 -0500
Date: Mon, 4 Mar 2019 16:27:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190304162723.GP4239@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304132507.39273826@redhat.com>
	<20190304123908.GK4239@redhat.com>
	<20190304151641.3deefc3b@redhat.com>
	<20190304142432.GM4239@redhat.com>
	<20190304161932.0438c880@redhat.com>
	<ae0335fb-9201-e09d-80ad-5e497365267b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae0335fb-9201-e09d-80ad-5e497365267b@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, david@gibson.dropbear.id.au

On Mon, Mar 04, 2019 at 05:12:40PM +0100, Michal Privoznik wrote:
> On 3/4/19 4:19 PM, Igor Mammedov wrote:
> 
> > Then I'd guess that most VMs end up with default '-numa node,mem'
> > which by design can produce only fake NUMA without ability to manage
> > guest RAM on host side. So such VMs aren't getting performance benefits
> > or worse run with performance regression (due to wrong sched/mm decisions
> > as guest kernel assumes NUMA topology is valid one).
> 
> Specifying NUMA distances in libvirt XML makes it generate the modern cmd
> line.

AFAIK, specifying any guest NUMA -> Host NUMA affinity makes it use the
modern cmd line. eg I  just modified a plain 8 CPU / 2 GB RAM guest
with this:

  <numatune>
    <memnode cellid='0' mode='strict' nodeset='0'/>
    <memnode cellid='1' mode='strict' nodeset='1'/>
  </numatune>
  <cpu mode='host-model'>
    <numa>
      <cell id='0' cpus='0-3' memory='1024000' unit='KiB'/>
      <cell id='1' cpus='4-7' memory='1024000' unit='KiB'/>
    </numa>
  </cpu>

and I can see libvirt decided to use memdev

  -object memory-backend-ram,id=ram-node0,size=1048576000,host-nodes=0,policy=bind
  -numa node,nodeid=0,cpus=0-3,memdev=ram-node0
  -object memory-backend-ram,id=ram-node1,size=1048576000,host-nodes=1,policy=bind
  -numa node,nodeid=1,cpus=4-7,memdev=ram-node1 

So unless I'm missing something, we aren't suffering from the problem
described by Igor above even today.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
