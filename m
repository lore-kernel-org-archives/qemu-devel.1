Received: from eggs.gnu.org ([2001:4830:134:3::10]:47065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFv2-0007ca-Ak
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFv0-0002eQ-GI
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:11:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-6-kwolf@redhat.com>
Date: Fri, 07 Dec 2018 14:11:34 +0100
In-Reply-To: <20181207115343.6747-6-kwolf@redhat.com> (Kevin Wolf's message of
	"Fri, 7 Dec 2018 12:53:43 +0100")
Message-ID: <87k1klwkft.fsf@dusky.pond.sub.org>
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Clarify that the number of extents provided in BlockdevCreateOptionsVmdk
> must match the number of extents that will actually be used. Providing
> more extents will result in an error now.
>
> This requires adapting the test case to provide the right number of
> extents.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json       |  3 ++-
>  block/vmdk.c               | 29 ++++++++++++++++++++++++-----
>  tests/qemu-iotests/237     |  6 +++++-
>  tests/qemu-iotests/237.out | 13 +++++++------
>  4 files changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0793550cf2..afdd2f89a2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4068,7 +4068,8 @@
>  #               twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
>  #               monolithicFlat, only one entry is required; for
>  #               twoGbMaxExtent* formats, the number of entries required is
> -#               calculated as extent_number = virtual_size / 2GB.
> +#               calculated as extent_number = virtual_size / 2GB. Providing
> +#               more extents than will be used is an error.
>  # @subformat    The subformat of the VMDK image. Default: "monolithicSparse".
>  # @backing-file The path of backing file. Default: no backing file is used.
>  # @adapter-type The adapter type used to fill in the descriptor. Default: ide.
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 5a162ee85c..682ad93aa1 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1970,6 +1970,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>  {
>      int extent_idx;
>      BlockBackend *blk = NULL;
> +    BlockBackend *extent_blk;
>      Error *local_err = NULL;
>      char *desc = NULL;
>      int ret = 0;
> @@ -2107,7 +2108,6 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>      }
>      extent_idx = 1;
>      while (created_size < size) {
> -        BlockBackend *extent_blk;
>          int64_t cur_size = MIN(size - created_size, extent_size);
>          extent_blk = extent_fn(cur_size, extent_idx, flat, split, compress,
>                                 zeroed_grain, opaque, errp);
> @@ -2121,6 +2121,17 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>          extent_idx++;
>          blk_unref(extent_blk);
>      }
> +
> +    /* Check whether we got excess extents */
> +    extent_blk = extent_fn(-1, extent_idx, flat, split, compress, zeroed_grain,
> +                           opaque, NULL);
> +    if (extent_blk) {
> +        blk_unref(extent_blk);
> +        error_setg(errp, "List of extents contains unused extents");
> +        ret = -EINVAL;
> +        goto exit;
> +    }
> +
>      /* generate descriptor file */
>      desc = g_strdup_printf(desc_template,
>                             g_random_int(),
> @@ -2181,6 +2192,12 @@ static BlockBackend *vmdk_co_create_opts_cb(int64_t size, int idx,
>      char *ext_filename = NULL;
>      char *rel_filename = NULL;
>  
> +    /* We're done, don't create excess extents. */
> +    if (size == -1) {
> +        assert(errp == NULL);
> +        return NULL;
> +    }
> +

I'm afraid I don't get this hunk.

>      if (idx == 0) {
>          rel_filename = g_strdup_printf("%s%s", data->prefix, data->postfix);
>      } else if (split) {
> @@ -2342,10 +2359,12 @@ static BlockBackend *vmdk_co_create_cb(int64_t size, int idx,
>      blk_set_allow_write_beyond_eof(blk, true);
>      bdrv_unref(bs);
>  
> -    ret = vmdk_init_extent(blk, size, flat, compress, zeroed_grain, errp);
> -    if (ret) {
> -        blk_unref(blk);
> -        blk = NULL;
> +    if (size != -1) {
> +        ret = vmdk_init_extent(blk, size, flat, compress, zeroed_grain, errp);
> +        if (ret) {
> +            blk_unref(blk);
> +            blk = NULL;
> +        }
>      }
>      return blk;
>  }
> diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
> index e04a1ac6be..251771d7fb 100755
> --- a/tests/qemu-iotests/237
> +++ b/tests/qemu-iotests/237
> @@ -20,6 +20,7 @@
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>  #
>  
> +import math
>  import iotests
>  from iotests import imgfmt
>  
> @@ -222,12 +223,15 @@ with iotests.FilePath('t.vmdk') as disk_path, \
>              iotests.log("= %s %d =" % (subfmt, size))
>              iotests.log("")
>  
> +            num_extents = math.ceil(size / 2.0**31)
> +            extents = [ "ext%d" % (i) for i in range(1, num_extents + 1) ]
> +
>              vm.launch()
>              blockdev_create(vm, { 'driver': imgfmt,
>                                    'file': 'node0',
>                                    'size': size,
>                                    'subformat': subfmt,
> -                                  'extents': ['ext1', 'ext2', 'ext3'] })
> +                                  'extents': extents })
>              vm.shutdown()
>  
>              iotests.img_info_log(disk_path)
> diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
> index 1aa9aad349..241c864369 100644
> --- a/tests/qemu-iotests/237.out
> +++ b/tests/qemu-iotests/237.out
> @@ -154,6 +154,7 @@ Job failed: Extent [0] not specified
>  
>  {"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0", "size": 512, "subformat": "monolithicFlat"}}}
>  {"return": {}}
> +Job failed: List of extents contains unused extents
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
>  
> @@ -161,7 +162,7 @@ Job failed: Extent [0] not specified
>  
>  = twoGbMaxExtentFlat 512 =
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0", "size": 512, "subformat": "twoGbMaxExtentFlat"}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "subformat": "twoGbMaxExtentFlat"}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
> @@ -181,7 +182,7 @@ Format specific information:
>  
>  = twoGbMaxExtentSparse 512 =
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0", "size": 512, "subformat": "twoGbMaxExtentSparse"}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "subformat": "twoGbMaxExtentSparse"}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
> @@ -203,7 +204,7 @@ Format specific information:
>  
>  = twoGbMaxExtentFlat 1073741824 =
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0", "size": 1073741824, "subformat": "twoGbMaxExtentFlat"}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 1073741824, "subformat": "twoGbMaxExtentFlat"}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
> @@ -223,7 +224,7 @@ Format specific information:
>  
>  = twoGbMaxExtentSparse 1073741824 =
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0", "size": 1073741824, "subformat": "twoGbMaxExtentSparse"}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 1073741824, "subformat": "twoGbMaxExtentSparse"}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
> @@ -245,7 +246,7 @@ Format specific information:
>  
>  = twoGbMaxExtentFlat 2147483648 =
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0", "size": 2147483648, "subformat": "twoGbMaxExtentFlat"}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 2147483648, "subformat": "twoGbMaxExtentFlat"}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
> @@ -265,7 +266,7 @@ Format specific information:
>  
>  = twoGbMaxExtentSparse 2147483648 =
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0", "size": 2147483648, "subformat": "twoGbMaxExtentSparse"}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 2147483648, "subformat": "twoGbMaxExtentSparse"}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}

Apart from the hunk that stumps me, the patch looks good to me.
