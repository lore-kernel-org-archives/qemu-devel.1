Received: from eggs.gnu.org ([2001:4830:134:3::10]:56260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewQRQ-00088b-Pv
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewQRP-0004Ap-Pt
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:49:00 -0400
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-3-git-send-email-thuth@redhat.com>
	<20180315092110.GD3146@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d3a009b-37c3-86b0-a734-e1783f507e60@redhat.com>
Date: Thu, 15 Mar 2018 11:48:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180315092110.GD3146@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/cdboot: Test booting from CD-ROM
 ISO image file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 15.03.2018 10:21, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 15, 2018 at 08:49:04AM +0100, Thomas Huth wrote:
>> We already have the code for a boot file in tests/boot-sector.c,
>> so if the genisoimage program is available, we can easily create
>> a bootable CD ISO image that we can use for testing whether our
>> CD-ROM emulation and the BIOS CD-ROM boot works correctly.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/Makefile.include |   3 +
>>  tests/cdrom-test.c     | 155 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 158 insertions(+)
>>  create mode 100644 tests/cdrom-test.c
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index ef9b88c..a104222 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -304,6 +304,7 @@ check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-f=
ilter-redirector$(EXESUF)
>>  check-qtest-i386-y +=3D tests/migration-test$(EXESUF)
>>  check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(EXESUF)
>>  check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
>> +check-qtest-i386-y +=3D tests/cdrom-test$(EXESUF)
>>  check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
>>  check-qtest-x86_64-y +=3D tests/sdhci-test$(EXESUF)
>>  gcov-files-i386-y +=3D i386-softmmu/hw/timer/mc146818rtc.c
>> @@ -398,6 +399,7 @@ check-qtest-s390x-y +=3D tests/virtio-balloon-test=
$(EXESUF)
>>  check-qtest-s390x-y +=3D tests/virtio-console-test$(EXESUF)
>>  check-qtest-s390x-y +=3D tests/virtio-serial-test$(EXESUF)
>>  check-qtest-s390x-y +=3D tests/cpu-plug-test$(EXESUF)
>> +check-qtest-s390x-y +=3D tests/cdrom-test$(EXESUF)
>> =20
>>  check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
>>  check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)
>> @@ -829,6 +831,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-uti=
l.o $(test-util-obj-y)
>>  tests/numa-test$(EXESUF): tests/numa-test.o
>>  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o=
 tests/acpi-utils.o
>>  tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
>> +tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(l=
ibqos-obj-y)
>> =20
>>  tests/migration/stress$(EXESUF): tests/migration/stress.o
>>  	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $=
< ,"LINK","$(TARGET_DIR)$@")
>> diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
>> new file mode 100644
>> index 0000000..1fc5230
>> --- /dev/null
>> +++ b/tests/cdrom-test.c
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Various tests for emulated CD-ROM drives.
>> + *
>> + * Copyright (c) 2018 Red Hat Inc.
>> + *
>> + * Author:
>> + *    Thomas Huth <thuth@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2
>> + * or later. See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "boot-sector.h"
>> +
>> +static char isoimage[] =3D "cdrom-boot-iso-XXXXXX";
>> +
>> +static int gen_iso(const char *fmt, ...)
>> +{
>> +    char *params, *command;
>> +    va_list args;
>> +    pid_t pid;
>> +    int status;
>> +
>> +    pid =3D fork();
>> +    if (pid =3D=3D 0) {
>> +        va_start(args, fmt);
>> +        params =3D g_strdup_vprintf(fmt, args);
>> +        va_end(args);
>> +        command =3D g_strdup_printf("exec genisoimage %s", params);
>> +        g_free(params);
>> +        execlp("/bin/sh", "sh", "-c", command, NULL);
>> +        exit(1);
>> +    }
>> +    wait(&status);
>=20
> IMHO this should just use g_spawn_sync(), also the use of
> shell seems rather unneccessary - why not just run genisoimage
> directly ?

That code was simply "inspired" from the execlp() code in
qtest_init_without_qmp_handshake() ... but g_spawn_sync() sounds like a
good alternative here, so I'll try to switch to that one instead.

 Thanks,
  Thomas
