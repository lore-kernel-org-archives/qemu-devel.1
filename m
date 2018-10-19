Received: from eggs.gnu.org ([2001:4830:134:3::10]:41264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDO06-0007h9-PM
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDO01-0008Bq-P8
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:11:09 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:39663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDNzy-00083Y-34
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:11:03 -0400
Received: by mail-pg1-x52b.google.com with SMTP id r9-v6so15314456pgv.6
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:10:57 -0700 (PDT)
References: <20181016174911.9052-1-richard.henderson@linaro.org>
	<CAFEAcA-NEN7MymyzmeOwz7bX99P_o6D9dMraHYA8LcFS7w9=_A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <12592ba3-ea47-e7c2-d67b-c58012c64287@linaro.org>
Date: Thu, 18 Oct 2018 23:10:53 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-NEN7MymyzmeOwz7bX99P_o6D9dMraHYA8LcFS7w9=_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/21] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/18/18 3:34 AM, Peter Maydell wrote:
> Hi; I get compile failures, I'm afraid:
> 
> FreeBSD's compiler gives warnings:
> In file included from /var/tmp/qemu-test.bVaUEj/accel/tcg/user-exec.c:28:
> /var/tmp/qemu-test.bVaUEj/include/qemu/atomic128.h:148:23: warning:
> unknown attribute 'error' ignored [-Wunknown-attributes]
> Int128 __attribute__((error("unsupported atomic")))
>                       ^
> /var/tmp/qemu-test.bVaUEj/include/qemu/atomic128.h:150:21: warning:
> unknown attribute 'error' ignored [-Wunknown-attributes]
> void __attribute__((error("unsupported atomic")))
>                     ^
> 
> x86-64 Linux clang fails with the same issue:
> In file included from
> /home/petmay01/linaro/qemu-for-merges/accel/tcg/user-exec.c:28:
> /home/petmay01/linaro/qemu-for-merges/include/qemu/atomic128.h:148:23:
> error: unknown attribute 'error' ignored
> [-Werror,-Wunknown-attributes]
> Int128 __attribute__((error("unsupported atomic")))
>                       ^
> /home/petmay01/linaro/qemu-for-merges/include/qemu/atomic128.h:150:21:
> error: unknown attribute 'error' ignored
> [-Werror,-Wunknown-attributes]
> void __attribute__((error("unsupported atomic")))

I used __has_attribute for this one.  Tested with clang 7.


> The win32 build fails with:
> 
> target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_le_parallel':
> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:573: undefined
> reference to `helper_atomic_cmpxchgo_le_mmu'
> target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_be_parallel':
> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:647: undefined
> reference to `helper_atomic_cmpxchgo_be_mmu'
> target/arm/helper-a64.o: In function `helper_casp_le_parallel':
> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:669: undefined
> reference to `helper_atomic_cmpxchgo_le_mmu'
> target/arm/helper-a64.o: In function `helper_casp_be_parallel':
> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:690: undefined
> reference to `helper_atomic_cmpxchgo_be_mmu'

This one I could not reproduce.  Tested with i686-w64-mingw32-gcc
and x86_64-w64-mingw32-gcc, both version 6.2.

I suspect configure misfired.  If you can, start this one over with a blank
build directory.

I've sent you a v2 pull.


r~
