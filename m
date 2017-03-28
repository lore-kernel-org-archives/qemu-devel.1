Received: from eggs.gnu.org ([2001:4830:134:3::10]:52501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cspGP-0003BN-NS
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cspGJ-0000hl-RR
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:44318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cspGJ-0000gs-HR
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:26:07 -0400
References: <1490653177-131484-1-git-send-email-agraf@suse.de>
	<20170328004108.GP28530@thinpad.lan.raisama.net>
From: Alexander Graf <agraf@suse.de>
Message-ID: <9d85e056-3331-9815-404b-9557ca5028cc@suse.de>
Date: Tue, 28 Mar 2017 13:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170328004108.GP28530@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 03/28/2017 02:41 AM, Eduardo Habkost wrote:
> On Tue, Mar 28, 2017 at 12:19:37AM +0200, Alexander Graf wrote:
>> KVM has a feature bitmap of CPUID bits that it knows works for guests.
>> QEMU removes bits that are not part of that bitmap automatically on VM
>> start.
>>
>> However, some times we just don't list features in that list because
>> they don't make sense for normal scenarios, but may be useful in specific,
>> targeted workloads.
>>
>> For that purpose, add a new =force option to all CPUID feature flags in
>> the CPU property. With that we can override the accel filtering and give
>> users full control over the CPUID feature bits exposed into guests.
>>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>>   target/i386/cpu.c | 30 ++++++++++++++++++++++++++----
>>   target/i386/cpu.h |  3 +++
>>   2 files changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 7aa7622..5a22f9a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2229,7 +2229,7 @@ void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>>       g_slist_foreach(list, x86_cpu_list_entry, &s);
>>       g_slist_free(list);
>>   
>> -    (*cpu_fprintf)(f, "\nRecognized CPUID flags:\n");
>> +    (*cpu_fprintf)(f, "\nRecognized CPUID flags (=on|=off|=force):\n");
>>       for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
>>           FeatureWordInfo *fw = &feature_word_info[i];
>>   
>> @@ -3460,6 +3460,7 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>>               x86_cpu_get_supported_feature_word(w, false);
>>           uint32_t requested_features = env->features[w];
>>           env->features[w] &= host_feat;
>> +        env->features[w] |= cpu->forced_features[w];
>>           cpu->filtered_features[w] = requested_features & ~env->features[w];
>>           if (cpu->filtered_features[w]) {
>>               rv = 1;
>> @@ -3693,6 +3694,7 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
>>   
>>   typedef struct BitProperty {
>>       uint32_t *ptr;
>> +    uint32_t *force_ptr;
>>       uint32_t mask;
>>   } BitProperty;
> Please take a look at:
>    Subject: [PATCH for-2.9 v2 1/2] i386: Replace uint32_t* with FeatureWord on feature getter/setter
>
> I plan to include that series in 2.9, and it would make the
> force_ptr field unnecessary.
>
>>   
>> @@ -3701,7 +3703,15 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
>>   {
>>       BitProperty *fp = opaque;
>>       bool value = (*fp->ptr & fp->mask) == fp->mask;
>> -    visit_type_bool(v, name, &value, errp);
>> +    bool forced = (*fp->force_ptr & fp->mask) == fp->mask;
>> +    char str[] = "force";
>> +    char *strval = str;
>> +
>> +    if (!forced) {
>> +        strcpy(str, value ? "on" : "off");
>> +    }
>> +
>> +    visit_type_str(v, name, &strval, errp);
> You can define an enum type in qapi-schema.json, and use
> visit_type_<YourEnumType>(). You can grep for
> visit_type_OnOffAuto to find examples.
>
> (But I suggest naming the enum something like
> "X86CPUFeatureSetting" instead of "OnOffForce", because we will
> probably add other enum values in the future).
>
> However: we need to find a way to do this and not break
> compatibility with "feat=yes|true|no|false", that's supported by
> StringInputVisitor (which is used by object_property_parse()).
> Maybe fallback to visit_type_bool() in case
> visit_type_<YourEnumType>() fails?

Putting it into a special enum sounds much more fragile than the current 
solution to me. We need to bool fallback either way, so I fail to see 
any benefit from having the enum.


Alex
