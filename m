Received: from eggs.gnu.org ([2001:4830:134:3::10]:59536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eC2YL-0000vz-HJ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eC2YH-0001b6-DL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:00:25 -0500
References: <CAFEAcA_krUaWG_EyyRM84znrYEFOhj2xtNgNpnxaUxMU4-EUCQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a04d2a2-98cc-5ef7-ace4-6836a1c9ec94@redhat.com>
Date: Tue, 7 Nov 2017 13:00:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_krUaWG_EyyRM84znrYEFOhj2xtNgNpnxaUxMU4-EUCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org

On 07.11.2017 12:41, Peter Maydell wrote:
> This is from https://bugs.launchpad.net/qemu/+bug/1701798, but
> that's quite a large thing, so here's the s390 specific part.
>=20
> On an ubuntu xenial install:
>=20
> $ apt install g++-5-s390x-linux-gnu
> $ cat hello.c
> #include <stdio.h>
> int main(void) {
>     printf("hello world\n");
>     return 0;
> }
> $ s390x-linux-gnu-gcc-5 -O hello.c -o hello.s390x
> $ QEMU_LD_PREFIX=3D/usr/s390x-linux-gnu/ gdb --args
> ~/linaro/qemu-from-laptop/qemu/build/all-linux-static/s390x-linux-user/=
qemu-s390x
> ./hello.s390x
> [...]
> (gdb) r
> [...]
> Thread 1 "qemu-s390x" received signal SIGABRT, Aborted.
> 0x0000000060215018 in raise ()
> (gdb) bt
> #0  0x0000000060215018 in raise ()
> #1  0x000000006021573a in abort ()
> #2  0x0000000060079a96 in op_risbg (s=3D0x7fffffffda10, o=3D0x7fffffffd=
950)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/transla=
te.c:3450
> #3  0x0000000060082c8b in translate_one (env=3D0x627f0350, s=3D0x7fffff=
ffda10)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/transla=
te.c:5824
> #4  0x0000000060082f3f in gen_intermediate_code (cs=3D0x627e80b0,
>     tb=3D0x60794d40 <static_code_gen_buffer+56064>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/transla=
te.c:5925
> #5  0x00000000600369aa in tb_gen_code (cpu=3D0x627e80b0, pc=3D274886359=
240,
>     cs_base=3D0, flags=3D3, cflags=3D0)
>=20
> This is because in op_risbg() we abort() if s->fields->op2 is not
> one of 0x55, 0x5d, 0x51. In this case it is 0x59. I don't know enough
> s390 to know what this might be, but we shouldn't really abort()
> inside QEMU for unimplemented guest insns.

If I've got the spec right, the 0x59 here means that it is a "new"
instruction called RISBGN which we do not support in QEMU yet. Instead
of calling abort(), the correct behavior for unsupported instructions
here is to generate a "operation" exception. Or even better: Implement
the instruction. If I've got the spec right, it's doing the same as
RISBG (with subcode 0x55), but just does not set the condition code at
the end, so this should be quite easy to implement?

 Thomas
