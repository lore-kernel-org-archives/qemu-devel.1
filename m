Received: from eggs.gnu.org ([2001:4830:134:3::10]:55475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFuK-0003Du-PA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFuJ-0001Qu-JU
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:08:00 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEFuJ-0001NN-CB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:07:59 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so1272277qka.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 07:07:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-8-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <61eaae1b-3420-d6f6-f214-9d323f1434c3@twiddle.net>
Date: Fri, 26 May 2017 07:07:50 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-8-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/26] target/s390x: implement STORE PAIR
 TO QUADWORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   target/s390x/insn-data.def |  2 ++
>   target/s390x/translate.c   | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 53c86d5832..751e3164dd 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -770,6 +770,8 @@
>   /* STORE ACCESS MULTIPLE */
>       C(0x9b00, STAM,    RS_a,  Z,   0, a2, 0, 0, stam, 0)
>       C(0xeb9b, STAMY,   RSY_a, LD,  0, a2, 0, 0, stam, 0)
> +/* STORE PAIR TO QUADWORD */
> +    C(0xe38e, STPQ,    RXY_a, Z,   0, a2, 0, 0, stpq, 0)

Use prep_r1_P here, so that r1 gets validated as even....

> +    /* In a parallel context, stop the world and single step.  */
> +    if (parallel_cpus) {
> +        potential_page_fault(s);
> +        gen_exception(EXCP_ATOMIC);
> +        return EXIT_NORETURN;
> +    }
> +
> +    /* In a serial context, perform the two stores ... */
> +    tcg_gen_qemu_st64(regs[r1], o->in2, get_mem_index(s));
> +    tcg_gen_addi_i64(o->in2, o->in2, 8);
> +    tcg_gen_qemu_st64(regs[r1 + 1], o->in2, get_mem_index(s));

... then use o->out / o->out2 for the stores.

Similarly, helper_atomic_sto_be_mmu in a helper for the parallel context.


r~
