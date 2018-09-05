Received: from eggs.gnu.org ([2001:4830:134:3::10]:55725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxMo5-00020d-E0
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxMo4-0001Z2-85
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:40:33 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxMo3-0001Xc-SP
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:40:32 -0400
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so10536796oie.13
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:40:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMo8BfL3J-oFqHds3=0nya-Cke1FstXWpkZosvBJsvZmHJc4bw@mail.gmail.com>
References: <20180904210036.7317-1-jcmvbkbc@gmail.com>
	<CAFEAcA-AyrFVYWkM+_aBQ8eXH-03UZfgiHrB37v=-iM+A=70DA@mail.gmail.com>
	<CAMo8Bf+3gws2Sa24xMfVsAQ_PaZVqKPbpqpySAAHrdkvnF-erw@mail.gmail.com>
	<CAFEAcA8M9+sZQehFQSUrrZYZ4e=CH6aDc890FfRwbMdQfUmEKA@mail.gmail.com>
	<CAMo8Bf+bV9wAX_ctyy2pftLnyb+_7ukiVkD5sEENX94=nQmMfw@mail.gmail.com>
	<CAFEAcA9LtXdP7MYEf4X3SkJjnpQaSDRNaFh3rYVcWeaUgKBoew@mail.gmail.com>
	<CAMo8BfL3J-oFqHds3=0nya-Cke1FstXWpkZosvBJsvZmHJc4bw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Sep 2018 02:40:10 +0100
Message-ID: <CAFEAcA_M2L8y0pc+LsudV0Ec-EzD5S-_E-jZE7QuXof+af3KTQ@mail.gmail.com>
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
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 5 September 2018 at 01:08, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Ok, the deadlock (and other weird behavior) is a separate problem:
> QEMU doesn't check results of resource allocation functions and
> then gets surprised. Errors must be handled and QEMU must be
> terminated properly.
>
> As to hitting the limit, I don't see anything wrong with it as long as
> the limits are relevant.

The limit is relevant *to the guest process*. It's not relevant
to QEMU's own allocations. If you're running directly under
the host kernel and you set a memory rlimit, it doesn't mean
that the kernel suddenly starts failing its own internal
allocations.

It would obviously be better if we fixed the problems of
allocations failing causing non-obvious problems (if nothing
else it would make debugging of things which triggered QEMU
asserts easier). But the guest should not be able to cause
QEMU's internal allocations to fail by setting the rlimit.

> What I've seen so far is application calling
> setrlimit to catch its own bugs and limit bug impact on the rest of
> the system. 64-on-64 would probably set up a relevant limit,
> 32-on-64 -- unlikely.

>> https://bugs.launchpad.net/qemu/+bug/1163034 is the bug I
>> mentioned in my earlier email, by the way.
>
> It looks like the proposed patch would fix the issue if it were
> 32-on-64 case without making it worse for the 64-on-64 case?

I still think 32-on-64 is a red herring here. If ignoring
client attempts to set the memory rlimits makes sense on
32-on-64 it makes sense for all configurations.

thanks
-- PMM
