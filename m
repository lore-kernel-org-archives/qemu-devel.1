Received: from eggs.gnu.org ([209.51.188.92]:33369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gjU6j-0005ll-TX
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gjU6i-0006kO-Bs
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:10:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54178
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gjU6i-0006iE-1a
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:10:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FJ9XER071006
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:10:38 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q1j77kn6e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:10:38 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 15 Jan 2019 19:10:37 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20190114154113.6188-3-farosas@linux.ibm.com>
References: <20190114154113.6188-1-farosas@linux.ibm.com>
	<20190114154113.6188-3-farosas@linux.ibm.com>
Date: Tue, 15 Jan 2019 17:10:32 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87imyp20uv.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] target/ppc: Add GDB callbacks for
 SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Fabiano Rosas <farosas@linux.ibm.com> writes:

> These will be used to let GDB know about PPC's Special Purpose
> Registers (SPR).
>
> They take an index based on the order the registers appear in the XML
> file sent by QEMU to GDB. This index does not match the actual
> location of the registers in the env->spr array so the
> gdb_find_spr_idx function does that conversion.
>
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/translate_init.inc.c | 49 +++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index ade06cc773..bbb468f38d 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9483,6 +9483,55 @@ static bool avr_need_swap(CPUPPCState *env)
>  #endif
>  }
>  
> +#if !defined(CONFIG_USER_ONLY)
> +static int gdb_find_spr_idx(CPUPPCState *env, int n)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr = &env->spr_cb[i];
> +
> +        if (spr->name && spr->gdb_id == n) {
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
> +static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +{
> +    int reg;
> +    int len;
> +
> +    reg = gdb_find_spr_idx(env, n);
> +    if (reg < 0) {
> +        return 0;
> +    }
> +
> +    len = TARGET_LONG_SIZE;
> +    stn_p(mem_buf, len, env->spr[reg]);
> +    ppc_maybe_bswap_register(env, mem_buf, len);
> +    return len;
> +}
> +
> +static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +{
> +    int reg;
> +    int len;
> +
> +    reg = gdb_find_spr_idx(env, n);
> +    if (reg < 0) {
> +        return 0;
> +    }
> +
> +    len = TARGET_LONG_SIZE;
> +    ppc_maybe_bswap_register(env, mem_buf, len);
> +    env->spr[reg] = ldn_p(mem_buf, len);
> +
> +    return len;
> +}
> +#endif
> +
>  static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {

I just noticed this patch doesn't build atomically because the callbacks
are not being used. I'll send another version fixing this.
