Received: from eggs.gnu.org ([2001:4830:134:3::10]:53867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deowQ-0006rp-5M
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deowL-0006NV-91
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:47:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170807203007.19033-1-eblake@redhat.com>
	<20170807203007.19033-5-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2f55501-1458-1eb4-dd1c-430793ecee3c@amsat.org>
Date: Mon, 7 Aug 2017 17:47:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170807203007.19033-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] qcow2: Check failure of
 bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/07/2017 05:30 PM, Eric Blake wrote:
> qcow2_co_pwritev_compressed() should not call bdrv_truncate()
> if determining the size failed.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   block/qcow2.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 99407403ea..40ba26c111 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3282,12 +3282,15 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>       z_stream strm;
>       int ret, out_len;
>       uint8_t *buf, *out_buf;
> -    uint64_t cluster_offset;
> +    int64_t cluster_offset;
> 
>       if (bytes == 0) {
>           /* align end of file to a sector boundary to ease reading with
>              sector based I/Os */
>           cluster_offset = bdrv_getlength(bs->file->bs);
> +        if (cluster_offset < 0) {
> +            return cluster_offset;
> +        }
>           return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
>       }
> 
