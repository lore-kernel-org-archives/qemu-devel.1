Received: from eggs.gnu.org ([2001:4830:134:3::10]:59638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQwoQ-0002xR-Fm
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQwoP-0006bL-JG
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:22:22 -0400
Date: Fri, 30 Jun 2017 16:22:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170630142211.GB4776@noname.redhat.com>
References: <20170627163145.GC4792@noname.redhat.com>
	<w51shihd3y2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51shihd3y2.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] QMP design: Fixing query-block
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

Am 30.06.2017 um 15:01 hat Alberto Garcia geschrieben:
> On Tue 27 Jun 2017 06:31:45 PM CEST, Kevin Wolf wrote:
> > * Speaking of recursion: ImageInfo recursively includes information
> >   about all images in the backing chain. This is what makes the output
> >   of query-named-block-nodes so redundant. It is also inconsistent
> >   because the runtime information (BlockInfo/BlockDeviceInfo) isn't
> >   recursive.
> 
> I've also been told of cases where a query-block command on a VM with a
> very large amount of images in all backing chains would slow down the
> guest because of this recursion.
> 
> I haven't been able to reproduce this problem myself, but being able to
> see only the devices seen by the guest (as opposed to the complete
> graph) seems like a good idea.

I think the information only really becomes redundant if you use
query-named-block-nodes because then you list every backing file node
and each of them contains the recursive information.

With query-block, you start at the top and include the information for
each image in the backing file chain only once. If we did indeed have a
problem there, that might mean that we do in fact need filtering to
reduce the overhead. But I don't think any of the information involves
any I/O to get, so it seems unlikely to me that this would make a big
difference.

Kevin
