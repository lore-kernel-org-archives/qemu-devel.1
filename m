Received: from eggs.gnu.org ([209.51.188.92]:59619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <metzman@google.com>) id 1gi2C8-000264-AU
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <metzman@google.com>) id 1gi2C6-00046F-0G
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:10:16 -0500
Received: from mail-yw1-xc32.google.com ([2607:f8b0:4864:20::c32]:33886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <metzman@google.com>) id 1gi2C5-00044Z-OB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:10:13 -0500
Received: by mail-yw1-xc32.google.com with SMTP id g75so6232909ywb.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 11:10:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
	<CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
	<8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
	<CABiizERPJa06YNEyUxEAgDaSgjJny4bTa4qpTDCwKzKMn5Ji=Q@mail.gmail.com>
	<0387b8e9-2b4f-ce1a-05df-b508851b84f0@redhat.com>
In-Reply-To: <0387b8e9-2b4f-ce1a-05df-b508851b84f0@redhat.com>
From: Jonathan Metzman <metzman@google.com>
Date: Fri, 11 Jan 2019 11:09:43 -0800
Message-ID: <CAMAxoC1m2g3AB6X5u=+L+K1avq36gSHeBRv-nDXobAJNc2d3qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Max Moroz <mmoroz@google.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

Could you clarify what you think the relationship between the qtest
process, QEMU, and afl-fuzz will look like when fuzzing?

Is it something like this:
1. afl-fuzz mutates a buffer, starts a qtest process, and gives the qtest
process the mutated buffer.
2. The qtest process starts a QEMU process and interacts with QEMU process
based on the buffer AFL gave it (qtest).
3. goto 1

I don't think this works (under normal circumstances). AFL will think it is
fuzzing qtest and will not learn about coverage or crashes from qsym.
There probably are ways to get this working, but I just want to make sure I
understand.

Thanks,
Jonathan

On Fri, Jan 11, 2019 at 8:16 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/01/19 16:41, Max Moroz wrote:
> >
> >
> > On Fri, Jan 11, 2019 at 7:34 AM Paolo Bonzini <pbonzini@redhat.com
> > <mailto:pbonzini@redhat.com>> wrote:
> >
> >     On 11/01/19 16:04, Max Moroz wrote:
> >     > We usually have a single fuzzing process, it starts with a fuzzing
> >     > engine's main function and is calling LLVMFuzzerTestOneInput with
> >     > various inputs and keep mutating them based on the coverage
> feedback.
> >     > Running a second process which you don't care too much about might
> be
> >     > fine, but the fuzzing process should be "replacing" or should I say
> >     > "imitating" the process whose coverage you're interested in.
> >
> >     What do you mean by replacing or imitating?
> >
> > To give you an example, when we fuzz ffmpeg, we do not run ffmpeg's main
> > function. We write LLVMFuzzerTestOneInput that would do the necessary
> > initialization, reset the state, etc, and then would pass (data, size)
> > provided by a fuzzing engine to the API(s) we're trying to fuzz. So, in
> > your case, there should not be a regular QEMU process, and instead the
> > fuzz target (i.e. LLVMFuzzerTestOneInput) should be doing certain
> > initialization (which is usually done by the QEMU process) and then call
> > the API you want to fuzz.
>
> The main issue is that we are not really testing an API and QEMU has a
> lot of global state.

Of course there are C functions to do the
> elementary I/O operations, but there are two problems.  The first and
> smaller is that one input would correspond to a sequence of invocations
> of the functions, not just one function invocation; the larger, is that
> the knowledge of the guest (memory map, placement of devices, etc.) is
> not easy to consume from within QEMU.  We do have a library that
> includes that knowledge, and it would be easy to use it from a mutator
> or input postprocessor, but I'm afraid that it would be very very
> intrusive to embed that library into QEMU, replacing all of main() etc.
>
> The simplest way would be to test the input by fork()-ing QEMU, followed
> by waitpid() in the parent and invoking the original main() in the
> child.  But that wouldn't buy much and would probably even be slower
> than an efficient deferred fork server.
>
> Paolo
>
> >
> >
> >
> >     Avoiding fork would probably be hard.  I'm mostly afraid that some
> state
> >     guest state is not resetted properly across runs, and this would
> result
> >     in non-reproducible crashes.
> >
> >     It seems to me that the task can be approached with AFL and a test
> case
> >     postprocessor to generate the qtest input; however, my knowledge of
> >     libFuzzer is very very limited.
> >
> >     Paolo
> >
>
>
