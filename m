Received: from eggs.gnu.org ([2001:4830:134:3::10]:59034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eKoMY-00086z-54
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eKoMM-0006IC-TK
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:40:30 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-3-david@redhat.com>
	<09ea70d8-4110-461a-fd9d-5e4220a5e7cb@redhat.com>
	<2e634659-9c04-cb2b-1fff-2255646f6fe2@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <de6f038e-f6ed-dee1-df00-d0ba909e7b87@twiddle.net>
Date: Fri, 1 Dec 2017 12:48:14 +0000
MIME-Version: 1.0
In-Reply-To: <2e634659-9c04-cb2b-1fff-2255646f6fe2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 for-2.12 02/16] s390x/tcg:
 get rid of runtime_exception()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 11/30/2017 03:56 PM, David Hildenbrand wrote:
> On 30.11.2017 10:10, Thomas Huth wrote:
>> On 29.11.2017 21:26, David Hildenbrand wrote:
>>> Let's use s390_program_interrupt() instead.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/fpu_helper.c  |  2 +-
>>>  target/s390x/int_helper.c  | 14 +++++++-------
>>>  target/s390x/internal.h    |  2 --
>>>  target/s390x/misc_helper.c | 16 ----------------
>>>  4 files changed, 8 insertions(+), 26 deletions(-)
>>
>> Is it a disadvantage that runtime_exception() was declared as
>> QEMU_NORETURN, and s390_program_interrupt() is not declared as
>> QEMU_NORETURN?
> 
> We could add that to trigger_pgm_exception instead. But if
> cpu_loop_exit() would really return, we would be in more trouble AKA
> nothing would work.

s390_program_interrupt and trigger_pgm_exception do return (kvm).

We could export tcg_s390_program_interrupt as NORETURN, and use it directly in
places that are tcg-only.  That might provide some minor advantages to the
compiler, but I don't think it's critical.


r~
