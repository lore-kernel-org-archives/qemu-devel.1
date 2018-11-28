Received: from eggs.gnu.org ([2001:4830:134:3::10]:49169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRyCT-0007pN-Ln
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRyCR-0006TJ-Tc
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:40:13 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRyCQ-0006SL-NN
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:40:10 -0500
Received: by mail-oi1-x243.google.com with SMTP id h25so22306124oig.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 03:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-5-sameo@linux.intel.com>
	<CAFEAcA9wvrnshOTYz-jZ0n6m7SfusYY+bnB-iPnQuVNqqdg5Ww@mail.gmail.com>
	<20181127153551.GC4393@caravaggio>
	<CAFEAcA9B5DPeot26-oGtR-h+xdfg+tmUPrYpKhaneaT1tr1yqQ@mail.gmail.com>
	<20181128104024.GD4393@caravaggio>
In-Reply-To: <20181128104024.GD4393@caravaggio>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Nov 2018 11:39:57 +0000
Message-ID: <CAFEAcA-G3_uhH134_n8yobkJQJ7pOvu-vpLe9MkwVp5DmJOeag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/13] target: arm: Move all interrupt and
 exception handlers into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 28 Nov 2018 at 10:40, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Given that this piece of code effectively builds a dependency to TCG
> from the KVM code, I see a few solutions but I need your input here. We
> could:
>
> - Decide we don't want to support --disable-tcg for ARM. We'd then carry
>   this patch serie from the NEMU code repo. Worst case scenario, at
>   least for us.
> - Manage to implement exception injection from userspace without TCG.
>   Would it even be possible?
> - Offload exception injections back to the kernel in those cases. I feel
>   this would be the cleanest solution but may need kernel changes.

The kernel folk were firmly against 3, IIRC, but you can go
and have the discussion if you like.

I don't really see what the problem is. This is just a bit
of code that's used by both TCG and KVM. Therefore it goes
in the binary whether TCG is enabled or not. Other functions
and bits of code are TCG only and therefore don't go in a
KVM-only binary. --disable-tcg just means "remove the code
we don't need"; there's nothing special about these functions
that says "they're really TCG and should be removed here".

thanks
-- PMM
