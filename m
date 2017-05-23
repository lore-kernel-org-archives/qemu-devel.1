Received: from eggs.gnu.org ([2001:4830:134:3::10]:59263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD71D-0004hn-5k
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD71A-0005Yr-37
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD719-0005YF-UE
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:26:20 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-22-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <845d90a9-5b5e-2862-bf76-2dd124c69333@redhat.com>
Date: Tue, 23 May 2017 12:26:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-22-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/31] target/s390x: Use unwind data for
 helper_tre
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 23.05.2017 05:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 15 ++++++++-------
>  target/s390x/translate.c  |  1 -
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 748a6e8..4c6c6ee 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -720,8 +720,10 @@ void HELPER(tr)(CPUS390XState *env, uint32_t len, uint64_t array,
>  uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
>                       uint64_t len, uint64_t trans)
>  {
> +    uintptr_t ra = GETPC();
>      uint8_t end = env->regs[0] & 0xff;
>      uint64_t l = len;
> +    uint32_t cc = 0;
>      uint64_t i;
>  
>      if (!(env->psw.mask & PSW_MASK_64)) {
> @@ -733,25 +735,24 @@ uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
>         amount of work we're willing to do.  For now, let's cap at 8k.  */
>      if (l > 0x2000) {
>          l = 0x2000;
> -        env->cc_op = 3;
> -    } else {
> -        env->cc_op = 0;
> +        cc = 3;
>      }
>  
>      for (i = 0; i < l; i++) {
>          uint8_t byte, new_byte;
>  
> -        byte = cpu_ldub_data(env, array + i);
> +        byte = cpu_ldub_data_ra(env, array + i, ra);
>  
>          if (byte == end) {
> -            env->cc_op = 1;
> +            cc = 1;
>              break;
>          }
>  
> -        new_byte = cpu_ldub_data(env, trans + byte);
> -        cpu_stb_data(env, array + i, new_byte);
> +        new_byte = cpu_ldub_data_ra(env, trans + byte, ra);
> +        cpu_stb_data_ra(env, array + i, new_byte, ra);
>      }
>  
> +    env->cc_op = cc;
>      env->retxl = len - i;
>      return array + i;
>  }

I think you should mention in the patch description that you've changed
the behavior of the CC settings here, too (it's not changed anymore in
case of exceptions).

Apart from that:

Reviewed-by: Thomas Huth <thuth@redhat.com>
