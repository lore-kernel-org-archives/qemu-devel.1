Received: from eggs.gnu.org ([209.51.188.92]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghtUt-00088s-GV
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghtUr-0006TB-K7
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:53:02 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghtUo-0006IE-2V
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:52:59 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so11726928oie.10
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 01:52:51 -0800 (PST)
MIME-Version: 1.0
References: <q186f8$1u3$1@blaine.gmane.org>
In-Reply-To: <q186f8$1u3$1@blaine.gmane.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 09:52:39 +0000
Message-ID: <CAFEAcA9F+57RZzRTga8BvY_zCf13WX8d3NF6HA8kChtcw9_v6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu-user-linux: how could I measure performance
 for aarch64 and arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 10 Jan 2019 at 19:33, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
> I am running the same application compiled for aarch64 and armv7l on
> x86_64 platform using qemu-user-linux tools.
>
> I see dramatic performance difference (30 times) between emulated
> architectures: aarch64 runs for ~4 minutes, armv7l runs for ~2 hours.
> I do understand that CPU architecture emulation is inherently slow
> thing, but my question is about the difference.
>
> How could I debug to understand what is the reason for such a big
> difference? I've already tried to run stress-ng compiled for this two
> architectures, but it leads to the same performance per second.
>
> I am running qemu 2.11, should I try other version?

Yes, do try 3.1 -- we have done some overall TCG performance
improvements.

For a big difference between target architectures like that,
I would try starting by using some host performance tools on
the two runs to see where all the time is being taken in
the armv7l guest run -- is it all in translated guest code,
or is there more time (proportionally) spent in particular
parts of the QEMU C code? Does the armv7l version do
many more or different syscalls (check with the QEMU -strace
option) ?

Also you should check performance on h/w 32 bit vs
64-bit Arm if you can, to confirm that it's not just
that the guest application runs much slower there.
(If you don't have the arm hardware you could at least
check x86 32-bit vs 64-bit.)

thanks
-- PMM
