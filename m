Received: from eggs.gnu.org ([2001:4830:134:3::10]:51442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXTpI-0001XO-MI
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXTpE-0002R4-PT
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:54:48 -0400
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-3-david@redhat.com>
	<20180625175029.69643252.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1dd2ef76-311a-64f0-4c2c-2f80738ff8a7@redhat.com>
Date: Mon, 25 Jun 2018 17:54:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180625175029.69643252.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/9] s390x/kvm: pass values instead of
 pointers to kvm_s390_set_clock_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On 25.06.2018 17:50, Cornelia Huck wrote:
> On Mon, 25 Jun 2018 13:53:45 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> We are going to factor out the TOD into a separate device and use const
>> pointers for device class functions where possible. We are passing right
>> now ordinary pointers that should never be touched when setting the TOD.
>> Let's just pass the values directly.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu.c       |  4 ++--
>>  target/s390x/kvm-stub.c  |  4 ++--
>>  target/s390x/kvm.c       | 12 ++++++------
>>  target/s390x/kvm_s390x.h |  4 ++--
>>  4 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index c268065887..68512e3e54 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -413,9 +413,9 @@ int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
> 
> Any reason why you keep the pointers here?
> 
>>      int r = 0;
>>  
>>      if (kvm_enabled()) {
>> -        r = kvm_s390_set_clock_ext(tod_high, tod_low);
>> +        r = kvm_s390_set_clock_ext(*tod_high, *tod_low);
>>          if (r == -ENXIO) {
>> -            return kvm_s390_set_clock(tod_high, tod_low);
>> +            return kvm_s390_set_clock(*tod_high, *tod_low);
> 
> Especially as it would be more clean to check for !NULL before
> dereferencing...

See the next patch :)

(I assume that refactoring code in order to rip it out does not make sense)

> 
>>          }
>>      }
>>      /* Fixme TCG */


-- 

Thanks,

David / dhildenb
