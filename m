Received: from eggs.gnu.org ([2001:4830:134:3::10]:43506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBLRn-0007FC-Dd
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBLRk-0005fZ-7i
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBLRk-0005fO-1g
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E244C059733
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 13:26:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170518120710.GE24085@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 18 May 2017 20:07:10 +0800")
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-4-quintela@redhat.com>
	<20170518120710.GE24085@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Thu, 18 May 2017 15:26:23 +0200
Message-ID: <871srm9tz4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/9] migration: Export qemu-file-channel.c
 functions in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Wed, May 17, 2017 at 05:47:50PM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  1 +
>>  include/migration/qemu-file.h |  4 ----
>>  migration/channel.c           |  1 +
>>  migration/colo.c              |  1 +
>>  migration/migration.c         |  1 +
>>  migration/qemu-file-channel.c |  1 +
>>  migration/qemu-file-channel.h | 21 +++++++++++++++++++++
>>  migration/rdma.c              |  1 +
>>  migration/savevm.c            |  1 +
>>  tests/test-vmstate.c          |  1 +
>>  10 files changed, 29 insertions(+), 4 deletions(-)
>>  create mode 100644 migration/qemu-file-channel.h
>> 
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index e831259..8280df1 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -19,6 +19,7 @@
>>  #include "qemu/thread.h"
>>  #include "qemu/notify.h"
>>  #include "migration/vmstate.h"
>> +#include "io/channel.h"
>
> Could I ask why we add this line here? I thought one of the main goals
> of this series is removing things from migration.h...



I remove from include/migration/qemu-file.h

-#include "io/channel.h"


Because all the QIOChannel functions in qemu-file.h are moved to
qemu-file-channel.h.

Great!

But migration/vmstate.h includes qemu-file.h

And migration.h includes vmstate.h

And migration.h has this functions:

void qemu_start_incoming_migration(const char *uri, Error **errp);
                                            QIOChannel *ioc,
                                            Error **errp);

void migration_tls_channel_connect(MigrationState *s,
                                   QIOChannel *ioc,
                                   const char *hostname,
                                   Error **errp);

And nothing else declares the QIOChannel.

So, the easy solution so far is to include this by now to maintain
compilation.

BTW, good catch.

So, I think that there is no other good solution to untangle the mess.

Later, Juan.
