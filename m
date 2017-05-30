Received: from eggs.gnu.org ([2001:4830:134:3::10]:42585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFj3U-0006w4-TY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFj3P-0003Tf-Te
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFj3P-0003TV-Kr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A660580C29
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 15:27:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6a45fac0-cbe2-8146-2741-c3589d759c04@redhat.com> (Laurent
	Vivier's message of "Wed, 24 May 2017 18:20:45 +0200")
References: <20170518172543.32694-1-quintela@redhat.com>
	<20170518172543.32694-3-quintela@redhat.com>
	<6a45fac0-cbe2-8146-2741-c3589d759c04@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 17:27:25 +0200
Message-ID: <87bmqafjqa.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com

Laurent Vivier <lvivier@redhat.com> wrote:
> On 18/05/2017 19:25, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/core/qdev.c                   | 1 -
>>  include/hw/acpi/memory_hotplug.h | 1 -
>>  include/hw/acpi/pcihp.h          | 1 -
>>  include/hw/pci/shpc.h            | 1 -
>>  include/net/net.h                | 1 -
>>  target/alpha/cpu.c               | 1 -
>>  target/hppa/cpu.c                | 1 -
>>  target/s390x/cpu.c               | 1 -
>>  target/tilegx/cpu.c              | 1 -
>>  9 files changed, 9 deletions(-)
>>=20
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 71ff95f..0ce45a2 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -37,7 +37,6 @@
>>  #include "hw/boards.h"
>>  #include "hw/sysbus.h"
>>  #include "qapi-event.h"
>> -#include "migration/vmstate.h"
>>=20=20
>>  bool qdev_hotplug =3D false;
>>  static bool qdev_hot_added =3D false;
>
> This one uses "VMStateDescription", "vmstate_check_only_migratable",
> "vmstate_register_with_alias_id" and "vmstate_unregister" from
> migration/savevm.h

#includes "hw/qdev.h"

which 1st include is

#include "hw/hw.h"

which include "migration/vmstate.h"

After this series the only include file that includes
migration/vmstate.h is hw/hw.h.  Removing it makes no sense (IMHO)
because it would mean including it directly in more than half of the tree.

>
>> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_h=
otplug.h
>> index db8ebc9..77c6576 100644
>> --- a/include/hw/acpi/memory_hotplug.h
>> +++ b/include/hw/acpi/memory_hotplug.h
>> @@ -3,7 +3,6 @@
>>=20=20
>>  #include "hw/qdev-core.h"
>>  #include "hw/acpi/acpi.h"
>> -#include "migration/vmstate.h"
>>  #include "hw/acpi/aml-build.h"
>>=20=20
>>  /**
>
> This one uses "VMSTATE_STRUCT()" which is defined in migration/vmstate.h

#include "hw/acpi/acpi.h"

which includes:

#include "hw/acpi/acpi_dev_interface.h"

->

#include "hw/boards.h"

->

#include "hw/hw.h"

>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>> index 04528b7..8a65f99 100644
>> --- a/include/hw/acpi/pcihp.h
>> +++ b/include/hw/acpi/pcihp.h
>> @@ -28,7 +28,6 @@
>>  #define HW_ACPI_PCIHP_H
>>=20=20
>>  #include "hw/acpi/acpi.h"
>> -#include "migration/vmstate.h"
>>  #include "hw/hotplug.h"
>>=20=20
>>  #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
>
> This one uses "VMSTATE_STRUCT()" which is defined in migration/vmstate.h

see previous one

>> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
>> index b208554..71e836b 100644
>> --- a/include/hw/pci/shpc.h
>> +++ b/include/hw/pci/shpc.h
>> @@ -3,7 +3,6 @@
>>=20=20
>>  #include "qemu-common.h"
>>  #include "exec/memory.h"
>> -#include "migration/vmstate.h"
>>  #include "hw/hotplug.h"
>>  #include "hw/pci/pci.h"
>
> This one uses "VMSTATE_BUFFER_UNSAFE_INFO_TEST()" which is defined in
> migration/vmstate.h.

#include "hw/pci/pci.h"
->
#include "hw/qedev.h"
->
#included "hw/hw.h"

>>=20=20
>> diff --git a/include/net/net.h b/include/net/net.h
>> index 99b28d5..ba663bd 100644
>> --- a/include/net/net.h
>> +++ b/include/net/net.h
>> @@ -6,7 +6,6 @@
>>  #include "qapi/qmp/qdict.h"
>>  #include "qemu/option.h"
>>  #include "net/queue.h"
>> -#include "migration/vmstate.h"
>>  #include "qapi-types.h"
>>=20=20
>>  #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
>
> This one uses "vmstate_offset_array()" which is defined in
> migration/vmstate.h
>
> Perhaps you can explain why you think they are unneeded?

In all previous ones, they arrive to hw/hw.h for means that are not
going to be removed.  For this one, I am getting trouble finding a
normal chain.

#include "qemu/osdep.h"
#include "net/net.h"

with this change works.  But I am not able to find *why*.

So, I am dropping this last bit.

Is that ok for you?

Later, Juan.
