Received: from eggs.gnu.org ([209.51.188.92]:44929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwpB-000634-KB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwp8-00046R-Cm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:54:27 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDwp4-0003zF-74
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:54:24 -0400
Received: by mail-ot1-x330.google.com with SMTP id k21so16787363otf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 12:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <e61c4a17-910b-0066-92ae-3fabf4a4e3e3@weilnetz.de>
In-Reply-To: <e61c4a17-910b-0066-92ae-3fabf4a4e3e3@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 02:54:11 +0700
Message-ID: <CAFEAcA-djqczK-BG-NBF3116fmmbxS5GPH94NGfDXWQU3dxoww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Misaligned memory writes on ARM and other runtime
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Wed, 10 Apr 2019 at 02:12, Stefan Weil <sw@weilnetz.de> wrote:
>
> When QEMU for ARM is compiled with sanitizers
> (--extra-cflags=-fsanitize=address,undefined), I see runtime errors for
> qemu-arm which indicate misaligned memory writes:
>
> /qemu/linux-user/fd-trans.c:1389:18: runtime error: store to misaligned
> address 0x42ff4b34 for type 'uint64_t', which requires 8 byte alignment
>
> The full sanitizer report is available from
> https://qemu.weilnetz.de/doc/sanitizer.txt. Some of the reported runtime
> errors can easily be fixed, for example by replacing "1 << 31"
> (currently 188 matches) by "1U << 31" (currently only 70 matches).

The shift "errors" are not in fact errors -- we compile with -fwrapv
to request a dialect of C where left shift of signed integers is
well-defined and has 2s complement semantics. Some versions
of the clang sanitizers don't correctly handle that flag as meaning
that those shifts should no longer generate sanitizer warnings.
If you're using a clang without that bug fix you can suppress the
warnings by adding "-fno-sanitize=shift-base" to the --extra-cflags
you pass to QEMU's configure.

The misaligned accesses are definitely bugs. The linux-user code
unfortunately has quite a lot of code in its data-structure conversion
code that is pretty fast and loose about accessing fields in
target-layout data structures.

thanks
-- PMM
