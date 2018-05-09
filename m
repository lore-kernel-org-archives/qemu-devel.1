Received: from eggs.gnu.org ([2001:4830:134:3::10]:43428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGKEA-00063A-A6
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGKE7-0000XL-0d
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:13:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGKE6-0000WJ-Ro
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:13:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68E1CEB71E
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 08:13:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180502155346.GG2679@work-vm> (David Alan Gilbert's message of
	"Wed, 2 May 2018 16:53:47 +0100")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-2-quintela@redhat.com>
	<20180502155346.GG2679@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 09 May 2018 10:15:39 +0200
Message-ID: <87603x6y8k.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 01/21] migration: Set error state in
 case of error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 0e90efa092..2ae560ea80 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -415,10 +415,20 @@ struct {
>>      int count;
>>  } *multifd_send_state;
>>  
>> -static void terminate_multifd_send_threads(Error *errp)
>> +static void terminate_multifd_send_threads(Error *err)
>>  {
>>      int i;
>>  
>> +    if (err) {
>> +        MigrationState *s = migrate_get_current();
>> +        migrate_set_error(s, err);
>> +        if (s->state == MIGRATION_STATUS_SETUP ||
>> +            s->state == MIGRATION_STATUS_ACTIVE) {
>
> Can you explain/add comment why these only set it in some states?
> For example what about PRE_SWITCHOVER, DEVICE or postcopy?

This were the ones needed when I did the patch? O:-)

Ok, looking at all of them:

    MIGRATION_STATUS_NONE = 0,

We can't be on that state

    MIGRATION_STATUS_SETUP = 1,
There

MIGRATION_STATUS_CANCELLING = 2,
    MIGRATION_STATUS_CANCELLED = 3,

We don't want to touch in the case of that two.

    MIGRATION_STATUS_ACTIVE = 4,

There.

    MIGRATION_STATUS_POSTCOPY_ACTIVE = 5,
    MIGRATION_STATUS_POSTCOPY_PAUSED = 6,

We are not supporing those yet.

    MIGRATION_STATUS_COMPLETED = 7,

This is impossible (TM)

    MIGRATION_STATUS_FAILED = 8,

We don't want to change.

    MIGRATION_STATUS_COLO = 9,

Not contemplated yet
    MIGRATION_STATUS_PRE_SWITCHOVER = 10,
    MIGRATION_STATUS_DEVICE = 11,

Needed.
    MIGRATION_STATUS__MAX = 12,

Irrelelevant.

So, I agree with your suggestion.

Later, Juan.


> Dave
>
>> +            migrate_set_state(&s->state, s->state,
>> +                              MIGRATION_STATUS_FAILED);
>> +        }
>> +    }
>> +
>>      for (i = 0; i < multifd_send_state->count; i++) {
>>          MultiFDSendParams *p = &multifd_send_state->params[i];
>>  
>> @@ -515,10 +525,20 @@ struct {
>>      int count;
>>  } *multifd_recv_state;
>>  
>> -static void terminate_multifd_recv_threads(Error *errp)
>> +static void terminate_multifd_recv_threads(Error *err)
>>  {
>>      int i;
>>  
>> +    if (err) {
>> +        MigrationState *s = migrate_get_current();
>> +        migrate_set_error(s, err);
>> +        if (s->state == MIGRATION_STATUS_SETUP ||
>> +            s->state == MIGRATION_STATUS_ACTIVE) {
>> +            migrate_set_state(&s->state, s->state,
>> +                              MIGRATION_STATUS_FAILED);
>> +        }
>> +    }
>> +
>>      for (i = 0; i < multifd_recv_state->count; i++) {
>>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>>  
>> -- 
>> 2.17.0
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
