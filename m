Received: from eggs.gnu.org ([2001:4830:134:3::10]:56813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cljK5-0001dR-Ql
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1cljK2-0002M8-NA
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:40:41 -0500
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com
	([104.47.41.75]:56000
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1cljK2-0002KC-EV
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:40:38 -0500
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900648332.27090.14562192041474683540.stgit@brijesh-build-machine>
	<20170308213224.GS4694@thinpad.lan.raisama.net>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a47e6f98-9524-8d9c-75ef-332086d6873f@amd.com>
Date: Wed, 8 Mar 2017 15:40:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170308213224.GS4694@thinpad.lan.raisama.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 20/20] migration: disable
 save/restore and migration when SEV is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: brijesh.singh@amd.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com



On 03/08/2017 03:32 PM, Eduardo Habkost wrote:
> On Wed, Mar 08, 2017 at 03:54:43PM -0500, Brijesh Singh wrote:
>> Snapshot, Restore and Migration is not implemented yet. Return error when
>> user tries to perform any of these operations.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  migration/migration.c |    7 +++++++
>>  migration/savevm.c    |   11 +++++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3dab684..287c72b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -37,6 +37,7 @@
>>  #include "io/channel-buffer.h"
>>  #include "io/channel-tls.h"
>>  #include "migration/colo.h"
>> +#include "sysemu/sev.h"
>>
>>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>>
>> @@ -1221,6 +1222,12 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>          error_setg(errp, QERR_MIGRATION_ACTIVE);
>>          return;
>>      }
>> +
>> +    if (sev_enabled()) {
>> +        error_setg(errp, "Migration is not implemented");
>> +        return;
>> +    }
>> +
>
> You can do this more easily by registering a migration blocker
> using migrate_add_blocker() when initializing SEV.
>

Thanks for tip, I was not aware of migrate_add_blocker(), I will look at using in next rev.

-Brijesh
