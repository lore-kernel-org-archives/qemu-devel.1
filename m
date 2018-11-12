Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMLJa-0000eo-Fj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 18:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMLJZ-00011K-FR
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 18:08:18 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-8-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c85988da-52e7-b035-8985-d96780678dde@redhat.com>
Date: Mon, 12 Nov 2018 17:08:08 -0600
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/11] block: Leave BDS.backing_file
 constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 8/9/18 5:31 PM, Max Reitz wrote:
> Parts of the block layer treat BDS.backing_file as if it were whatever
> the image header says (i.e., if it is a relative path, it is relative to
> the overlay), other parts treat it like a cache for
> bs->backing->bs->filename (relative paths are relative to the CWD).
> Considering bs->backing->bs->filename exists, let us make it mean the
> former.
> 
> Among other things, this now allows the user to specify a base when
> using qemu-img to commit an image file in a directory that is not the
> CWD (assuming, everything uses relative filenames).
> 
> Before this patch:
> 
> $ ./qemu-img create -f qcow2 foo/bot.qcow2 1M
> $ ./qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
> $ ./qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'

Three failures in a row - no way to commit short of changing your 
working directory.

> 
> After this patch:
> 
> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
> Image committed.
> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
> Image committed.

Yay, that looks saner.

> 
> With this change, bdrv_find_backing_image() must look at whether the
> user has overridden a BDS's backing file.  If so, it can no longer use
> bs->backing_file, but must instead compare the given filename against
> the backing node's filename directly.
> 
> Note that this changes the QAPI output for a node's backing_file.  We
> had very inconsistent output there (sometimes what the image header
> said, sometimes the actual filename of the backing image).  This
> inconsistent output was effectively useless, so we have to decide one
> way or the other.  Considering that bs->backing_file usually at runtime
> contained the path to the image relative to qemu's CWD (or absolute),
> this patch changes QAPI's backing_file to always report the
> bs->backing->bs->filename from now on.  If you want to receive the image
> header information, you have to refer to full-backing-filename.
> 
> This necessitates a change to iotest 228.  The interesting information
> it really wanted is the image header, and it can get that now, but it
> has to use full-backing-filename instead of backing_file.  Because of
> this patch's changes to bs->backing_file's behavior, we also need some
> reference output changes.
> 
> Along with the changes to bs->backing_file, stop updating
> BDS.backing_format in bdrv_backing_attach() as well.  This necessitates
> a change to the reference output of iotest 191.

Good explanations for the test changes.

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h  | 14 +++++++++-----
>   block.c                    | 29 ++++++++++++++++++++++-------
>   block/qapi.c               |  7 ++++---
>   qemu-img.c                 | 12 ++++++++++--
>   tests/qemu-iotests/191.out |  1 -
>   tests/qemu-iotests/228     |  6 +++---
>   tests/qemu-iotests/228.out |  6 +++---
>   7 files changed, 51 insertions(+), 24 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index d3d8b22155..8f2c515ec1 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -737,11 +737,15 @@ struct BlockDriverState {
>       bool walking_aio_notifiers; /* to make removal during iteration safe */
>   
>       char filename[PATH_MAX];
> -    char backing_file[PATH_MAX]; /* if non zero, the image is a diff of
> -                                    this file image */
> -    /* The backing filename indicated by the image header; if we ever
> -     * open this file, then this is replaced by the resulting BDS's
> -     * filename (i.e. after a bdrv_refresh_filename() run). */
> +    /* If non-zero, the image is a diff of this image file.  Note that

Pre-existing, but that sentence might read nicer as:

If not empty, this image is a diff in relation to backing_file.

> +     * this the name given in the image header and may therefore not

"this the name" is wrong; did you mean "this is the name" or "this name" 
or "the name"?

> +     * be equal to .backing->bs->filename, and relative paths are
> +     * resolved relatively to their overlay. */
> +    char backing_file[PATH_MAX];
> +    /* The backing filename indicated by the image header.  Contrary
> +     * to backing_file, if we ever open this file, auto_backing_file
> +     * is replaced by the resulting BDS's filename (i.e. after a
> +     * bdrv_refresh_filename() run). */
>       char auto_backing_file[PATH_MAX];
>       char backing_format[16]; /* if non-zero and backing_file exists */
>   

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
