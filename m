Received: from eggs.gnu.org ([2001:4830:134:3::10]:35206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dG1bO-0000BQ-UG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dG1bL-0006RL-Nq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:15:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dG1bL-0006R8-FP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:15:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69FAF15447
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 11:15:42 +0000 (UTC)
References: <20170518172543.32694-1-quintela@redhat.com>
	<20170518172543.32694-3-quintela@redhat.com>
	<6a45fac0-cbe2-8146-2741-c3589d759c04@redhat.com>
	<87bmqafjqa.fsf@secure.mitica>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <2f51eaea-6f4f-1500-21db-7c7e1daf4a17@redhat.com>
Date: Wed, 31 May 2017 13:15:38 +0200
MIME-Version: 1.0
In-Reply-To: <87bmqafjqa.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/11] migration: Remove unneeded includes
 of migration/vmstate.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com

On 30/05/2017 17:27, Juan Quintela wrote:
> Laurent Vivier <lvivier@redhat.com> wrote:
>> On 18/05/2017 19:25, Juan Quintela wrote:
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/core/qdev.c                   | 1 -
>>>  include/hw/acpi/memory_hotplug.h | 1 -
>>>  include/hw/acpi/pcihp.h          | 1 -
>>>  include/hw/pci/shpc.h            | 1 -
>>>  include/net/net.h                | 1 -
>>>  target/alpha/cpu.c               | 1 -
>>>  target/hppa/cpu.c                | 1 -
>>>  target/s390x/cpu.c               | 1 -
>>>  target/tilegx/cpu.c              | 1 -
>>>  9 files changed, 9 deletions(-)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 71ff95f..0ce45a2 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -37,7 +37,6 @@
>>>  #include "hw/boards.h"
>>>  #include "hw/sysbus.h"
>>>  #include "qapi-event.h"
>>> -#include "migration/vmstate.h"
>>> =20
>>>  bool qdev_hotplug =3D false;
>>>  static bool qdev_hot_added =3D false;
>>
>> This one uses "VMStateDescription", "vmstate_check_only_migratable",
>> "vmstate_register_with_alias_id" and "vmstate_unregister" from
>> migration/savevm.h
>=20
> #includes "hw/qdev.h"
>=20
> which 1st include is
>=20
> #include "hw/hw.h"
>=20
> which include "migration/vmstate.h"
>=20
> After this series the only include file that includes
> migration/vmstate.h is hw/hw.h.  Removing it makes no sense (IMHO)
> because it would mean including it directly in more than half of the tr=
ee.
>=20
>>
>>> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memor=
y_hotplug.h
>>> index db8ebc9..77c6576 100644
>>> --- a/include/hw/acpi/memory_hotplug.h
>>> +++ b/include/hw/acpi/memory_hotplug.h
>>> @@ -3,7 +3,6 @@
>>> =20
>>>  #include "hw/qdev-core.h"
>>>  #include "hw/acpi/acpi.h"
>>> -#include "migration/vmstate.h"
>>>  #include "hw/acpi/aml-build.h"
>>> =20
>>>  /**
>>
>> This one uses "VMSTATE_STRUCT()" which is defined in migration/vmstate=
.h
>=20
> #include "hw/acpi/acpi.h"
>=20
> which includes:
>=20
> #include "hw/acpi/acpi_dev_interface.h"
>=20
> ->
>=20
> #include "hw/boards.h"
>=20
> ->
>=20
> #include "hw/hw.h"
>=20
>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>> index 04528b7..8a65f99 100644
>>> --- a/include/hw/acpi/pcihp.h
>>> +++ b/include/hw/acpi/pcihp.h
>>> @@ -28,7 +28,6 @@
>>>  #define HW_ACPI_PCIHP_H
>>> =20
>>>  #include "hw/acpi/acpi.h"
>>> -#include "migration/vmstate.h"
>>>  #include "hw/hotplug.h"
>>> =20
>>>  #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
>>
>> This one uses "VMSTATE_STRUCT()" which is defined in migration/vmstate=
.h
>=20
> see previous one
>=20
>>> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
>>> index b208554..71e836b 100644
>>> --- a/include/hw/pci/shpc.h
>>> +++ b/include/hw/pci/shpc.h
>>> @@ -3,7 +3,6 @@
>>> =20
>>>  #include "qemu-common.h"
>>>  #include "exec/memory.h"
>>> -#include "migration/vmstate.h"
>>>  #include "hw/hotplug.h"
>>>  #include "hw/pci/pci.h"
>>
>> This one uses "VMSTATE_BUFFER_UNSAFE_INFO_TEST()" which is defined in
>> migration/vmstate.h.
>=20
> #include "hw/pci/pci.h"
> ->
> #include "hw/qedev.h"
> ->
> #included "hw/hw.h"
>=20
>>> =20
>>> diff --git a/include/net/net.h b/include/net/net.h
>>> index 99b28d5..ba663bd 100644
>>> --- a/include/net/net.h
>>> +++ b/include/net/net.h
>>> @@ -6,7 +6,6 @@
>>>  #include "qapi/qmp/qdict.h"
>>>  #include "qemu/option.h"
>>>  #include "net/queue.h"
>>> -#include "migration/vmstate.h"
>>>  #include "qapi-types.h"
>>> =20
>>>  #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
>>
>> This one uses "vmstate_offset_array()" which is defined in
>> migration/vmstate.h
>>
>> Perhaps you can explain why you think they are unneeded?
>=20
> In all previous ones, they arrive to hw/hw.h for means that are not
> going to be removed.  For this one, I am getting trouble finding a
> normal chain.
>=20
> #include "qemu/osdep.h"
> #include "net/net.h"
>=20
> with this change works.  But I am not able to find *why*.

Perhaps you can play with "cc -E"?

>=20
> So, I am dropping this last bit.
>=20
> Is that ok for you?

It makes sense

Thanks,
Laurent
