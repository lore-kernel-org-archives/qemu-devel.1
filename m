Received: from eggs.gnu.org ([2001:4830:134:3::10]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0Nje-0007lu-28
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f0Nja-0002Su-VB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:44:10 -0400
From: David Hildenbrand <david@redhat.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
Message-ID: <f9001269-f4bd-6d9a-0ec3-aeeb44146e3a@redhat.com>
Date: Mon, 26 Mar 2018 10:43:49 +0200
MIME-Version: 1.0
In-Reply-To: <4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 6/7] s390x/kvm: handle AP
 instruction interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, berrange@redhat.com, eskultet@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 26.03.2018 10:32, David Hildenbrand wrote:
> On 16.03.2018 00:24, Tony Krowiak wrote:
>> If the CPU model indicates that AP facility is installed on
>> the guest (i.e., -cpu xxxx,ap=on), then the expectation is that
>> the AP bus running in the guest will initialize; however, if the
>> AP instructions are not being interpreted by the firmware, then
>> they will be intercepted and routed back to QEMU for handling.
>> If a handler is not defined to process the intercepted instruciton,
>> then an operation exception will be injected into the
>> guest, in which case the AP bus will not initialize.
>>
>> There are two situations where AP instructions will not be
>> interpreted:
>>
>> 1. The guest is not configured with a vfio-ap device (i.e.,
>>    -device vfio-ap,sysfsdev=$path-to-mdev). The realize function for
>>    the vfio-ap device enables interpretive execution of AP
>>    instructions.
>>
>> 2. The guest is a second level guest but the first level guest has
>>    not enabled interpretive execution.
>>
>> This patch introduces AP instruction handlers to ensure the AP bus
>> module initializes on the guest when the AP facility is installed
>> on the guest but AP instructions are not being interpreted. The logic
>> incorporated is:
>>
>> * If the CPU model indicates AP instructions are
>>   installed
>>
>>   * Set the status response code for the instruction to indicate that
>>     the APQN contained in the instruction is not valid. This is
>>     a valid response because there will be no devices configured for
>>     the guest in any of the above scenarios.
>>
>> * Else return an error from the handler. This will result in an
>>   operation being injected into the guest and the AP bus will not
> 
> s/operation/operation exception/
> 
>>   initialize on the guest. That is commensurate with how things work
>>   today.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>  hw/vfio/ap.c                 |   45 ++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/s390x/ap-device.h |    6 +++++
>>  target/s390x/kvm.c           |   14 +++++++++++++
>>  3 files changed, 65 insertions(+), 0 deletions(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index b397bb1..88e744d 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -148,6 +148,51 @@ static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>>      kvm_s390_set_interpret_ap(0);
>>  }
>>  
> 
> I think you are missing cpu_synchronize_state(CPU(cpu)) in all of these
> functions.
> 

No you don't. There is just a duplicate cpu_synchronize_state(CPU(cpu))
in kvm_sclp_service_call() which confused me.


-- 

Thanks,

David / dhildenb
