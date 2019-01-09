Received: from eggs.gnu.org ([209.51.188.92]:50316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghBxQ-0007At-54
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghBxP-0002AS-9r
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:23:36 -0500
Date: Wed, 9 Jan 2019 12:23:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109112311.GB4867@localhost.localdomain>
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108194552.45453-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: add rough-block-status
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org

Am 08.01.2019 um 20:45 hat Vladimir Sementsov-Ogievskiy geschrieben:
> bdrv_co_block_status digs bs->file for additional, more accurate search
> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
> 
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> knows, where are holes and where is data. But every block_status
> request calls lseek additionally. Assume a big disk, full of
> data, in any iterative copying block job (or img convert) we'll call
> lseek(HOLE) on every iteration, and each of these lseeks will have to
> iterate through all metadata up to the end of file. It's obviously
> ineffective behavior. And for many scenarios we don't need this lseek
> at all.
> 
> So, add an option to omit calling lseek.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I don't think adding an option is a good idea, people will not know this
option or forget to add it. Also, it's an option that you want to
specify almost always, so if we do add an option, maybe it should be the
default and an option should be added to enable recursive mode?

I haven't checked the full list of bdrv_co_block_status() callers yet.
So far we're talking about 'qemu-img convert' or the mirror job. Maybe
we need to check other callers, too, but for now I'll stick to these.

The interesting case seems to be preallocated qcow2 images, where the
clusters are allocated on the qcow2 level, but not in the image file.
If we don't do the lseek there, we'll have to read in the data and will
only then detect that it is zero (qemu-img only, mirror doesn't do this
yet - should it have an option to enable a zero-detecting mode? Can
detect-zeroes on the target node achieve the same thing?). So at least
in qemu-img, we don't get a different result, it's just a bit slower.

Also note that this is only metadata preallocation; full preallocation
will still return allocated for the protocol layer and so it will always
be slow.

Now, if this isn't about correctness, but about performance, maybe we
can do some heuristics instead of adding a user option? A very simple
approach could be, look at the lower layers only if we got a large
allocated area. If the image was preallocated, everything is allocated,
so if bdrv_co_block_status() returns a short range, it's a hint that
qcow2 knows _something_ at least. (That something could just be that
someone discarded something from a preallocated image, so we can't jump
to the conclusion that it's not preallocated - but it's certainly more
likely). And for small buffer, just reading it in and checking whether
it is zero can't be that much slower than finding a hole first.

So how about we look at the protocol layer only if we got an allocated
range of at least a megabyte or something? Or maybe make it depend on
the cluster size because with 2 MB clusters that will be always the
case, even if the image isn't preallocated.

Kevin
