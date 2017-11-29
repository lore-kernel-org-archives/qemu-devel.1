Received: from eggs.gnu.org ([2001:4830:134:3::10]:53105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK7cP-00021V-Bb
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK7cK-0007s8-Fs
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:02:01 -0500
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-10-david@redhat.com>
	<6ab0f28c-3295-b375-d068-367be3adf587@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5ec7977f-af96-dd2a-d51e-ed8bc79d36dd@redhat.com>
Date: Wed, 29 Nov 2017 20:01:52 +0100
MIME-Version: 1.0
In-Reply-To: <6ab0f28c-3295-b375-d068-367be3adf587@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 09/15] s390x/tcg: use
 program_interrupt_ra() in SCLP Service Call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 29.11.2017 19:10, Richard Henderson wrote:
> On 11/28/2017 08:33 PM, David Hildenbrand wrote:
>>      qemu_mutex_lock_iothread();
>>      int r = sclp_service_call(env, r1, r2);
>>      if (r < 0) {
>> -        program_interrupt(env, -r, 4);
>> -        r = 0;
>> +        program_interrupt_ra(env, -r, 4, GETPC());
>>      }
>>      qemu_mutex_unlock_iothread();
>>      return r;
> 
> Incidentally, shouldn't the unlock happen before throwing the exception?
> We will unlock after a longjmp, but it does look odd to write it this way.
> 

Yes, but we have that all over the place, no? The unlock here could be
moved up.

> 
> r~
> 


-- 

Thanks,

David / dhildenb
