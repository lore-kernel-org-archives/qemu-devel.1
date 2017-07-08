Received: from eggs.gnu.org ([2001:4830:134:3::10]:35341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTtGt-00077v-DW
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTtGs-0007Dt-Ij
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 13:11:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170708025030.15845-1-rth@twiddle.net>
	<20170708025030.15845-2-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <66bdbcf1-dd15-1e7e-bc30-d80ae6e88ffb@amsat.org>
Date: Sat, 8 Jul 2017 14:10:45 -0300
MIME-Version: 1.0
In-Reply-To: <20170708025030.15845-2-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] tcg: Fix off-by-one in
 assert in page_set_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, riku.voipio@iki.fi, laurent@vivier.eu, qemu-arm@nongnu.org

On 07/07/2017 11:50 PM, Richard Henderson wrote:
> Most of the users of page_set_flags offset (page, page + len) as
> the end points.  One might consider this an error, since the other
> users do supply an endpoint as the last byte of the region.
> 
> However, the first thing that page_set_flags does is round end UP
> to the start of the next page.  Which means computing page + len - 1
> is in the end pointless.  Therefore, accept this usage and do not
> assert when given the exact size of the vm as the endpoint.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>   accel/tcg/translate-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index dfb9f0d..57578a4 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2068,7 +2068,7 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
>          guest address space.  If this assert fires, it probably indicates
>          a missing call to h2g_valid.  */
>   #if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
> -    assert(end < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
> +    assert(end <= ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));

worth adding a comment /* end rounded up */ ?

anyway for this tricky catch:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   #endif
>       assert(start < end);
>       assert_memory_lock();
> 
