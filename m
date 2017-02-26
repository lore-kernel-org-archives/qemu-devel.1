Received: from eggs.gnu.org ([2001:4830:134:3::10]:37863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1ci411-00086J-Tq
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 13:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmarek@suse.com>) id 1ci40y-0006Ok-KF
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 13:57:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:48998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mmarek@suse.com>) id 1ci40y-0006O8-BA
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 13:57:48 -0500
References: <20170225231653.14942-1-mmarek@suse.com>
	<20170225233845.25828-1-mmarek@suse.com>
	<41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
From: Michal Marek <mmarek@suse.com>
Message-ID: <f0b31c30-6b3e-fe9e-5f60-7a117456b595@suse.com>
Date: Sun, 26 Feb 2017 19:57:45 +0100
MIME-Version: 1.0
In-Reply-To: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Eric Bischoff <ebischoff@suse.com>, Miroslav Benes <mbenes@suse.cz>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>

Dne 26.2.2017 v 12:22 Thomas Huth napsal(a):
> On 26.02.2017 00:38, Michal Marek wrote:
>> The implementation is partially cargo cult based, but it works for the
>> linux kernel use case.
>>
>> Signed-off-by: Michal Marek <mmarek@suse.com>
>> ---
>> v3:
>>  - Initialize the buffer in do_stfle()
>> v2:
>>  - STFLE is not a privileged instruction, go through the MMU to store the
>>    result
>>  - annotate the stfl helper with TCG_CALL_NO_RWG
>>  - Use a large enough buffer to hold the feature bitmap
>>  - Fix coding style of the stfle helper
>> ---
>>  target/s390x/cpu_features.c |  6 ++++--
>>  target/s390x/cpu_features.h |  2 +-
>>  target/s390x/helper.h       |  2 ++
>>  target/s390x/insn-data.def  |  2 ++
>>  target/s390x/misc_helper.c  | 36 ++++++++++++++++++++++++++++++++++++
>>  target/s390x/translate.c    | 17 +++++++++--------
>>  6 files changed, 54 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 42fd9d792bc8..d77c560380c4 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -286,11 +286,11 @@ void s390_init_feat_bitmap(const S390FeatInit init, S390FeatBitmap bitmap)
>>      }
>>  }
>>  
>> -void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>> +int s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>>                            uint8_t *data)
>>  {
>>      S390Feat feat;
>> -    int bit_nr;
>> +    int bit_nr, res = 0;
>>  
>>      if (type == S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, features)) {
>>          /* z/Architecture is always active if around */
>> @@ -303,9 +303,11 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>>              bit_nr = s390_features[feat].bit;
>>              /* big endian on uint8_t array */
>>              data[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
>> +            res = MAX(res, bit_nr / 8 + 1);
> 
> Not sure whether the assumption is valid, but it seems like the bit
> numbers are stored in ascending order in the s390_features array, so you
> could theoretically also get along without the res variable and the MAX
> calculation and just return the last bit_nr / 8 + 1 at the end.

Maybe. If we are doing this, a comment in the s390_features definition
should be added.


>> +static int do_stfle(CPUS390XState *env, uint64_t addr, int len)
>> +{
>> +    S390CPU *cpu = s390_env_get_cpu(env);
>> +    /* 256 doublewords as per STFLE documentation */
>> +    uint8_t data[256 * 8] = { 0 };
>> +    int i, res;
>> +
>> +    memset(data, 0, sizeof(data));
> 
> You've alread set data to 0 with the "= { 0 }" initializer, so the
> memset() is redundant here (or you can remove the "= { 0 }" initializer
> instead.

Oops. It was quite late in my timezone when I sent the v3. v2 was correct.


>> +    res = s390_fill_feat_block(cpu->model->features, S390_FEAT_TYPE_STFL, data);
>> +    for (i = 0; i < MIN(res, len); i++) {
>> +        cpu_stb_data(env, addr + i, data[i]);
> 
> Since we know that we're using 64-bit values here, why not using
> cpu_stq_data instead? That should be faster.

STFL is storing a 32bit number. But this needs fixing anyway, res needs
to be rounded up to a multiple of 8.


> I think you could even use s390_cpu_virt_mem_write() here to avoid the
> loop completely.

_That_ is the function I was looking for.


>> +uint64_t HELPER(stfle)(CPUS390XState *env, uint64_t a0, uint64_t r0)
>> +{
>> +    int need, len = r0 & 0xff;
> 
> According to the POP spec, the address "must be designated on a
> doubleword boundary; otherwise, a specification exception is recognized."
> Could you please add this check here (or in translate.c)?

Dumb question, but how do I signal a specification exception?
s390_cpu_do_interrupt() does not seem to be prepared for it.


>> +void HELPER(stfl)(CPUS390XState *env)
>> +{
>> +    do_stfle(env, 200, 4);
> 
> It's maybe nicer to use offsetof(LowCore, stfl_fac_list) instead of the
> magic value 200 here.

OK.

Michal
