Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxJmU-0002qI-7s
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 18:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxJmT-0007hC-8F
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 18:26:42 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:45946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxJmS-0007fj-Vl
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 18:26:41 -0400
Received: by mail-yw1-xc42.google.com with SMTP id p206-v6so1885535ywg.12
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 15:26:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8M9+sZQehFQSUrrZYZ4e=CH6aDc890FfRwbMdQfUmEKA@mail.gmail.com>
References: <20180904210036.7317-1-jcmvbkbc@gmail.com>
	<CAFEAcA-AyrFVYWkM+_aBQ8eXH-03UZfgiHrB37v=-iM+A=70DA@mail.gmail.com>
	<CAMo8Bf+3gws2Sa24xMfVsAQ_PaZVqKPbpqpySAAHrdkvnF-erw@mail.gmail.com>
	<CAFEAcA8M9+sZQehFQSUrrZYZ4e=CH6aDc890FfRwbMdQfUmEKA@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 4 Sep 2018 15:26:39 -0700
Message-ID: <CAMo8Bf+bV9wAX_ctyy2pftLnyb+_7ukiVkD5sEENX94=nQmMfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: do setrlimit selectively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Tue, Sep 4, 2018 at 3:10 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 4 September 2018 at 23:02, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> On Tue, Sep 4, 2018 at 2:13 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> I think the issue here is not related to 32-on-64 but to the fact
>>> that we just pass through the memory rlimits. What we should ideally
>>> be doing is tracking the actual guest memory allocations sufficiently
>>> that we can then apply the rlimits at the QEMU level, so that guest
>>> allocations that breach limits can be failed, without ever causing
>>> QEMU's own alloactions to fail.
>>
>> In a sense we do it by limiting 32-bit guest to 32 or less bits of the address
>> space, that's why it should be rather safe to just ignore setrlimit calls in
>> 32-on-64 case.
>
> I'm not sure why you think that we should treat 32-on-64 differently.

I'm not sure, it's just that I have a case that I'd like to fix, and
it's 32-on 64.

> You could make a case for always ignoring setrlimit calls: if we
> ever hit the limit it's as likely to be by failing a QEMU internal
> allocation as a guest one, so not to imposing the limit at all
> would avoid QEMU failing then. But that would apply in both the
> 32-on-64 and also 32-on-32 and 64-on-64 cases too.

That's what I did initially, but it feels somewhat unsafe in 64-on-64 case.
My expectation is that limits set by 64-bit guest should be somewhat
suitable for the 64-bit host, is it wrong?

-- 
Thanks.
-- Max
