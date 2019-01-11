Received: from eggs.gnu.org ([209.51.188.92]:42024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghz4K-0002ae-2X
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghz4J-0002f1-2D
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:50:00 -0500
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:36228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1ghz4I-0002bM-5F
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:49:58 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190110201124.GJ2589@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110201124.GJ2589@work-vm>
MIME-Version: 1.0
Date: Fri, 11 Jan 2019 18:49:53 +0300
Message-Id: <2578541547221793@myt5-68ad52a76c91.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>

10.01.2019, 23:12, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>>  Hi,
>>
>>  The series adds migration capability which allows to skip 'external' =
RAM blocks
>>  during migration. External block is a RAMBlock which available from t=
he outside
>>  of current QEMU process (e.g. file in /dev/shm). It's useful for fast=
 local
>>  migration to update QEMU for the running guests.
>
> Hi Yury,
>   There have been a few similar patch series around from people wanting
> to do similar things.
>   In particular Lai Jiangshan's https://lists.nongnu.org/archive/html/q=
emu-devel/2018-03/msg07511.html
> and C=C3=A9dric Le Goater wanted to skip regions for a different reason=
.
>
>   We merged some of C=C3=A9dric's code last year so that we now
> have the qemu_ram_is_migratable() function - and we should be reusing
> that to skip things rather than adding a new check that we have to add
> everywhere.
>

I didn't see the series, so I'll check it, thanks!
But I saw qemu_ram_is_migratable() function and corresponding patch.
It's very close to my needs, but it works a bit different IIUC:
1. Not migratable blocks isn't validated (existence and size) during migr=
ation,
2. "Migratable" state is determined during the block creation time.
   Such case isn't valid because of it:
   * Source has one migratable and one not migratable RAM blocks,
   * Target has the same (idstr) blocks, but both are not migratable.
   Thus, target will not expect pages for not migratable blocks.

>   Also, ypu're skipping 'external' things, I think the other suggestion
> was to skip 'shared' things (i.e. anything with share=3D0); skipping
> share=3Don cases sounds easier to me.

I agree that introducing new term is a complication, but 'share' and 'ext=
ernal'
terms have important differences (I'll describe it below).

Just to clarify:
* 'share' means that other processes has an access to such memory,
* 'external' means file backed memory.

There is another use case I wanted to support (I had to write about it in
the cover letter, sorry..):
1. Migrate source VM to file and kill source,
2. Start target VM and migrate it from file.
In such case source VM may have memory-backend-ram with share=3Doff, it's=
 ok.

Thus, in the new migration capability I want to migrate memory that meets
three conditions:
1. The source will not use the memory after migration ends,
2. The source may exit before target starts (migrate to file),
3. The target has an access to the memory.

I think 'external' fits them better than 'share'.

>
> Dave
>
>>  Patches:
>>  1. Add offset validation to make sure that external RAM block has the=
 same
>>     physical offset on target side,
>>  2. Add RAM_EXTERNAL flag to determine external RAM blocks,
>>  3. Add ignore-external migration capability,
>>  4. Add a test.
>>
>>  Usage example:
>>  1. Start source VM:
>>     qemu-system-x86 \
>>       -m 4G \
>>       -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem-p=
ath=3D/dev/shm/mem0 \
>>       -numa node,memdev=3Dmem0 \
>>       -qmp unix:/tmp/qemu-qmp-1.sock,server,nowait \
>>
>>  2. Start target VM:
>>     qemu-system-x86 \
>>       -m 4G \
>>       -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem-p=
ath=3D/dev/shm/mem0 \
>>       -numa node,memdev=3Dmem0 \
>>       -qmp unix:/tmp/qemu-qmp-2.sock,server,nowait \
>>       -incoming defer
>>
>>  3. Enable ignore-external capability on both VMs:
>>     { "execute": "migrate-set-capabilities" , "arguments":
>>       { "capabilities": [ { "capability": "x-ignore-external", "state"=
: true } ] } }
>>
>>  4. Start migration.
>>
>>  Regards,
>>  Yury
>>
>>  Yury Kotov (4):
>>    migration: add RAMBlock's offset validation
>>    exec: add RAM_EXTERNAL flag to mark non-QEMU allocated blocks
>>    migration: introduce ignore-external capability
>>    tests/migration-test: Add a test for ignore-external capability
>>
>>   backends/hostmem-file.c | 3 +-
>>   exec.c | 7 ++-
>>   include/exec/cpu-common.h | 1 +
>>   include/exec/memory.h | 3 ++
>>   migration/migration.c | 9 ++++
>>   migration/migration.h | 1 +
>>   migration/ram.c | 52 ++++++++++++++++--
>>   numa.c | 4 +-
>>   qapi/migration.json | 6 ++-
>>   tests/migration-test.c | 109 +++++++++++++++++++++++++++++++-------
>>   10 files changed, 165 insertions(+), 30 deletions(-)
>>
>>  --
>>  2.20.1
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury
