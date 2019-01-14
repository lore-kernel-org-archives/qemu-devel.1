Received: from eggs.gnu.org ([209.51.188.92]:42792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj5fm-0001IC-Vv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj5fl-0006NF-1J
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:05:14 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:34921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj5fj-0006BD-7v
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:05:12 -0500
Received: by mail-ot1-x32d.google.com with SMTP id 81so19968945otj.2
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 09:05:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA8GE72MaUFvbfHUL7vwkBNzWh+q_0VgzbmLJ-StYhWM4Q@mail.gmail.com>
	<a1dddb07-0602-f488-210e-e4f6611f64ae@redhat.com>
In-Reply-To: <a1dddb07-0602-f488-210e-e4f6611f64ae@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 17:04:53 +0000
Message-ID: <CAFEAcA9Fo4t4zN2CeoQyB1pJyM0XcKFgi73zyQuwZUxRhLN5XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 14 Jan 2019 at 16:59, Thomas Huth <thuth@redhat.com> wrote:
>
> On 2019-01-14 17:31, Peter Maydell wrote:
> > We prohibit -device foo for non-pluggable devices:
> > $ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257
> > qemu-system-x86_64: -device i8257: Parameter 'driver' expects
> > pluggable device type
> >
> > And we suppress them from "-device help" output too.
> >
> > But we still allow the user to do this:
> >
> > $ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257,help
> > i8257 options:
> >   dshift=<int32>
> >   base=<int32>
> >   pageh-base=<int32>
> >   page-base=<int32>
>
> Could this still be sometimes useful, e.g. when a device is configured
> with the "-global" parameter?

Hmm, good point: some of the properties are usefully human
changeable even for built-in devices. But a lot of them
are not, if you look at the iotkit example.
Perhaps a useful compromise would be filtering out the
"child<" properties? (these are all created via
object_property_add_child() and user changes to them seem
unlikely to be ever something that would work).

thanks
-- PMM
