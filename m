Received: from eggs.gnu.org ([2001:4830:134:3::10]:46029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD8LE-0001I8-69
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD8LD-00046W-4H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:27:56 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD8LC-00044G-Nq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:27:55 -0400
Received: by mail-oi1-x241.google.com with SMTP id e17-v6so23967123oig.12
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:27:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a11adc0b-4737-f270-0cd1-1390239c00a5@redhat.com>
References: <20181018130434.23237-1-philmd@redhat.com>
	<20181018130434.23237-4-philmd@redhat.com>
	<CAFEAcA-p21K3nbCUL0Hi=cBhqpPmQaHUXrUpEFuWFL+thgJoSg@mail.gmail.com>
	<a11adc0b-4737-f270-0cd1-1390239c00a5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 14:27:33 +0100
Message-ID: <CAFEAcA8T4mN33XznhU3EZHo43KKFLdNw57yXOStmGdhqkU1ZmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, QEMU Developers <qemu-devel@nongnu.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>

On 18 October 2018 at 14:19, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 18/10/2018 15:08, Peter Maydell wrote:
>> This field is the parent-type for the QOM object, so I don't
>> think it makes sense for it to be a union. Any one QOM object
>> should have a single distinct parent type. (There are other
>> examples of "some more or less similar device has ISA and
>> SysBus or PCI and SysBus variations" which should provide
>> some models to copy from.

> So to avoid union, I have to use:
>
>     typedef struct PVPanicCommonState {
>         MemoryRegion mr;
>         uint16_t ioport;
>     } PVPanicCommonState;
>
>     typedef struct PVPanicISAState {
>         /*< private >*/
>         ISADevice isadev;
>
>         /*< public >*/
>         PVPanicCommonState common;
>     } PVPanicISAState;
>
>     #define PVPANIC_ISA(obj)    \
>         OBJECT_CHECK(PVPanicISAState, (obj), TYPE_PVPANIC)
>
>     typedef struct PVPanicMMIOState {
>         /*< private >*/
>         SysBusDevice busdev;
>
>         /*< public >*/
>         PVPanicCommonState common;
>     } PVPanicMMIOState;
>
>     #define PVPANIC_MMIO(obj)    \
>         OBJECT_CHECK(PVPanicMMIOState, (obj), TYPE_PVPANIC)
>

Something like that, I think. Basically you have two
distinct types, an ISA PVPanic and a SysBus PVPanic,
which have straightforward inheritance (the ISA PVPanic
is-a ISADevice, the SysBus PVPanic is-a SysBusdevice).
Both have-a PVPanic common state.

See eg hw/display/sm501.c, or hw/net/ne2000{,-isa}.c.

thanks
-- PMM
