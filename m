Received: from eggs.gnu.org ([2001:4830:134:3::10]:48654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dEcvr-0007tF-ES
	for qemu-devel@nongnu.org; Sat, 27 May 2017 10:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dEcvo-0001tB-8k
	for qemu-devel@nongnu.org; Sat, 27 May 2017 10:43:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dEcvn-0001pr-Vn
	for qemu-devel@nongnu.org; Sat, 27 May 2017 10:43:04 -0400
References: <1495704132-5675-1-git-send-email-thuth@redhat.com>
	<b8b5569d-db2a-2c6c-f4c2-6647bb1444e5@redhat.com>
	<091318e1-6572-9c69-c294-2dab340e03ed@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fc75573b-555b-3033-0984-7393c68a3271@redhat.com>
Date: Sat, 27 May 2017 16:42:57 +0200
MIME-Version: 1.0
In-Reply-To: <091318e1-6572-9c69-c294-2dab340e03ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x/cpu_models: Allow some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 26.05.2017 22:14, Thomas Huth wrote:
> On 26.05.2017 14:14, David Hildenbrand wrote:
>> On 25.05.2017 11:22, Thomas Huth wrote:
>>> Currently we only present the plain z900 feature bits to the guest,
>>> but QEMU already emulates some additional features (but not all of
>>> the next CPU generation, so we can not use the next CPU level as
>>> default yet). Since newer Linux kernels are checking the feature bits
>>> and refuse to work if a required feature is missing, it would be nice
>>> to have a way to present more of the supported features when we are
>>> running with the "qemu" CPU.
>>> This patch now adds the supported features to the "full_feat" bitmap,
>>> so that additional features can be enabled on the command line now,
>>> for example with:
>>>
>>>  qemu-system-s390x -cpu qemu,stfle=true,ldisp=true,eimm=true,stckf=true>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  v2: Mark feats array with "static const"
>>>
>>>  target/s390x/cpu_models.c | 34 +++++++++++++++++++++++++++++++---
>>>  1 file changed, 31 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index 8d27363..e5e005a 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -658,6 +658,30 @@ static void check_compatibility(const S390CPUModel *max_model,
>>>                    "available in the configuration: ");
>>>  }
>>>  
>>> +/**
>>> + * The base TCG CPU model "qemu" is based on the z900. However, we already
>>> + * can also emulate some additional features of later CPU generations, so
>>> + * we add these additional feature bits here.
>>> + */
>>> +static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>>> +{
>>> +    static const int feats[] = {
>>> +        S390_FEAT_STFLE,
>>> +        S390_FEAT_EXTENDED_IMMEDIATE,
>>> +        S390_FEAT_LONG_DISPLACEMENT,
>>> +        S390_FEAT_LONG_DISPLACEMENT_FAST,
>>> +        S390_FEAT_STORE_CLOCK_FAST,
>>> +        S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
>>> +        S390_FEAT_EXECUTE_EXT,
>>> +        S390_FEAT_STFLE_45,
>>> +    };
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(feats); i++) {
>>> +        set_bit(feats[i], fbm);
>>> +    }
>>> +}
>>> +
>>>  static S390CPUModel *get_max_cpu_model(Error **errp)
>>>  {
>>>      static S390CPUModel max_model;
>>> @@ -670,10 +694,11 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>>>      if (kvm_enabled()) {
>>>          kvm_s390_get_host_cpu_model(&max_model, errp);
>>>      } else {
>>> -        /* TCG emulates a z900 */
>>> +        /* TCG emulates a z900 (with some optional additional features) */
>>>          max_model.def = &s390_cpu_defs[0];
>>>          bitmap_copy(max_model.features, max_model.def->default_feat,
>>>                      S390_FEAT_MAX);
>>> +        add_qemu_cpu_model_features(max_model.features);
>>>      }
>>>      if (!*errp) {
>>>          cached = true;
>>> @@ -925,11 +950,14 @@ static void s390_host_cpu_model_initfn(Object *obj)
>>>  
>>>  static void s390_qemu_cpu_model_initfn(Object *obj)
>>>  {
>>> +    static S390CPUDef s390_qemu_cpu_defs;
>>>      S390CPU *cpu = S390_CPU(obj);
>>>  
>>>      cpu->model = g_malloc0(sizeof(*cpu->model));
>>> -    /* TCG emulates a z900 */
>>> -    cpu->model->def = &s390_cpu_defs[0];
>>> +    /* TCG emulates a z900 (with some optional additional features) */
>>> +    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_cpu_defs));
>>> +    add_qemu_cpu_model_features(s390_qemu_cpu_defs.full_feat);
>>> +    cpu->model->def = &s390_qemu_cpu_defs;
>>>      bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
>>>                  S390_FEAT_MAX);
>>
>> That should work for the general case, at least for now.
>>
>> arch_query_cpu_model_baseline() will still drop the additional featues.
> 
> It's only for experimenting with the additional feature right now, not
> for serious usage yet (since some features are still missing to run
> Linux kernels that are compiled for something > z900) - so I don't think
> we need this for QMP already, i.e. IMHO we do not need care too much
> about arch_query_cpu_model_baseline() yet.
> 

Yes, for a short term solution this should be just fine.

>> Another option would be to directly bump up the CPU model to a z9, with
>> missing base features (for now). Which looks cleaner in my eyes:
> 
> But couldn't this cause issues, too? What if a kernel just assumes that
> certain features are available with a z9 machine, without having a
> closer look at the feature bits? Also, what about the features that we

A tcg guest currently only sees the feature part of CPU models. So e.g.
CPUID is not correctly set. So it most likely makes sense to connect
that properly to the CPU model, too, before we change the CPU
generation. (otherwise we will have guest visible changes once we
connect it - not the features will change but the CPU type/generation).

> already provide, but that were not available in the z9 yet, like
> S390_FEAT_GENERAL_INSTRUCTIONS_EXT (which was introduced with the z10 as
> far as I can see)? Don't you have the same issue with
> arch_query_cpu_model_baseline() there?

Both point are true. In your approach, I don't like creation of fake,
duplicate CPU definitions. But as this will be a short term "hack" to
allow enabling these features, this should be fine for now. We should
just keep in mind that once we want to enable these features
permanently, that we should get rid of the hacked up CPU definition and
implement proper migration compatibility support.

So
Acked-by: David Hildenbrand <david@redhat.com>

Thanks!


> 
>  Thomas
> 


-- 

Thanks,

David
