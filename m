Received: from eggs.gnu.org ([2001:4830:134:3::10]:54707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGnXo-0000Bf-4N
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dGnXj-0006Ul-Ao
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dGnXj-0006UP-1S
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:27:11 -0400
References: <20170531220129.27724-1-aurelien@aurel32.net>
	<20170531220129.27724-31-aurelien@aurel32.net>
	<ea25b082-923d-6c7d-bca3-b4adbd412419@redhat.com>
	<781667e0-740c-8e43-d94b-387092eab0e6@redhat.com>
	<20170601191718.6cftzl5ama4s3es3@aurel32.net>
	<c3c65598-59ca-c80e-1f8d-340ab19d902f@redhat.com>
	<207db011-5035-acb3-2032-8408b4ec38e6@redhat.com>
	<20170602140429.elahcu5olntw7ypi@aurel32.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <69683bdb-f972-e9ed-5599-8f2b88711b02@redhat.com>
Date: Fri, 2 Jun 2017 16:27:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170602140429.elahcu5olntw7ypi@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 30/30] target/s390x: update maximum TCG
 model to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 02.06.2017 16:04, Aurelien Jarno wrote:
> On 2017-06-02 13:30, David Hildenbrand wrote:
>> On 02.06.2017 10:09, Thomas Huth wrote:
>>> On 01.06.2017 21:17, Aurelien Jarno wrote:
>>>> On 2017-06-01 11:04, David Hildenbrand wrote:
>>>>> On 01.06.2017 10:38, David Hildenbrand wrote:
>>>>>> On 01.06.2017 00:01, Aurelien Jarno wrote:
>>>>>>> At the same time fix the TCG version of get_max_cpu_model to return the
>>>>>>> maximum model like on KVM. Remove the ETF2 and long-displacement
>>>>>>
>>>>>> I don't understand the part
>>>>>> "fix the TCG version of get_max_cpu_model to return the maximum model
>>>>>> like on KVM".
>>>>>>
>>>>>> Can you elaborate?
>>>>>>
>>>>>>> facilities from the additional features as it is included in the z800.
>>>>>>>
>>>>>>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>>>>>> ---
>>>>>>>  target/s390x/cpu_models.c | 13 ++++++-------
>>>>>>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>>>>>> index fc3cb25cc3..c13bbd852c 100644
>>>>>>> --- a/target/s390x/cpu_models.c
>>>>>>> +++ b/target/s390x/cpu_models.c
>>>>>>> @@ -668,8 +668,6 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>>>>>>>      static const int feats[] = {
>>>>>>>          S390_FEAT_STFLE,
>>>>>>>          S390_FEAT_EXTENDED_IMMEDIATE,
>>>>>>> -        S390_FEAT_EXTENDED_TRANSLATION_2,
>>>>>>> -        S390_FEAT_LONG_DISPLACEMENT,
>>>>>>>          S390_FEAT_LONG_DISPLACEMENT_FAST,
>>>>>>>          S390_FEAT_ETF2_ENH,
>>>>>>>          S390_FEAT_STORE_CLOCK_FAST,
>>>>>>> @@ -696,9 +694,9 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>>>>>>>      if (kvm_enabled()) {
>>>>>>>          kvm_s390_get_host_cpu_model(&max_model, errp);
>>>>>>>      } else {
>>>>>>> -        /* TCG emulates a z900 (with some optional additional features) */
>>>>>>> -        max_model.def = &s390_cpu_defs[0];
>>>>>>> -        bitmap_copy(max_model.features, max_model.def->default_feat,
>>>>>>> +        /* TCG emulates a z800 (with some optional additional features) */
>>>>>>> +        max_model.def = s390_find_cpu_def(0x2066, 7, 3, NULL);
>>>>>>> +        bitmap_copy(max_model.features, max_model.def->full_feat,
>>>>>>>                      S390_FEAT_MAX);
>>>>>
>>>>> This is most likely wrong: you're indicating features here that are not
>>>>> available on tcg. esp. S390_FEAT_SIE_F2 and friends.
>>>>>
>>>>> I think should only copy the base features and add whatever else is
>>>>> available via add_qemu_cpu_model_features() as already done.
>>>>
>>>> The patch series added all the z800 features exposed via STFL/STFLE.
>>>> Indeed the SIE features are missing, but anyway QEMU doesn't emulate SIE
>>>> at all so the lack of these features are not exposed to the guest. In that
>>>> regard QEMU already wrongly claim to emulate a z900.
>>
>> Please note that:
>>
>> a) SIE features were never part of the max model. QEMU never claimed
>> that. With your change one could suddenly do a -cpu z900,sie_f2=on,
>> which is wrong.
>>
>> b) The SIE_F2 feature tells the guest that the SIE instruction is
>> available. E.g. Linux will look at this bit and show SIE support in
>> /proc/cpuinfo and unlock the KVM module.
> 
> I understand your point. That said I doubt we will support the SIE
> instruction soon (it looks quite complicated and I can't find any doc).
> As we are going to emulate more facilities to QEMU, it will be more and
> more difficult to select a modern CPU. One will have to use -cpu,z900,
> etf2=on,ldisp=on,...,eimm=on. I think we have to provide users with an
> easier way to do that.
> 

Okay, I think you got something wrong here (which happens easily with
all these different model types).

CPU definitions:
- Base definition: Minimum features we expect to be around on such a CPU
- Default definition: Features we expect to be around in sane
  environments (== KVM on LPAR)
- Full definition: Maximum features that could be around on such a CPU
  (and there are ususally quite some missing, e.g. when running KVM
   under z/VM)

Only default and full definitions can ever change.

CPU models:
- Base model: maps to base definition == will never change
   -> e.g. "z900-base"
- Default model: maps to default definition == can change (but migration
  safe via compatibility machines!)
  -> e.g. "z900" or "qemu"
- Host model: only for KVM, maps to "max model"
- Max model: (not exposed yet directly for TCG) "maximum supported model
  + features"

Full models do not exist!
So in summary, what you want to do here is:

1. Get the definition of the z800 model. Copy the base features to the
   max model.
2. Add all features that are supported additionally and not in the base.
3. (Maybe add a hack like Thomas implemented to support some further
    features that are exceeding the full model)

So, especially, the CPU model "z800" does not map to the full model, but
the default model. It will never contain SIE features (at least for now)

-cpu z800 can therefore be used just fine, as it won't select SIE
features (especially because SIE features are also only available for
KVM in rare situations as nested virtualization has to be enabled
explcitily).

You can use

{ "execute": "query-cpu-model-expansion", "arguments": { "type": "full",
"model": { "name": "z800" } } }

To see all features that are currently part of the "default" model.

{"return": {"model": {"name": "z800-base", "props": {"pfmfi": false,
"exrl": false, "stfle45": false, "cmma": false, "dateh2": false,
"gen13ptff": false, "dateh": false, "iacc2": false, "parseh": false,
"csst": false, "idter": false, "idtes": false, "msa": false, "aefsi":
false, "csst2": false, "csske": false, "msa5": false, "msa4": false,
"msa3": false, "msa2": false, "msa1": false, "sthyi": false, "stckf":
false, "stfle": false, "etf3": false, "etf2": false, "edat": false,
"hfpm": false, "ri": false, "edat2": false, "hfpue": false, "dfp":
false, "mvcos": false, "sprogp": false, "sigpif": false, "ldisphp":
false, "vx": false, "ipter": false, "emon": false, "cei": false,
"cmpsceh": false, "ginste": false, "dfppc": false, "dfpzc": false,
"dfphp": false, "stfle49": false, "asnlxr": false, "gpereh": false,
"esop": false, "ectg": false, "ib": false, "siif": false, "esan3": true,
"fpe": false, "ibs": false, "zarch": true, "stfle53": false, "sief2":
false, "eimm": false, "srs": false, "cte": false, "fpseh": false,
"ltlbc": false, "ldisp": false, "64bscao": false, "ctop": false,
"etf3eh": false, "etf2eh": false, "nonqks": false, "pfpo": false, "te":
false, "cmm": false, "tods": false, "plo": true, "gsls": false, "skey":
false}}}}

Which is the same as
{ "execute": "query-cpu-model-expansion", "arguments": { "type":
"static", "model": { "name": "z800" } } }
{"return": {"model": {"name": "z800-base"}}}

So no SIE features.


> One possibility would be to filter the features that are not emulated by
> QEMU (like on the ppc64 target) or to allow the user to specify a higher
> model provided the non emulated features are disabled. Something like
> -cpu z800,sie_f2=off.
> 
>> Please, just don't add features to the MAX model that we don't implement.
> 
> Please note that QEMU does not fully implement S390_FEAT_ESAN3 (though
> that is addressed in this patchset) and S390_FEAT_ZARCH, despite
> claiming it.

Yes, there is a lot missing on the TCG side as I noticed already :) But
I think we're going into the right direction. (as long as Linux runs ...)


-- 

Thanks,

David
