Received: from eggs.gnu.org ([209.51.188.92]:59387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mmoroz@google.com>) id 1ghyNO-0004eE-0r
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mmoroz@google.com>) id 1ghyNM-0003AZ-1b
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:05:37 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:35655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mmoroz@google.com>) id 1ghyNI-0002yu-Vi
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:05:34 -0500
Received: by mail-io1-xd2b.google.com with SMTP id f4so12414516ion.2
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:05:25 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
In-Reply-To: <CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
From: Max Moroz <mmoroz@google.com>
Date: Fri, 11 Jan 2019 07:04:48 -0800
Message-ID: <CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Jonathan Metzman <metzman@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

Paolo, thanks for clarifying, that makes total sense! I'd suggest not
focusing on AFL, but go for a libFuzzer-based fuzz target (i.e.
write LLVMFuzzerTestOneInput function), in that case you'll get both
libFuzzer and AFL engines pluggable to that fuzz target. OSS-Fuzz runs both.

On Thu, Jan 10, 2019 at 10:49 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Thu, Jan 10, 2019 at 11:25 PM Paolo Bonzini <pbonzini@redhat.com>
> wrote:
> > On 10/01/19 17:07, Max Moroz via Qemu-devel wrote:
> > > +Oliver and Jonathan
> > >
> > > I'm a little confused. Do you want to fuzz QEMU or to fuzz something
> else
> > > using QEMU? In case of the latter, there was some discussion on
> OSS-Fuzz
> > > and (I think) even a build support was (sort of) added:
> > > https://github.com/google/oss-fuzz/issues/1754
> >
> > We want to fuzz QEMU.
> >
> > The input is a sequence of operations on a PCI device or on guest
> > memory, and you try and crash QEMU by passing it crazy operations.
> >
> > The qtest mode that Stefan mentioned provides something like a "JTAG
> > over ASCII" where a testcase can inject elementary I/O operations into
> > QEMU.  However, that is certainly too much for AFL to fuzz effectively;
> > it would have to "learn" the qtest protocol, how to drive the PCI host
> > bridge, how to setup a PCI device, and only then it would be able to
> > find bugs.  So one idea would be to build another layer on top of qtest,
> > that accepts higher-level operations and builds the qtest ASCII input
> > from those.
>
> Question for the oss-fuzz folks: QEMU's qtest protocol involves a
> 2-process architecture with a qtest process that connects to a QEMU
> process.  We don't care about the code coverage/sanitizers/etc on the
> test process, only the QEMU process.  The LLVMFuzzerTestOneInput()
> entry point would nevertheless be in the qtest process.  Does this fit
> into the oss-fuzz architecture?
>

We usually have a single fuzzing process, it starts with a fuzzing engine's
main function and is calling LLVMFuzzerTestOneInput with various inputs and
keep mutating them based on the coverage feedback. Running a second process
which you don't care too much about might be fine, but the fuzzing process
should be "replacing" or should I say "imitating" the process whose
coverage you're interested in. Does it make any sense?



>
> Thanks,
> Stefan
>
