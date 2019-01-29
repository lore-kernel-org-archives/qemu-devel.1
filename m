Received: from eggs.gnu.org ([209.51.188.92]:41350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goHG7-0007BW-0f
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goHG5-0000jU-Os
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:28:10 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1goHG5-0000fI-Ea
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:28:09 -0500
Received: by mail-pg1-x544.google.com with SMTP id t13so7939528pgr.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 16:28:08 -0800 (PST)
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-3-farosas@linux.ibm.com>
	<30929550-4e18-6c43-1d8f-d4065ec70544@ozlabs.ru>
	<20190126015006.GB22942@umbus> <878sz41rjx.fsf@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d06f8763-f994-5913-424a-542f33d6b09a@ozlabs.ru>
Date: Tue, 29 Jan 2019 11:28:01 +1100
MIME-Version: 1.0
In-Reply-To: <878sz41rjx.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 2/3] target/ppc: Add GDB
 callbacks for SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Richard Henderson <richard.henderson@linaro.org>, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 29/01/2019 07:00, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> 
>> On Thu, Jan 24, 2019 at 06:20:02PM +1100, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 23/01/2019 04:01, Fabiano Rosas wrote:
>>>> These will be used to let GDB know about PPC's Special Purpose
>>>> Registers (SPR).
>>>>
>>>> They take an index based on the order the registers appear in the XML
>>>> file sent by QEMU to GDB. This index does not match the actual
>>>> location of the registers in the env->spr array so the
>>>> gdb_find_spr_idx function does that conversion.
>>>>
>>>> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
>>>> ---
>>>>  target/ppc/translate_init.inc.c | 54 ++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 53 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
>>>> index 710064a25d..f29ac3558a 100644
>>>> --- a/target/ppc/translate_init.inc.c
>>>> +++ b/target/ppc/translate_init.inc.c
>>>> @@ -9487,6 +9487,55 @@ static bool avr_need_swap(CPUPPCState *env)
>>>>  #endif
>>>>  }
>>>>  
>>>> +#if !defined(CONFIG_USER_ONLY)
>>>> +static int gdb_find_spr_idx(CPUPPCState *env, int n)
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>>>> +        ppc_spr_t *spr = &env->spr_cb[i];
>>>> +
>>>> +        if (spr->name && spr->gdb_id == n) {
>>>> +            return i;
>>>> +        }
>>>> +    }
>>>> +    return -1;
>>>> +}
>>>> +
>>>> +static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>>>> +{
>>>> +    int reg;
>>>> +    int len;
>>>> +
>>>> +    reg = gdb_find_spr_idx(env, n);
>>>> +    if (reg < 0) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    len = TARGET_LONG_SIZE;
>>>> +    stn_p(mem_buf, len, env->spr[reg]);
>>>> +    ppc_maybe_bswap_register(env, mem_buf, len);
>>>
>>>
>>> I am confused by this as it produces different results depending on the
>>> guest mode:
>>
>>
>> Hm, yeah, I thought the bswap here looked odd, but it wasn't obvious
>> to me if it was bogus here, or just a bogus gdb interface we have to
>> work around.
>>
>>> (gdb) p $pvr
>>> $1 = 0x14c0000000000
>>> (gdb) c
>>> Continuing.
>>> Program received signal SIGINT, Interrupt.
>>> (gdb) p $pvr
>>> $2 = 0x4c0100
>>
>> But that behaviour definitely looks wrong.
> 
> GDB detects the endianness by looking at the ELF headers:


but this is a register which does not have endianness, the endianness
appears here because the interface between gdb and qemu is
uint8_t*==bytestream but this interface should have fixed endianness
imho (now it is bigendian afaict).

Something is not right here...

> 
> (gdb) p/x $pvr
> $1 = 0x1024b0000000000
> (gdb) file ~/qemu/roms/SLOF/board-qemu/llfw/stage1.elf
> Reading symbols from ~/qemu/roms/SLOF/board-qemu/llfw/stage1.elf...done.
> (gdb) show endian
> The target endianness is set automatically (currently big endian)
> (gdb) p/x $pvr
> $2 = 0x4b0201
> (gdb) c
> Continuing.
> 
> (gdb) ^C
> Program received signal SIGINT, Interrupt.
> 0x74a70c00000000c0 in ?? ()
> (gdb) file vmlinux
> Reading symbols from vmlinux...done.
> (gdb) show endian
> The target endianness is set automatically (currently little endian)
> (gdb) p/x $pvr
> $3 = 0x4b0201
> 
> The maybe_bswap_register is done due to QEMU having TARGET_WORDS_BIGENDIAN set
> even after we have changed into LE mode.
> 
>>> First print is when I stopped the guest in the SLOF firmware (so it is
>>> big-endian) and then I continued and stopped gdb when the guest booted a
>>> little-endian system; the KVM host is little endian, the machine running
>>> gdb is LE too.
>>>
>>> QEMU monitor prints the same 0x4c0100 in both cases.
>>>
>>> I am adding the inventor of maybe_bswap_register() in cc: for
>>> assistance. Swapping happens:
>>> - once for BE: after stn_p()
>>> 	*(unsigned long *)mem_buf is 0x14c0000000000
>>> - twice for LE.
>>>
>>>
>>>
>>>
>>>
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>>>> +{
>>>> +    int reg;
>>>> +    int len;
>>>> +
>>>> +    reg = gdb_find_spr_idx(env, n);
>>>> +    if (reg < 0) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    len = TARGET_LONG_SIZE;
>>>> +    ppc_maybe_bswap_register(env, mem_buf, len);
>>>> +    env->spr[reg] = ldn_p(mem_buf, len);
>>>> +
>>>> +    return len;
>>>> +}
>>>> +#endif
>>>> +
>>>>  static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>>>>  {
>>>>      if (n < 32) {
>>>> @@ -9716,7 +9765,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>>>>          gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
>>>>                                   32, "power-vsx.xml", 0);
>>>>      }
>>>> -
>>>> +#ifndef CONFIG_USER_ONLY
>>>> +    gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
>>>> +                             pcc->gdb_num_sprs, "power-spr.xml", 0);
>>>> +#endif
>>>>      qemu_init_vcpu(cs);
>>>>  
>>>>      pcc->parent_realize(dev, errp);
>>>>
>>>
> 

-- 
Alexey
