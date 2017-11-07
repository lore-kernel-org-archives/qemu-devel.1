Received: from eggs.gnu.org ([2001:4830:134:3::10]:36922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eC2ll-0004Fp-Nx
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eC2ld-000800-KL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:14:17 -0500
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:48154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eC2ld-0007zG-CY
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:14:09 -0500
Received: by mail-lf0-x22e.google.com with SMTP id r135so14213774lfe.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 04:14:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA_krUaWG_EyyRM84znrYEFOhj2xtNgNpnxaUxMU4-EUCQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f84b877e-c6af-2999-533e-5946086d589f@twiddle.net>
Date: Tue, 7 Nov 2017 13:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_krUaWG_EyyRM84znrYEFOhj2xtNgNpnxaUxMU4-EUCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] target-s390x: assertion failure in op_risbg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>

On 11/07/2017 12:41 PM, Peter Maydell wrote:
> This is from https://bugs.launchpad.net/qemu/+bug/1701798, but
> that's quite a large thing, so here's the s390 specific part.
> 
> On an ubuntu xenial install:
> 
> $ apt install g++-5-s390x-linux-gnu
> $ cat hello.c
> #include <stdio.h>
> int main(void) {
>     printf("hello world\n");
>     return 0;
> }
> $ s390x-linux-gnu-gcc-5 -O hello.c -o hello.s390x
> $ QEMU_LD_PREFIX=/usr/s390x-linux-gnu/ gdb --args
> ~/linaro/qemu-from-laptop/qemu/build/all-linux-static/s390x-linux-user/qemu-s390x
> ./hello.s390x
> [...]
> (gdb) r
> [...]
> Thread 1 "qemu-s390x" received signal SIGABRT, Aborted.
> 0x0000000060215018 in raise ()
> (gdb) bt
> #0  0x0000000060215018 in raise ()
> #1  0x000000006021573a in abort ()
> #2  0x0000000060079a96 in op_risbg (s=0x7fffffffda10, o=0x7fffffffd950)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c:3450
> #3  0x0000000060082c8b in translate_one (env=0x627f0350, s=0x7fffffffda10)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c:5824
> #4  0x0000000060082f3f in gen_intermediate_code (cs=0x627e80b0,
>     tb=0x60794d40 <static_code_gen_buffer+56064>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c:5925
> #5  0x00000000600369aa in tb_gen_code (cpu=0x627e80b0, pc=274886359240,
>     cs_base=0, flags=3, cflags=0)
> 
> This is because in op_risbg() we abort() if s->fields->op2 is not
> one of 0x55, 0x5d, 0x51. In this case it is 0x59. I don't know enough
> s390 to know what this might be, but we shouldn't really abort()
> inside QEMU for unimplemented guest insns.

Like aarch64, we abort not for completely unknown/unimplemented guest insns,
but when we're in a state that we didn't expect.  Truely unknown insns are
filtered earlier.

That we got here suggests there's an entry in insn-data.def, but I failed to
fill in all of the blanks.  Which for this case is fairly brown-bag-worthy.


r~
