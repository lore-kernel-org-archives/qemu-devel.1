Received: from eggs.gnu.org ([2001:4830:134:3::10]:43528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbAgZ-0000dF-Lz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dbAgW-0001Kq-HW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:12:29 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:38529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dbAgW-0001K9-A5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:12:28 -0400
Received: by mail-wr0-x22e.google.com with SMTP id f21so101971957wrf.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 12:12:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500906730-26467-5-git-send-email-kwolf@redhat.com>
References: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
	<1500906730-26467-5-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 20:12:06 +0100
Message-ID: <CAFEAcA-Zvk_m4JLVNXzBOizBWEwAMAAFaDLoR7+s=8MnKBsSQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 4/5] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 15:32, Kevin Wolf <kwolf@redhat.com> wrote:
> Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> nodes above the top layer of mirror and commit block jobs. The
> assumption made there was that since libvirt doesn't do node-level
> management of the block layer yet, it shouldn't be affected by added
> nodes.
>
> This is true as far as commands issued by libvirt are concerned. It only
> uses BlockBackend names to address nodes, so any operations it performs
> still operate on the root of the tree as intended.
>
> However, the assumption breaks down when you consider query commands,
> which return data for the wrong node now. These commands also return
> information on some child nodes (bs->file and/or bs->backing), which
> libvirt does make use of, and which refer to the wrong nodes, too.
>
> One of the consequences is that oVirt gets wrong information about the
> image size and stops the VM in response as long as a mirror or commit
> job is running:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1470634
>
> This patch fixes the problem by hiding the implicit nodes created
> automatically by the mirror and commit block jobs in the output of
> query-block and BlockBackend-based query-blockstats as long as the user
> doesn't indicate that they are aware of those nodes by providing a node
> name for them in the QMP command to start the block job.

Hi -- Coverity complains about dereference-after-NULL-check
for this change (CID 1378275).

> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -64,7 +64,6 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>          info->backing_file = g_strdup(bs->backing_file);
>      }
>
> -    info->backing_file_depth = bdrv_get_backing_file_depth(bs);
>      info->detect_zeroes = bs->detect_zeroes;
>
>      if (blk && blk_get_public(blk)->throttle_state) {
> @@ -125,6 +124,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>
>      bs0 = bs;
>      p_image_info = &info->image;
> +    info->backing_file_depth = 0;
>      while (1) {
>          Error *local_err = NULL;
>          bdrv_query_image_info(bs0, p_image_info, &local_err);
> @@ -133,13 +133,21 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>              qapi_free_BlockDeviceInfo(info);
>              return NULL;
>          }
> +
>          if (bs0->drv && bs0->backing) {
> +            info->backing_file_depth++;
>              bs0 = bs0->backing->bs;
>              (*p_image_info)->has_backing_image = true;
>              p_image_info = &((*p_image_info)->backing_image);
>          } else {
>              break;
>          }
> +
> +        /* Skip automatically inserted nodes that the user isn't aware of for
> +         * query-block (blk != NULL), but not for query-named-block-nodes */
> +        while (blk && bs0 && bs0->drv && bs0->implicit) {
> +            bs0 = backing_bs(bs0);
> +        }
>      }

The analysis is a bit confusing because it involves a loop, but
this while loop at the bottom of the "while (1)" implies that
bs0 could be NULL here, in which case we'll stop iterating through
this while(), which will cause us to go up to the top of the while(1),
where we call bdrv_query_image_info(bs0, ...), which assumes that
bs0 is non-NULL.

Either we need to handle bs0 == NULL in some way other than
crashing in the call to bdrv_query_image_info(), or bs0
can't ever be NULL here in which case it's an unnecessary
test in the while condition.

thanks
-- PMM
