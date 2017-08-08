Received: from eggs.gnu.org ([2001:4830:134:3::10]:37996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2ip-0006bz-51
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2ik-0001OB-7r
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df2ij-0001NX-Ro
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A92EB72FD5
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:30:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170720111059.GA878@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 20 Jul 2017 19:10:59 +0800")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-15-quintela@redhat.com>
	<20170720111059.GA878@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 13:30:39 +0200
Message-ID: <87bmnq9u00.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 14/17] migration: Delay the start of
 reception on main channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, berrange@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Mon, Jul 17, 2017 at 03:42:35PM +0200, Juan Quintela wrote:
>> When we start multifd, we will want to delay the main channel until
>> the others are created.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration.c | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d9d5415..e122684 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -358,14 +358,11 @@ static void process_incoming_migration_co(void *opaque)
>>  
>>  static void migration_incoming_setup(QEMUFile *f)
>>  {
>> -    MigrationIncomingState *mis = migration_incoming_get_current();
>> -
>>      if (multifd_load_setup() != 0) {
>>          /* We haven't been able to create multifd threads
>>             nothing better to do */
>>          exit(EXIT_FAILURE);
>>      }
>> -    mis->from_src_file = f;
>
> Shall we keep this, and ...
>
>>      qemu_file_set_blocking(f, false);
>>  }
>>  
>> @@ -384,18 +381,26 @@ void migration_fd_process_incoming(QEMUFile *f)
>>  gboolean migration_ioc_process_incoming(QIOChannel *ioc)
>>  {
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>> +    gboolean result = FALSE;
>>  
>>      if (!mis->from_src_file) {
>>          QEMUFile *f = qemu_fopen_channel_input(ioc);
>>          mis->from_src_file = f;
>
> ... remove this instead?  I am not sure, but looks like RDMA is still
> using migration_fd_process_incoming():
>
> rdma_accept_incoming_migration
>   migration_fd_process_incoming
>     migration_incoming_setup
>     migration_incoming_process
>       process_incoming_migration_co <-- here we'll use from_src_file
>                                         while it's not inited?

Reworked all the "incoming" logic for other reasons, I *think* that now
it is correct.

Later, Juan.
