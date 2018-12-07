Received: from eggs.gnu.org ([2001:4830:134:3::10]:57603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVI9F-00025h-Im
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVI9E-0001Uf-L2
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:34:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-6-kwolf@redhat.com>
	<87k1klwkft.fsf@dusky.pond.sub.org>
	<20181207145417.GG5119@linux.fritz.box>
Date: Fri, 07 Dec 2018 16:34:29 +0100
In-Reply-To: <20181207145417.GG5119@linux.fritz.box> (Kevin Wolf's message of
	"Fri, 7 Dec 2018 15:54:17 +0100")
Message-ID: <874lbps64a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 5/5] vmdk: Reject excess extents in
 blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.12.2018 um 14:11 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Clarify that the number of extents provided in BlockdevCreateOptionsVmdk
>> > must match the number of extents that will actually be used. Providing
>> > more extents will result in an error now.
>> >
>> > This requires adapting the test case to provide the right number of
>> > extents.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > ---
>> >  qapi/block-core.json       |  3 ++-
>> >  block/vmdk.c               | 29 ++++++++++++++++++++++++-----
>> >  tests/qemu-iotests/237     |  6 +++++-
>> >  tests/qemu-iotests/237.out | 13 +++++++------
>> >  4 files changed, 38 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 0793550cf2..afdd2f89a2 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -4068,7 +4068,8 @@
>> >  #               twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
>> >  #               monolithicFlat, only one entry is required; for
>> >  #               twoGbMaxExtent* formats, the number of entries required is
>> > -#               calculated as extent_number = virtual_size / 2GB.
>> > +#               calculated as extent_number = virtual_size / 2GB. Providing
>> > +#               more extents than will be used is an error.
>> >  # @subformat    The subformat of the VMDK image. Default: "monolithicSparse".
>> >  # @backing-file The path of backing file. Default: no backing file is used.
>> >  # @adapter-type The adapter type used to fill in the descriptor. Default: ide.
>> > diff --git a/block/vmdk.c b/block/vmdk.c
>> > index 5a162ee85c..682ad93aa1 100644
>> > --- a/block/vmdk.c
>> > +++ b/block/vmdk.c
>> > @@ -1970,6 +1970,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>> >  {
>> >      int extent_idx;
>> >      BlockBackend *blk = NULL;
>> > +    BlockBackend *extent_blk;
>> >      Error *local_err = NULL;
>> >      char *desc = NULL;
>> >      int ret = 0;
>> > @@ -2107,7 +2108,6 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>> >      }
>> >      extent_idx = 1;
>> >      while (created_size < size) {
>> > -        BlockBackend *extent_blk;
>> >          int64_t cur_size = MIN(size - created_size, extent_size);
>> >          extent_blk = extent_fn(cur_size, extent_idx, flat, split, compress,
>> >                                 zeroed_grain, opaque, errp);
>> > @@ -2121,6 +2121,17 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>> >          extent_idx++;
>> >          blk_unref(extent_blk);
>> >      }
>> > +
>> > +    /* Check whether we got excess extents */
>> > +    extent_blk = extent_fn(-1, extent_idx, flat, split, compress, zeroed_grain,
>> > +                           opaque, NULL);
>> > +    if (extent_blk) {
>> > +        blk_unref(extent_blk);
>> > +        error_setg(errp, "List of extents contains unused extents");
>> > +        ret = -EINVAL;
>> > +        goto exit;
>> > +    }
>> > +
>> >      /* generate descriptor file */
>> >      desc = g_strdup_printf(desc_template,
>> >                             g_random_int(),
>> > @@ -2181,6 +2192,12 @@ static BlockBackend *vmdk_co_create_opts_cb(int64_t size, int idx,
>> >      char *ext_filename = NULL;
>> >      char *rel_filename = NULL;
>> >  
>> > +    /* We're done, don't create excess extents. */
>> > +    if (size == -1) {
>> > +        assert(errp == NULL);
>> > +        return NULL;
>> > +    }
>> > +
>> 
>> I'm afraid I don't get this hunk.
>
> vmdk_co_create_opts_cb() is for the legacy code path, where 'qemu-img
> create' passes us a QemuOpts. This doesn't contain extents, so rather
> than returning ther next extent from the input, this function simply
> creates a new extent file each time it is called.
>
> When checking whether we have too many extents, we don't know from which
> code path we came, so we have to call the callback uncondtionally and
> see whether it still returns an extra extent. In this case, creating a
> new one would obviously be counterproductive and trigger an error, so I
> just return NULL immediately.
>
> If you have a suggestion for a comment to put somewhere, I'll gladly add
> it.

Coming up with intelligble comments exceed my mental capabilities right
now, I'm afraid.  But I can still give my
Reviewed-by: Markus Armbruster <armbru@redhat.com>
