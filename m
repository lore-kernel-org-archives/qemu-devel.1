Received: from eggs.gnu.org ([209.51.188.92]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzPTH-0000xE-4Z
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzPHq-0003Fj-20
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:15:59 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-15-david@redhat.com>
	<c57c068f-1c42-9cba-0f0f-3204f6648d8d@linaro.org>
	<f11109de-6ba3-5104-71b6-1245c42b282e@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <864f3ba7-3115-c6f8-e018-15425ca67a72@twiddle.net>
Date: Thu, 28 Feb 2019 09:15:52 -0800
MIME-Version: 1.0
In-Reply-To: <f11109de-6ba3-5104-71b6-1245c42b282e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 14/33] s390x/tcg: Implement VECTOR LOAD
 MULTIPLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 2/28/19 12:36 AM, David Hildenbrand wrote:
> On 27.02.19 17:02, Richard Henderson wrote:
>> On 2/26/19 3:38 AM, David Hildenbrand wrote:
>>> Also fairly easy to implement. One issue we have is that exceptions will
>>> result in some vectors already being modified. At least handle it
>>> consistently per vector by using a temporary vector. Good enough for
>>> now, add a FIXME.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/insn-data.def      |  2 ++
>>>  target/s390x/translate_vx.inc.c | 26 ++++++++++++++++++++++++++
>>>  2 files changed, 28 insertions(+)
>>
>> I suppose the fixme is good enough.  For the record, I think you could do the
>> check with just two loads -- the first and last quadword.  After that, none of
>> the other loads can fault, and you can store everything else into the
>> destination vectors as you read them.
> 
> Aren't such approaches prone to races if other VCPUs invalidate page
> tables/TLB entries?

No, because...

> (or am I messing up things and the MMU of this VCPU won't be touched
> while in this block and once we touched all applicable pages, it cannot
> fail anymore?)

Correct.

If vcpu 1 does a global invalidate, the time at which vcpu 2 acknowledges that
invalidate is somewhat fluid.  VCPU 2 will see an interrupt, exit at a TB
boundary, and then acknowledge.

VCPU 1 has to wait for the ack before it knows the operation is complete.

Thus no race within any given instruction's execution.


r~
