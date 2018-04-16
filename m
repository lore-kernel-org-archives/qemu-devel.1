Received: from eggs.gnu.org ([2001:4830:134:3::10]:56720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f859e-0005Zm-Gf
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f859d-0006ea-H0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:30:50 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f859d-0006eM-CI
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:30:49 -0400
Received: by mail-ot0-x243.google.com with SMTP id p33-v6so17556668otp.11
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:30:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e879b530-1e00-6b58-7e23-eb8e76f7bfa4@twiddle.net>
References: <20180413142336.32163-1-peter.maydell@linaro.org>
	<e879b530-1e00-6b58-7e23-eb8e76f7bfa4@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 15:30:28 +0100
Message-ID: <CAFEAcA90-LDMEBHhntTrtLxvjTPN17C1fZhOZ2ttB3jCg4LvwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 13 April 2018 at 20:09, Richard Henderson <rth@twiddle.net> wrote:
> On 04/13/2018 04:23 AM, Peter Maydell wrote:
>> The MIPS TCG target makes the assumption that the offset from the
>> target env pointer to the tlb_table is less than about 64K. This
>> used to be true, but gradual addition of features to the Arm
>> target means that it's no longer true there. This results in
>> the build-time assertion failing:
>>
>> In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
>>                  from /home/pm215/qemu/tcg/tcg.c:28:
>> /home/pm215/qemu/tcg/mips/tcg-target.inc.c: In function =E2=80=98tcg_out=
_tlb_load=E2=80=99:
>> /home/pm215/qemu/include/qemu/compiler.h:90:36: error: static assertion =
failed: "not expecting: offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1][=
1]) > 0x7ff0 + 0x7fff"
>>  #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
>>                                     ^
>> /home/pm215/qemu/include/qemu/compiler.h:98:30: note: in expansion of ma=
cro =E2=80=98QEMU_BUILD_BUG_MSG=E2=80=99
>>  #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x=
)
>>                               ^
>> /home/pm215/qemu/tcg/mips/tcg-target.inc.c:1236:9: note: in expansion of=
 macro =E2=80=98QEMU_BUILD_BUG_ON=E2=80=99
>>          QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
>>          ^
>> /home/pm215/qemu/rules.mak:66: recipe for target 'tcg/tcg.o' failed
>
> Yes, I asked for help on this from the MIPS folks back in January when I =
posted
> patches for ppc and arm(32) hosts.  And then of course forgot about it in=
 the
> interim.
>
>> +    while (add_off >=3D 0x8000) {
>> +        /* Most target env are smaller than 32k, but a few are larger t=
han 64k,
>> +         * so handle an arbitrarily large offset.
>> +         */
>>          tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, TCG_REG_A0, 0x7ff0)=
;
>>          cmp_off -=3D 0x7ff0;
>>          add_off -=3D 0x7ff0;
>
> This is a pretty darned good solution, really.  I should have thought of =
it
> myself at the time.  The new AArch64 offset is about 80k, so there will b=
e two
> adds emitted.  Loading C<<16 into a temp register and then adding would b=
e no
> better in the end (one can only add C<<16 directly with mipsr6 extensions=
).
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; applied to master.

-- PMM
