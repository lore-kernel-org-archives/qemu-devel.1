Received: from eggs.gnu.org ([2001:4830:134:3::10]:57263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxLMd-0002B8-9n
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxLMb-0005E1-Sa
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:08:07 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:36747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxLMa-0005Cn-Jw
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:08:05 -0400
Received: by mail-yw1-xc41.google.com with SMTP id w202-v6so1977231yww.3
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 17:08:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9LtXdP7MYEf4X3SkJjnpQaSDRNaFh3rYVcWeaUgKBoew@mail.gmail.com>
References: <20180904210036.7317-1-jcmvbkbc@gmail.com>
	<CAFEAcA-AyrFVYWkM+_aBQ8eXH-03UZfgiHrB37v=-iM+A=70DA@mail.gmail.com>
	<CAMo8Bf+3gws2Sa24xMfVsAQ_PaZVqKPbpqpySAAHrdkvnF-erw@mail.gmail.com>
	<CAFEAcA8M9+sZQehFQSUrrZYZ4e=CH6aDc890FfRwbMdQfUmEKA@mail.gmail.com>
	<CAMo8Bf+bV9wAX_ctyy2pftLnyb+_7ukiVkD5sEENX94=nQmMfw@mail.gmail.com>
	<CAFEAcA9LtXdP7MYEf4X3SkJjnpQaSDRNaFh3rYVcWeaUgKBoew@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 4 Sep 2018 17:08:03 -0700
Message-ID: <CAMo8BfL3J-oFqHds3=0nya-Cke1FstXWpkZosvBJsvZmHJc4bw@mail.gmail.com>
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

On Tue, Sep 4, 2018 at 3:55 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 4 September 2018 at 23:26, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> On Tue, Sep 4, 2018 at 3:10 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 4 September 2018 at 23:02, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
>>> You could make a case for always ignoring setrlimit calls: if we
>>> ever hit the limit it's as likely to be by failing a QEMU internal
>>> allocation as a guest one, so not to imposing the limit at all
>>> would avoid QEMU failing then. But that would apply in both the
>>> 32-on-64 and also 32-on-32 and 64-on-64 cases too.
>>
>> That's what I did initially, but it feels somewhat unsafe in 64-on-64 case.
>> My expectation is that limits set by 64-bit guest should be somewhat
>> suitable for the 64-bit host, is it wrong?
>
> It doesn't matter what the limit the guest sets is -- the
> problem is that if we hit it then chances are good it'll cause
> a QEMU allocation to fail and then we'll deadlock. The limit
> might be entirely reasonable for the guest program (which
> presumably has a plan for handling the failure) but QEMU
> itself can't cope with hitting the limit.

Ok, the deadlock (and other weird behavior) is a separate problem:
QEMU doesn't check results of resource allocation functions and
then gets surprised. Errors must be handled and QEMU must be
terminated properly.

As to hitting the limit, I don't see anything wrong with it as long as
the limits are relevant. What I've seen so far is application calling
setrlimit to catch its own bugs and limit bug impact on the rest of
the system. 64-on-64 would probably set up a relevant limit,
32-on-64 -- unlikely.

> https://bugs.launchpad.net/qemu/+bug/1163034 is the bug I
> mentioned in my earlier email, by the way.

It looks like the proposed patch would fix the issue if it were
32-on-64 case without making it worse for the 64-on-64 case?

-- 
Thanks.
-- Max
