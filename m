Received: from eggs.gnu.org ([2001:4830:134:3::10]:56981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAFhW-0006Au-OM
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAFhV-0004kM-Sj
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:38:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:52057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAFhV-0004jA-K0
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:38:29 -0400
Received: by mail-wr0-x243.google.com with SMTP id j15so5036183wre.8
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 06:38:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171101203620.GA17963@flamenco>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
	<4ab3bd81-925c-a281-614c-2cd87fce38b5@redhat.com>
	<20171101203620.GA17963@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 13:38:07 +0000
Message-ID: <CAFEAcA-CX90dLbR8ypEidniFmORRZ8u7Pzc3fcaKJSeF9zTK1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/51] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 1 November 2017 at 20:36, Emilio G. Cota <cota@braap.org> wrote:
> On Wed, Nov 01, 2017 at 18:34:23 +0100, Thomas Huth wrote:
>> Seems like something in this patch series broke a couple of ARM boards
>> (smdkc210, nuri, raspi2, xlnx-ep108 and xlnx-zcu102). With current
>> master branch, I just get this error:
>>
>> $ aarch64-softmmu/qemu-system-aarch64  -machine raspi2
>> **
>> ERROR:/home/thuth/devel/qemu/tcg/tcg.c:537:tcg_register_thread:
>> assertion failed: (n < max_cpus)
>> Aborted (core dumped)
>>
>> Could you please have a look at this?
>
> Turns out some boards initialize a fixed number of vcpus, which
> can be > max_cpus.
>
> The below fixes the issue for me, although I'm not entirely happy
> with it because if -{smp,max}_cpus < machine_class->max_cpus, some
> TCG regions will be wasted. Not a huge deal (in most cases it will be
> 2MB per unused vCPU), but a better fix might be to just honour -max_cpus
> for these boards. We might just not care enough though.

Maybe we should allow machine models to specify:
 * max_cpus (the most they can support; 1 if not set by board,
   as in current code)
 * min_cpus (the least they can support; 1 if not set by board)
 * default_cpus (what you get if you don't ask for something else;
   1 if not set by board)

Then:
 * these boards which always create a fixed number of CPUs
   should set all three to the same thing
 * boards which only create the CPUs requested by the user
   can leave them unset (as today)
 * the generic command line parsing code should stop with an
   error message if the user sets max_cpus smaller than
   the board's min_cpus setting or greater than the board's
   max_cpus, or if they set -smp to less than the board's
   min_cpus
 * the TCG code can rely on the max_cpus global being right

Incidentally every time we add a field to MachineClass we
should add a doc comment giving its semantics.

thanks
-- PMM
