Received: from eggs.gnu.org ([2001:4830:134:3::10]:43749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJaP-0001Mb-Ln
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJaK-00083S-P4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:34:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdJaK-00083K-GM
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:34:40 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB18380473
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 16:34:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170127174530.GH3323@work-vm> (David Alan Gilbert's message of
	"Fri, 27 Jan 2017 17:45:30 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-10-git-send-email-quintela@redhat.com>
	<20170127174530.GH3323@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 17:34:31 +0100
Message-ID: <87a89q59t4.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/17] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We create new channels for each new thread created. We only send through
>> them a character to be sure that we are creating the channels in the
>> right order.
>> 
>> Note: Reference count/freeing of channels is not done
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  6 +++++
>>  migration/ram.c               | 45 +++++++++++++++++++++++++++++++++-
>>  migration/socket.c            | 56 +++++++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 104 insertions(+), 3 deletions(-)
>
> One thing not direclt in here, you should probably look at the migration cancel
> code to get it to call shutdown() on all your extra sockets, it stops things
> blocking in any one of them.

Will do.

>> 
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index f119ba0..3989bd6 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -22,6 +22,7 @@
>>  #include "qapi-types.h"
>>  #include "exec/cpu-common.h"
>>  #include "qemu/coroutine_int.h"
>> +#include "io/channel.h"
>> 
>>  #define QEMU_VM_FILE_MAGIC           0x5145564d
>>  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
>> @@ -218,6 +219,11 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp);
>> 
>>  void tcp_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
>> 
>> +QIOChannel *socket_recv_channel_create(void);
>> +int socket_recv_channel_destroy(QIOChannel *recv);
>> +QIOChannel *socket_send_channel_create(void);
>> +int socket_send_channel_destroy(QIOChannel *send);
>> +
>>  void unix_start_incoming_migration(const char *path, Error **errp);
>> 
>>  void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 939f364..5ad7cb3 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -386,9 +386,11 @@ void migrate_compress_threads_create(void)
>> 
>>  struct MultiFDSendParams {
>>      QemuThread thread;
>> +    QIOChannel *c;
>>      QemuCond cond;
>>      QemuMutex mutex;
>>      bool quit;
>> +    bool started;
>>  };
>>  typedef struct MultiFDSendParams MultiFDSendParams;
>> 
>> @@ -397,6 +399,13 @@ static MultiFDSendParams *multifd_send;
>>  static void *multifd_send_thread(void *opaque)
>>  {
>>      MultiFDSendParams *params = opaque;
>> +    char start = 's';
>> +
>> +    qio_channel_write(params->c, &start, 1, &error_abort);
>
> I'd be tempted to send something stronger as a guarantee
> that you're connecting the right thing to the right place;
> maybe something like a QEMU + UUID + fd index?
> I guarantee someone is going to mess up the fd's in the wrong
> order or connect some random other process to one of them.

which UUID? I can put anything there.

>> +    qemu_mutex_lock(&params->mutex);
>> +    params->started = true;
>> +    qemu_cond_signal(&params->cond);
>> +    qemu_mutex_unlock(&params->mutex);
>> 
>>      qemu_mutex_lock(&params->mutex);
>
> That unlock/lock pair is odd.

Fixed.

>
>>      while (!params->quit){
>> @@ -433,6 +442,7 @@ void migrate_multifd_send_threads_join(void)
>>          qemu_thread_join(&multifd_send[i].thread);
>>          qemu_mutex_destroy(&multifd_send[i].mutex);
>>          qemu_cond_destroy(&multifd_send[i].cond);
>> +        socket_send_channel_destroy(multifd_send[i].c);
>>      }
>>      g_free(multifd_send);
>>      multifd_send = NULL;
>> @@ -452,18 +462,31 @@ void migrate_multifd_send_threads_create(void)
>>          qemu_mutex_init(&multifd_send[i].mutex);
>>          qemu_cond_init(&multifd_send[i].cond);
>>          multifd_send[i].quit = false;
>> +        multifd_send[i].started = false;
>> +        multifd_send[i].c = socket_send_channel_create();
>> +        if(!multifd_send[i].c) {
>> +            error_report("Error creating a send channel");
>> +            exit(0);
>
> Hmm no exit!

I have to add the error path before to the callers :-(


>
> We need to be careful there since that's a sync; it depends what
> calls this, if I'm reading the code above correctly then it gets called
> from the main thread and that would be bad if it blocked; it's ok if it
> was the fd threads or the migration thread though.

I think it is from the migration thread, no?
/me checks

I stand corrected.  It is called from the main thread.  It works if
destination is not up.  It segfaults if destination is launched but not
conffigured for multithread.

Will post fix later.

Later, Juan.
