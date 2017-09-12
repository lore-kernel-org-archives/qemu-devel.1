Received: from eggs.gnu.org ([2001:4830:134:3::10]:37533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmtT-0000my-El
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmtQ-0005e8-7R
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drmtQ-0005aP-2D
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:14:28 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
	<cff16e31-4be0-9665-62d7-88a12b6d0b56@weilnetz.de>
	<15608989-cb43-a522-9a7d-b57b3a393155@weilnetz.de>
	<abc99a4a-1386-2757-e605-f10d0afe6b3e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a90999d-6f79-cbd4-aaba-a6cd425980c6@redhat.com>
Date: Tue, 12 Sep 2017 17:13:56 +0200
MIME-Version: 1.0
In-Reply-To: <abc99a4a-1386-2757-e605-f10d0afe6b3e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

On 12/09/2017 16:56, Thomas Huth wrote:
> The problem is that the SLOF firmware just performs very badly with TCG
> (it's fine on real hardware). It executes a lot of Forth code, and the
> Forth interpreter uses things like computed gotos or other tricks that
> basically prevent proper JIT operation here. I've done quite a bit of
> optimizations in SLOF in the past already, but I've got hardly any idea=
s
> left how to fix that further.

Two ideas for QEMU based on a quick "perf record" test:

- 25% of the time is spent in cpu_exec.  PPC doesn't use
tcg_gen_lookup_and_goto_ptr.  The main thing to be careful about is
that, whenever an interrupt is pending (e.g. after enabling them) you
need to force an exit to the loop.  See for example commits b29fd33db5
("target/arm: use DISAS_EXIT for eret handling", 2017-07-17) and
b74cddcbf6 ("target/mips: Use BS_EXCP where interrupts are expected",
2017-08-02).  On PPC this mostly means SPRs and env->msr writes.  Apart
from this, however, it shouldn't be hard to do.

- 8% of the time is spend in cpu_exec's call to
object_class_dynamic_cast_assert aka this line

    CPUClass *cc =3D CPU_GET_CLASS(cpu);

This maybe could avoid the dynamic cast.  But it's also possible that
fixing the first gets rid of this one too.

Thanks,

Paolo
