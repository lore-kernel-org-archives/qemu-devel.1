Received: from eggs.gnu.org ([2001:4830:134:3::10]:50753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cb5dJ-0002d4-EW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cb5dE-0007Oc-PJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:16:33 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cb5dE-0007NL-JN
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:16:28 -0500
Received: by mail-vk0-f47.google.com with SMTP id x75so77180430vke.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 05:16:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <HE1PR0802MB2265F12CE6DF970BC8D0D252AD400@HE1PR0802MB2265.eurprd08.prod.outlook.com>
References: <1485943606-13998-1-git-send-email-lprosek@redhat.com>
	<20170201102013.GC3232@redhat.com>
	<CABdb735fGM9r4tirfOTyK1Jv8oC868nW5rCsNk_X5acoiav1iA@mail.gmail.com>
	<20170201110320.GD3232@redhat.com>
	<CABdb737yd8ookNxet=Rp7b6-fux6iiBiS7KrrddtZ2EZVPFKqg@mail.gmail.com>
	<a03be6ea-a7bd-3b99-a94b-f180ef6f9e0a@openvz.org>
	<CABdb736+iGndMmYTVcrwRzEwGX9A8uizPthM3_-TYw34-+up_w@mail.gmail.com>
	<HE1PR0802MB2265F12CE6DF970BC8D0D252AD400@HE1PR0802MB2265.eurprd08.prod.outlook.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 7 Feb 2017 14:16:27 +0100
Message-ID: <CABdb735GNrspfp1PSCoHJFPiBQ-OQbo=NLrsY7oBXe00Z-d96g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kostyushko <aleksko@virtuozzo.com>
Cc: Denis Lunev <den@virtuozzo.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Feb 6, 2017 at 5:10 PM, Alexey Kostyushko <aleksko@virtuozzo.com> wrote:
> This info is more about pvpanic patch, but may be relevant here also.
>
> Consider that KeInitializeCrashDumpHeader is not enough to create dumps
> because it copy only primary header

You mean that the secondary data area is missing? That's by design -
again, the OS is running, we're not really crashing it so
BugCheckSecondaryDumpDataCallback's are not invoked.

For the actual "crash" crash dumps, we can experiment with
BugCheckDumpIoCallback which would let us push out the header as well
as secondary data but that's a non-goal at the moment.

> and doesn't copy KdDebuggerBlock.

It contains the pointers from KdDebuggerBlock: PsLoadedModuleList,
PsActiveProcessHead, and more. In my testing, the dump created from
KeInitializeCrashDumpHeader and the raw memory image was fully
functional. If there's anything specific you're concerned about, I can
check it.

> Look to combine info from KeCapturePersistentThreadState.

This looks like an undocumented API and I'd like to avoid those if possible.

> Also whenever amount of RAM is changed (memory hot-plug) you need to
> recreate headers.

That would be a maybe. We could just patch the memory regions in the
header to reflect the current memory layout. And there's a chance we
may need to do it anyways - the physical memory layout that QEMU works
with doesn't match what Windows sees for some reason. That's one thing
I need to take a close look at. Thanks!

> I think that there should be virtio direct channel for general purposes of
> dumping and guest-agent channel may be usefull for obtainin varoius
>
> info from guest drivers through ioctls and providing live-dump feature.
>
> ________________________________
> From: Ladi Prosek <lprosek@redhat.com>
> Sent: Monday, February 6, 2017 6:50:43 PM
> To: Denis Lunev
> Cc: Daniel P. Berrange; qemu-devel; Michael Roth; Alexey Kostyushko
> Subject: Re: [Qemu-devel] [PATCH] qga: implement guest-file-ioctl
>
> On Mon, Feb 6, 2017 at 4:37 PM, Denis V. Lunev <den@openvz.org> wrote:
>> On 02/01/2017 04:41 PM, Ladi Prosek wrote:
>>> On Wed, Feb 1, 2017 at 12:03 PM, Daniel P. Berrange <berrange@redhat.com>
>>> wrote:
>>>> On Wed, Feb 01, 2017 at 11:50:43AM +0100, Ladi Prosek wrote:
>>>>> On Wed, Feb 1, 2017 at 11:20 AM, Daniel P. Berrange
>>>>> <berrange@redhat.com> wrote:
>>>>>> On Wed, Feb 01, 2017 at 11:06:46AM +0100, Ladi Prosek wrote:
>>>>>>> Analogous to guest-file-read and guest-file-write, this commit adds
>>>>>>> support for issuing IOCTLs to files in the guest. With the goal of
>>>>>>> abstracting away the differences between Posix ioctl() and Win32
>>>>>>> DeviceIoControl() to provide one unified API, the schema
>>>>>>> distinguishes
>>>>>>> between input and output buffer sizes (as required by Win32) and
>>>>>>> allows the caller to supply either a 'buffer', pointer to which will
>>>>>>> be passed to the Posix ioctl(), or an integer argument, passed to
>>>>>>> ioctl() directly.
>>>>>> What is the intended usage scenario for this ?
>>>>> My specific case is extracting a piece of data from Windows guests.
>>>>> Guest driver exposes a file object with a well-known IOCTL code to
>>>>> return a data structure from the kernel.
>>>> Please provide more information about what you're trying to do.
>>>>
>>>> If we can understand the full details it might suggest a different
>>>> approach that exposing a generic ioctl passthrough facility.
>>> The end goal is to be able to create a Window crash dump file from a
>>> running (or crashed, but running is more interesting because Windows
>>> can't do that by itself) Windows VM. To do that without resorting to
>>> hacks, the host application driving this needs to get the crash dump
>>> header, which Windows provides in its KeInitializeCrashDumpHeader
>>> kernel API.
>>>
>>> I believe that the most natural way to do this is to have
>>> 1) a driver installed in the guest providing a way to call
>>> KeInitializeCrashDumpHeader from user space
>>> 2) an agent in the guest, running in user space, calling the driver
>>> and passing the result back to the host
>>>
>>> Now 2) may as well be an existing agent, such as the QEMU guest agent,
>>> and that's why I am here :)
>>>
>>> KeInitializeCrashDumpHeader returns an opaque byte array, happens to
>>> be 8192 bytes at the moment. My first choice for the kernel-user
>>> interface in the guest is IOCTL because what I'm trying to get across
>>> is a block, a "datagram", not a stream, and I have the option for
>>> easily adding more functionality later by adding more IOCTL codes with
>>> the file object still representing "the driver".
>>>
>>> I could use regular file I/O as well. I would either have to devise a
>>> protocol for talking to the driver, have a way of delimiting messages,
>>> re-syncing the channel etc., or make a slight semantic shift and
>>> instead of the file object representing the driver, it would represent
>>> this one particular function of the driver. Opening the file and
>>> reading from it until eof would yield the crash dump header.
>> I think that this is not as good as can be for the whole design of the
>> feature.
>> The problem here is that userspace starts toooooooooo late and is not
>> accessible when the guest BSODS and we do need a dump for analysis.
>>
>> May be it worth to push this header to QEMU at boot time through virtio
>> bus?
>
> Yes, definitely an option. I believe that having the ability to create
> a dump out of a live system, i.e. without crashing it, is what adds
> the most value here. And that would most likely happen on an
> up-and-running guest so the difference between being able to do it
> after a kernel driver loads and after a user space service starts is
> not that significant.
>
> Still, the sooner the better, for sure. I think I've seen
> virtio-pstore suggested as a possible channel to use to push the
> header.
>
> Thanks!
>
>> Den
