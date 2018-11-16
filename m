Received: from eggs.gnu.org ([2001:4830:134:3::10]:59540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNgfG-00063B-S1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNgfF-0000qA-TB
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:08:14 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNgfE-0000p1-Ry
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:08:13 -0500
Received: by mail-oi1-x243.google.com with SMTP id r127-v6so20041923oie.3
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 08:08:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 16:07:50 +0000
Message-ID: <CAFEAcA-kdvXHxG-Uf8hs5eZ9VLEPOjC9-=9uOUnZ5KEvK7HKFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/14] arm: nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 12 November 2018 at 21:42, Steffen G=C3=B6rtz <contrib@steffen-goertz.de=
> wrote:
> This series contains additional peripheral devices for the nRF51822
> microcontroller.
>
> Included devices:
> - Random Number Generator
> - Non-volatile Memories
> - General purpose I/O
> - Timer
> - Stub for clock peripheral
>
> v5:

Hi; if I apply this patchset and run "make check" I get a
test failure where QEMU segfaults:

TEST: tests/device-introspect-test... (pid=3D16982)
  /arm/device/introspect/list:                                         OK
  /arm/device/introspect/list-fields:                                  OK
  /arm/device/introspect/none:                                         OK
  /arm/device/introspect/abstract:                                     OK
  /arm/device/introspect/abstract-interfaces:                          OK
  /arm/device/introspect/concrete/defaults/none:
Broken pipe
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/libqtest.c:125:
kill_qemu() detected QEMU death from signal 11 (Segmentation fault)
(core dumped)
FAIL
GTester: last random seed: R02Sf08c9db2414e3ce0bd5246714a0b952c
(pid=3D16997)
FAIL: tests/device-introspect-test

This is the test which tries to instantiate and delete every
kind of device in the system, and something is going wrong
when it tries to do this for your devices. You can run the
test under valgrind like this:

QTEST_QEMU_BINARY=3D'valgrind arm-softmmu/qemu-system-arm'
tests/device-introspect-test -p
/arm/device/introspect/concrete/defaults/none

(you need to run that from the build directory).

That tells us that the problem is:

=3D=3D17507=3D=3D Invalid read of size 8
=3D=3D17507=3D=3D    at 0x9484A9: object_get_canonical_path_component (obje=
ct.c:1710)
=3D=3D17507=3D=3D    by 0x636637: print_qom_composition (qdev-monitor.c:777=
)
=3D=3D17507=3D=3D    by 0x6365D4: print_qom_composition_child (qdev-monitor=
.c:761)
=3D=3D17507=3D=3D    by 0x9466CB: do_object_child_foreach (object.c:913)
=3D=3D17507=3D=3D    by 0x946755: object_child_foreach (object.c:928)
=3D=3D17507=3D=3D    by 0x636699: print_qom_composition (qdev-monitor.c:782=
)
=3D=3D17507=3D=3D    by 0x6365D4: print_qom_composition_child (qdev-monitor=
.c:761)
=3D=3D17507=3D=3D    by 0x9466CB: do_object_child_foreach (object.c:913)
=3D=3D17507=3D=3D    by 0x946755: object_child_foreach (object.c:928)
=3D=3D17507=3D=3D    by 0x636699: print_qom_composition (qdev-monitor.c:782=
)
=3D=3D17507=3D=3D    by 0x636774: hmp_info_qom_tree (qdev-monitor.c:804)
=3D=3D17507=3D=3D    by 0x43FE9B: handle_hmp_command (monitor.c:3415)
=3D=3D17507=3D=3D  Address 0x3060c8b0 is 1,056 bytes inside a block of size=
 2,032 free'd
=3D=3D17507=3D=3D    at 0x4C2EDEB: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D17507=3D=3D    by 0x9459EE: object_finalize (object.c:541)
=3D=3D17507=3D=3D    by 0x946916: object_unref (object.c:985)
=3D=3D17507=3D=3D    by 0x65E8D8: qmp_device_list_properties (qmp.c:548)
=3D=3D17507=3D=3D    by 0x65571D: qmp_marshal_device_list_properties
(qapi-commands-misc.c:1441)
=3D=3D17507=3D=3D    by 0xA762BC: do_qmp_dispatch (qmp-dispatch.c:129)
=3D=3D17507=3D=3D    by 0xA76483: qmp_dispatch (qmp-dispatch.c:171)
=3D=3D17507=3D=3D    by 0x441A04: monitor_qmp_dispatch (monitor.c:4085)
=3D=3D17507=3D=3D    by 0x441D24: monitor_qmp_bh_dispatcher (monitor.c:4157=
)
=3D=3D17507=3D=3D    by 0xA85B2A: aio_bh_call (async.c:90)
=3D=3D17507=3D=3D    by 0xA85BC2: aio_bh_poll (async.c:118)
=3D=3D17507=3D=3D    by 0xA8A946: aio_dispatch (aio-posix.c:440)
=3D=3D17507=3D=3D  Block was alloc'd at
=3D=3D17507=3D=3D    at 0x4C2DB8F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D17507=3D=3D    by 0x7A337B8: g_malloc (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
=3D=3D17507=3D=3D    by 0x945A44: object_new_with_type (object.c:552)
=3D=3D17507=3D=3D    by 0x945AA0: object_new (object.c:563)
=3D=3D17507=3D=3D    by 0x65E783: qmp_device_list_properties (qmp.c:513)
=3D=3D17507=3D=3D    by 0x65571D: qmp_marshal_device_list_properties
(qapi-commands-misc.c:1441)
=3D=3D17507=3D=3D    by 0xA762BC: do_qmp_dispatch (qmp-dispatch.c:129)
=3D=3D17507=3D=3D    by 0xA76483: qmp_dispatch (qmp-dispatch.c:171)
=3D=3D17507=3D=3D    by 0x441A04: monitor_qmp_dispatch (monitor.c:4085)
=3D=3D17507=3D=3D    by 0x441D24: monitor_qmp_bh_dispatcher (monitor.c:4157=
)
=3D=3D17507=3D=3D    by 0xA85B2A: aio_bh_call (async.c:90)
=3D=3D17507=3D=3D    by 0xA85BC2: aio_bh_poll (async.c:118)


which is to say that we decremented the reference count of
an object to 0, thus freeing it, but did not disconnect it
from the QOM tree first, so the next time we tried to look
through everything on the QOM tree we ran into freed memory.

Running the test with QTEST_LOG=3D1 lets us look at what device
the test harness was working on when it crashed, which is
"nrf51_soc.nvm", and then we can look more closely at the
instance-init routine of that device.

The crash turns out to be because some of your calls to
memory_region_init_io() in nrf51_nvm_init() pass a NULL pointer
as the owner, rather than 'obj', which means that the memory
regions aren't cleaned up when the device is.

thanks
-- PMM
