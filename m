Received: from eggs.gnu.org ([2001:4830:134:3::10]:58194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjq2D-0001Pj-3r
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjq27-0000ur-W0
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:26:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjq27-0000uE-Mp
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:26:19 -0500
Date: Fri, 3 Mar 2017 16:26:12 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170303162611.GE13631@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1488517304-23131-1-git-send-email-he.chen@linux.intel.com>
	<20170303135704.GX2778@thinpad.lan.raisama.net>
	<d93b2ebb-c5a3-a774-30fd-2d92c7703549@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d93b2ebb-c5a3-a774-30fd-2d92c7703549@redhat.com>
Subject: Re: [Qemu-devel] [RFC] x86: Allow to set NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, He Chen <he.chen@linux.intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Mar 03, 2017 at 10:09:22AM -0600, Eric Blake wrote:
> On 03/03/2017 07:57 AM, Eduardo Habkost wrote:
> 
> >> With this patch, when a user wants to create a guest that contains
> >> several vNUMA nodes and also wants to set distance among those nodes,
> >> the QEMU command would like:
> >>
> >> ```
> >> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=0,policy=bind,id=node0 \
> >> -numa node,nodeid=0,cpus=0,memdev=node0,distance=10,distance=21,distance=31,distance=41 \
> 
> > 
> > It would be nice to have a more intuitive syntax to represent
> > ordered lists in QemuOpts. But this is what we have today.
> > 
> 
> Markus has the discussion on representing arrays via the command line;
> particularly since this array is very tightly coupled to the order in
> which values are presented, it may be worth having:
> 
> -numa
> node,nodeid=0,cpus=0,memdev=nod0,distance.0=10,distance.1=21,distance.2=31,distance.3=41
> 
> with the explicit distance.0= suffixes to distance making it more
> obvious that we are dealing with an array.
> 
> > I think the proposal makes sense. I would like the semantics of the new option
> > to be documented at qapi-schema.json and qemu-options.hx.
> > 
> > I would call the new NumaNodeOptions field "distances", as it is
> > a list of distances.
> 
> Indeed, Markus is trying (with his work on -blockdev for 2.9) to get the
> command line to a point where it is identical to the QMP code, by
> reusing qapi-schema.json, so we should very much keep that in mind with
> whatever we add to -numa in 2.10.
> 
> 
> > but in the future we could support something like:
> > 
> >   -numa node,nodeid=0,cpus=0,memdev=node0 \
> >   -numa node,nodeid=1,cpus=1,memdev=node1 \
> >   -numa node,nodeid=2,cpus=2,memdev=node2 \
> >   -numa node,nodeid=3,cpus=3,memdev=node3 \
> >   -numa distances,distances[0][0]=10,distances[0][1]=21,distances[0][2]=31,distances[0][3]=41,\
> >                   distances[1][0]=21,distances[1][1]=10,distances[1][2]=21,distances[1][3]=31,\
> >                   distances[2][0]=31,distances[2][1]=21,distances[2][2]=10,distances[2][3]=21,\
> >                   distances[3][0]=41,distances[3][1]=31,distances[3][2]=21,distances[3][3]=10
> 
> Except that [] requires special shell quoting, so the proposal would be
> more like:
> 
> -numa distances.0.0=10,distances.0.1=21
> 
> Right now, QMP doesn't support 2-D arrays (although this may be a good
> reason to introduce support), so that's also something to think about
> (not insurmountable, but makes the task more complex).

What I don't like about this syntax is that it is duplicating information
twice. IIUC the NUMA distance information is unidirectional, so specifying
the same data for both direetions (node 0 -> node 3, and node 3 -> node 0)
looks like overkill. Also the self-node distance isi defined to always be
10 IIUC, so specifying that is not required. IOW, could cut down the data
we need to provider to just

   -numa distances,nodea=0,nodeb=1,value=20
   -numa distances,nodea=0,nodeb=2,value=20
   -numa distances,nodea=0,nodeb=3,value=20
   -numa distances,nodea=1,nodeb=2,value=20
   -numa distances,nodea=1,nodeb=3,value=20
   -numa distances,nodea=2,nodeb=3,value=20


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
