Received: from eggs.gnu.org ([2001:4830:134:3::10]:39727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frO1F-0000F9-EV
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 09:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frO1E-0001p0-Ot
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 09:45:25 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:42962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frO1E-0001nb-KP
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 09:45:24 -0400
Received: by mail-oi0-x22b.google.com with SMTP id b16-v6so21505096oic.9
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 06:45:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGmj6qti3t3dBp6OT1H_UrkUi5OvXrb1nhEyozonz6uZm2P95A@mail.gmail.com>
References: <CAGmj6qti3t3dBp6OT1H_UrkUi5OvXrb1nhEyozonz6uZm2P95A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Aug 2018 14:45:03 +0100
Message-ID: <CAFEAcA8wZ7ga0kJ3WQ-A=fYNeJrxxCV+b2n7_Ni4Hg7jBS+L0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Simulating a composite machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schroeder <mkschreder.uk@googlemail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 August 2018 at 13:54, Martin Schroeder via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> Is it possible to instantiate multiple CPUs of different architectures
> and simuate them with different images at the same time? Some examples
> include ARM socs with m3/m4 coprocessor core but also boards with
> multiple processors where it is desirable to connect the chips over
> for example virtual SPI or UART and then simulate the composite system
> as a single machine where each of the cores runs a separate firmware.

Not currently, no. There's some out of tree stuff various people
have done involving connecting up separate QEMU processes.

> Is something like this easy to implement given current processor
> objects or does this require substantial changes to how qemu works?
> One area I do not fully understand is native code generator and
> whether it would be able to cope with two cores of *different*
> architectures at the same time.

At the moment some bits of our core code assume all the CPUs
in the system are basically identical (shared code cache, etc).
I'm planning to do some work to fix the simpler parts of this,
so you can have two different CPUs of the same architecture
in a system (eg a Cortex-M4 with an FPU plus one without an FPU,
or an M3 and an A-class core). Multiple completely different
architectures (eg Microblaze + ARM, or ARM + PPC) is rather
harder, as at the moment we build entirely separate
qemu-system-* binaries for each architecture and there are
some compile-time assumptions made. I'd like to see us work
towards making that possible, but there's potentially quite
a bit of effort required.

thanks
-- PMM
