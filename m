Received: from eggs.gnu.org ([209.51.188.92]:55461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBcBK-0005uM-Gv
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBcBJ-0007D5-84
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:27:42 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:52318)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBcBI-0007A2-Ft
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:27:41 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Date: Wed, 03 Apr 2019 12:27:36 +0300
Message-Id: <157081554283651@vla1-9d3c37294942.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hostmem: Disable add/del memory during
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "quintela@redhat.com" <quintela@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, zhanghailiang <zhang.zhanghailiang@huawei.com>

25.03.2019, 14:58, "Juan Quintela" <quintela@redhat.com>:
> Yury Kotov <yury-kotov@yandex-team.ru> wrote:
>> =C2=A0I found a bug in QEMU 2.12 with adding memory-backend while live=
 migration
>> =C2=A0thread is running.
>>
>> =C2=A0But it seems that this bug was implicitly fixed in this commit (=
QEMU 3.0):
>> =C2=A0=C2=A0=C2=A0b895de50: migration: discard non-migratable RAMBlock=
s
>>
>> =C2=A0I think it's better to disallow add/del memory backends during m=
igration to
>> =C2=A0to prevent other possible problems. Anyway, user can't use this =
memory because
>> =C2=A0of disabled hotplug/hotunplug devs.
>
> Hi
>
> My understanding is that we already disable memory hotplug/unplug durin=
g
> migration. At least, the idea of those patches was to disable all
> hotplug/unplug during migration. The only reason that I can think for
> using this patch is if anyone is planning about support some
> hotplug/upplug during migration (to my knowledge, nobody is working on
> that).
>

Sorry, what patches do you mean? It seems that I missed them...

> So, I think it is better to just disallow on high level all hoplug
> operations, instead of in all backends.
>

Agreed. I also had such idea and I did a quick look on this, but din't fo=
und how
to do it without some refactoring.

> But will wait to see what everybody else think about it.
>
> BTW, if we plan to ship this for an old qemu, I will try to disable
> hotplug for all devices, not only memory, no?
>
> Later, Juan.
>
>> =C2=A0The idea of this commit is the same as that:
>> =C2=A0=C2=A0=C2=A0b06424de: migration: Disable hotplug/unplug memory d=
uring migration
>>
>> =C2=A0Backtrace of this bug in QEMU 2.12:
>> =C2=A00 find_next_bit (addr=3Daddr@entry=3D0x0, size=3Dsize@entry=3D26=
2144, offset=3Doffset@entry=3D0) at util/bitops.c:46
>> =C2=A01 migration_bitmap_find_dirty (rs=3D0x7f58f80008c0, start=3D0, r=
b=3D0x5557e66e3200) at migration/ram.c:816
>> =C2=A02 find_dirty_block (again=3D<synthetic pointer>, pss=3D<syntheti=
c pointer>, rs=3D0x7f58f80008c0) at migration/ram.c:1243
>> =C2=A03 ram_find_and_save_block (rs=3Drs@entry=3D0x7f58f80008c0, last_=
stage=3Dlast_stage@entry=3Dfalse) at migration/ram.c:1592
>> =C2=A04 ram_find_and_save_block (last_stage=3Dfalse, rs=3D0x7f58f80008=
c0) at migration/ram.c:2335
>> =C2=A05 ram_save_iterate (f=3D0x5557e69f1000, opaque=3D<optimized out>=
) at migration/ram.c:2338
>> =C2=A06 qemu_savevm_state_iterate (f=3D0x5557e69f1000, postcopy=3Dfals=
e) at migration/savevm.c:1191
>> =C2=A07 migration_iteration_run (s=3D0x5557e666b030) at migration/migr=
ation.c:2301
>> =C2=A08 migration_thread (opaque=3D0x5557e666b030) at migration/migrat=
ion.c:2409
>> =C2=A09 start_thread (arg=3D0x7f59055d5700) at pthread_create.c:333
>> =C2=A010 clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0backends/hostmem.c | 9 ++++++++-
>> =C2=A0=C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>>
>> =C2=A0diff --git a/backends/hostmem.c b/backends/hostmem.c
>> =C2=A0index f61093654e..5c71bd3f6b 100644
>> =C2=A0--- a/backends/hostmem.c
>> =C2=A0+++ b/backends/hostmem.c
>> =C2=A0@@ -18,6 +18,7 @@
>> =C2=A0=C2=A0#include "qapi/visitor.h"
>> =C2=A0=C2=A0#include "qemu/config-file.h"
>> =C2=A0=C2=A0#include "qom/object_interfaces.h"
>> =C2=A0+#include "migration/misc.h"
>>
>> =C2=A0=C2=A0#ifdef CONFIG_NUMA
>> =C2=A0=C2=A0#include <numaif.h>
>> =C2=A0@@ -271,6 +272,11 @@ host_memory_backend_memory_complete(UserCre=
atable *uc, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *ptr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t sz;
>>
>> =C2=A0+ if (!migration_is_idle()) {
>> =C2=A0+ error_setg(errp, "Adding memory-backend isn't allowed while mi=
grating");
>> =C2=A0+ goto out;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bc->alloc) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bc->alloc(=
backend, &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (local_=
err) {
>> =C2=A0@@ -344,7 +350,8 @@ out:
>> =C2=A0=C2=A0static bool
>> =C2=A0=C2=A0host_memory_backend_can_be_deleted(UserCreatable *uc)
>> =C2=A0=C2=A0{
>> =C2=A0- if (host_memory_backend_is_mapped(MEMORY_BACKEND(uc))) {
>> =C2=A0+ if (host_memory_backend_is_mapped(MEMORY_BACKEND(uc)) ||
>> =C2=A0+ !migration_is_idle()) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fal=
se;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return tru=
e;

Regards,
Yury
