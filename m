Received: from eggs.gnu.org ([2001:4830:134:3::10]:59798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWVUe-0006fM-Nu
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWVUd-0005i2-N2
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:24:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170715132841.9865-1-hpoussin@reactos.org>
	<20170715132841.9865-5-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f675ff1-e6ce-a6b2-f63c-4b063871a215@amsat.org>
Date: Sat, 15 Jul 2017 19:24:45 -0300
MIME-Version: 1.0
In-Reply-To: <20170715132841.9865-5-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] vvfat: initialize memory after
 allocating it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Hi Hervé,

On 07/15/2017 10:28 AM, Hervé Poussineau wrote:
> This prevents some host to guest memory content leaks.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
> 
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>   block/vvfat.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index afc6170a69..7340decef3 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -115,6 +115,7 @@ static inline int array_ensure_allocated(array_t* array, int index)
>           array->pointer = g_realloc(array->pointer, new_size);
>           if (!array->pointer)
>               return -1;

isn't it safer:

if (likely(new_size > array->size)) {

> +        memset(array->pointer + array->size, 0, new_size - array->size);

}

?

>           array->size = new_size;
>           array->next = index + 1;
>       }
> 

Regards,

Phil.
