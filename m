Received: from eggs.gnu.org ([2001:4830:134:3::10]:37542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGNd8-0006uF-3I
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGNd5-0002Rb-2o
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:51:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fGNd4-0002Pv-TW
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:51:30 -0400
References: <fe42db47-7e7c-3ec5-ab5f-8e8653554a74@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4082565-98f0-7bd7-4409-45af9d8823fb@redhat.com>
Date: Wed, 9 May 2018 13:51:26 +0200
MIME-Version: 1.0
In-Reply-To: <fe42db47-7e7c-3ec5-ab5f-8e8653554a74@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] lm32: tcg_handle_interrupt: assertion failed:
 (qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Walle <michael@walle.cc>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 08/05/2018 03:49, Philippe Mathieu-Daud=C3=A9 wrote:
> #2  0x00007fe17d5eefa5 in g_assertion_message () at
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #3  0x00007fe17d5ef00a in g_assertion_message_expr () at
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #4  0x0000559d92ace7d5 in tcg_handle_interrupt (cpu=3D0x559d93aa35d0,
> mask=3D2) at qemu/accel/tcg/tcg-all.c:42
> #5  0x0000559d92af1b3c in cpu_interrupt (cpu=3D0x559d93aa35d0, mask=3D2=
) at
> qemu/include/qom/cpu.h:848
> #6  0x0000559d92af2516 in cpu_irq_handler (opaque=3D0x559d93aa35d0, irq=
=3D0,
> level=3D1) at qemu/hw/lm32/milkymist.c:59
> #7  0x0000559d92b6639d in qemu_set_irq (irq=3D0x559d93a0f250, level=3D1=
) at
> qemu/hw/core/irq.c:45
> #8  0x0000559d92b76d5f in qemu_irq_raise (irq=3D0x559d93a0f250) at
> qemu/include/hw/irq.h:16
> #9  0x0000559d92b7723e in update_irq (s=3D0x559d93adba00) at
> qemu/hw/intc/lm32_pic.c:51
> #10 0x0000559d92b7738e in lm32_pic_set_im (d=3D0x559d93adba00, im=3D1) =
at
> qemu/hw/intc/lm32_pic.c:82
> #11 0x0000559d92af72e0 in helper_wcsr_im (env=3D0x559d93aab870, im=3D1)=
 at
> qemu/target/lm32/op_helper.c:105
> #12 0x00007fe155e250ca in code_gen_buffer ()
> #13 0x0000559d92adec8e in cpu_tb_exec (cpu=3D0x559d93aa35d0,
> itb=3D0x7fe155e24fc0 <code_gen_buffer+49043>)

All these calls into lm32_pic.c need to take the BQL.  They are all
wrong, but this one was unlucky (or lucky) enough to be caught.

Paolo
