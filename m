Received: from eggs.gnu.org ([2001:4830:134:3::10]:52264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNKB8-00013w-30
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNKB2-0007yF-1V
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:03:06 -0500
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-9-david@redhat.com>
	<a4725e2c-3b8c-eee7-1587-0a22d24aa5f2@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <be257229-3723-7144-fffb-2206cab23e79@redhat.com>
Date: Fri, 8 Dec 2017 16:02:56 +0100
MIME-Version: 1.0
In-Reply-To: <a4725e2c-3b8c-eee7-1587-0a22d24aa5f2@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 08/10] s390x/tcg: implement
 extract-CPU-time facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08.12.2017 00:54, Richard Henderson wrote:
> On 12/07/2017 08:53 AM, David Hildenbrand wrote:
>> It only provides the EXTRACT CPU TIME instruction. We can reuse the stpt
>> helper, which calculates the CPU timer value.
>>
>> As the instruction is not privileged, but we don't have a CPU timer
>> value in case of linux user, we simply fake the CPU timer to be 0.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu_models.c  |  1 +
>>  target/s390x/insn-data.def |  2 ++
>>  target/s390x/translate.c   | 36 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 39 insertions(+)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 94d24e423d..0be037eac1 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -834,6 +834,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>>          S390_FEAT_STORE_CLOCK_FAST,
>>          S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
>>          S390_FEAT_ETF3_ENH,
>> +        S390_FEAT_EXTRACT_CPU_TIME,
>>          S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
>>          S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
>>          S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
>> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
>> index f7b66b0091..5e33bd27ff 100644
>> --- a/target/s390x/insn-data.def
>> +++ b/target/s390x/insn-data.def
>> @@ -369,6 +369,8 @@
>>      C(0xb24f, EAR,     RRE,   Z,   0, 0, new, r1_32, ear, 0)
>>  /* EXTRACT CPU ATTRIBUTE */
>>      C(0xeb4c, ECAG,    RSY_a, GIE, 0, a2, r1, 0, ecag, 0)
>> +/* EXTRACT CPU TIME */
>> +    C(0xc801, ECTG,    SSF,   ECT, 0, 0, 0, 0, ectg, 0)
>>  /* EXTRACT FPC */
>>      C(0xb38c, EFPC,    RRE,   Z,   0, 0, new, r1_32, efpc, 0)
>>  /* EXTRACT PSW */
>> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
>> index 1e4079464a..e0f55fc8e9 100644
>> --- a/target/s390x/translate.c
>> +++ b/target/s390x/translate.c
>> @@ -3887,6 +3887,41 @@ static ExitStatus op_spm(DisasContext *s, DisasOps *o)
>>      return NO_EXIT;
>>  }
>>  
>> +static ExitStatus op_ectg(DisasContext *s, DisasOps *o)
>> +{
>> +    int b1 = get_field(s->fields, b1);
>> +    int d1 = get_field(s->fields, d1);
>> +    int b2 = get_field(s->fields, b2);
>> +    int d2 = get_field(s->fields, d2);
>> +    int r3 = get_field(s->fields, r3);
>> +    TCGv_i64 tmp = tcg_temp_new_i64();
>> +
>> +    /* fetch all operands first */
>> +    o->in1 = tcg_temp_new_i64();
>> +    tcg_gen_addi_i64(o->in1, regs[b1], d1);
>> +    o->in2 = tcg_temp_new_i64();
>> +    tcg_gen_addi_i64(o->in2, regs[b2], d2);
>> +    o->addr1 = get_address(s, 0, r3, 0);
>> +
>> +    /* load the third operand into r3 before modifying anything */
>> +    tcg_gen_qemu_ld64(regs[r3], o->addr1, get_mem_index(s));
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +    /* subtract CPU timer from first operand and store in GR0 */
>> +    gen_helper_stpt(tmp, cpu_env);
>> +    tcg_gen_sub_i64(regs[0], o->in1, tmp);
>> +#else
>> +    /* we don't have a CPU timer, fake value 0 */
>> +    tcg_gen_mov_i64(regs[0], o->in1);
>> +#endif
> 
> It's easy enough to pass along cpu_get_host_ticks() for user-only.  Possibly
> not quite right, but better than nothing.
> 
> 
> r~
> 


What about this:


+/* Store CPU Timer (also used for EXTRACT CPU TIME) */
+uint64_t HELPER(stpt)(CPUS390XState *env)
+{
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * Fake a descending CPU timer. We could get negative values here,
+     * but we don't care as it is up to the OS when to process that
+     * interrupt and reset to > 0.
+     */
+    return UINT64_MAX - (uint64_t)cpu_get_host_ticks();
+#else
+    return time2tod(env->cputm - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+#endif
+}
+

-- 

Thanks,

David / dhildenb
