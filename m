Received: from eggs.gnu.org ([2001:4830:134:3::10]:57394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDwy6-0000tx-Mb
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDwy5-0004eT-Gf
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:22:22 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20161202173454.19179-1-alex.bennee@linaro.org>
	<8737i21vl8.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0bde5bb4-091e-e250-b283-5f1faf8e4351@twiddle.net>
Date: Mon, 5 Dec 2016 09:22:12 -0800
MIME-Version: 1.0
In-Reply-To: <8737i21vl8.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.8] target-arm/translate-a64: fix
 gen_load_exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, stefanha@redhat.com, peter.maydell@linaro.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 12/05/2016 03:09 AM, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> While testing rth's latest TCG patches with risu I found ldaxp was
>> broken. Investigating further I found it was broken by 1dd089d0 when
>> the cmpxchg atomic work was merged.
> 
> CC'ing Paolo/Richard
> 
> Do you guys have any final TCG fixes planned for 2.8 that can take this
> fix for the ldaxp regression?
> 
>> As part of that change the code
>> attempted to be clever by doing a single 64 bit load and then shuffle
>> the data around to set the two 32 bit registers.
>>
>> As I couldn't quite follow the endian magic I've simply partially
>> reverted the change to the original code gen_load_exclusive code. This
>> doesn't affect the cmpxchg functionality as that is all done on in
>> gen_store_exclusive part which is untouched.
>>
>> I've also restored the comment that was removed (with a slight tweak
>> to mention cmpxchg).
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  target-arm/translate-a64.c | 42 +++++++++++++++++++-----------------------
>>  1 file changed, 19 insertions(+), 23 deletions(-)
>>
>> diff --git a/target-arm/translate-a64.c b/target-arm/translate-a64.c
>> index de48747..6dc27a6 100644
>> --- a/target-arm/translate-a64.c
>> +++ b/target-arm/translate-a64.c
>> @@ -1839,41 +1839,37 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
>>      }
>>  }
>>
>> +/*
>> + * Load/Store exclusive instructions are implemented by remembering
>> + * the value/address loaded, and seeing if these are the same
>> + * when the store is performed. This is not actually the architecturally
>> + * mandated semantics, but it works for typical guest code sequences
>> + * and avoids having to monitor regular stores.
>> + *
>> + * The store exclusive uses the atomic cmpxchg primitives to avoid
>> + * races in multi-threaded linux-user and when MTTCG softmmu is
>> + * enabled.
>> + */
>>  static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
>>                                 TCGv_i64 addr, int size, bool is_pair)
>>  {
>>      TCGv_i64 tmp = tcg_temp_new_i64();
>> -    TCGMemOp be = s->be_data;
>> +    TCGMemOp memop = s->be_data + size;
>>
>>      g_assert(size <= 3);
>> +    tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), memop);
>> +
>>      if (is_pair) {
>> +        TCGv_i64 addr2 = tcg_temp_new_i64();
>>          TCGv_i64 hitmp = tcg_temp_new_i64();
>>
>> -        if (size == 3) {
>> -            TCGv_i64 addr2 = tcg_temp_new_i64();
>> -
>> -            tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s),
>> -                                MO_64 | MO_ALIGN_16 | be);
>> -            tcg_gen_addi_i64(addr2, addr, 8);
>> -            tcg_gen_qemu_ld_i64(hitmp, addr2, get_mem_index(s),
>> -                                MO_64 | MO_ALIGN | be);
>> -            tcg_temp_free_i64(addr2);
>> -        } else {
>> -            g_assert(size == 2);
>> -            tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s),
>> -                                MO_64 | MO_ALIGN | be);
>> -            if (be == MO_LE) {
>> -                tcg_gen_extr32_i64(tmp, hitmp, tmp);
>> -            } else {
>> -                tcg_gen_extr32_i64(hitmp, tmp, tmp);
>> -            }
>> -        }
>> -
>> +        g_assert(size >= 2);
>> +        tcg_gen_addi_i64(addr2, addr, 1 << size);
>> +        tcg_gen_qemu_ld_i64(hitmp, addr2, get_mem_index(s), memop);
>> +        tcg_temp_free_i64(addr2);
>>          tcg_gen_mov_i64(cpu_exclusive_high, hitmp);
>>          tcg_gen_mov_i64(cpu_reg(s, rt2), hitmp);
>>          tcg_temp_free_i64(hitmp);
>> -    } else {
>> -        tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), size | MO_ALIGN | be);
>>      }
>>
>>      tcg_gen_mov_i64(cpu_exclusive_val, tmp);

Acked-by: Richard Henderson <rth@twiddle.net>


r~
