Received: from eggs.gnu.org ([2001:4830:134:3::10]:38602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAZsg-00009K-DJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAZsa-0005LJ-6C
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:15:54 -0400
References: <20180702111737.18970-1-cohuck@redhat.com>
	<20180702111737.18970-7-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fffba8cf-cc67-b9ba-f2cc-16b6738c1f15@redhat.com>
Date: Thu, 11 Oct 2018 14:15:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180702111737.18970-7-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 06/15] s390x/tod: factor out
 TOD into separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On 2018-07-02 13:17, Cornelia Huck wrote:
> From: David Hildenbrand <david@redhat.com>
>=20
> Let's treat this like a separate device. TCG will have to store the
> actual state/time later on.
>=20
> Include cpu-qom.h in kvm_s390x.h (due to S390CPU) to compile tod-kvm.c.

This patch breaks "make check" when QEMU has been compiled with
--disable-tcg on s390x:

$ gdb --args s390x-softmmu/qemu-system-s390x -nographic -accel qtest
[...]
ERROR:qom/object.c:549:object_new_with_type: assertion failed: (type !=3D=
 NULL)

Program received signal SIGABRT, Aborted.
[...]
(gdb) bt
#0  0x000003fffcac1220 in raise () from /lib64/libc.so.6
#1  0x000003fffcac2aa8 in abort () from /lib64/libc.so.6
#2  0x000003fffd0fdd5e in g_assertion_message () from /lib64/libglib-2.0.=
so.0
#3  0x000003fffd0fddc6 in g_assertion_message_expr () from /lib64/libglib=
-2.0.so.0
#4  0x00000001002d4bf2 in object_new_with_type (type=3D0x0)
    qom/object.c:549
#5  0x00000001002d4d6e in object_new (typename=3Dtypename@entry=3D0x10049=
0ce8 "s390-tod-qemu")
    at qom/object.c:563
#6  0x00000001001c04ee in s390_init_tod () at hw/s390x/tod.c:25
#7  0x0000000100233d00 in machine_run_board_init (machine=3D0x1008f5510)
    at hw/core/machine.c:834
#8  0x000000010012cb08 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>)
    at vl.c:4489

> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index dc704b57d6..93282f7c59 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -14,6 +14,9 @@ obj-$(CONFIG_PCI) +=3D s390-pci-bus.o s390-pci-inst.o
>  obj-$(call lnot,$(CONFIG_PCI)) +=3D s390-pci-stub.o
>  obj-y +=3D s390-skeys.o
>  obj-y +=3D s390-stattrib.o
> +obj-y +=3D tod.o
> +obj-$(CONFIG_KVM) +=3D tod-kvm.o
> +obj-$(CONFIG_TCG) +=3D tod-qemu.o

With --disable-tcg, tod-qemu.o is not included in the build.

[...]
> diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
> new file mode 100644
> index 0000000000..0501affa7f
> --- /dev/null
> +++ b/hw/s390x/tod.c
> @@ -0,0 +1,119 @@
> +/*
> + * TOD (Time Of Day) clock
> + *
> + * Copyright 2018 Red Hat, Inc.
> + * Author(s): David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/s390x/tod.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "migration/register.h"
> +
> +void s390_init_tod(void)
> +{
> +    Object *obj;
> +
> +    if (kvm_enabled()) {
> +        obj =3D object_new(TYPE_KVM_S390_TOD);
> +    } else {
> +        obj =3D object_new(TYPE_QEMU_S390_TOD);
> +    }

... but with "-accel qtest", QEMU tries to instantiate the object here.

I think we should maybe simply inclue tod-qemu.o unconditionally? Opinion=
s?

 Thomas
