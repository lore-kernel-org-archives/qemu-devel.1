Received: from eggs.gnu.org ([2001:4830:134:3::10]:60555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d303u-0006GI-Bn
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d303r-0007DG-Kn
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d303r-0007Cc-BN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:59:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC84A80045
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 12:59:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <a338b667-31cf-8a49-7463-8efc8be7c009@redhat.com> (Laurent
	Vivier's message of "Tue, 25 Apr 2017 14:39:54 +0200")
References: <20170425101758.3944-1-quintela@redhat.com>
	<20170425101758.3944-3-quintela@redhat.com>
	<a338b667-31cf-8a49-7463-8efc8be7c009@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 25 Apr 2017 14:59:13 +0200
Message-ID: <87vapsmyn2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: to_dst_file at that point
 is NULL
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
> On 25/04/2017 12:17, Juan Quintela wrote:
>> We have just arrived as:
>> 
>> migration.c: qemu_migrate()
>>   ....
>>   s = migrate_init() <- puts it to NULL
>>   ....
>>   {tcp,unix}_start_outgoing_migration ->
>>      socket_outgoing_migration
>>         migration_channel_connect()
>> 	   sets to_dst_file
>> 
>> if tls is enabled, we do another round through
>> migrate_channel_tls_connect(), but we only set it up if there is no
>> error.  So we don't need the assignation.  I am removing it to remove
>> in the follwing patches the knowledge about MigrationState in that two
>> files.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/socket.c | 1 -
>>  migration/tls.c    | 1 -
>>  2 files changed, 2 deletions(-)
>> 
>> diff --git a/migration/socket.c b/migration/socket.c
>> index 13966f1..dc88812 100644
>> --- a/migration/socket.c
>> +++ b/migration/socket.c
>> @@ -79,7 +79,6 @@ static void socket_outgoing_migration(QIOTask *task,
>>  
>>      if (qio_task_propagate_error(task, &err)) {
>>          trace_migration_socket_outgoing_error(error_get_pretty(err));
>> -        data->s->to_dst_file = NULL;
>>          migrate_fd_error(data->s, err);
>>          error_free(err);
>>      } else {
>> diff --git a/migration/tls.c b/migration/tls.c
>> index 45bec44..a33ecb7 100644
>> --- a/migration/tls.c
>> +++ b/migration/tls.c
>> @@ -116,7 +116,6 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>>  
>>      if (qio_task_propagate_error(task, &err)) {
>>          trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
>> -        s->to_dst_file = NULL;
>>          migrate_fd_error(s, err);
>>          error_free(err);
>>      } else {
>> 
>
> In migrate_fd_error(), we have "assert(s->to_dst_file == NULL);", so you
> break the function with this change.

I missundertood something, or everyway to arrive here, to_dst_file is
always NULL.  See the comment of the file, the only distintion if we go
through tls is that we do "yet" another round through the init
functions, but it is still NULL.  At least I can't see how this can be
NULL at this point.

Forget about tls for now, centrate in the normal socket.c case:

we are inside socket_outgoing_migration()
    nothing here touch any componetes of data

so go to the caller:

socket_start_outgoing_migration().

It init all data values to NULL/0 (g_new0).

we call qio_channel_set_name() -> no "data" here.
qio_channel_socket_connect_async()

It touches "neworking" things here, but nothing related to data, the
first function that we call when we receive a connection is
socket_outgoing_migration(), so we are good.


Back to the tls case:

migration_tls_outgoing_handshake () -> nothing touch "s" until we call
migrate_fd_error().

what calls migration_tls_outgoing_handshake?
migration_tls_outgoing_connect().

But that only calls it using qio_channel_tls_handshake().  Notice that
they pass us here MigrationState, so, who calls this function?

migration_channel_connect(), this is the function that calls tls, and
tls ends calling this function without the tls stuff.  So, at the point
when we setup s->to_dst_file = f here, it is the 1st time that we have
set that field, too late to affect the migrate_fd_error() that we were
talking about, no?

Later, Juan.
