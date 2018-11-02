Received: from eggs.gnu.org ([2001:4830:134:3::10]:57792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIZaR-0001rI-BI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIZaP-0002mx-Er
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:34:07 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIZaP-0002mi-8f
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:34:05 -0400
Received: by mail-ot1-x343.google.com with SMTP id m15so1679708otl.7
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:34:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e2efa1f8-7ada-d5c4-9719-491d9b5f477b@redhat.com>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
	<CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
	<20181005180901.GA32677@localhost.localdomain>
	<CAFEAcA80cys-98QwJgAk_2LXfAeMHgCUS2L3Z+NgY4ZsCFhSPw@mail.gmail.com>
	<CAFEAcA8gYwFZynMyiEHf+VPbaBerA9JTUPAHsipEvOqkBjHxMQ@mail.gmail.com>
	<20181008164026.GD4604@localhost.localdomain>
	<e2efa1f8-7ada-d5c4-9719-491d9b5f477b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 13:33:43 +0000
Message-ID: <CAFEAcA8eB8zZnS1G1FHWo=ix4uoO_-NCh3qfkkNLtyMDpTOPsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 9 October 2018 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 08/10/2018 18:40, Kevin Wolf wrote:
>>>
>>> I'm pretty confident this analysis of the problem is correct:
>>> unfortunately I have no idea what the right way to fix it is...
>> Yes, I agree with your analysis. If __thread variables can be destructed
>> before pthread_key_create() destructors are called (and in particular if
>> the former are implemented in terms of the latter), this implies at
>> least two rules:
>>
>> 1. The Notfier itself can't be a TLS variable
>>
>> 2. The notifier callback can't access any TLS variables
>>
>> Of course, with these restrictions, qemu_thread_atexit_*() with its
>> existing API is as useless as it could be.
>
> Yup, we have to stop using pthread_key_create.  Luckily, these days
> there is always qemu_thread_start that wraps the thread, so we can call
> qemu_thread_atexit_run from there, and change exit_key to a thread-local
> NotifierList.

We would also need to catch exits via qemu_thread_exit(), right?
We probably also need to handle the main thread specially, via
atexit(). This seems to be pretty much what we already do in
util/qemu-thread-win32.c...

thanks
-- PMM
