Received: from eggs.gnu.org ([209.51.188.92]:39700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmoroz@google.com>) id 1ghywd-00050i-62
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmoroz@google.com>) id 1ghywa-0006U3-UH
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:42:03 -0500
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mmoroz@google.com>) id 1ghywa-0006Tb-6Y
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:42:00 -0500
Received: by mail-it1-x12d.google.com with SMTP id p197so3440978itp.0
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:42:00 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
	<CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
	<8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
In-Reply-To: <8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
From: Max Moroz <mmoroz@google.com>
Date: Fri, 11 Jan 2019 07:41:22 -0800
Message-ID: <CABiizERPJa06YNEyUxEAgDaSgjJny4bTa4qpTDCwKzKMn5Ji=Q@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Jonathan Metzman <metzman@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

On Fri, Jan 11, 2019 at 7:34 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/01/19 16:04, Max Moroz wrote:
> > We usually have a single fuzzing process, it starts with a fuzzing
> > engine's main function and is calling LLVMFuzzerTestOneInput with
> > various inputs and keep mutating them based on the coverage feedback.
> > Running a second process which you don't care too much about might be
> > fine, but the fuzzing process should be "replacing" or should I say
> > "imitating" the process whose coverage you're interested in.
>
> What do you mean by replacing or imitating?
>

To give you an example, when we fuzz ffmpeg, we do not run ffmpeg's main
function. We write LLVMFuzzerTestOneInput that would do the necessary
initialization, reset the state, etc, and then would pass (data, size)
provided by a fuzzing engine to the API(s) we're trying to fuzz. So, in
your case, there should not be a regular QEMU process, and instead the fuzz
target (i.e. LLVMFuzzerTestOneInput) should be doing certain initialization
(which is usually done by the QEMU process) and then call the API you want
to fuzz.


>
> Avoiding fork would probably be hard.  I'm mostly afraid that some state
> guest state is not resetted properly across runs, and this would result
> in non-reproducible crashes.
>
> It seems to me that the task can be approached with AFL and a test case
> postprocessor to generate the qtest input; however, my knowledge of
> libFuzzer is very very limited.
>
> Paolo
>
