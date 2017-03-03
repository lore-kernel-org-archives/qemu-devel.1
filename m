Received: from eggs.gnu.org ([2001:4830:134:3::10]:43606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjqjK-00040E-LS
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjqjF-0000tB-Na
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:10:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjqjF-0000sm-9X
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:10:53 -0500
Date: Fri, 3 Mar 2017 14:10:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170303171050.GA2778@thinpad.lan.raisama.net>
References: <1488517304-23131-1-git-send-email-he.chen@linux.intel.com>
	<20170303135704.GX2778@thinpad.lan.raisama.net>
	<d93b2ebb-c5a3-a774-30fd-2d92c7703549@redhat.com>
	<20170303162611.GE13631@redhat.com>
	<20170303164751.GY2778@thinpad.lan.raisama.net>
	<20170303165218.GI13631@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303165218.GI13631@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, He Chen <he.chen@linux.intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Mar 03, 2017 at 04:52:18PM +0000, Daniel P. Berrange wrote:
> On Fri, Mar 03, 2017 at 01:47:51PM -0300, Eduardo Habkost wrote:
> > On Fri, Mar 03, 2017 at 04:26:12PM +0000, Daniel P. Berrange wrote:
> > > On Fri, Mar 03, 2017 at 10:09:22AM -0600, Eric Blake wrote:
> > > > On 03/03/2017 07:57 AM, Eduardo Habkost wrote:
> > > > 
> > > > >> With this patch, when a user wants to create a guest that contains
> > > > >> several vNUMA nodes and also wants to set distance among those nodes,
> > > > >> the QEMU command would like:
> > > > >>
> > > > >> ```
> > > > >> -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=0,policy=bind,id=node0 \
> > > > >> -numa node,nodeid=0,cpus=0,memdev=node0,distance=10,distance=21,distance=31,distance=41 \
> > > > 
> > > > > 
> > > > > It would be nice to have a more intuitive syntax to represent
> > > > > ordered lists in QemuOpts. But this is what we have today.
> > > > > 
> > > > 
> > > > Markus has the discussion on representing arrays via the command line;
> > > > particularly since this array is very tightly coupled to the order in
> > > > which values are presented, it may be worth having:
> > > > 
> > > > -numa
> > > > node,nodeid=0,cpus=0,memdev=nod0,distance.0=10,distance.1=21,distance.2=31,distance.3=41
> > > > 
> > > > with the explicit distance.0= suffixes to distance making it more
> > > > obvious that we are dealing with an array.
> > > > 
> > > > > I think the proposal makes sense. I would like the semantics of the new option
> > > > > to be documented at qapi-schema.json and qemu-options.hx.
> > > > > 
> > > > > I would call the new NumaNodeOptions field "distances", as it is
> > > > > a list of distances.
> > > > 
> > > > Indeed, Markus is trying (with his work on -blockdev for 2.9) to get the
> > > > command line to a point where it is identical to the QMP code, by
> > > > reusing qapi-schema.json, so we should very much keep that in mind with
> > > > whatever we add to -numa in 2.10.
> > > > 
> > > > 
> > > > > but in the future we could support something like:
> > > > > 
> > > > >   -numa node,nodeid=0,cpus=0,memdev=node0 \
> > > > >   -numa node,nodeid=1,cpus=1,memdev=node1 \
> > > > >   -numa node,nodeid=2,cpus=2,memdev=node2 \
> > > > >   -numa node,nodeid=3,cpus=3,memdev=node3 \
> > > > >   -numa distances,distances[0][0]=10,distances[0][1]=21,distances[0][2]=31,distances[0][3]=41,\
> > > > >                   distances[1][0]=21,distances[1][1]=10,distances[1][2]=21,distances[1][3]=31,\
> > > > >                   distances[2][0]=31,distances[2][1]=21,distances[2][2]=10,distances[2][3]=21,\
> > > > >                   distances[3][0]=41,distances[3][1]=31,distances[3][2]=21,distances[3][3]=10
> > > > 
> > > > Except that [] requires special shell quoting, so the proposal would be
> > > > more like:
> > > > 
> > > > -numa distances.0.0=10,distances.0.1=21
> > > > 
> > > > Right now, QMP doesn't support 2-D arrays (although this may be a good
> > > > reason to introduce support), so that's also something to think about
> > > > (not insurmountable, but makes the task more complex).
> > > 
> > > What I don't like about this syntax is that it is duplicating information
> > > twice. IIUC the NUMA distance information is unidirectional, so specifying
> > > the same data for both direetions (node 0 -> node 3, and node 3 -> node 0)
> > > looks like overkill. Also the self-node distance isi defined to always be
> > > 10 IIUC, so specifying that is not required. IOW, could cut down the data
> > > we need to provider to just
> > > 
> > >    -numa distances,nodea=0,nodeb=1,value=20
> > >    -numa distances,nodea=0,nodeb=2,value=20
> > >    -numa distances,nodea=0,nodeb=3,value=20
> > >    -numa distances,nodea=1,nodeb=2,value=20
> > >    -numa distances,nodea=1,nodeb=3,value=20
> > >    -numa distances,nodea=2,nodeb=3,value=20
> > 
> > The ACPI spec (I'm looking at revision 5.0) explicitly mentions
> > that A->B distance may be different from B->A distrance:
> > 
> > "The entry value is a one-byte unsigned integer. The relative
> > distance from System Locality i to System Locality j is the
> > i*N + j entry in the matrix, where N is the number of System
> > Localities.  Except for the relative distance from a System
> > Locality to itself, each relative distance is stored twice in the
> > matrix. This provides the capability to describe the scenario
> > where the relative distances for the two directions between
> > System Localities is different."
> 
> Ah interesting, learn something new every day ? I've only made
> that unidirectional assumption for the last 10 years ;-P
> 
> > But I agree we could figure out a more compact syntax for more
> > common cases where self-node distance is 10 and distance is the
> > same both ways.
> 
> QAPI would need a specialized numeric matrix type, which we could
> efficiently map into some CLI syntax, in order to avoid needing to
> tickle the rather verbose general purpose list syntax. Probably
> not worth the hassle though - rather than just picking shorter
> variable names eg
> 
>   -numa dist,a=0,b=1,val=3
> 
> instead of
> 
>   -numa distances,nodea=0,nodeb=1,value=20

Whatever syntax/names we choose, we could have reasonable
defaults for omitted values:

* If A->B is set and B->A is omitted, use the same value for both
  A->B and B->A
* If A->A is omitted, use min(10, configured_distances)

This way, the previous example:

   -numa distances,distances.0.0=10,distances.0.1=21,distances.0.2=31,distances.0.3=41,\
                   distances.1.0=21,distances.1.1=10,distances.1.2=21,distances.1.3=31,\
                   distances.2.0=31,distances.2.1=21,distances.2.2=10,distances.2.3=21,\
                   distances.3.0=41,distances.3.1=31,distances.3.2=21,distances.3.3=10

could be written as:

   -numa distances,distances.0.1=21,distances.0.2=31,distances.0.3=41,\
                                    distances.1.2=21,distances.1.3=31,\
                                                     distances.2.3=21

-- 
Eduardo
