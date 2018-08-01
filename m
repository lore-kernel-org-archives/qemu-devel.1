Received: from eggs.gnu.org ([2001:4830:134:3::10]:46127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fku9n-0005EQ-3b
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fku9l-0006i1-Qb
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:39:27 -0400
References: <20180801132733.15628-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8dd02a8d-093f-5592-d4ee-50cc4fba6de9@redhat.com>
Date: Wed, 1 Aug 2018 18:39:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180801132733.15628-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] tests: virtio: separate ccw
 tests from libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, e.emanuelegiuseppe@gmail.com

On 08/01/2018 03:27 PM, Paolo Bonzini wrote:
> Because qtest does not support s390 channel I/O, s390 only performs smo=
ke tests on
> those few devices that do not have any functional tests.  Therefore, ev=
ery time we
> add functional tests for a virtio device, the choice is between removin=
g
> those tests from the s390 suite (so that s390 actually _loses_ coverage=
)
> or sprinkling the test with architecture checks.
>=20
> This patch simply creates a ccw-specific test that only performs smoke =
tests on
> all virtio-ccw devices.  If channel I/O support is ever added to qtest =
and libqos,
> then this file can go away.  In the meanwhile, it simplifies maintenanc=
e and
> makes sure that all virtio devices are tested.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/Makefile.include  |   5 +-
>  tests/virtio-ccw-test.c | 118 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+), 3 deletions(-)
>  create mode 100644 tests/virtio-ccw-test.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a49282704e..cf835f2fd0 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -401,9 +401,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/test-n=
etfilter$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESU=
F)
>  check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(E=
XESUF)
>  check-qtest-s390x-y +=3D tests/drive_del-test$(EXESUF)
> -check-qtest-s390x-y +=3D tests/virtio-balloon-test$(EXESUF)
> -check-qtest-s390x-y +=3D tests/virtio-console-test$(EXESUF)
> -check-qtest-s390x-y +=3D tests/virtio-serial-test$(EXESUF)
> +check-qtest-s390x-y +=3D tests/virtio-ccw-test$(EXESUF)
>  check-qtest-s390x-y +=3D tests/cpu-plug-test$(EXESUF)
> =20
>  check-qtest-generic-y +=3D tests/machine-none-test$(EXESUF)
> @@ -807,6 +805,7 @@ tests/wdt_ib700-test$(EXESUF): tests/wdt_ib700-test=
.o
>  tests/tco-test$(EXESUF): tests/tco-test.o $(libqos-pc-obj-y)
>  tests/virtio-balloon-test$(EXESUF): tests/virtio-balloon-test.o $(libq=
os-virtio-obj-y)
>  tests/virtio-blk-test$(EXESUF): tests/virtio-blk-test.o $(libqos-virti=
o-obj-y)
> +tests/virtio-ccw-test$(EXESUF): tests/virtio-ccw-test.o
>  tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-ob=
j-y) $(libqos-virtio-obj-y)
>  tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-ob=
j-y)
>  tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-vir=
tio-obj-y)
> diff --git a/tests/virtio-ccw-test.c b/tests/virtio-ccw-test.c
> new file mode 100644
> index 0000000000..0af3a7bb31
> --- /dev/null
> +++ b/tests/virtio-ccw-test.c
> @@ -0,0 +1,118 @@
> +/*
> + * QTest testcase for VirtIO CCW
> + *
> + * Copyright (c) 2014 SUSE LINUX Products GmbH
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +/* Until we have a full libqos implementation of virtio-ccw (which req=
uires
> + * also to add support for I/O channels to qtest), we can only do simp=
le
> + * tests that initialize the devices.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/virtio.h"
> +
> +static void virtio_balloon_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-balloon-ccw");
> +    qtest_end();
> +}
> +
> +static void virtconsole_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-serial-ccw,id=3Dvser=
0 "
> +                                "-device virtconsole,bus=3Dvser0.0");
> +    qtest_end();
> +}
> +
> +static void virtserialport_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-serial-ccw,id=3Dvser=
0 "
> +                                "-device virtserialport,bus=3Dvser0.0"=
);
> +    qtest_end();
> +}
> +
> +static void virtio_serial_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-serial-ccw");
> +    qtest_end();
> +}
> +
> +static void virtio_serial_hotplug(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-serial-ccw");
> +    qtest_qmp_device_add("virtserialport", "hp-port", NULL);
> +    qtest_qmp_device_del("hp-port");
> +    qtest_end();
> +}
> +
> +static void virtio_blk_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-drive if=3Dnone,id=3Ddrv0,file=3Dn=
ull-co://,format=3Draw "
> +                                "-device virtio-blk-ccw,drive=3Ddrv0")=
;
> +    qtest_end();
> +}
> +
> +static void virtio_net_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-net-ccw");
> +    qtest_end();
> +}
> +
> +static void virtio_9p_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-fsdev synth,id=3Dfsdev0 "
> +                                "-device virtio-9p-ccw,fsdev=3Dfsdev0,=
mount_tag=3Dqtest");
> +    qtest_end();
> +}
> +
> +static void virtio_rng_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-rng-ccw");
> +    qtest_end();
> +}
> +
> +static void virtio_scsi_nop(void)
> +{
> +    global_qtest =3D qtest_startf("-device virtio-scsi-ccw");
> +    qtest_end();
> +}
> +
> +static void virtio_scsi_hotplug(void)
> +{
> +    global_qtest =3D qtest_startf("-drive if=3Dnone,id=3Ddrv0,file=3Dn=
ull-co://,format=3Draw "
> +                                "-drive if=3Dnone,id=3Ddrv1,file=3Dnul=
l-co://,format=3Draw "
> +                                "-device virtio-scsi-ccw "
> +                                "-device scsi-hd,drive=3Ddrv0");
> +    qtest_qmp_device_add("scsi-hd", "scsihd", "'drive': 'drv1'");
> +    qtest_qmp_device_del("scsihd");
> +
> +    qtest_end();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/virtio/balloon/nop", virtio_balloon_nop);
> +    qtest_add_func("/virtio/console/nop", virtconsole_nop);
> +    qtest_add_func("/virtio/serialport/nop", virtserialport_nop);
> +    qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
> +    qtest_add_func("/virtio/serial/hotplug", virtio_serial_hotplug);
> +    qtest_add_func("/virtio/block/nop", virtio_blk_nop);
> +    qtest_add_func("/virtio/net/nop", virtio_net_nop);
> +    qtest_add_func("/virtio/9p/nop", virtio_9p_nop);
> +    qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
> +    qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
> +    qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
> +
> +    ret =3D g_test_run();
> +
> +    return ret;
> +}

I think you could omit the virtio_net_nop test here, since we already
check that device in tests/pxe-test.c (and maybe also virtio_blk and
virtio_scsi since they are tested in tests/cdrom-test.c).

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
