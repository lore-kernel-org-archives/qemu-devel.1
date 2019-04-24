Received: from eggs.gnu.org ([209.51.188.92]:42289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJDrb-0003JP-39
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJDoD-0003cP-Q8
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:03:18 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
	<a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <03eb94f6-6f8f-0358-df00-bc487e5e3bff@redhat.com>
Date: Wed, 24 Apr 2019 11:03:03 +0200
MIME-Version: 1.0
In-Reply-To: <a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/10] s390x: new guest features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 24.04.19 10:40, Christian Borntraeger wrote:
>=20
>=20
> On 23.04.19 14:11, David Hildenbrand wrote:
>> On 18.04.19 13:31, Christian Borntraeger wrote:
>>> Adding generation 15.
>>>
>>> Some interesting aspects:
>>> - conditional SSKE and bpb are deprecated. This patch set addresses t=
hat
>>>   for csske.
>>> - no name yet for gen15, I suggest to use the assigned numbers and
>>>   provide an alias later on. (I have split out this into a separate
>>>   patch)
>>>
>>> Christian Borntraeger (10):
>>>   linux header sync
>>>   s390x/cpumodel: remove CSSKE from base model
>>>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
>>>   s390x/cpumodel: msa9 facility
>>>   s390x/cpumodel: vector enhancements
>>>   s390x/cpumodel: enhanced sort facility
>>>   s390x/cpumodel: deflate
>>>   s390x/cpumodel: add gen15 defintions
>>>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
>>>   s390x/cpumodel: do not claim csske for expanded models in qmp
>>>
>>>  hw/s390x/s390-virtio-ccw.c      |  6 +++
>>>  linux-headers/asm-s390/kvm.h    |  5 +-
>>>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
>>>  target/s390x/cpu_features.h     |  3 ++
>>>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
>>>  target/s390x/cpu_models.c       | 35 ++++++++++++
>>>  target/s390x/cpu_models.h       |  1 +
>>>  target/s390x/gen-features.c     | 94 +++++++++++++++++++++++++++++++=
+-
>>>  target/s390x/kvm.c              | 18 +++++++
>>>  9 files changed, 263 insertions(+), 2 deletions(-)
>>>
>>
>> I guess to handle deprecation of CSSKE:
>>
>> 1. Remove it from the base + default model of the gen15, keep it in th=
e
>> max model. This is completely done in target/s390x/gen-features.c.
>> Existing base models are not modified.
>>
>> 2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.g. z14
>> will work. We can backport this to distros/stable.
>=20
> Yes, I have already implemented that, still doing some testing and poli=
shinh.
>>
>>
>> CPU model expansion:
>>
>> cpu_info_from_model() should already properly be based on the base
>> features. "gen15" vs. "gen15,csske=3Don" should be automatically gener=
ated
>> when expanding.
>>
>> CPU model baseline:
>>
>> s390_find_cpu_def() should make sure that CSSKE is basically ignored
>> when determining maximum model, however it will properly be indicated =
if
>> both models had the feature.
>>
>> CPU model comparison:
>>
>> Should work as expected. Availability of CSSKE will be considered when
>> calculating the result.
>>
>> gen14,csske=3Don and gen15,csske=3Doff will result in
>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.
>>
>> gen14,csske=3Doff and gen15,csske=3Doff should result in
>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>
>> gen14,csske=3Don and gen15,csske=3Don should result in
>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>
>> Forward migration:
>>
>> Now, the only issue is when csske is actually turned of in future
>> machines. We would e.g. have
>>
>> gen15,csske=3Don and gen16,csske=3Doff
>>
>> While baselining will work correctly (gen15,csske=3Doff), forward
>> migration is broken (comparison will properly indicate
>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when ripping
>> out features. Same applies to BPB.
>>
>>
>> Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske for
>> expanded models in qmp" tried to address this, however I am not really
>> happy with this approach. We should not play such tricks when expandin=
g
>> the host model. "-cpu host" and "-cpu $expanded_host" would be
>> different,
>=20
> We discussed this some time ago and I think we agreed that for host pas=
sthrough
> it is ok to be different that host-model (e.g. passing through the cpui=
d, passing
> through all non-hypervisor managed features etc).

I remember the plan was to use the "max" model to do such stuff. E.g.
-cpu max / no -cpu

Versus
-cpu host

We can have features in "host" we don't have in "max". But "-cpu host"
and it's expansion should look 100% the same.

>=20
>=20
>> that is really confusing, especially think about baselining
>> or comparing against "host", where your patch does not apply..
>>
>>
>> Whenever users would specify "-cpu gen15", everything would be fine in
>> regards to forward migration. Maybe clients really have to be taught
>> about upcoming forward migration issues. "Don't use the host model, ma=
ke
>> sure bpa and csske are disabled".
>=20
>=20
> the thing is, I think the host-model is actually the preferred setting =
so I
> would like to have this forward-migrateable as well. I will focus on pa=
tches
> 1-9 first and lets have a side discussion on patch 10.
>=20

Makes sense. This is also something that can be fixed on higher layers
(disable cpu feature for gen15 to prepare for migration).

--=20

Thanks,

David / dhildenb
