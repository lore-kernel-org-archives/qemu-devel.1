Received: from eggs.gnu.org ([2001:4830:134:3::10]:52509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej0vD-0001lI-QV
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej0vC-0002xt-Mo
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:56:19 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:46390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej0vC-0002xR-Hx
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:56:18 -0500
Received: by mail-ot0-x22a.google.com with SMTP id f56so1301134otj.13
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 02:56:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206091700.GB4942@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
	<20180202100843.GD13090@stefanha-x1.localdomain>
	<CAFEAcA-5PwhJw9epXh+0_oe3E-vsVKkQDX3s1Go-FBzO=FA3zA@mail.gmail.com>
	<20180205155108.GF28241@stefanha-x1.localdomain>
	<CAFEAcA-vd3vEJ0i=2LtaR-NQjHoJVYWCNDHOmh3iREPcQsqR4A@mail.gmail.com>
	<20180206091700.GB4942@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 10:55:57 +0000
Message-ID: <CAFEAcA-o3b0B1BhzTP5YdsXLyq50_WC7hzZU8vb-EmTOBKjhWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nesrine Zouari <nesrine.zouari@enis.tn>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>

On 6 February 2018 at 09:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Mon, Feb 05, 2018 at 03:55:01PM +0000, Peter Maydell wrote:
>> ...and "online processing of traces" is pretty much exactly
>> what an instrumentation plugin API is for.
>
> There are two cases for online processing:
>
> 1. Synchronous - this is what the instrumentation plugins will be able
>    to do.  It means that QEMU waits until the event has been processed,
>    and the plugin is therefore able to control QEMU.
>
> 2. Asynchronous - this is what LTTng UST does.  It means that the
>    process analyzing the trace does not hold up QEMU, but it cannot
>    control QEMU without some delay between trace events firing and
>    reacting to them.  I think Nesrine's use case is this one.
>
> #2 is useful for "real-time" graphs, for example.  That is still
> "oneline" but it doesn't require instrumentation plugins.
>
> Given that the instrumentation plugin API is still in early development,
> it would delay Nesrine's work and I recommend against depending on it.

I don't really want us to end up with two separate ways of doing
basically the same thing that have been implemented entirely
independently.

A lot of the problems you need to solve (like "how do we
configurably add tracing of things like guest register changes
into the generated code in a maintainable and efficient way")
are the same both ways.

>> It would also let you put the logic of "how do we know what a
>> guest OS task switch is anyway" somewhere other than QEMU,
>> which is nice because that's very guest-OS specific.
>
> How do you envision that instrumentation plugins will monitor guest OS
> task switches if QEMU does not know about them?

The plugin can register for information like changes of the
relevant system registers (and could potentially do cleverer
things like looking at guest in-memory task data structures).
QEMU doesn't need to know (and shouldn't know) that x86 CR3 or
Arm CONTEXTIDR are how you identify a guest OS task switch.

> Without instrumentation plugins I would add a guest_x86_cr3_write trace
> event, for example.  Then the trace consumer can interpret that event as
> a task switch if it knows the guest OS always writes to the cr3 register
> on a task switch.  No instrumentation plugins are necessary in order to
> do this and it doesn't hardcode knowledge of guest OS task switching
> into QEMU either.

This only works if you have a trace event for the register change,
which we don't.

thanks
-- PMM
