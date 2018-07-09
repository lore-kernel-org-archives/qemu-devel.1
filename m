Received: from eggs.gnu.org ([2001:4830:134:3::10]:41936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcSWt-0004Ky-TM
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcSWs-0007vD-Ms
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:32:23 -0400
Date: Mon, 9 Jul 2018 11:32:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180709093214.GA3511@localhost.localdomain>
References: <20180706164542.9476-1-kwolf@redhat.com>
	<be1b9d41-1eb3-c24c-c459-cc6d6599de22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1b9d41-1eb3-c24c-c459-cc6d6599de22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix copy-on-read crash with partial
 final cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 06.07.2018 um 23:20 hat Eric Blake geschrieben:
> On 07/06/2018 11:45 AM, Kevin Wolf wrote:
> > If the virtual disk size isn't aligned to full clusters,
> > bdrv_co_do_copy_on_readv() may get pnum == 0 before having the full
> > cluster completed, which will let it run into an assertion failure:
> > 
> > qemu-io: block/io.c:1203: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
> > 
> > Check for EOF, assert that we read at least as much as the read request
> > originally wanted to have (which is true at EOF because otherwise
> > bdrv_check_byte_request() would already have returned an error) and
> > return success early even though we couldn't copy the full cluster.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/io.c                 | 6 ++++++
> >   tests/qemu-iotests/197     | 9 +++++++++
> >   tests/qemu-iotests/197.out | 8 ++++++++
> >   3 files changed, 23 insertions(+)
> > 
> > diff --git a/block/io.c b/block/io.c
> > index 038449f81f..4c0831149c 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -1200,6 +1200,12 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
> >               pnum = MIN(cluster_bytes, max_transfer);
> >           }
> > +        /* Stop at EOF if the image ends in the middle of the cluster */
> > +        if (ret == 0 && pnum == 0) {
> 
> Is it any smarter to check for 'ret & BDRV_BLOCK_EOF' instead of pnum == 0?
> 
> But as far as I can tell, right now those two conditions are synonymous.

You removed the context from your quote, which contains the assertion
that the commit message mentions:

    assert(skip_bytes < pnum);

So I think it makes more sense to check pnum, because it's the short
pnum and not the BDRV_BLOCK_EOF flag that would make the following code
fail.

> > +echo
> > +echo '=== Partial final cluster ==='
> > +echo
> > +
> > +_make_test_img 1024
> > +$QEMU_IO -f $IMGFMT -C -c 'read 0 1024' "$TEST_IMG" | _filter_qemu_io
> 
> Here, $TEST_IMG has no backing file, and does not have the final
> cluster allocated; all we have to do is properly read all zeroes.

And write them back, we test that it's allocated afterwards.

> Is it worth also explicitly testing reading of allocated data under
> COR

I could add a second read of the same area, which would not only test
reading of allocated data, but also test whether the allocating COR
wrote the correct data (all zeros).

Do you think that would be a worthwhile addition?

> and/or the case of one image with another backing image (with
> same or differing partial cluster sizes), where COR actually has to
> write the partial cluster?  However, the logic in the code appears to
> cover all of those, whether or not the testsuite does as well.

Having a backing file is a different code path for non-zero data, but I
think we already test normal write/write_zeroes extensively. For zero
data, it doesn't make a difference whether it comes from the backing
file or from not having a backing file (as far as the COR logic is
concerned, anyway).

I didn't want to use a backing file because the test is 'generic', but
it already uses qcow2 in other cases, so if we really think this is
important to have, I guess I can have another case with qcow2 over
$IMGFMT and non-zero data.

Kevin
