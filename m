Received: from eggs.gnu.org ([2001:4830:134:3::10]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eP7Eo-00022c-BH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eP7Ej-0003A6-E1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:38:18 -0500
References: <20171208165529.14124-1-david@redhat.com>
	<20171213132407.5227-1-david@redhat.com>
	<d10affdd-dd7a-8d0d-1a52-dce16dd766a4@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b9bfcad7-fd53-2373-2f47-8707f257ba5b@redhat.com>
Date: Wed, 13 Dec 2017 14:38:04 +0100
MIME-Version: 1.0
In-Reply-To: <d10affdd-dd7a-8d0d-1a52-dce16dd766a4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x/cpumodel: make qemu
 cpu model play with "none" machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 13.12.2017 14:34, Christian Borntraeger wrote:
> 
> 
> On 12/13/2017 02:24 PM, David Hildenbrand wrote:
>> Make sure "-cpu qemu" works with "-M none".
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> Conny, if this is okay, can you squash with the original patch?
>>
>>  hw/s390x/s390-virtio-ccw.c  | 4 ----
>>  target/s390x/cpu_models.c   | 7 +++++--
>>  target/s390x/gen-features.c | 4 ++--
>>  3 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index c1f96418fa..466e45343c 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -725,10 +725,6 @@ bool css_migration_enabled(void)
>>
>>  static void ccw_machine_2_12_instance_options(MachineState *machine)
>>  {
>> -    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_12 };
>> -
>> -    /* with 2.12 we emulated a stripped down zEC12 (GA 2) */
>> -    s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
>>  }
> 
> So what happens now when you specify a 2.10 machine? 

the 2.11 handler is called, initializing it to a z900.

$ qemu-system-s390x -nographic -machine s390-ccw-virtio-2.10 -hda
guest-tcg.qcow2
LOADPARM=[........]
Using virtio-blk.
Using SCSI scheme.
.....
The Linux kernel requires more recent processor hardware
Detected machine-type number: 2064
Missing facilities: 18,21,25,27,32,33,34,35,45,49,52
See Principles of Operations for facility bits

$ qemu-system-s390x -nographic -machine s390-ccw-virtio-2.12 -hda
guest-tcg.qcow2
LOADPARM=[........]
Using virtio-blk.
Using SCSI scheme.
.....
[    0.325571] Linux version 4.13.9-300.fc27.s390x ...

-- 

Thanks,

David / dhildenb
