Received: from eggs.gnu.org ([2001:4830:134:3::10]:54520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dZbFD-0004HU-CT
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dZbFA-00024i-7L
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dZbFA-00024Q-1w
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:09:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22CAB20273
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:09:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170719133829.GG30084@redhat.com> (Daniel P. Berrange's message
	of "Wed, 19 Jul 2017 14:38:29 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-3-quintela@redhat.com>
	<20170719133829.GG30084@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 24 Jul 2017 13:09:41 +0200
Message-ID: <877eyy851m.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 02/17] migration: Create
 migration_ioc_process_incoming()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Mon, Jul 17, 2017 at 03:42:23PM +0200, Juan Quintela wrote:
>> We need to receive the ioc to be able to implement multifd.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/channel.c   |  3 +--
>>  migration/migration.c | 16 +++++++++++++---
>>  migration/migration.h |  2 ++
>>  3 files changed, 16 insertions(+), 5 deletions(-)
>> 
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 719055d..5b777ef 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -36,8 +36,7 @@ gboolean migration_channel_process_incoming(QIOChannel *ioc)
>>              error_report_err(local_err);
>>          }
>>      } else {
>> -        QEMUFile *f = qemu_fopen_channel_input(ioc);
>> -        migration_fd_process_incoming(f);
>> +        return migration_ioc_process_incoming(ioc);
>>      }
>>      return FALSE; /* unregister */
>>  }
>
> This is going to break TLS with multi FD I'm afraid.
>
>
> We have two code paths:
>
>  1. Non-TLS
>
>     event loop POLLIN on migration listener socket
>      +-> socket_accept_incoming_migration()
>           +-> migration_channel_process_incoming()
> 	       +-> migration_ioc_process_incoming()
> 	            -> returns FALSE if all required FD channels are now present
>
>  2. TLS
>
>     event loop POLLIN on migration listener socket
>      +-> socket_accept_incoming_migration()
>           +-> migration_channel_process_incoming()
> 	       +-> migration_tls_channel_process_incoming
> 	            -> Registers watch for TLS handhsake on client socket
> 	            -> returns FALSE immediately to remove listener watch
>
>     event loop POLLIN on migration *client* socket
>      +-> migration_tls_incoming_handshake
>           +-> migration_channel_process_incoming()
> 	       +-> migration_ioc_process_incoming()
> 	            -> return value ignored
>

The part of the cover letter when I explained that TLS was not working
and asked for help was not chopped for user error.

I *think* that is fixed this correctly.

As this worked differently than I expected, I just changed how things
were done.

Thanks, Juan.
