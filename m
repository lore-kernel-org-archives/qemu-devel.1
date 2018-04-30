Received: from eggs.gnu.org ([2001:4830:134:3::10]:40047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDCqe-0007Nj-4U
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDCqY-0007Nc-PJ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:44:24 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:45883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDCqY-0007NI-Gu
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:44:18 -0400
Received: by mail-wr0-x22f.google.com with SMTP id p5-v6so8795095wre.12
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:44:18 -0700 (PDT)
References: <20180413142336.32163-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180413142336.32163-1-peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 18:44:15 +0100
Message-ID: <87k1so4mj4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> The MIPS TCG target makes the assumption that the offset from the
> target env pointer to the tlb_table is less than about 64K. This
> used to be true, but gradual addition of features to the Arm
> target means that it's no longer true there. This results in
> the build-time assertion failing:
>
> In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
>                  from /home/pm215/qemu/tcg/tcg.c:28:
> /home/pm215/qemu/tcg/mips/tcg-target.inc.c: In function =E2=80=98tcg_out_=
tlb_load=E2=80=99:
> /home/pm215/qemu/include/qemu/compiler.h:90:36: error: static assertion f=
ailed: "not expecting: offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1][1=
]) > 0x7ff0 + 0x7fff"
>  #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
>                                     ^
> /home/pm215/qemu/include/qemu/compiler.h:98:30: note: in expansion of mac=
ro =E2=80=98QEMU_BUILD_BUG_MSG=E2=80=99
>  #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
>                               ^
> /home/pm215/qemu/tcg/mips/tcg-target.inc.c:1236:9: note: in expansion of =
macro =E2=80=98QEMU_BUILD_BUG_ON=E2=80=99
>          QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
>          ^
> /home/pm215/qemu/rules.mak:66: recipe for target 'tcg/tcg.o' failed
>
> An ideal long term approach would be to rearrange the CPU state
> so that the tlb_table was not so far along it, but this is tricky
> because it would move it from the "not cleared on CPU reset" part
> of the struct to the "cleared on CPU reset" part.

Is that really a problem? Doesn't it mean we'll just reload the TLB
after a reset?

--
Alex Benn=C3=A9e
