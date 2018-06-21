Received: from eggs.gnu.org ([2001:4830:134:3::10]:49420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW02s-000719-Ao
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW02p-0007tW-9x
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:54:42 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-5-david@redhat.com>
	<8f537d31-91df-99cc-624b-82434dc084ee@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a0f58d3e-7c79-f6be-782d-92cd5bbf7868@redhat.com>
Date: Thu, 21 Jun 2018 15:54:36 +0200
MIME-Version: 1.0
In-Reply-To: <8f537d31-91df-99cc-624b-82434dc084ee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/tcg: SET CLOCK COMPARATOR can
 clear CKC interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 21.06.2018 14:09, Thomas Huth wrote:
> On 20.06.2018 12:08, David Hildenbrand wrote:
>> Let's stop the timer and delete any pending CKC IRQ before doing
>> anything else.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/misc_helper.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index 6ccbe1fe9a..d5f9f5e1d3 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -158,6 +158,12 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
>>      Error *err = NULL;
>>      S390TOD tod_base;
>>  
>> +    /* stop the timer and remove pending CKC IRQs */
>> +    timer_del(env->tod_timer);
>> +    qemu_mutex_lock_iothread();
>> +    env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
>> +    qemu_mutex_unlock_iothread();
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
>>      if (time == -1ULL) {
> 
> I wonder whether that check is still adequate? Is there really a way to
> disable the clock comparator like this? At least I haven't seen it in
> the PoP.

e.g. 4-61 (Control)

4. When the clock-comparator sign control is zero,
(a) the program can set the clock comparator to
all zeros to ensure that an interruption condition
is immediately present, and (b) the program can
set the clock comparator to a value of all binary
ones to ensure that a clock-comparator interrup-
tion is never recognized. [...]

Rational from 4-59 (Control):

The clock comparator provides a means of causing
an interruption when the TOD-clock value exceeds a
value specified by the program.

We can never exceed all binary 1s. So it is really exceeding, not "hitting"


> 
>>          return;
>>      }
>>
> 


-- 

Thanks,

David / dhildenb
