Received: from eggs.gnu.org ([2001:4830:134:3::10]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQi96-00085Y-Cq
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQi94-00077w-U9
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:15:00 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQi94-00077L-OD
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 18:14:58 -0500
Received: by mail-ot0-x241.google.com with SMTP id y10so11991429otg.10
	for <qemu-devel@nongnu.org>; Sun, 17 Dec 2017 15:14:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1513548172.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
	<cover.1513548172.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 17 Dec 2017 23:14:37 +0000
Message-ID: <CAFEAcA9qOtMtct6hND=uOiP_Nv9vaiuR=0NkSvrQQdz0v3FmfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/61] Trivial patches for 2017-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 17 December 2017 at 22:07, Michael Tokarev <mjt@tls.msk.ru> wrote:
>> Here's a large pull request for trivial-patches queue.
>> It's been quite a whie since the last request, and many
>> changes has been accumulated.
>>
>> Also there's a large patchset by Philippe Mathieu-Daud=C3=A9
>> named "remove i386/pc dependency from non-PC world (part 1)"
>> consisting of 42 patches which makes good portion of this
>> pull request.
>
> I forgot to add my S-o-b lines to the large series by
> Philippe Mathieu-Daud=C3=A9. So here's a re-send of just the
> cover letter (not all the other patches). The only difference
> is the addition of 42 of my "S-o-b" line.

I'm afraid this fails 'make check'. (I only tested the
first pullreq but if you only changed signoffs then
it'll still be the same):

TEST: tests/qom-test... (pid=3D12208)
  /alpha/qom/clipper:
Broken pipe
FAIL
GTester: last random seed: R02S26a31a16d967b2664ad714c1c7f8e7f1
(pid=3D12214)
  /alpha/qom/none:                                                     OK
FAIL: tests/qom-test
TEST: tests/test-hmp... (pid=3D12219)
  /alpha/hmp/clipper:
Broken pipe
FAIL
GTester: last random seed: R02S0c5a0f7de3fc6e9885b740c77c86eef2
(pid=3D12225)
  /alpha/hmp/none:                                                     OK
  /alpha/hmp/none+2MB:                                                 OK
FAIL: tests/test-hmp

This is because qemu-system-alpha segfaults on startup:

Thread 1 "qemu-system-alp" received signal SIGSEGV, Segmentation fault.
0x00005555557db414 in memory_region_update_container_subregions
(subregion=3D0x555556ad6330)
    at /home/petmay01/linaro/qemu-for-merges/memory.c:2290
2290        QTAILQ_INSERT_TAIL(&mr->subregions, subregion, subregions_link)=
;
(gdb) bt
#0  0x00005555557db414 in memory_region_update_container_subregions
(subregion=3D0x555556ad6330)
    at /home/petmay01/linaro/qemu-for-merges/memory.c:2290
#1  0x00005555557db4da in memory_region_add_subregion_common
(mr=3D0x5555569e2140, offset=3D32, subregion=3D0x555556ad6330)
    at /home/petmay01/linaro/qemu-for-merges/memory.c:2303
#2  0x00005555557db516 in memory_region_add_subregion
(mr=3D0x5555569e2140, offset=3D32, subregion=3D0x555556ad6330)
    at /home/petmay01/linaro/qemu-for-merges/memory.c:2311
#3  0x000055555594e8bd in isa_register_ioport (dev=3D0x555556ad6270,
io=3D0x555556ad6330, start=3D32)
    at /home/petmay01/linaro/qemu-for-merges/hw/isa/isa-bus.c:130
#4  0x000055555594b844 in pic_common_realize (dev=3D0x555556ad6270,
errp=3D0x7fffffffdaf0)
    at /home/petmay01/linaro/qemu-for-merges/hw/intc/i8259_common.c:77
#5  0x000055555594c744 in pic_realize (dev=3D0x555556ad6270, errp=3D0x7ffff=
fffdaf0)
    at /home/petmay01/linaro/qemu-for-merges/hw/intc/i8259.c:461
#6  0x00005555558f3d60 in device_set_realized (obj=3D0x555556ad6270,
value=3Dtrue, errp=3D0x7fffffffdc90)
    at /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:914
#7  0x0000555555ac188c in property_set_bool (obj=3D0x555556ad6270, v=3D
    0x555556ad6f20, name=3D0x555555d2271b "realized",
opaque=3D0x555556ad66a0, errp=3D0x7fffffffdc90)
    at /home/petmay01/linaro/qemu-for-merges/qom/object.c:1906
#8  0x0000555555abfc01 in object_property_set (obj=3D0x555556ad6270, v=3D
    0x555556ad6f20, name=3D0x555555d2271b "realized",
errp=3D0x7fffffffdc90) at
/home/petmay01/linaro/qemu-for-merges/qom/object.c:1102
#9  0x0000555555ac2bc9 in object_property_set_qobject
(obj=3D0x555556ad6270, value=3D0x555556ad6520, name=3D0x555555d2271b
"realized", errp=3D0x7fffffffdc90) at
/home/petmay01/linaro/qemu-for-merges/qom/qom-qobject.c:27
#10 0x0000555555abfe96 in object_property_set_bool
(obj=3D0x555556ad6270, value=3Dtrue, name=3D0x555555d2271b "realized",
errp=3D0x7fffffffdc90) at
/home/petmay01/linaro/qemu-for-merges/qom/object.c:1171
#11 0x00005555558f27a9 in qdev_init_nofail (dev=3D0x555556ad6270) at
/home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:338
#12 0x000055555594b984 in i8259_init_chip (name=3D0x555555d2c08c
"isa-i8259", bus=3D0x555556ad5550, master=3Dtrue)
    at /home/petmay01/linaro/qemu-for-merges/hw/intc/i8259_common.c:96
#13 0x000055555594c783 in i8259_init (bus=3D0x555556ad5550,
parent_irq=3D0x555556ad6050)
    at /home/petmay01/linaro/qemu-for-merges/hw/intc/i8259.c:473
#14 0x0000555555851873 in typhoon_init (ram_size=3D134217728,
isa_bus=3D0x7fffffffde08, p_rtc_irq=3D0x7fffffffde10, cpus=3D0x7fffffffdea0=
,
sys_map_irq=3D0x55555584f22a <clipper_pci_map_irq>) at
/home/petmay01/linaro/qemu-for-merges/hw/alpha/typhoon.c:925
#15 0x000055555584f3dd in clipper_init (machine=3D0x55555697b390) at
/home/petmay01/linaro/qemu-for-merges/hw/alpha/dp264.c:77
#16 0x00005555558fba0a in machine_run_board_init (machine=3D0x55555697b390)
    at /home/petmay01/linaro/qemu-for-merges/hw/core/machine.c:792
#17 0x000055555587ac3d in main (argc=3D1, argv=3D0x7fffffffe338,
envp=3D0x7fffffffe348) at
/home/petmay01/linaro/qemu-for-merges/vl.c:4708


There was also a minor merge conflict with the tpm pullreq
(both pulls change the #includes in hw/tpm/tpm_tis.c) which
you might fix when you respin.

thanks
-- PMM
