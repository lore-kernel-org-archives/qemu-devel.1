Received: from eggs.gnu.org ([2001:4830:134:3::10]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezMVH-0007rX-Ah
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezMVG-0003S9-Gm
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:13:07 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezMVG-0003Rf-9L
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:13:06 -0400
Received: by mail-ot0-x241.google.com with SMTP id m7-v6so13176396otd.1
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 06:13:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6750673e-ffc3-578e-e867-332ac0790935@redhat.com>
References: <1521794165-31678-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-KEnE9NKGC-vTnMByFC_LDPt2Ae8G7GfOxakfgMGH90w@mail.gmail.com>
	<6750673e-ffc3-578e-e867-332ac0790935@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 13:12:44 +0000
Message-ID: <CAFEAcA_u3cKF1aSHbrjW0Hc403G5GkNNom_9mqkJfregfqMymw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 23 March 2018 at 12:31, Thomas Huth <thuth@redhat.com> wrote:
> On 23.03.2018 10:56, Peter Maydell wrote:
>> On 23 March 2018 at 08:36, Thomas Huth <thuth@redhat.com> wrote:
>>> Most of the RISC-V boards currently crash when they are started with
>>> "-nodefaults", e.g.:
>>>
>>> $ gdb --args riscv32-softmmu/qemu-system-riscv32 -nodefaults -M sifive_=
e
>>> [...]
>>> (gdb) r
>>> Program received signal SIGSEGV, Segmentation fault.
>>> qemu_chr_fe_init ([...], s=3Ds@entry=3D0x0, [...])
>>>     at chardev/char-fe.c:210
>>> 210         } else if (s->be) {
>>> (gdb) bt
>>>  0  0x00005555558695f8 in qemu_chr_fe_init ([...], s=3Ds@entry=3D0x0, [=
...])
>>>     at chardev/char-fe.c:210
>>>  1  0x00005555556fb425 in sifive_uart_create ([...], chr=3D0x0, [...])
>>>     at hw/riscv/sifive_uart.c:169
>>>  2  0x00005555556f8cc4 in riscv_sifive_e_init (machine=3D[...])
>>>     at hw/riscv/sifive_e.c:164
>>>     [...]
>>>
>>> With "-nodefaults" there are no entries in serial_hds[], so qemu_chr_fe=
_init()
>>> finally tries to dereference a NULL pointer. Let's fix this problem by
>>> creating a "null" chardev in this case instead.
>>
>> Isn't it possible to fix this another level further down
>> by having qemu_chr_fe_init() &c handle having a NULL chardev?
>
> Not sure, ... I don't think that we should create a "null" device in
> chardev/char-fe.c - that would sound like a layer violation to me.

It already does treat a NULL Chardev* as being "do nothing"
most of the time: eg qemu_chr_fe_write(), qemu_chr_fe_read_all(),
qemu_chr_fe_ioctl(), qemu_chr_fe_set_handlers() &c all have
"if be->chr is NULL, do nothing" checks.

> So all we could do there is to set an error in "errp" or to simply
> "ignore" the NULL pointer (so that b->chr simply gets set to NULL here).

I think that the latter seems to be what the design intends:
a backend with a NULL chardev pointer is "backend with no
chardev attached at the moment". At least some of our UART devices
handle that as "just dump output into nothingness", which
seems logical to me.

Cc'ing Marc-Andr=C3=A9 and Paolo as the chardev maintainers --
do you have a plan for what the intended design here is?

thanks
-- PMM
