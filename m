Received: from eggs.gnu.org ([209.51.188.92]:41634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwqk8-0001ZQ-U5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwqk6-00081l-Pe
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:58:36 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:36854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwqk3-0007zf-NG
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:58:33 -0500
Received: by mail-ot1-x333.google.com with SMTP id v62so36452589otb.3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 07:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20190215180500.6906-1-peter.maydell@linaro.org>
	<87h8cx432h.fsf@zen.linaroharston>
In-Reply-To: <87h8cx432h.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 15:58:15 +0000
Message-ID: <CAFEAcA_BOCiCyXOwv_GGY83Qz6e8BuDUdGhe5+tZaHJ8V-L=YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/armsse: Make 0x5...
 alias region work for per-CPU devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Thu, 21 Feb 2019 at 14:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The region 0x40010000 .. 0x4001ffff and its secure-only alias
> > at 0x50010000... are for per-CPU devices. We implement this by
> > giving each CPU its own container memory region, where the
> > per-CPU devices live. Unfortunately, the alias region which
> > makes devices mapped at 0x4... addresses also appear at 0x5...
> > is only implemented in the overall "all CPUs" container. The
> > effect of this bug is that the CPU_IDENTITY register block appears
> > only at 0x4001f000, but not at the 0x5001f000 alias where it should
> > also appear. Guests (like very recent Arm Trusted Firmware-M)
> > which try to access it at 0x5001f000 will crash.
> >
> > Fix this by moving the handling for this alias from the "all CPUs"
> > container to the per-CPU container. (We leave the aliases for
> > 0x1... and 0x3... in the overall container, because there are
> > no per-CPU devices there.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Looks good from code inspection. However I'm having trouble getting the
> right runes for building the firmware. What TARGET_PLATFORM matches the
> IoTKit SSE2 that uses this?

To hit this you will need to use -DTARGET_PLATFORM=3DAN521 for
arm-tfm, and the QEMU mps2-an521 machine.

(Building arm-tfm firmware is indeed a bit of a pain, it has
a pile of annoying dependencies and a tendency to want
bleeding-edge versions of tools like dtc and cmake.)

thanks
-- PMM
