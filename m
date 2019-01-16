Received: from eggs.gnu.org ([209.51.188.92]:34724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjdaX-0001vS-0O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjdUj-0000Fe-Sd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:12:06 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gjdUg-00008h-2f
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:12:03 -0500
Received: by mail-pg1-x543.google.com with SMTP id t13so2248098pgr.11
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 21:11:58 -0800 (PST)
References: <20190114154113.6188-1-farosas@linux.ibm.com>
	<20190114154113.6188-3-farosas@linux.ibm.com>
	<87imyp20uv.fsf@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1bf214c0-4f49-0c55-30e0-85e1ec110f61@ozlabs.ru>
Date: Wed, 16 Jan 2019 16:11:52 +1100
MIME-Version: 1.0
In-Reply-To: <87imyp20uv.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au



On 16/01/2019 06:10, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@linux.ibm.com> writes:
> 
>> These will be used to let GDB know about PPC's Special Purpose
>> Registers (SPR).
>>
>> They take an index based on the order the registers appear in the XML
>> file sent by QEMU to GDB. This index does not match the actual
>> location of the registers in the env->spr array so the
>> gdb_find_spr_idx function does that conversion.
>>
>> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
>> ---
>>  target/ppc/translate_init.inc.c | 49 +++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
>> index ade06cc773..bbb468f38d 100644
>> --- a/target/ppc/translate_init.inc.c
>> +++ b/target/ppc/translate_init.inc.c
>> @@ -9483,6 +9483,55 @@ static bool avr_need_swap(CPUPPCState *env)
>>  #endif
>>  }
>>  
>> +#if !defined(CONFIG_USER_ONLY)
>> +static int gdb_find_spr_idx(CPUPPCState *env, int n)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>> +        ppc_spr_t *spr = &env->spr_cb[i];
>> +
>> +        if (spr->name && spr->gdb_id == n) {
>> +            return i;
>> +        }
>> +    }
>> +    return -1;
>> +}
>> +
>> +static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>> +{
>> +    int reg;
>> +    int len;
>> +
>> +    reg = gdb_find_spr_idx(env, n);
>> +    if (reg < 0) {
>> +        return 0;
>> +    }
>> +
>> +    len = TARGET_LONG_SIZE;
>> +    stn_p(mem_buf, len, env->spr[reg]);
>> +    ppc_maybe_bswap_register(env, mem_buf, len);
>> +    return len;
>> +}
>> +
>> +static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>> +{
>> +    int reg;
>> +    int len;
>> +
>> +    reg = gdb_find_spr_idx(env, n);
>> +    if (reg < 0) {
>> +        return 0;
>> +    }
>> +
>> +    len = TARGET_LONG_SIZE;
>> +    ppc_maybe_bswap_register(env, mem_buf, len);
>> +    env->spr[reg] = ldn_p(mem_buf, len);
>> +
>> +    return len;
>> +}
>> +#endif
>> +
>>  static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>>  {
>>      if (n < 32) {
> 
> I just noticed this patch doesn't build atomically because the callbacks
> are not being used. I'll send another version fixing this.

Just merge it into 3/3.



-- 
Alexey
