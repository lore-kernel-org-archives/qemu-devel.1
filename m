Received: from eggs.gnu.org ([2001:4830:134:3::10]:45866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ctwao-0008TH-Fq
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ctwan-0001Tb-EV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:27:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5979a675-6077-50f8-0714-7e509a9bc492@amsat.org>
Date: Fri, 31 Mar 2017 10:27:44 -0300
MIME-Version: 1.0
In-Reply-To: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, patches@linaro.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Hi,

Eduardo you seem skilled regarding Coccinelle scripts, is it possible to 
write one to find those overflows?

Peter having one more macro might help or confuses more?

#define MULTIPLY64(a32, b32) ((int64_t)a32 * b32)

On 03/31/2017 10:13 AM, Peter Maydell wrote:
> Coverity (CID 1307776) points out that in the multiply:
>   space = to_allocate * s->tracks;
> we are trying to calculate a 64 bit result but the types
> of to_allocate and s->tracks mean that we actually calculate
> a 32 bit result. Add an explicit cast to force a 64 bit
> multiply.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> NB: compile-and-make-check tested only...
> ---
>  block/parallels.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 4173b3f..3886c30 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -206,7 +206,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>      }
>
>      to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
> -    space = to_allocate * s->tracks;
> +    space = (int64_t)to_allocate * s->tracks;
>      if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SECTOR_BITS) {
>          int ret;
>          space += s->prealloc_size;
>
