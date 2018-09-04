Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxJPI-0005lv-Gf
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 18:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxJPH-0004U8-Lk
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 18:02:44 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:39127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxJPH-0004Tx-GG
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 18:02:43 -0400
Received: by mail-yw1-xc43.google.com with SMTP id m62-v6so1877536ywd.6
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 15:02:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AyrFVYWkM+_aBQ8eXH-03UZfgiHrB37v=-iM+A=70DA@mail.gmail.com>
References: <20180904210036.7317-1-jcmvbkbc@gmail.com>
	<CAFEAcA-AyrFVYWkM+_aBQ8eXH-03UZfgiHrB37v=-iM+A=70DA@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 4 Sep 2018 15:02:42 -0700
Message-ID: <CAMo8Bf+3gws2Sa24xMfVsAQ_PaZVqKPbpqpySAAHrdkvnF-erw@mail.gmail.com>
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

On Tue, Sep 4, 2018 at 2:13 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 4 September 2018 at 22:00, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> When running 32-bit guest on 64-bit host setrlimit guest calls that
>> affect memory resources (RLIMIT_{AS,DATA,STACK}) don't always make sense
>> as is. They may result in QEMU lockup because mprotect call in
>> page_unprotect would fail with ENOMEM error code, causing infinite loop
>> of SIGSEGV. E.g. it happens when running libstdc++ testsuite for xtensa
>> target on x86_64 host.
>>
>> Don't call host setrlimit for memory-related resources when running
>> 32-bit guest on 64-bit host.
>
> I think the issue here is not related to 32-on-64 but to the fact
> that we just pass through the memory rlimits. What we should ideally
> be doing is tracking the actual guest memory allocations sufficiently
> that we can then apply the rlimits at the QEMU level, so that guest
> allocations that breach limits can be failed, without ever causing
> QEMU's own alloactions to fail.

In a sense we do it by limiting 32-bit guest to 32 or less bits of the address
space, that's why it should be rather safe to just ignore setrlimit calls in
32-on-64 case.

-- 
Thanks.
-- Max
