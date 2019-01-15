Received: from eggs.gnu.org ([209.51.188.92]:38814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjJAh-0005ah-B6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjJAg-0005Y3-IV
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:30:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gjJAg-0005UQ-7a
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:30:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA8GE72MaUFvbfHUL7vwkBNzWh+q_0VgzbmLJ-StYhWM4Q@mail.gmail.com>
	<a1dddb07-0602-f488-210e-e4f6611f64ae@redhat.com>
	<CAFEAcA9Fo4t4zN2CeoQyB1pJyM0XcKFgi73zyQuwZUxRhLN5XQ@mail.gmail.com>
Date: Tue, 15 Jan 2019 08:23:40 +0100
In-Reply-To: <CAFEAcA9Fo4t4zN2CeoQyB1pJyM0XcKFgi73zyQuwZUxRhLN5XQ@mail.gmail.com>
	(Peter Maydell's message of "Mon, 14 Jan 2019 17:04:53 +0000")
Message-ID: <87o98ijseb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] -device foo,
 help shouldn't be allowed for devices where -device foo is forbidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 14 Jan 2019 at 16:59, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 2019-01-14 17:31, Peter Maydell wrote:
>> > We prohibit -device foo for non-pluggable devices:
>> > $ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257
>> > qemu-system-x86_64: -device i8257: Parameter 'driver' expects
>> > pluggable device type
>> >
>> > And we suppress them from "-device help" output too.
>> >
>> > But we still allow the user to do this:
>> >
>> > $ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257,help
>> > i8257 options:
>> >   dshift=<int32>
>> >   base=<int32>
>> >   pageh-base=<int32>
>> >   page-base=<int32>
>>
>> Could this still be sometimes useful, e.g. when a device is configured
>> with the "-global" parameter?

That's exactly why we provide this help.  Admittedly obscure.

> Hmm, good point: some of the properties are usefully human
> changeable even for built-in devices. But a lot of them
> are not, if you look at the iotkit example.
> Perhaps a useful compromise would be filtering out the
> "child<" properties? (these are all created via
> object_property_add_child() and user changes to them seem
> unlikely to be ever something that would work).

As long as "seem unlikely to be ever" actually means "are not going to
be", no objection.  I doubt it's worth the effort, though.

A worthier goal would be getting -global to provide help.  Sadly, that
doesn't seem practical in the current state of things.
