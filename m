Received: from eggs.gnu.org ([2001:4830:134:3::10]:36055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ezLr7-00049x-Bx
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ezLr4-0000RI-5V
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:31:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ezLr4-0000Qt-0c
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:31:34 -0400
References: <1521794165-31678-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-KEnE9NKGC-vTnMByFC_LDPt2Ae8G7GfOxakfgMGH90w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6750673e-ffc3-578e-e867-332ac0790935@redhat.com>
Date: Fri, 23 Mar 2018 13:31:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KEnE9NKGC-vTnMByFC_LDPt2Ae8G7GfOxakfgMGH90w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/riscv: Fix crashes with
 "-nodefaults"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 23.03.2018 10:56, Peter Maydell wrote:
> On 23 March 2018 at 08:36, Thomas Huth <thuth@redhat.com> wrote:
>> Most of the RISC-V boards currently crash when they are started with
>> "-nodefaults", e.g.:
>>
>> $ gdb --args riscv32-softmmu/qemu-system-riscv32 -nodefaults -M sifive=
_e
>> [...]
>> (gdb) r
>> Program received signal SIGSEGV, Segmentation fault.
>> qemu_chr_fe_init ([...], s=3Ds@entry=3D0x0, [...])
>>     at chardev/char-fe.c:210
>> 210         } else if (s->be) {
>> (gdb) bt
>>  0  0x00005555558695f8 in qemu_chr_fe_init ([...], s=3Ds@entry=3D0x0, =
[...])
>>     at chardev/char-fe.c:210
>>  1  0x00005555556fb425 in sifive_uart_create ([...], chr=3D0x0, [...])
>>     at hw/riscv/sifive_uart.c:169
>>  2  0x00005555556f8cc4 in riscv_sifive_e_init (machine=3D[...])
>>     at hw/riscv/sifive_e.c:164
>>     [...]
>>
>> With "-nodefaults" there are no entries in serial_hds[], so qemu_chr_f=
e_init()
>> finally tries to dereference a NULL pointer. Let's fix this problem by
>> creating a "null" chardev in this case instead.
>=20
> Isn't it possible to fix this another level further down
> by having qemu_chr_fe_init() &c handle having a NULL chardev?

Not sure, ... I don't think that we should create a "null" device in
chardev/char-fe.c - that would sound like a layer violation to me.

So all we could do there is to set an error in "errp" or to simply
"ignore" the NULL pointer (so that b->chr simply gets set to NULL here).

In the first case, we'd run into abort()s instead, since lots of caller
call this function with errp =3D &error_abort. So that does also not soun=
d
very user-friendly (unless we change the error_aborts into error_fatals
maybe).

In the second case, QEMU seems either bails out later in serial_mm_init
(when calling serial_realize_core()) with:

$ riscv32-softmmu/qemu-system-riscv32 -nodefaults -M virt
qemu-system-riscv32: Can't create serial device, empty char device

... or it seems to start in case of the other riscv machines. Not sure
whether we can trust all the remaining functions to deal correctly with
a NULL pointer in b->chr here though... I guess we could try and find
out later where there are other crashes in that case.

Opinions?

> That would be nicer than requiring every UART model to handle
> it, because inevitably people will forget about that corner case.

At least we need some more automatic qtest coverage here... (e.g.
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05033.html)

 Thomas
