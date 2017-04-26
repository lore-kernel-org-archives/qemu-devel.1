Received: from eggs.gnu.org ([2001:4830:134:3::10]:43672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3LJv-000525-5M
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3LJq-00075a-8p
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3LJq-00074l-0c
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QBejG8003280
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 07:41:12 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebuq78h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 07:41:10 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 21:39:41 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3QBdUBJ66257092
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 21:39:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3QBcr2w017232
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 21:38:53 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170425104338.31984-1-rth@twiddle.net>
References: <20170425104338.31984-1-rth@twiddle.net>
Date: Wed, 26 Apr 2017 17:08:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmrjbdqj.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize return value after
 exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>

Richard Henderson <rth@twiddle.net> writes:

> Users of tcg_gen_atomic_cmpxchg and do_atomic_op rightfully utilize
> the output.  Even though this code is dead, it gets translated, and
> without the initialization we encounter a tcg_error.
>
> Reported-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Tested-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

> ---
>  tcg/tcg-op.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 95a39b7..6b1f415 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2861,6 +2861,9 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
>  #endif
>  #else
>          gen_helper_exit_atomic(tcg_ctx.tcg_env);
> +        /* Produce a result, so that we have a well-formed opcode stream
> +           with respect to uses of the result in the (dead) code following.  */
> +        tcg_gen_movi_i64(retv, 0);
>  #endif /* CONFIG_ATOMIC64 */
>      } else {
>          TCGv_i32 c32 = tcg_temp_new_i32();
> @@ -2966,6 +2969,9 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
>  #endif
>  #else
>          gen_helper_exit_atomic(tcg_ctx.tcg_env);
> +        /* Produce a result, so that we have a well-formed opcode stream
> +           with respect to uses of the result in the (dead) code following.  */
> +        tcg_gen_movi_i64(ret, 0);
>  #endif /* CONFIG_ATOMIC64 */
>      } else {
>          TCGv_i32 v32 = tcg_temp_new_i32();
> -- 
> 2.9.3
