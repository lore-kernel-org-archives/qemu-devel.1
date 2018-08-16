Received: from eggs.gnu.org ([2001:4830:134:3::10]:55571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqMWh-0002cX-GF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqMWe-0003L8-AV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:57:39 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqMWe-0003Kl-2C
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:57:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id y10-v6so2348392pfn.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 10:57:36 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-49-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0b20986-875c-7c8e-a74f-ea7b27e1ec02@linaro.org>
Date: Thu, 16 Aug 2018 10:57:32 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-49-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 48/84] disas: Add support for microMIPS
 and nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> +#define umips_decode_gpr3_reg_names(rn) mips_gpr_names[umips_decode_gpr3[rn]]
> +#define umips_decode_gpr3_src_store_reg_names(rn) \
> +    mips_gpr_names[umips_decode_gpr3_src_store[rn]]
> +
> +int nanomips_dis(char *buf, unsigned address, unsigned short one,
> +                 unsigned short two, unsigned short three);
> +
> +int print_insn_micromips(bfd_vma memaddr, struct disassemble_info *info)
> +{

All of the umips stuff is GPLv3 code and cannot be included in QEMU.

At least it corresponds quite closely to binutils commit

commit df58fc944dbc6d5efd8d3826241b64b6af22f447 (HEAD)
Author: Richard Sandiford <rdsandiford@googlemail.com>
Date:   Sun Jul 24 14:20:15 2011 +0000

    bfd/
    2011-02-25  Chao-ying Fu  <fu@mips.com>
                Ilie Garbacea  <ilie@mips.com>
                Maciej W. Rozycki  <macro@codesourcery.com>
                Joseph Myers  <joseph@codesourcery.com>
                Catherine Moore  <clm@codesourcery.com>
                Richard Sandiford  <rdsandiford@googlemail.com>

IANAL, and the GNU project has always allowed the original
license holder to distribute under multiple licenses, which
in this case would be mips.com, now wavecomp.com, but... ug.

That said, you don't seem to actually be using *any* of the
micromips bits.  You've stripped all of that out from the
body of print_insn_micromips and then call into nanomips_dis.

So just remove all of the bits you aren't using, and rename
the entry point, and you'll be fine.


> new file mode 100644
> index 0000000..35c3973
> --- /dev/null
> +++ b/disas/nanomips.cpp
> @@ -0,0 +1,15752 @@
> +
> +#include <cstring>
> +#include <stdexcept>
> +#include <sstream>
> +
> +#define INCLUDE_STANDALONE_UNIT_TEST

This is new code and needs a comment at the top for its license.


r~
