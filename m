Received: from eggs.gnu.org ([2001:4830:134:3::10]:53946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8S6-00005S-Lu
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8S3-00026K-DJ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:17:34 -0400
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7cfbd0da-8654-b9b6-983f-b0bb9c45b6ba@redhat.com>
Date: Wed, 27 Jun 2018 13:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180625115352.6889-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 7/9] s390x/tcg: implement
 SET CLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 25.06.2018 13:53, David Hildenbrand wrote:
> This allows a guest to change its TOD. We already take care of updating
> all CKC timers from within S390TODClass.
> 
> Use MO_ALIGN to load the operand manually - this will properly trigger a
> SPECIFICATION exception.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  3 +--
>  target/s390x/misc_helper.c | 16 ++++++++++++++++
>  target/s390x/translate.c   |  9 +++++++++
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 59cba86a27..97c60ca7bc 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -127,6 +127,7 @@ DEF_HELPER_4(diag, void, env, i32, i32, i32)
>  DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
>  DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
>  DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
> +DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
>  DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
>  DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
>  DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 157619403d..5c6f33ed9c 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -997,8 +997,7 @@
>  /* SET ADDRESS SPACE CONTROL FAST */
>      C(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0)
>  /* SET CLOCK */
> -    /* ??? Not implemented - is it necessary? */
> -    C(0xb204, SCK,     S,     Z,   0, 0, 0, 0, 0, 0)
> +    C(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0)
>  /* SET CLOCK COMPARATOR */
>      C(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0)
>  /* SET CLOCK PROGRAMMABLE FIELD */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 4872bdd774..a223970d1c 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -189,6 +189,22 @@ void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
>      helper_sckc(env, env->ckc);
>  }
>  
> +/* Set Clock */
> +uint32_t HELPER(sck)(CPUS390XState *env, uint64_t tod_low)
> +{
> +    S390TODState *td = s390_get_todstate();
> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
> +    S390TOD tod = {
> +        .high = 0,
> +        .low = tod_low,
> +    };
> +
> +    qemu_mutex_lock_iothread();
> +    tdc->set(td, &tod, &error_abort);
> +    qemu_mutex_unlock_iothread();
> +    return 0;
> +}
> +
>  /* Set Tod Programmable Field */
>  void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
>  {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index fdfec7feba..57c03cbf58 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4016,6 +4016,15 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
>      return DISAS_NEXT;
>  }
>  
> +static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
> +{
> +    check_privileged(s);
> +    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
> +    gen_helper_sck(cc_op, cpu_env, o->in1);
> +    set_cc_static(s);
> +    return DISAS_NEXT;
> +}
> +
>  static DisasJumpType op_sckc(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
> 

Acked-by: Thomas Huth <thuth@redhat.com>
