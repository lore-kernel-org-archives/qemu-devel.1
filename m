Received: from eggs.gnu.org ([2001:4830:134:3::10]:51157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZFCt-0003FM-1i
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZFCo-0005ff-2f
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:05:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cZFCn-0005f2-NB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:05:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
	<20170201102013.GC3232@redhat.com>
	<CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
	<20170201110320.GD3232@redhat.com>
	<CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
Date: Thu, 02 Feb 2017 12:05:30 +0100
In-Reply-To: <CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
	(Ladi Prosek's message of "Wed, 1 Feb 2017 14:41:01 +0100")
Message-ID: <87h94c6ef9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

Ladi Prosek <lprosek@redhat.com> writes:

> On Wed, Feb 1, 2017 at 12:03 PM, Daniel P. Berrange <berrange@redhat.com> wrote:
>> On Wed, Feb 01, 2017 at 11:50:43AM +0100, Ladi Prosek wrote:
>>> On Wed, Feb 1, 2017 at 11:20 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>>> > On Wed, Feb 01, 2017 at 11:06:46AM +0100, Ladi Prosek wrote:
>>> >> Analogous to guest-file-read and guest-file-write, this commit adds
>>> >> support for issuing IOCTLs to files in the guest. With the goal of
>>> >> abstracting away the differences between Posix ioctl() and Win32
>>> >> DeviceIoControl() to provide one unified API, the schema distinguishes
>>> >> between input and output buffer sizes (as required by Win32) and
>>> >> allows the caller to supply either a 'buffer', pointer to which will
>>> >> be passed to the Posix ioctl(), or an integer argument, passed to
>>> >> ioctl() directly.
>>> >
>>> > What is the intended usage scenario for this ?
>>>
>>> My specific case is extracting a piece of data from Windows guests.
>>> Guest driver exposes a file object with a well-known IOCTL code to
>>> return a data structure from the kernel.
>>
>> Please provide more information about what you're trying to do.
>>
>> If we can understand the full details it might suggest a different
>> approach that exposing a generic ioctl passthrough facility.
>
> The end goal is to be able to create a Window crash dump file from a
> running (or crashed, but running is more interesting because Windows
> can't do that by itself) Windows VM. To do that without resorting to
> hacks, the host application driving this needs to get the crash dump
> header, which Windows provides in its KeInitializeCrashDumpHeader
> kernel API.
>
> I believe that the most natural way to do this is to have
> 1) a driver installed in the guest providing a way to call
> KeInitializeCrashDumpHeader from user space
> 2) an agent in the guest, running in user space, calling the driver
> and passing the result back to the host
>
> Now 2) may as well be an existing agent, such as the QEMU guest agent,
> and that's why I am here :)

Makes sense.

> KeInitializeCrashDumpHeader returns an opaque byte array, happens to
> be 8192 bytes at the moment. My first choice for the kernel-user
> interface in the guest is IOCTL because what I'm trying to get across
> is a block, a "datagram", not a stream, and I have the option for
> easily adding more functionality later by adding more IOCTL codes with
> the file object still representing "the driver".

ioctl() is the traditional way to do something like this.

In Linux, you might well be asked to do a pseudo-file in /sys instead.

> I could use regular file I/O as well. I would either have to devise a
> protocol for talking to the driver, have a way of delimiting messages,
> re-syncing the channel etc.,

Way too much trouble.

>                              or make a slight semantic shift and
> instead of the file object representing the driver, it would represent
> this one particular function of the driver. Opening the file and
> reading from it until eof would yield the crash dump header.

Or even simpler: read(fd, buf, n) always returns the first @n bytes of
the crash dump header.  If you want to detect a size that doesn't match
your expectations, pass a slightly larger buffer.

>>> > The size of arguments that need to be provided to ioctl()s vary on
>>> > the architecture of the guest kernel that's running, which cannot be
>>> > assumed to be the same as the architecture of the QEMU binary. ie
>>> > you can be running i686 kernel in an x86_64 QEMU.  So it feels like
>>> > it is going to be hard for applications to reliably use this feature
>>> > unless they have more information about the guest OS, that is not
>>> > currently provided by QEMU guest agent. So it feels like this design
>>> > is not likely to be satisfactory to me.
>>>
>>> I can turn this around and say that guest-file-read and
>>> guest-file-write shouldn't exist because applications can't reliably
>>> know what the format of files on the guest is.
>>
>> No that's not the same thing at all. From the POV of the QEMU API, the
>> contents of the files do not matter - it is just a byte stream and the
>> guest agent API lets you read it in the same way no matter what is in
>> the files, or what OS is running. There's no need to know anything about
>> the guest OS in order to successfully read/write the entire file.
>
> Ok, so there are two different aspects that should probably be
> separated. The actual semantics of IOCTL calls is equivalent to the
> semantics of files in general. For files it's stream in, stream out
> (and seeking and such). For IOCTL it's a buffer in, buffer out (and a
> return code). The content is file specific, IOCTL code specific,
> whatever. Definitely not guest agent's business to interpret it. Here
> I think my analogy holds.

"Everything is a file".  Many times we made something not a file we
regretted it later.

>> The ioctl design you've proposed here is different because you need to
>> know precise operating system details before you can use the API. I
>> think that's really flawed.
>
> Yes, maybe. Maybe the concept of the IOCTL syscall is just too
> different across the guest operating systems supported by the agent. I
> tried to abstract away the differences between Posix and Windows.
> Perhaps I didn't do it right or there's more OSes to worry about. Yes,
> in theory the data passed to or from IOCTL may contain pointers and
> not be easily remotable. But it's not common. Files can also be opened
> with all kinds of obscure flags on different OSes, many of which are
> not supported by guest-file-open.

ioctl() is an ugly low-level interface, which makes it awkward to pass
through QGA.

Your point that we strip away details of the file I/O interfaces for QGA
is valid.  I wouldn't rule out the possibility of a suitably limited
ioctl() pass through out of hand.  But we'd probably want more than one
use case to demonstrate that it's useful despite the limitations.

>> It would be possible to design a ioctl API that is more usable if you
>> didn't try to do generic passthrough of arbitrary ioctl commands. Instead
>> provide a QAPI schema that uses a union to provide strongly typed arguments
>> for the ioctl commands you care about using. Or completely separate QAPI
>> commands instead of multiplexing everything into an ioctl command.
>
> I can add a QAPI command for my specific use case if it's acceptable,
> that's not a problem. Although at that point I would probably just go
> back to my plan b and use regular file I/O and guest-file-read. I just
> wanted to be as generic as possible to benefit other use cases as well
> and I ended up with what's basically my stab at RPC ioctl.

I appreciate you trying to provide something that's generally useful
instead of just hacking up a one-off that works four your special
problem.

Of course, designing a generally useful thing can sometimes be more
trouble than it's worth.  Use your judgement.
