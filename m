Received: from eggs.gnu.org ([2001:4830:134:3::10]:36675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPf1J-0001j3-Gb
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPf1G-0003cj-BF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:10:21 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPf1G-0003cS-5e
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:10:18 -0400
Received: by mail-qk0-x242.google.com with SMTP id r62so2235396qkf.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 18:10:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924253.28532.2681638904562623104.stgit@frigg.lan>
	<ca41d7c2-b009-46b9-1f76-3e45c0f91ecf@twiddle.net>
	<877ezzapyu.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <11b802c6-253c-1aaf-75d1-1f73e23c4d64@twiddle.net>
Date: Mon, 26 Jun 2017 18:10:14 -0700
MIME-Version: 1.0
In-Reply-To: <877ezzapyu.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 2/6] queue: Add macro for incremental
 traversal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/26/2017 05:33 AM, Lluís Vilanova wrote:
> Richard Henderson writes:
> 
>> On 06/12/2017 07:54 AM, Lluís Vilanova wrote:
>>> Adds macro QTAILQ_FOREACH_CONTINUE to support incremental list
>>> traversal.
>>>
>>> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
>>> ---
>>> include/qemu/queue.h |   12 ++++++++++++
>>> 1 file changed, 12 insertions(+)
>>>
>>> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
>>> index 35292c3155..eb2bf9cb1c 100644
>>> --- a/include/qemu/queue.h
>>> +++ b/include/qemu/queue.h
>>> @@ -415,6 +415,18 @@ struct {                                                                \
>>> (var);                                                  \
>>> (var) = ((var)->field.tqe_next))
>>> +/**
>>> + * QTAILQ_FOREACH_CONTINUE:
>>> + * @var: Variable to resume iteration from.
>>> + * @field: Field in @var holding a QTAILQ_ENTRY for this queue.
>>> + *
>>> + * Resumes iteration on a queue from the element in @var.
>>> + */
>>> +#define QTAILQ_FOREACH_CONTINUE(var, field)                             \
>>> +        for ((var) = ((var)->field.tqe_next);                           \
>>> +                (var);                                                  \
>>> +                (var) = ((var)->field.tqe_next))
>>> +
>>> #define QTAILQ_FOREACH_SAFE(var, head, field, next_var)                 \
>>> for ((var) = ((head)->tqh_first);                               \
>>> (var) && ((next_var) = ((var)->field.tqe_next), 1);     \
>>>
>>>
> 
>> I still say this isn't required if the breakpoint loop is better structured.
> 
> I can embed the use of QTAILQ into translate-block.c, but I wanted to keep the
> implementation of breakpoint lists hidden behind the cpu_breakpoint API.

I think using QTAILQ in the common main loop is better than twisting the logic 
so that the loop is unnaturally split into a subroutine.


r~
