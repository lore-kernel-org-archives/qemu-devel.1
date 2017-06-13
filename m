Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKoRJ-0000VL-EC
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKoRI-0002gl-Lj
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:13:09 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKoRI-0002gT-FL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:13:08 -0400
Received: by mail-wr0-x235.google.com with SMTP id 36so28583244wry.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:13:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496857819-12466-6-git-send-email-kwolf@redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
	<1496857819-12466-6-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 17:12:46 +0100
Message-ID: <CAFEAcA-zObhNAR7iuQZ0MH7-ng86m2XEik8bie3o4THEbLwcVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 5/8] commit: Fix use after free in completion
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

On 7 June 2017 at 18:50, Kevin Wolf <kwolf@redhat.com> wrote:
> The final bdrv_set_backing_hd() could be working on already freed nodes
> because the commit job drops its references (through BlockBackends) to
> both overlay_bs and top already a bit earlier.
>
> One way to trigger the bug is hot unplugging a disk for which
> blockdev_mark_auto_del() cancels the block job.
>
> Fix this by taking BDS-level references while we're still using the
> nodes.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/block/commit.c b/block/commit.c
> index a3028b2..af6fa68 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -89,6 +89,10 @@ static void commit_complete(BlockJob *job, void *opaque)
>      int ret = data->ret;
>      bool remove_commit_top_bs = false;
>
> +    /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
> +    bdrv_ref(top);
> +    bdrv_ref(overlay_bs);
> +
>      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
>       * the normal backing chain can be restored. */
>      blk_unref(s->base);

Hi -- coverity complains about this change, because bdrv_ref()
assumes that its argument is not NULL, but later on in commit_complete()
we have a check
    "if (overlay_bs && ...)"
which assumes its argument might be NULL. (CID 1376205)

Which is correct?

thanks
-- PMM
