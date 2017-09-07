Received: from eggs.gnu.org ([2001:4830:134:3::10]:52155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpvNl-0000HI-GY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpvNg-00018Y-Q7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpvNg-000188-Jy
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8A037E42C
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 11:53:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <265f10bb-5718-aaac-d0fe-595a78acdf46@redhat.com> (Eric Blake's
	message of "Wed, 6 Sep 2017 11:15:23 -0500")
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-8-quintela@redhat.com>
	<265f10bb-5718-aaac-d0fe-595a78acdf46@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 07 Sep 2017 13:53:55 +0200
Message-ID: <87tw0ebu7g.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 07/22] migration: Make
 migrate_fd_error() the owner of the Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Eric Blake <eblake@redhat.com> wrote:
D> On 09/06/2017 06:51 AM, Juan Quintela wrote:
>> So far, we had to free the error after each caller, so just do it
>> here.  Once there, tls.c was leaking the error.
>
> You mention tls.c,
>
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/channel.c   |  1 -
>>  migration/migration.c | 10 ++++------
>>  migration/migration.h |  4 ++--
>>  migration/socket.c    |  1 -
>>  4 files changed, 6 insertions(+), 10 deletions(-)
>
> but don't touch it.  Am I missing something?
>

It was missing error_free();  So it leaked the Error * variable.
I will improve the message for next version.



>>  
>> -void migrate_fd_error(MigrationState *s, const Error *error)
>> +void migrate_fd_error(MigrationState *s, Error *error)
>>  {
>
> No comments at definition,

We free it inside now, so it can't be const.

>> +++ b/migration/migration.h
>> @@ -163,8 +163,8 @@ bool  migration_has_all_channels(void);
>>  
>>  uint64_t migrate_max_downtime(void);
>>  
>> -void migrate_set_error(MigrationState *s, const Error *error);
>> -void migrate_fd_error(MigrationState *s, const Error *error);
>> +void migrate_set_error(MigrationState *s, Error *error);
>> +void migrate_fd_error(MigrationState *s, Error *error);
>
> or at declaration. That would be worth adding at some point, but this
> patch isn't making it worse.

will add them, thanks.

> The code looks okay in isolation, so if it is only the commit message
> that needs fixing,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks.
