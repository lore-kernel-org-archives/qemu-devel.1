Received: from eggs.gnu.org ([2001:4830:134:3::10]:60599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crMvL-0001c5-9S
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crMvG-0001CQ-Lp
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:58:27 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1crMvG-0001CH-FH
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:58:22 -0400
Received: by mail-wr0-x233.google.com with SMTP id u1so6931369wra.2
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:58:22 -0700 (PDT)
References: <1472935202-3342-1-git-send-email-rth@twiddle.net>
	<1472935202-3342-14-git-send-email-rth@twiddle.net>
	<87vay1w7p8.fsf@linaro.org>
	<f851ddba-bc62-2477-dd05-3f7e9d364668@twiddle.net>
	<87efxn9e2f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87efxn9e2f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Fri, 24 Mar 2017 10:58:19 +0000
Message-ID: <877f3fx7p0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/34] tcg: Add atomic helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org


Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Richard Henderson <rth@twiddle.net> writes:
>
>> On 09/12/2016 06:47 AM, Alex Bennée wrote:
>>>> > +    /* Notice an IO access, or a notdirty page.  */
>>>> > +    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
>>>> > +        /* There's really nothing that can be done to
>>>> > +           support this apart from stop-the-world.  */
>>>> > +        goto stop_the_world;
>>> We are also triggering on TLB_NOTDIRTY here in the case where a
>>> conditional write is the first write to a page. I don't know if a
>>> stop_the_world is required at this point but we will need to ensure we
>>> clear bits as notdirty_mem_write() does.
>>>
>>
>> You're quite right that we could probably special-case TLB_NOTDIRTY here such
>> that (1) we needn't leave the cpu loop, and (2) needn't utilize the actual
>> "write" part of notdirty_mem_write; just set the bits then fall through to the
>> actual atomic instruction below.
>
> I do hit this case with ppc64, where I see that its the first write to
> the page and it exits from this every time, causing the kernel to print
> soft-lockups.
>
> Can we add the special case here for NOTDIRTY and set the page as dirty
> and return successfully?

Does the atomic step fall-back not work for you?

--
Alex Bennée
