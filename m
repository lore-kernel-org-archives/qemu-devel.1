Received: from eggs.gnu.org ([2001:4830:134:3::10]:37714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2iF-0006K4-GB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2iA-0000zi-JI
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df2iA-0000y0-DA
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BD1261487
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:30:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170720105622.GD2101@work-vm> (David Alan Gilbert's message of
	"Thu, 20 Jul 2017 11:56:23 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-15-quintela@redhat.com>
	<20170720105622.GD2101@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 13:29:59 +0200
Message-ID: <87fud29u14.fsf@secure.mitica>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
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
>>      qemu_file_set_blocking(f, false);
>>  }
>>  
>> @@ -384,18 +381,26 @@ void migration_fd_process_incoming(QEMUFile *f)
>>  gboolean migration_ioc_process_incoming(QIOChannel *ioc)
>>  {
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>> +    gboolean result = FALSE;
>
> I wonder if we need some state somewhere so that we can see that the
> incoming migration is partially connected - since the main incoming
> coroutine hasn't started yet, we've not got much of mis setup.

For other reasons this code has changed, and now this variable don't
exist.

Later, Juan.
