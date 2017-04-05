Received: from eggs.gnu.org ([2001:4830:134:3::10]:60858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1cvi0j-00053A-6N
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1cvi0f-0000kB-0S
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:17:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:43455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <he.chen@linux.intel.com>)
	id 1cvi0e-0000jd-Kn
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:17:52 -0400
Date: Wed, 5 Apr 2017 18:17:54 +0800
From: He Chen <he.chen@linux.intel.com>
Message-ID: <20170405101754.GB29512@he>
References: <1491042326-24335-1-git-send-email-he.chen@linux.intel.com>
	<20170403083851.u6f7ktakdqtmzwhj@kamzik.brq.redhat.com>
	<3d69719c-914e-0538-e816-7a613a6af95e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d69719c-914e-0538-e816-7a613a6af95e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] Allow setting NUMA distance for
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
Cc: Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Apr 03, 2017 at 01:58:34PM -0500, Eric Blake wrote:
> On 04/03/2017 03:38 AM, Andrew Jones wrote:
> > On Sat, Apr 01, 2017 at 06:25:26PM +0800, He Chen wrote:
> >> Current, QEMU does not provide a clear command to set vNUMA distance for
> >> guest although we already have `-numa` command to set vNUMA nodes.
> >>
> 
> >> +++ b/qapi-schema.json
> >> @@ -5644,10 +5644,14 @@
> >>  ##
> >>  # @NumaOptionsType:
> >>  #
> >> +# @node: NUMA nodes configuration
> >> +#
> >> +# @dist: NUMA distance configuration
> >> +#
> 
> Missing a '(since 2.10)' tag on @dist.
> 
> 
> >>  ##
> >> +# @NumaDistOptions:
> >> +#
> >> +# Set the distance between 2 NUMA nodes.
> >> +#
> >> +# @src: source NUMA node.
> >> +#
> >> +# @dst: destination NUMA node.
> >> +#
> >> +# @val: NUMA distance from source node to destination node.
> 
> Missing mention of the magic of 255.
> 
> >> +#
> >> +# Since: 2.10
> >> +##
> >> +{ 'struct': 'NumaDistOptions',
> >> +  'data': {
> >> +   'src': 'uint16',
> >> +   'dst': 'uint16',
> >> +   'val': 'uint8' }}
> >> +
> 
> Is a user allowed to pass { "src":0, "dst":0, "val":11 }, or do you
> hard-validate that the diagonal of the matrix is always 10 (the user can
> omit it, but if specified it must be 10).  Do you enforce that no
> distance is less than 10?
> 

I see your concern, I think it's reasonable that a user is allowed to
set distance 11 to local node but qemu refuses and complains about it.

If the distance of local is omitted, qemu can fill it, but if specified,
I think it must be 10.

In current version patch, the distance is enforced to be >= 10, this
check is done in numa_distance_parser.
Anyway, I will imporve it in next patch, thanks for your review.

> >> +@var{source} and @var{destination} are NUMA node IDs.
> >> +@var{distance} is the NUMA distance from @var{source} to @var{destination}.
> >> +The distance from node A to node B may be different from the distance from
> >> +node B to node A as the distance can to be asymmetrical. If a node is
> >> +unreachable, set 255 as distance.
> > 
> > The distance from a node to itself is always 10.  If no distance values
> > are given for node pairs, then the default distance of 20 is used for each
> > pair.  If any pair of nodes is given a distance, then all pairs must be
> > given distances.  Although, when distances are only given in one direction
> > for each pair of nodes, then the distances in the opposite directions are
> > assumed to be the same.  If, however, an asymmetrical pair of distances is
> > given for even one node pair, then all node pairs must be provided
> > distance values for both directions, even when they are symmetrical.  When
> > a node is unreachable from another node, set the pair's distance to 255.
> 
> I don't like duplication where it is not necessary, but don't know if
> there's an easy way to make the .json file and qemu-options.hx refer to
> one another, since they both feed separate user-visible documentation.
> So you may have to repeat some of this in the .json file (such as my
> mention above that at least documenting that 255 is special).
> 

I am afraid that I am not an expert in qapi, I do see some parts in
these two files are duplicate and I am not sure I can deal with it well,
if you agree, I may probably just document magic 255 in next patch.

Thanks,
-He
