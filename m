Received: from eggs.gnu.org ([2001:4830:134:3::10]:37272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOnXz-0003ae-ME
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOnXx-0000J5-6O
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:36:47 -0500
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-7-david@redhat.com>
	<20171212144944.09860296.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <90e6ad8c-3ff9-7cbf-c740-5d2f512f4d17@redhat.com>
Date: Tue, 12 Dec 2017 17:36:40 +0100
MIME-Version: 1.0
In-Reply-To: <20171212144944.09860296.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 06/15] s390x/flic: factor out
 injection of floating interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On 12.12.2017 14:49, Cornelia Huck wrote:
> On Mon, 11 Dec 2017 14:47:31 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let the flic device handle it internally. This will allow us to later
>> on store floating interrupts in the flic for the TCG case.
>>
>> This now also simplifies kvm.c. All that's left is the fallback
>> interface for floating interrupts, which is no triggered directly via
> 
> s/no/now/
> 
>> the flic in case anything goes wrong.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/intc/s390_flic.c          | 31 ++++++++++++++++++++
>>  hw/intc/s390_flic_kvm.c      | 63 ++++++++++++++++++++++++++++++++++++----
>>  include/hw/s390x/s390_flic.h |  5 ++++
>>  target/s390x/cpu.h           |  7 ++++-
>>  target/s390x/interrupt.c     | 42 +++++++++++----------------
>>  target/s390x/kvm-stub.c      | 13 ---------
>>  target/s390x/kvm.c           | 68 ++++----------------------------------------
>>  target/s390x/kvm_s390x.h     | 10 +------
>>  8 files changed, 123 insertions(+), 116 deletions(-)
>>
>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>> index a78bdf1d90..8d521c415a 100644
>> --- a/hw/intc/s390_flic.c
>> +++ b/hw/intc/s390_flic.c
>> @@ -131,6 +131,34 @@ static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
>>      return 0;
>>  }
>>  
>> +static void qemu_s390_inject_service(S390FLICState *fs, uint32_t parm)
>> +{
>> +
>> +    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
>> +
>> +    /* FIXME: don't inject into dummy CPU */
>> +    cpu_inject_service(dummy_cpu, parm);
>> +}
>> +
>> +static void qemu_s390_inject_io(S390FLICState *fs, uint16_t subchannel_id,
>> +                                uint16_t subchannel_nr, uint32_t io_int_parm,
>> +                                uint32_t io_int_word)
>> +{
>> +    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
>> +
>> +    /* FIXME: don't inject into dummy CPU */
>> +    cpu_inject_io(dummy_cpu, subchannel_id, subchannel_nr, io_int_parm,
>> +                  io_int_word);
>> +}
>> +
>> +static void qemu_s390_inject_crw_mchk(S390FLICState *fs)
>> +{
>> +    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
>> +
>> +    /* FIXME: don't inject into dummy CPU */
>> +    cpu_inject_crw_mchk(dummy_cpu);
>> +}
>> +
>>  static void qemu_s390_flic_reset(DeviceState *dev)
>>  {
>>      QEMUS390FLICState *flic = QEMU_S390_FLIC(dev);
>> @@ -172,6 +200,9 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
>>      fsc->clear_io_irq = qemu_s390_clear_io_flic;
>>      fsc->modify_ais_mode = qemu_s390_modify_ais_mode;
>>      fsc->inject_airq = qemu_s390_inject_airq;
>> +    fsc->inject_service = qemu_s390_inject_service;
>> +    fsc->inject_io = qemu_s390_inject_io;
>> +    fsc->inject_crw_mchk = qemu_s390_inject_crw_mchk;
>>  }
> 
> As you now have a callback for ->inject_io(), make
> qemu_s390_inject_airq() invoke it directly instead of going the detour
> through s390_io_interrupt()?

Indeed, that makes sense.


-- 

Thanks,

David / dhildenb
