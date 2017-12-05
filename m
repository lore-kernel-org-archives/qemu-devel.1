Received: from eggs.gnu.org ([2001:4830:134:3::10]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMGAy-0001x8-1y
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMGAu-0008OJ-4R
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:34:32 -0500
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-10-david@redhat.com>
	<20171205162408.31ccdf1f.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <977ac4ff-331d-ad0c-9e30-4fbb80bc539d@redhat.com>
Date: Tue, 5 Dec 2017 17:34:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171205162408.31ccdf1f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 9/9] s390x: change the QEMU cpu
 model to a stripped down z12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 05.12.2017 16:24, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 15:01:50 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> We are good enough to boot upstream Linux kernels / Fedora 26/27. That
>> should be suficient for now.
> 
> s/suficient/sufficient/
> 
>>
>> As the QEMU CPU model is migration safe, let's add compatibility code.
>> Generate the feature list to reduce the trouble of messing things up in the
>> future.
> 
> So we can mess up things effortlessly? :)

See, what I care about :P

s/trouble/chance/

> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c  |   6 +++
>>  target/s390x/cpu.h          |   3 ++
>>  target/s390x/cpu_models.c   | 100 ++++++++++++++++++--------------------------
>>  target/s390x/cpu_models.h   |   1 +
>>  target/s390x/gen-features.c |  87 ++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 138 insertions(+), 59 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index a23b8aec9f..edd18b7fac 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -721,6 +721,9 @@ bool css_migration_enabled(void)
>>  
>>  static void ccw_machine_2_12_instance_options(MachineState *machine)
>>  {
>> +    const S390FeatBitmap qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_12 };
>> +
>> +    s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
> 
> Does this want a comment?

Yes, will add comments to both.
[...]
>> +
>> +    /* TCG emulates some features that can usually not be enabled with
>> +     * the emulated machine generation. Make sure they can be enabled
>> +     * when using the QEMU model by adding them to full_feat. We have
>> +     * to copy the definition to do that.
>> +     */
>> +    memcpy(&s390_qemu_cpu_def, def, sizeof(s390_qemu_cpu_def));
>> +    bitmap_or(s390_qemu_cpu_def.full_feat, s390_qemu_cpu_def.full_feat,
>> +              qemu_max_cpu_feat, S390_FEAT_MAX);
>> +
> 
> So is this the place to e.g. enable zpci? Or does this need to go into
> the feature definitions?

It will go into target/s390x/gen-features.c under:

1. "qemu_V2_12" if you want it to always be active with "-cpu qemu"
2. "qemu_MAX" if you only want to be able to enable it via "-cpu
qemu,zpci=on"

Thanks!

-- 

Thanks,

David / dhildenb
