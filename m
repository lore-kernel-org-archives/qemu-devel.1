Received: from eggs.gnu.org ([2001:4830:134:3::10]:38197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccAO4-0008Bb-V1
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccAO1-0003Bx-Sa
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:33:17 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccAO1-0003BU-LQ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:33:13 -0500
Received: by mail-wm0-x233.google.com with SMTP id c85so258822838wmi.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 04:33:13 -0800 (PST)
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<871sv6xmzk.fsf@linaro.org>
	<0ec07664-fa06-8f09-33ce-ca15448c7851@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <0ec07664-fa06-8f09-33ce-ca15448c7851@redhat.com>
Date: Fri, 10 Feb 2017 12:33:24 +0000
Message-ID: <87y3xew7hn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/02/2017 13:13, Alex Bennée wrote:
>>> +        if (atomic_read(&other_cpu->running) &&
>>> !qemu_cpu_is_self(other_cpu)) {
>> The comment above reads:
>>
>>   Must only be called from outside cpu_exec.
>>
>> So we need to revise this comment. Is this really a limitation or was it
>> originally the design goal?
>
> If you want to call it within cpu_exec, you can always use
> cpu_exec_end/start around it.
>
> I think we should first of all get rid of the iothread lock within
> cpu_exec, and then look at this patch again.

What to do with the MTTCG series in the meantime?

I'm hesitant to hold up the whole series for a potentially messy
re-factor of the cpu loop code to push out the BQL which could take some
time, although of course I don't want to merge something that makes that
harder.

That said for TCG system emulation EXCP_ATOMIC is currently broken with
respect to debugging. However for the initial guests/host combination of
ARMv7/8 on x86_64 we don't need the fallback with pretty much 99% of
deployed hosts. How about the following:

  - drop Pranith's patch for the current MTTCG series
  - replace with an error/abort on EXCP_ATOMIC
  - proceed with merge as plan
  - tackle the BQL lock next (along with more MTTCG guest/targets enablement)

Richard/Peter,

Any thoughts/opinions on this?

--
Alex Bennée
