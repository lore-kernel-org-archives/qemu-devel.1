Received: from eggs.gnu.org ([209.51.188.92]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghvpa-0002T9-7l
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghvpM-0002K2-5B
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:22:25 -0500
Date: Fri, 11 Jan 2019 13:21:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111122151.GF5010@dhcp-200-186.str.redhat.com>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

Am 11.01.2019 um 12:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 11.01.2019 13:41, Kevin Wolf wrote:
> > Am 10.01.2019 um 14:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> drv_co_block_status digs bs->file for additional, more accurate search
> >> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
> >>
> >> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> >> knows, where are holes and where is data. But every block_status
> >> request calls lseek additionally. Assume a big disk, full of
> >> data, in any iterative copying block job (or img convert) we'll call
> >> lseek(HOLE) on every iteration, and each of these lseeks will have to
> >> iterate through all metadata up to the end of file. It's obviously
> >> ineffective behavior. And for many scenarios we don't need this lseek
> >> at all.
> >>
> >> So, let's "5daa74a6ebc" by default, leaving an option to return
> >> previous behavior, which is needed for scenarios with preallocated
> >> images.
> >>
> >> Add iotest illustrating new option semantics.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > 
> > I still think that an option isn't a good solution and we should try use
> > some heuristics instead.
> 
> Do you think that heuristics would be better than fair cache for lseek
> results?

I don't think lseek() results are cachable, at least for images that can
share BLK_PERM_WRITE between processes.

> I don't see good heuristics, neither want to implement lseek optimizations.
> In our cases we don't need lseek under qcow2 at all, and it's obviously better
> just don't lseek in these cases.

I suggested one: Pass large contiguous allocated ranges to the protocol
driver, but just assume that the allocation status is correct in the
format layer if they are small.

> Moreover, as I understand, the cases when we need lseek are those when qcow2 thinks
> that the cluster is data, but actually it's a hole on fs... Isn't it better to
> support this thing in qcow2? A kind of allocated-zeroes cluster? We have enough
> reserved bits in cluster descriptor to add this feature. And than we don't need
> this kind of cheating when user "better knows" where are holes than format layer
> which owns the data..

The point of metadata preallocation is that you don't have to update the
metadata when you write to the image. Having to clear a bit in the L2
entry would negate that.

Maybe another option would be to use a compatible feature flag in qcow2
that is set during creation with preallocation=metadata, and we would
only go to the lower layer if the flag is set. The downside side is that
this would only be effective for new images, so copying old preallocated
images would be slowed down considerably.

Kevin
