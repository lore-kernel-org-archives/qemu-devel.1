Received: from eggs.gnu.org ([2001:4830:134:3::10]:51091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cmNfk-0003we-VM
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cmNfh-0005AN-SW
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:45:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cmNfh-00059C-JP
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:45:41 -0500
Date: Fri, 10 Mar 2017 16:45:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170310164536.GO32264@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1489141097-28587-1-git-send-email-he.chen@linux.intel.com>
	<89688700-069c-1700-b226-0c1e81203c76@redhat.com>
	<20170310163859.GN32264@redhat.com>
	<20170310184025-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170310184025-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] x86: Allow to set NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Mar 10, 2017 at 06:40:52PM +0200, Michael S. Tsirkin wrote:
> On Fri, Mar 10, 2017 at 04:38:59PM +0000, Daniel P. Berrange wrote:
> > On Fri, Mar 10, 2017 at 10:37:08AM -0600, Eric Blake wrote:
> > > On 03/10/2017 04:18 AM, He Chen wrote:
> > > > Current, QEMU does not provide a clear command to set vNUMA distance for
> > > > guest although we already have `-numa` command to set vNUMA nodes.
> > > > 
> > > 
> > > > 
> > > > This patch is going to add SLIT table support in QEMU, and provides
> > > > addtional option `dist` for command `-numa` to allow user set vNUMA
> > > 
> > > s/addtional/additional/
> > > 
> > > > distance by QEMU command.
> > > > 
> > > > With this patch, when a user wants to create a guest that contains
> > > > several vNUMA nodes and also wants to set distance among those nodes,
> > > > the QEMU command would like:
> > > > 
> > > > ```
> > > > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=0,policy=bind,id=node0 \
> > > > -numa node,nodeid=0,cpus=0,memdev=node0 \
> > > > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=1,policy=bind,id=node1 \
> > > > -numa node,nodeid=1,cpus=1,memdev=node1 \
> > > > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=2,policy=bind,id=node2 \
> > > > -numa node,nodeid=2,cpus=2,memdev=node2 \
> > > > -object memory-backend-ram,size=1G,prealloc=yes,host-nodes=3,policy=bind,id=node3 \
> > > > -numa node,nodeid=3,cpus=3,memdev=node3 \
> > > > -numa dist,a=0,b=1,val=21 \
> > > > -numa dist,a=0,b=2,val=31 \
> > > > -numa dist,a=0,b=3,val=41 \
> > > > -numa dist,a=1,b=0,val=21 \
> > > > ...
> > > > ```
> > > 
> > > 
> > > > +++ b/qapi-schema.json
> > > > @@ -5647,7 +5647,7 @@
> > > >  # Since: 2.1
> > > >  ##
> > > >  { 'enum': 'NumaOptionsType',
> > > > -  'data': [ 'node' ] }
> > > > +  'data': [ 'node', 'dist' ] }
> > > 
> > > Missing documentation, including the fact that 'dist' is added in 2.10
> > > (you've missed 2.9).
> > > 
> > > >  
> > > >  ##
> > > > +# @NumaDistOptions:
> > > > +#
> > > > +# Set distance between 2 NUMA nodes. (for OptsVisitor)
> > > > +#
> > > > +# @a: first NUMA node.
> > > > +#
> > > > +# @b: second NUMA node.
> > > > +#
> > > > +# @val: NUMA distance between 2 given NUMA nodes.
> > > > +#
> > > > +# Since: 2.9
> > > 
> > > This is a new feature, but you've missed soft freeze; this will have to
> > > be 2.10.
> > > 
> > > > +##
> > > > +{ 'struct': 'NumaDistOptions',
> > > > +  'data': {
> > > > +   'a':   'uint8',
> > > > +   'b':   'uint8',
> > > > +   'val': 'uint8' }}
> > > 
> > > Using uint8 limits us to at most 256 numa nodes. Is that going to bite
> > > us in the future?
> > > 
> > > Is 'a' and 'b' really the best naming convention to use (it's concise,
> > > but maybe 'first' and 'second', or 'source' and 'destination' is better)?
> > 
> > 'src' and 'dst' are probably a reasnoable compromise between meaningful
> > and short.
> 
> AFAIK the distance is assumed to be symmetrical, src/dst seems
> to imply asymmetry.

No, the distance needs to be asymmetrical - see discussions under previous
postings of this patch.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
