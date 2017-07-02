Received: from eggs.gnu.org ([2001:4830:134:3::10]:50432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRelc-00078k-4R
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRelb-00011w-7A
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:18:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRelb-00010L-1H
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:18:23 -0400
Date: Sun, 2 Jul 2017 15:18:21 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170702131821.hn7z47hgdnywn5dv@aurel32.net>
References: <20170701202600.14057-1-rth@twiddle.net>
	<20170701202600.14057-9-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170701202600.14057-9-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] target/s390x: Fix risbg handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-07-01 13:26, Richard Henderson wrote:
> The rotation is to the left, but extract shifts to the right.
> The computation of the extract parameters needs adjusting.
> 
> For the entry condition, simplify
> 
> 	64 - rot + len <= 64
> 	-rot + len <= 0
> 	len <= rot
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 1f0c401..89b2ea5 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3472,8 +3472,8 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>      }
>  
>      /* In some cases we can implement this with extract.  */
> -    if (imask == 0 && pos == 0 && len > 0 && rot + len <= 64) {
> -        tcg_gen_extract_i64(o->out, o->in2, rot, len);
> +    if (imask == 0 && pos == 0 && len > 0 && len <= rot) {
> +        tcg_gen_extract_i64(o->out, o->in2, 64 - rot, len);
>          return NO_EXIT;
>      }

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>


-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
