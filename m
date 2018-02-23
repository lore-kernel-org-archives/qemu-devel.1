Received: from eggs.gnu.org ([2001:4830:134:3::10]:45717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHUY-0008EL-Gp
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHUU-00007l-Hy
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:50:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHUU-00004x-63
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:50:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-25-armbru@redhat.com>
	<a4a8b578-e5c8-b4d1-67dd-1b26983ba898@redhat.com>
Date: Fri, 23 Feb 2018 18:50:36 +0100
In-Reply-To: <a4a8b578-e5c8-b4d1-67dd-1b26983ba898@redhat.com> (Eric Blake's
	message of "Mon, 12 Feb 2018 16:26:23 -0600")
Message-ID: <874lm7k32r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 24/29] qapi: Empty out qapi-schema.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/11/2018 03:36 AM, Markus Armbruster wrote:
>> The previous commit improved compile time by including less of the
>> generated QAPI headers.  This is impossible for stuff defined directly
>> in qapi-schema.json, because that ends up in headers that that pull in
>> everything.
>>
>> Move everything but include directives from qapi-schema.json to new
>> sub-module qapi/misc.json, then include just the "misc" shard where
>> possible.
>>
>> It's not possible everywhere, except:
>
> Odd wording, did you mean one of:
>
> It's possible everywhere, except:
> It's almost possible everywhere, except:

The former.

>> * monitor.c needs qmp-command.h to get qmp_init_marshall()
>
> s/marshall/marshal/

Yes.

>> * monitor.c, ui/vnc.c and the generated qapi-event-FOO.c need
>>    qapi-event.h to get enum QAPIEvent
>>
>> Perhaps we'll get rid of those some other day.
>>
>> Adding a type to qapi/migration.json now recompiles some 120 instead
>> of 2300 out of 5100 objects.
>
> Getting better :)
>
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   .gitignore                         |    4 +
>>   Makefile                           |    9 +
>>   Makefile.objs                      |    4 +
>>   arch_init.c                        |    2 +-
>>   balloon.c                          |    2 +-
>>   block/iscsi.c                      |    2 +-
>>   cpus.c                             |    2 +-
>>   dump.c                             |    4 +-
>>   hmp.c                              |   10 +-
>>   hw/acpi/core.c                     |    2 +-
>>   hw/acpi/cpu.c                      |    2 +-
>>   hw/acpi/memory_hotplug.c           |    2 +-
>>   hw/acpi/vmgenid.c                  |    2 +-
>>   hw/core/qdev.c                     |    2 +-
>>   hw/i386/xen/xen-hvm.c              |    2 +-
>>   hw/ipmi/ipmi.c                     |    2 +-
>>   hw/pci/pci-stub.c                  |    2 +-
>>   hw/pci/pci.c                       |    2 +-
>>   hw/ppc/spapr_rtc.c                 |    2 +-
>>   hw/s390x/s390-skeys.c              |    2 +-
>>   hw/timer/mc146818rtc.c             |    4 +-
>>   hw/virtio/virtio-balloon.c         |    2 +-
>>   hw/watchdog/watchdog.c             |    2 +-
>>   include/hw/qdev-properties.h       |    3 +-
>>   include/monitor/monitor.h          |    2 +-
>>   include/sysemu/arch_init.h         |    2 +-
>>   include/sysemu/balloon.h           |    2 +-
>>   include/sysemu/dump.h              |    2 +-
>>   include/sysemu/hostmem.h           |    2 +-
>>   include/sysemu/replay.h            |    3 +-
>>   iothread.c                         |    2 +-
>>   migration/savevm.c                 |    3 +-
>>   numa.c                             |    4 +-
>
> Mostly mechanical,
>
>>   qapi-schema.json                   | 3098 +-----------------------------------
>>   qapi/misc.json                     | 3090 +++++++++++++++++++++++++++++++++++
>
> A huge move of content (git won't flag it as a rename, though ;(
>
> But why is the new file smaller than what was removed from the old
> file? Let's see...[1]
>
>>   qapi/run-state.json                |   10 +
>>   qdev-monitor.c                     |    2 +-
>>   qmp.c                              |    4 +-
>>   stubs/uuid.c                       |    2 +-
>>   stubs/vmgenid.c                    |    2 +-
>>   stubs/xen-hvm.c                    |    2 +-
>>   target/arm/monitor.c               |    3 +-
>>   target/i386/cpu.c                  |    4 +-
>>   tests/qmp-test.c                   |    3 +-
>>   tests/test-qobject-input-visitor.c |    2 +-
>>   tests/test-visitor-serialization.c |    1 -
>>   ui/gtk.c                           |    2 +-
>>   util/qemu-config.c                 |    2 +-
>>   vl.c                               |    4 +-
>>   49 files changed, 3181 insertions(+), 3144 deletions(-)
>>   create mode 100644 qapi/misc.json
>
> Huge email, but reviewing is not too hard.
>
>>
>> diff --git a/.gitignore b/.gitignore
>> index 42c57998fd..7f162e862f 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -38,6 +38,7 @@
>>   /qapi/qapi-commands-crypto.[ch]
>>   /qapi/qapi-commands-introspect.[ch]
>>   /qapi/qapi-commands-migration.[ch]
>> +/qapi/qapi-commands-misc.[ch]
>
> If my comments on the earlier patch result in a glob here, you
> wouldn't need these changes.
>
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -99,6 +99,7 @@ GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
>>   GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
>>   GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
>>   GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
>> +GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
>>   GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c
>>   GENERATED_FILES += qapi/qapi-types-rocker.h qapi/qapi-types-rocker.c
>>   GENERATED_FILES += qapi/qapi-types-run-state.h qapi/qapi-types-run-state.c
>> @@ -116,6 +117,7 @@ GENERATED_FILES += qapi/qapi-visit-common.h qapi/qapi-visit-common.c
>>   GENERATED_FILES += qapi/qapi-visit-crypto.h qapi/qapi-visit-crypto.c
>>   GENERATED_FILES += qapi/qapi-visit-introspect.h qapi/qapi-visit-introspect.c
>>   GENERATED_FILES += qapi/qapi-visit-migration.h qapi/qapi-visit-migration.c
>> +GENERATED_FILES += qapi/qapi-visit-misc.h qapi/qapi-visit-misc.c
>
> And again, my comments about using intermediate variables and make
> text substitution would result in less duplication here.
>
>> +++ b/Makefile.objs
>> @@ -11,6 +11,7 @@ util-obj-y += qapi/qapi-types-common.o
>>   util-obj-y += qapi/qapi-types-crypto.o
>>   util-obj-y += qapi/qapi-types-introspect.o
>>   util-obj-y += qapi/qapi-types-migration.o
>> +util-obj-y += qapi/qapi-types-misc.o
>
> and possibly here too.
>
>> +++ b/hmp.c
>> @@ -23,13 +23,21 @@
>>   #include "qemu/config-file.h"
>>   #include "qemu/option.h"
>>   #include "qemu/timer.h"
>> -#include "qmp-commands.h"
>>   #include "qemu/sockets.h"
>>   #include "monitor/monitor.h"
>>   #include "monitor/qdev.h"
>>   #include "qapi/error.h"
>>   #include "qapi/opts-visitor.h"
>>   #include "qapi-builtin-visit.h"
>> +#include "qapi/qapi-commands-block.h"
>> +#include "qapi/qapi-commands-char.h"
>> +#include "qapi/qapi-commands-migration.h"
>> +#include "qapi/qapi-commands-misc.h"
>> +#include "qapi/qapi-commands-net.h"
>> +#include "qapi/qapi-commands-rocker.h"
>> +#include "qapi/qapi-commands-run-state.h"
>> +#include "qapi/qapi-commands-tpm.h"
>> +#include "qapi/qapi-commands-ui.h"
>
> Well, not every file gets a smaller list of includes ;)
>
>> +++ b/qapi-schema.json
>> @@ -92,3100 +92,4 @@
>>   { 'include': 'qapi/transaction.json' }
>>   { 'include': 'qapi/trace.json' }
>>   { 'include': 'qapi/introspect.json' }
>> -
>> -##
>> -# = Miscellanea
>> -##
>
>> -# Since: 2.11
>> -##
>> -{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
>> +{ 'include': 'qapi/misc.json' }
>
> [1] Conflict magnet. We'd better be prepared for some rebasing to get
> this patch series through.  See what the last item is here...
>
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> new file mode 100644
>> index 0000000000..225631bf7d
>> --- /dev/null
>> +++ b/qapi/misc.json
>> @@ -0,0 +1,3090 @@
>> +# -*- Mode: Python -*-
>> +#
>> +
>
> Should we be thinking about copyright/license statements in the QAPI
> submodule files?  But that's a topic for another series.
>
>
>> +# Since: 2.9
>> +##
>> +{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>
> [1] ...and oops - you already hit one of those
> conflicts. watchdog-set-action disappeared in the move.  Or did it?
> [2]
>
>> index bca46a8785..a27c3c2a93 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -283,6 +283,16 @@
>>     'data': [ 'reset', 'shutdown', 'poweroff', 'pause', 'debug', 'none',
>>               'inject-nmi' ] }
>>   +
>> +##
>> +# @watchdog-set-action:
>> +#
>> +# Set watchdog action
>> +#
>> +# Since: 2.11
>> +##
>> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
>> +
>
> [2] Oh, you MOVED it to a different file.  Let's fix that separately,
> so that THIS patch can be just 1-1 file motion, not 1-N (making
> rebasing easier).

Okay.

>>   ##
>>   # @GUEST_PANICKED:
>>   #
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 846238175f..b8f6bc3f7e 100644
>> --- a/qdev-monitor.c
>
> Looks reasonable, but not quite ready for my R-b until v3.
