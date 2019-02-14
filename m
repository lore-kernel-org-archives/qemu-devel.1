Received: from eggs.gnu.org ([209.51.188.92]:52256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMDw-0005B2-Aw
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMDv-0004GE-8U
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:59:04 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:38203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMDu-00048Q-PJ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:59:03 -0500
Received: by mail-ot1-x336.google.com with SMTP id m1so12358623otf.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:58:59 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 18:58:46 +0000
Message-ID: <CAFEAcA_WNz+=mxvyekHN0u9kSzw6QrmmF9Lz8LzjJaL125zanw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] coverity detected issue in contrib/elf2dmp/main.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Hi; Coverity detected an issue in contrib/elf2dmp/main.c (CID 1398641).
In this loop:

    for (; KernBase >= 0xfffff78000000000; KernBase -= PAGE_SIZE) {
        nt_start_addr = va_space_resolve(&vs, KernBase);
        if (!nt_start_addr) {
            continue;
        }

        if (*(uint16_t *)nt_start_addr == 0x5a4d) { /* MZ */
            break;
        }
    }

we might end exiting with nt_start_addr == NULL, if we go all
the way through the address range without finding anything
and the loop terminates via the "KernBase >= 0xfffff78000000000"
condition.

However, we don't check for this, so we will then segfault
in pe_get_pdb_symstore_hash(), which assumes it's passed a non-NULL
address.

I guess we should be checking for nt_start_addr == NULL at the
end of the loop and treating it as a fatal error?

thanks
-- PMM
