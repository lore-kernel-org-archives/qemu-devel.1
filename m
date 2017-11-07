Received: from eggs.gnu.org ([2001:4830:134:3::10]:54284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC2GA-0005Eq-3h
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC2G9-0001eP-5W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:41:38 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:47525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC2G8-0001dz-Uf
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:41:37 -0500
Received: by mail-wr0-x244.google.com with SMTP id k61so5736229wrc.4
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 03:41:36 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 11:41:14 +0000
Message-ID: <CAFEAcA_krUaWG_EyyRM84znrYEFOhj2xtNgNpnxaUxMU4-EUCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] target-s390x: assertion failure in op_risbg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

This is from https://bugs.launchpad.net/qemu/+bug/1701798, but
that's quite a large thing, so here's the s390 specific part.

On an ubuntu xenial install:

$ apt install g++-5-s390x-linux-gnu
$ cat hello.c
#include <stdio.h>
int main(void) {
    printf("hello world\n");
    return 0;
}
$ s390x-linux-gnu-gcc-5 -O hello.c -o hello.s390x
$ QEMU_LD_PREFIX=/usr/s390x-linux-gnu/ gdb --args
~/linaro/qemu-from-laptop/qemu/build/all-linux-static/s390x-linux-user/qemu-s390x
./hello.s390x
[...]
(gdb) r
[...]
Thread 1 "qemu-s390x" received signal SIGABRT, Aborted.
0x0000000060215018 in raise ()
(gdb) bt
#0  0x0000000060215018 in raise ()
#1  0x000000006021573a in abort ()
#2  0x0000000060079a96 in op_risbg (s=0x7fffffffda10, o=0x7fffffffd950)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c:3450
#3  0x0000000060082c8b in translate_one (env=0x627f0350, s=0x7fffffffda10)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c:5824
#4  0x0000000060082f3f in gen_intermediate_code (cs=0x627e80b0,
    tb=0x60794d40 <static_code_gen_buffer+56064>)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c:5925
#5  0x00000000600369aa in tb_gen_code (cpu=0x627e80b0, pc=274886359240,
    cs_base=0, flags=3, cflags=0)

This is because in op_risbg() we abort() if s->fields->op2 is not
one of 0x55, 0x5d, 0x51. In this case it is 0x59. I don't know enough
s390 to know what this might be, but we shouldn't really abort()
inside QEMU for unimplemented guest insns.

(if you let execution continue, or don't run in a debugger then
linux-user does its usual thing of obfuscating failures inside QEMU
and then runs into a different assert due to trying to take the tb
lock inside cpu_restore_state().)

thanks
-- PMM
