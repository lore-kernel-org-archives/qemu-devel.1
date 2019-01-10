Received: from eggs.gnu.org ([209.51.188.92]:58291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dvyukov@google.com>) id 1ghb4w-0006I3-Mm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dvyukov@google.com>) id 1ghauJ-0004H8-A7
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:02:04 -0500
Received: from mail-it1-x131.google.com ([2607:f8b0:4864:20::131]:39465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dvyukov@google.com>) id 1ghauJ-0004Fy-3D
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:02:03 -0500
Received: by mail-it1-x131.google.com with SMTP id a6so16334531itl.4
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 06:02:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
In-Reply-To: <jpgsgy0aaw6.fsf@linux.bootlegged.copy>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 10 Jan 2019 15:01:50 +0100
Message-ID: <CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
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
To: Bandan Das <bsd@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kostya Serebryany <kcc@google.com>, Max Moroz <mmoroz@google.com>, Andrey Konovalov <andreyknvl@google.com>

On Thu, Jan 10, 2019 at 2:40 PM Bandan Das <bsd@redhat.com> wrote:
>
> Hi Stefan,
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > Hi folks,
> > I'd like to start fuzzing emulated devices in QEMU.  Here is an
> > internship project idea I'm proposing to do this.
> >
> > Any thoughts?  Want to co-mentor this in Google Summer of Code or Outreachy?
> >
> > Stefan
> >
> > '''Summary:''' Integrate oss-fuzz into QEMU so that the virtio-blk
> > device can be fuzz tested.
> >
> > oss-fuzz offers a fuzz testing service to open source projects.  This
> > means random inputs are continuously tested against the program in
> > order to find crashes and other bugs.  Fuzz testing complements
> > hand-written test suites by exploring the input space of a program and
> > therefore the code paths that may be taken.
> >
> > The goal of this project is to integrate oss-fuzz into QEMU so that
> > the virtio-blk-pci device can be fuzzed at both the VIRTIO and PCI bus
> > level.  virtio-blk-pci is a PCI device, which means it is connected to
> > the virtual machine's PCI bus and has a certain set of registers that
> > can be programmed by the guest.  Furthermore, it is a VIRTIO device -
> > this is the specification the describes most of the functionality of
> > virtio-blk.  Bugs exist at both the PCI and VIRTIO levels, so it's
> > important to fuzz both of them.
> >
> > Fuzzing emulated devices involves accessing their hardware registers
> > randomly to make the device respond.  QEMU has a device testing
> > interface called "qtest" that accepts read/write and other commands
> > over a socket and is ideal for writing device-level tests.  You may
> > find that oss-fuzz works better integrated directly into the QEMU
> > program instead of as a separate qtest program, so you can consider
> > adding a new command-line option to QEMU for running in oss-fuzz mode.
>
> This sounds very interesting and if successful can easily be a stepping stone
> to other sections. I would be interested in co-mentoring specifically focusing
> on the PCI code.
>
> One of the things I remember getting into trouble with when I was trying to hack
> on this, especially fuzzing Qemu as a whole is what would the run environment
> be like ? Would Qemu attempt to run a regular guest in oss-fuzz mode or only
> a certain part of Qemu (emulated devices for example) be somehow run without
> interacting with other dependent components ?

Ideally (from fuzzing perspective) we test just a single component and
everything else is stubbed out. But I don't know how feasible this is.
AFL can fork the whole process and then feed the input in some way.
This would allow to test the whole qemu without stubbing anything.
Should be possible with libFuzzer with some effort too.
I would say: start with whatever is simpler to do and then we will see
how good/bad it works.

One thing I forgot to mention (though, not the top priority) is
libprotobuf-mutator:
https://github.com/google/libprotobuf-mutator#libprotobuf-mutator
http://llvm.org/devmtg/2017-10/slides/Serebryany-Structure-aware%20fuzzing%20for%20Clang%20and%20LLVM%20with%20libprotobuf-mutator.pdf
https://chromium.googlesource.com/chromium/src/testing/libfuzzer/+/HEAD/libprotobuf-mutator.md

It allows fuzzer to work with structured inputs. Say, if you want as
input some sequence of actions (function calls) with some particular
arguments. This can be encoded as a protobuf message, and then fuzzer
function will interpret this protobuf message as actual actions. For
complex inputs this may be much more efficient than blob-mutations and
then some ad-hoc interpretation of that blob.




> > This project involves learning about VIRTIO and PCI devices, as well
> > as figuring out how to integrate oss-fuzz into QEMU so that it can
> > effective explore the code paths in virtio-blk device emulation code.
> > You will enjoy this project if you want to learn how device emulation
> > works and are interested in fuzzers.
> >
> > '''Links:'''
> > * [https://github.com/google/oss-fuzz/blob/master/docs/ideal_integration.md
> > oss-fuzz integration overview]
> > * [https://github.com/google/fuzzer-test-suite/blob/master/tutorial/libFuzzerTutorial.md
> > libfuzzer tutorial]
> > * [http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html
> > VIRTIO specification]
> > * [https://wiki.osdev.org/PCI PCI bus overview]
> >
> > '''Details:'''
> > * Skill level: intermediate
> > * Language: C
> > * Mentor: Stefan Hajnoczi <stefanha@redhat.com>
