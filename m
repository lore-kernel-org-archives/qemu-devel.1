Received: from eggs.gnu.org ([2001:4830:134:3::10]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9VdO-0005EM-Ig
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9VdN-0006Sc-IF
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:59:26 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:37352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9VdN-0006R0-DA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:59:25 -0400
Received: by mail-oi0-x229.google.com with SMTP id f63-v6so7941040oic.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 05:59:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f89278ba-b805-e47d-7e5e-d103ab9c4294@amsat.org>
References: <20180419220914.959-1-f4bug@amsat.org>
	<20180419220914.959-2-f4bug@amsat.org>
	<CAFEAcA-LYpqaYfdmjzXwMDau8bZH_zxXaRCCL5dRT1p6spjUxQ@mail.gmail.com>
	<f89278ba-b805-e47d-7e5e-d103ab9c4294@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 13:59:04 +0100
Message-ID: <CAFEAcA9zuoVDJqZ88jBG0fEpC2imDuj2OAAMpgqiQ=MbtE3QSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/isa/superio: Fix inconsistent use
 of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 20 April 2018 at 13:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hi Peter,
>
> On 04/20/2018 05:43 AM, Peter Maydell wrote:
>> On 19 April 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>>> 4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
>>> use of Chardev->be. Also, this CharBackend member is private and is
>>> not supposed to be accessible.

>> You should not need to create fake null devices like this. The
>> device using the chardev should just cope with having a NULL
>> pointer now we have commit 12051d82f004024.
>
> I am trying to model a SoC with 4 uarts, and started using the current
> pattern:
>
>   for (i =3D 0; i < MAX_SERIAL_PORTS; i+++) {
>     if (serial_hds[i]) {
>       serial_mm_init(..., serial_hds[i], ...);

This is wrong, because it means that the UART device will
only be visible to the guest if the user connected it to
something (with -serial whatever). You should always create
the same number of devices, which correspond to what
hard wired UARTs the board has.

(The exception would I guess be if the devices were pluggable,
so each serial device was a pluggable PCI UART or something
weird; in that case there's an argument that -serial means
"create and plug in one of these devices". x86 is probably
also different for legacy reasons.)

> Since we can now safely call serial_mm_init(..., chr=3DNULL, ...), I'll
> work on simplifying and fixing this.

Correct. There are a bunch of dubious workarounds in the
codebase which try to handle the problem at different levels,
but we've decided that the right thing is for the NULL pointer
to be dealt with in one place at the bottom (in the qemu_chr_fe_*
functions).

Incidentally I was wondering if we could sensibly get rid of
the compile time MAX_SERIAL_PORTS. Right now there's no way
to model a device with five UARTs such that they can all
be sent to interesting places. I think there's no reason
for this except that the PC traditionally has 4 UARTs and
nobody's ever changed the code...

thanks
-- PMM
