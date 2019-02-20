Received: from eggs.gnu.org ([209.51.188.92]:59659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwU6h-0002ii-5p
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwU6f-0004J9-Gh
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:48:22 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwU6f-0004IF-8d
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:48:21 -0500
Received: by mail-ot1-x342.google.com with SMTP id b3so40893814otp.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:48:21 -0800 (PST)
MIME-Version: 1.0
References: <alpine.BSF.2.21.9999.1902151046540.80982@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1902151046540.80982@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Feb 2019 15:48:08 +0000
Message-ID: <CAFEAcA_o7eS854bC3aC4kZjyd3so3LmQzr76WMg9zWueEz8=FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MemoryRegionOps access sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 15 Feb 2019 at 09:56, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Hello,
>
> Could someone please explain how the MemoryRegionOps
> valid.{min,max}_access_size and unaligned and corresponding impl
> constraints work and where are these implemented? And in particular if
> this would work:
>
> static const MemoryRegionOps ops = {
>      .read = readfn,
>      .write = writefn,
>      .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
>      .impl.min_access_size = 4,
>      .impl.max_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,
> };

These are implemented in memory.c. The documentation
is in the comments on the MemoryRegionOps struct in
include/exec/memory.h.

The .valid parts should specify what the device permits
the guest to do (and where failures result in MemTxErrors
usually meaning bus error/data abort). These ought to be
handled by the memory_region_access_valid() function, but
I can't see how the logic there actually does the right
thing. Maybe Paolo understands that part better than me.

The .impl parts specify what the implementation can
deal with, and access_with_adjusted_size() takes
care of making multiple accesses to the underlying
device if necessary. (The fiddling of the data to
put it in the right place is done at the next level
down by memory_region_shift_read_access()
and memory_region_shift_write_access().)

I think your suggested MemoryRegionOps ought to work.

thanks
-- PMM
