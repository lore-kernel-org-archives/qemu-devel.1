Received: from eggs.gnu.org ([2001:4830:134:3::10]:55020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRcp1-0001BJ-QY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRcoy-00006x-Gx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:50:35 -0500
References: <20181127114102.4319-1-david@redhat.com>
	<a632f840-f738-fd79-9f2d-5b51852c4726@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6aabbad7-885a-0ed9-15d9-fbfd89148e94@redhat.com>
Date: Tue, 27 Nov 2018 13:50:29 +0100
MIME-Version: 1.0
In-Reply-To: <a632f840-f738-fd79-9f2d-5b51852c4726@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tod: properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 27.11.18 13:19, Thomas Huth wrote:
> On 2018-11-27 12:41, David Hildenbrand wrote:
>> Just like on other architectures, we should stop the clock while the guest
>> is not running. This is already properly done for TCG. Right now, doing an
>> offline migration (stop, migrate, cont) can easily trigger stalls in the
>> guest.
>>
>> Even doing a
>>     (hmp) stop
>>     ... wait 2 minutes ...
>>     (hmp) cont
>> will already trigger stalls.
>>
>> So whenever the guest stops, backup the KVM TOD. When continuning to run
>> the guest, restore the KVM TOD.
>>
>> One special case is starting a simple VM: Reading the TOD from KVM to
>> stop it right away until the guest is actually started means that the
>> time of any simple VM will already differ to the host time. We can
>> simply leave the TOD running and the guest won't be able to recognize
>> it.
>>
>> For migration, we actually want to keep the TOD stopped until really
>> starting the guest. To be able to catch most errors, we should however
>> try to set the TOD in addition to simply storing it. So we can still
>> catch basic migration problems.
>>
>> If anything goes wrong while backing up/restoring the TOD, we have to
>> ignore it (but print a warning). This is then basically a fallback to
>> old behavior (TOD remains running).
>>
>> I tested this very basically with an initrd:
>>     1. Start a simple VM. Observed that the TOD is kept running. Old
>>        behavior.
>>     2. Ordinary live migration. Observed that the TOD is temporarily
>>        stopped on the destination when setting the new value and
>>        correctly started when finally starting the guest.
>>     3. Offline live migration. (stop, migrate, cont). Observed that the
>>        TOD will be stopped on the source with the "stop" command. On the
>>        destination, the TOD is temporarily stopped when setting the new
>>        value and correctly started when finally starting the guest via
>>        "cont".
>>     4. Simple stop/cont correctly stops/starts the TOD. (multiple stops
>>        or conts in a row have no effect, so works as expected)
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/tod-kvm.c     | 88 +++++++++++++++++++++++++++++++++++++++++-
>>  include/hw/s390x/tod.h |  7 +++-
>>  2 files changed, 92 insertions(+), 3 deletions(-)
> [...]
>> @@ -49,10 +112,31 @@ static void kvm_s390_tod_class_init(ObjectClass *oc, void *data)
>>      tdc->set = kvm_s390_tod_set;
>>  }
>>  
>> +static void kvm_s390_tod_init(Object *obj)
>> +{
>> +    S390TODState *td = S390_TOD(obj);
>> +
>> +    /*
>> +     * The TOD is initially running (value stored in KVM). Avoid needless
>> +     * loading/storing of the TOD when starting a simple VM, so let it
>> +     * run although the (never started) VM is stopped. For migration, we
>> +     * will properly set the TOD later.
>> +     */
>> +    td->stopped = false;
>> +
>> +    /*
>> +     * We need to know when the VM gets started/stopped to start/stop the TOD.
>> +     * As we can never have more than one TOD instance (and that will never be
>> +     * removed), registering here and never unregistering is good enough.
>> +     */
>> +    qemu_add_vm_change_state_handler(kvm_s390_tod_vm_state_change, td);
> 
> I think you should rather do this in a realize() function instead, since
> instance_init can be called multiple times (during introspection of the
> object, for example). See my blog article here for some details:
> 
> https://people.redhat.com/~thuth/blog/qemu/2018/09/10/instance-init-realize.html


Even for types that cannot be created by the user?

Anyhow, realize is the right thing to do, I just wanted to avoid
introducing a realize callback for tod clocks.

Thanks!

> 
>> +}
>> +
>>  static TypeInfo kvm_s390_tod_info = {
>>      .name = TYPE_KVM_S390_TOD,
>>      .parent = TYPE_S390_TOD,
>>      .instance_size = sizeof(S390TODState),
>> +    .instance_init = kvm_s390_tod_init,
>>      .class_init = kvm_s390_tod_class_init,
>>      .class_size = sizeof(S390TODClass),
>>  };
> 
>  Thomas
> 


-- 

Thanks,

David / dhildenb
