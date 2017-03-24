Received: from eggs.gnu.org ([2001:4830:134:3::10]:46813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crLs9-0003ts-Qw
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crLs3-0002ZC-US
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1crLs3-0002YX-NA
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A461AC05490D
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 09:50:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <afa29375-4d2f-8d69-4552-1b7c68d399f8@redhat.com> (Thomas Huth's
	message of "Fri, 24 Mar 2017 10:48:13 +0100")
References: <20170323205025.12113-1-quintela@redhat.com>
	<20170323205025.12113-2-quintela@redhat.com>
	<afa29375-4d2f-8d69-4552-1b7c68d399f8@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Mar 2017 10:50:57 +0100
Message-ID: <874lyj80la.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Disable hotplug/unplug
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 23.03.2017 21:50, Juan Quintela wrote:
>> Until we have reviewed what can/can't be hotplug during migration,
>> disable it.  We can enable it later for the things that we know that
>> work.  For instance, memory hotplug during postcopy don't work
>> currently.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  hw/core/qdev.c | 5 +++++
>>  qdev-monitor.c | 7 ++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 1e7fb33..8c4a3f3 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -277,6 +277,11 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>      HotplugHandler *hotplug_ctrl;
>>      HotplugHandlerClass *hdc;
>>  
>> +    if (!migration_is_idle()) {
>> +        error_setg(errp, "device_add not allowed while migrating");
>> +        return;
>> +    }
>> +
>>      if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>>          error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>>          return;
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 5f2fcdf..e0622b4 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -29,7 +29,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/help_option.h"
>>  #include "sysemu/block-backend.h"
>> -
>> +#include "migration/migration.h"
>>  /*
>>   * Aliases were a bad idea from the start.  Let's keep them
>>   * from spreading further.
>
> Maybe better keep an empty line between the include statement and the
> comment?

Oops, sure.

>
>  Thomas
>
>
>> @@ -566,6 +566,11 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>      BusState *bus = NULL;
>>      Error *err = NULL;
>>  
>> +    if (!migration_is_idle()) {
>> +        error_setg(errp, "device_add not allowed while migrating");
>> +        return NULL;
>> +    }
>> +
>>      driver = qemu_opt_get(opts, "driver");
>>      if (!driver) {
>>          error_setg(errp, QERR_MISSING_PARAMETER, "driver");
>> 
