Received: from eggs.gnu.org ([2001:4830:134:3::10]:34733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dL2NV-0002Db-TV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dL2NR-0002f4-Vk
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dL2NR-0002ez-PO
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:06:05 -0400
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e28faf6e-2329-c063-929f-45f39e4e2ba5@redhat.com>
Date: Wed, 14 Jun 2017 09:05:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170613214736.19963-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] target/s390x: change PSW_SHIFT_KEY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, Miroslav Benes <mbenes@suse.cz>

On 13.06.2017 23:47, David Hildenbrand wrote:
> Such shifts are usually used to easily extract the PSW KEY from the PSW
> mask, so let's avoid the confisuing offset of 4.

s/confisuing/confusing/

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h       | 2 +-
>  target/s390x/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index a4028fb..532a4a0 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -315,7 +315,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
>  #define PSW_MASK_IO             0x0200000000000000ULL
>  #define PSW_MASK_EXT            0x0100000000000000ULL
>  #define PSW_MASK_KEY            0x00F0000000000000ULL
> -#define PSW_SHIFT_KEY           56
> +#define PSW_SHIFT_KEY           52
>  #define PSW_MASK_MCHECK         0x0004000000000000ULL
>  #define PSW_MASK_WAIT           0x0002000000000000ULL
>  #define PSW_MASK_PSTATE         0x0001000000000000ULL
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 8c055b7..fae006f 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3780,7 +3780,7 @@ static ExitStatus op_spka(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
>      tcg_gen_shri_i64(o->in2, o->in2, 4);
> -    tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, PSW_SHIFT_KEY - 4, 4);
> +    tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, PSW_SHIFT_KEY, 4);
>      return NO_EXIT;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
