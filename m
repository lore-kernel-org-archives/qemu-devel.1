Received: from eggs.gnu.org ([2001:4830:134:3::10]:55092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRcpJ-0001Pl-1v
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRcpG-0000Ir-Qh
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:50:52 -0500
References: <20181127114102.4319-1-david@redhat.com>
	<20181127133819.52621d1c.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5e05f435-cdc0-4eff-c61e-abb7fa097eb6@redhat.com>
Date: Tue, 27 Nov 2018 13:50:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181127133819.52621d1c.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On 27.11.18 13:38, Cornelia Huck wrote:
> On Tue, 27 Nov 2018 12:41:02 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
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
>>
>> diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
>> index df564ab89c..d4b12e1145 100644
>> --- a/hw/s390x/tod-kvm.c
>> +++ b/hw/s390x/tod-kvm.c
> 
>> @@ -38,6 +49,58 @@ static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
>>      if (r) {
>>          error_setg(errp, "Unable to set KVM guest TOD clock: %s",
>>                     strerror(-r));
>> +        return;
> 
> I don't think you need this new 'return'.

Yes, very right!

Thanks!


-- 

Thanks,

David / dhildenb
