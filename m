Received: from eggs.gnu.org ([2001:4830:134:3::10]:55623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f745J-0007L4-CX
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f745G-0004RW-H7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:10:09 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1f745G-0004Qd-7d
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:10:06 -0400
Received: by mail-pf0-x244.google.com with SMTP id q9so6630407pff.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 12:10:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180413142336.32163-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e879b530-1e00-6b58-7e23-eb8e76f7bfa4@twiddle.net>
Date: Fri, 13 Apr 2018 09:09:59 -1000
MIME-Version: 1.0
In-Reply-To: <20180413142336.32163-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] tcg/mips: Handle large offsets
 from target env to tlb_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/13/2018 04:23 AM, Peter Maydell wrote:
> The MIPS TCG target makes the assumption that the offset from the
> target env pointer to the tlb_table is less than about 64K. This
> used to be true, but gradual addition of features to the Arm
> target means that it's no longer true there. This results in
> the build-time assertion failing:
> 
> In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
>                  from /home/pm215/qemu/tcg/tcg.c:28:
> /home/pm215/qemu/tcg/mips/tcg-target.inc.c: In function ‘tcg_out_tlb_load’:
> /home/pm215/qemu/include/qemu/compiler.h:90:36: error: static assertion failed: "not expecting: offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1][1]) > 0x7ff0 + 0x7fff"
>  #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
>                                     ^
> /home/pm215/qemu/include/qemu/compiler.h:98:30: note: in expansion of macro ‘QEMU_BUILD_BUG_MSG’
>  #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
>                               ^
> /home/pm215/qemu/tcg/mips/tcg-target.inc.c:1236:9: note: in expansion of macro ‘QEMU_BUILD_BUG_ON’
>          QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
>          ^
> /home/pm215/qemu/rules.mak:66: recipe for target 'tcg/tcg.o' failed

Yes, I asked for help on this from the MIPS folks back in January when I posted
patches for ppc and arm(32) hosts.  And then of course forgot about it in the
interim.

> +    while (add_off >= 0x8000) {
> +        /* Most target env are smaller than 32k, but a few are larger than 64k,
> +         * so handle an arbitrarily large offset.
> +         */
>          tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, TCG_REG_A0, 0x7ff0);
>          cmp_off -= 0x7ff0;
>          add_off -= 0x7ff0;

This is a pretty darned good solution, really.  I should have thought of it
myself at the time.  The new AArch64 offset is about 80k, so there will be two
adds emitted.  Loading C<<16 into a temp register and then adding would be no
better in the end (one can only add C<<16 directly with mipsr6 extensions).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
