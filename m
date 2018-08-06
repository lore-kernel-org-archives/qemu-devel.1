Received: from eggs.gnu.org ([2001:4830:134:3::10]:50750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fmdKZ-0007zv-7j
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fmdKT-0004Ew-Rm
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 07:05:43 -0400
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
	<20180805182832.3012-3-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3e2202db-64cb-ecd6-4dc3-23489c03e8f7@redhat.com>
Date: Mon, 6 Aug 2018 13:05:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180805182832.3012-3-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] target/s390x: fix CSST decoding and
 runtime alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

On 05.08.2018 20:28, Pavel Zbitskiy wrote:
> CSST is defined as:
> 
>     C(0xc802, CSST,    SSF,   CASS, la1, a2, 0, 0, csst, 0)
> 
> It means that the first parameter is handled by in1_la1().
> in1_la1() fills addr1 field, and not in1.
> 
> Furthermore, when extract32() is used for the alignment check, the
> third parameter should specify the number of trailing bits that must
> be 0. For FC these numbers are:
> 
>     FC=0: 2

-> word, 4 bytes -> 2 bit

>     FC=1: 3

-> double word, 8 bytes -> 3 bit

>     FC=2: 4

-> quad word, 16 bytes -> 4 bit

> 
> For SC these numbers are:
> 
>     SC=0: 0
>     SC=1: 1
>     SC=2: 2
>     SC=3: 3
>     SC=4: 4

Right, corresponds to the size.

> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/mem_helper.c | 2 +-
>  target/s390x/translate.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index e21a47fb4d..c94dbf3fcb 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1442,7 +1442,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>      }
>  
>      /* Sanity check the alignments.  */
> -    if (extract32(a1, 0, 4 << fc) || extract32(a2, 0, 1 << sc)) {
> +    if (extract32(a1, 0, fc + 2) || extract32(a2, 0, sc)) {
>          goto spec_exception;
>      }
>  
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index efdc88e227..f318fb6e4e 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2050,9 +2050,9 @@ static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
>      TCGv_i32 t_r3 = tcg_const_i32(r3);
>  
>      if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> -        gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->in1, o->in2);
> +        gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->addr1, o->in2);
>      } else {
> -        gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
> +        gen_helper_csst(cc_op, cpu_env, t_r3, o->addr1, o->in2);

Indeed, only addr1 is filled.

(did this ever work?)

>      }
>      tcg_temp_free_i32(t_r3);
>  
> 

Are you running some test case or how did you find this? (PoP review?)


Haven't tested it yet, but looks sane to me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
