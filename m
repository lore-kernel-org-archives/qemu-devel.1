Received: from eggs.gnu.org ([2001:4830:134:3::10]:49282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ek9Dy-00084M-5W
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ek9Dv-0003Y0-4l
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:00:22 -0500
Date: Fri, 9 Feb 2018 15:00:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209140007.GC3998@localhost.localdomain>
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-5-kwolf@redhat.com>
	<78712c7a-a8f0-5d7b-d1f5-d37fcb178655@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78712c7a-a8f0-5d7b-d1f5-d37fcb178655@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/27] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Am 09.02.2018 um 00:29 hat Eric Blake geschrieben:
> On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> > All of the simple options are now passed to qcow2_create2() in a
> > BlockdevCreateOptions object. Still missing: node-name and the
> > encryption options.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/qcow2.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++------------
> >   1 file changed, 152 insertions(+), 38 deletions(-)
> > 
> 
> > -static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, Error **errp)
> > +static bool validate_cluster_size(size_t cluster_size, Error **errp)
> >   {
> > -    size_t cluster_size;
> > -    int cluster_bits;
> > -
> > -    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
> > -                                         DEFAULT_CLUSTER_SIZE);
> > -    cluster_bits = ctz32(cluster_size);
> > +    int cluster_bits = ctz32(cluster_size);
> >       if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS ||
> >           (1 << cluster_bits) != cluster_size)
> 
> Pre-existing, but why are we manually calling ctz32() instead of using
> is_power_of_2()?

Probably because is_power_of_2() is newer than this code.

Also, if we don't call ctz32(), we'd have to use (1 << MIN_CLUSTER_BITS)
and (1 << MAX_CLUSTER_BITS), so I'm not sure if that would be better.

> > @@ -2720,10 +2726,92 @@ static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
> >        */
> >       BlockBackend *blk;
> >       QCowHeader *header;
> > +    size_t cluster_size;
> > +    int version;
> > +    int refcount_order;
> >       uint64_t* refcount_table;
> >       Error *local_err = NULL;
> >       int ret;
> > +    /* Validate options and set default values */
> > +    assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
> > +    qcow2_opts = &create_options->u.qcow2;
> > +
> > +    if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
> > +        error_setg(errp, "Image size must be a multiple of 512 bytes");
> > +        ret = -EINVAL;
> > +        goto out;
> > +    }
> 
> This check looks new.  Does it really belong in this patch?  And it does NOT
> match what qemu-img can currently do, nor the fact that qcow2 supports
> byte-based addressing:
> 
> $ qemu-img create -f qcow2 tmp 12345
> Formatting 'tmp', fmt=qcow2 size=12345 cluster_size=65536 lazy_refcounts=off
> refcount_bits=16

You're ignoring the result of this command:

$ ./qemu-img create -f qcow2 /tmp/test.qcow2 12345
Formatting '/tmp/test.qcow2', fmt=qcow2 size=12345 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ ./qemu-img info -f qcow2 /tmp/test.qcow2
image: /tmp/test.qcow2
file format: qcow2
virtual size: 13K (12800 bytes)
disk size: 196K
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

As you can see, the size got silently rounded up to the next 512 bytes.
qcow2_create() still does the same even after this patch, but I chose
not to extend the magic rounding to the QMP command.

In the protocol drivers, I generally just allow byte granularity image
sizes, but qcow2 does use sectors internally, so it felt safer to
require 512 byte alignment in qcow2.

> > +    if (!qcow2_opts->has_lazy_refcounts) {
> > +        qcow2_opts->lazy_refcounts = false;
> > +    }
> > +    if (version < 3 && qcow2_opts->lazy_refcounts) {
> > +        error_setg(errp, "Lazy refcounts only supported with compatibility "
> > +                   "level 1.1 and above (use compat=1.1 or greater)");
> 
> Do we want to reword this error message at all, now that QMP spells it 'v3'?
> Should qemu-img be taught to accept 'compat=v3' as a synonym to
> 'compat=1.1'?

Actually, it does accept 'v3' when the whole series is applied, and the
message is changed in a later patch that enables this.

Kevin
