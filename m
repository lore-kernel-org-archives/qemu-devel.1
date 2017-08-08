Received: from eggs.gnu.org ([2001:4830:134:3::10]:57517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df0vY-0003qz-2j
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df0vU-0004k3-PE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df0vU-0004jc-GM
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:35:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65DE0356E2
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 09:35:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170719173513.GJ3500@work-vm> (David Alan Gilbert's message of
	"Wed, 19 Jul 2017 18:35:14 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-10-quintela@redhat.com>
	<20170719173513.GJ3500@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 11:35:44 +0200
Message-ID: <87ziba9zbj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 09/17] migration: Start of multiple fd
 work
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
>> We create new channels for each new thread created. We only send through
>> them a character to be sure that we are creating the channels in the
>> right order.
>
> That text is out of date isn't it?

oops, fixed.


>> +gboolean multifd_new_channel(QIOChannel *ioc)
>> +{
>> +    int thread_count = migrate_multifd_threads();
>> +    MultiFDRecvParams *p = g_new0(MultiFDRecvParams, 1);
>> +    MigrationState *s = migrate_get_current();
>> +    char string[MULTIFD_UUID_MSG];
>> +    char string_uuid[UUID_FMT_LEN];
>> +    char *uuid;
>> +    int id;
>> +
>> +    qio_channel_read(ioc, string, sizeof(string), &error_abort);
>> +    sscanf(string, "%s multifd %03d", string_uuid, &id);
>> +
>> +    if (qemu_uuid_set) {
>> +        uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
>> +    } else {
>> +        uuid = g_strdup(multifd_uuid);
>> +    }
>> +    if (strcmp(string_uuid, uuid)) {
>> +        error_report("multifd: received uuid '%s' and expected uuid '%s'",
>> +                     string_uuid, uuid);
>
> probably worth adding the channel id as well so we can see
> when it fails.

Done.

>> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>> +                          MIGRATION_STATUS_FAILED);
>> +        terminate_multifd_recv_threads();
>> +        return FALSE;
>> +    }
>> +    g_free(uuid);
>> +
>> +    if (multifd_recv_state->params[id] != NULL) {
>> +        error_report("multifd: received id '%d' is already setup'", id);
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>> +                          MIGRATION_STATUS_FAILED);
>> +        terminate_multifd_recv_threads();
>> +        return FALSE;
>> +    }
>> +    qemu_mutex_init(&p->mutex);
>> +    qemu_sem_init(&p->sem, 0);
>> +    p->quit = false;
>> +    p->id = id;
>> +    p->c = ioc;
>> +    atomic_set(&multifd_recv_state->params[id], p);
>
> Can you explain why this is quite so careful about ordering ? Is there
> something that could look at params or try and take the mutex before
> the count is incremented?

what happened to me in the middle stages of the patches (yes, doing
asynchronously was painful) was that:

I created the threads (at the beggining I did the
multifd_recv_state->params[id] == p inside the thread, that makes things
really, really racy.  I *think* that now we could probably do this
as you state.



> I think it's safe to do:
>  p->quit = false;
>  p->id = id;
>  p->c = ioc;
>  &multifd_recv_state->params[id] = p;
>  qemu_sem_init(&p->sem, 0);
>  qemu_mutex_init(&p->mutex);
>  qemu_thread_create(...)
>  atomic_inc(&multifd_recv_state->count);    <-- I'm not sure if this
>  needs to be atomic

We only change it on the main thread, so it should be enough.  The split
that I want to do is:

we do the listen asynchronously
when something arrives, we just read it (main thread)
we then read <uuid> <string> <arguments>
and then after checking that uuid is right, we call whatever function we
have for "string", in our case "multifd", with <arguments> as one string
parameters.

This should make it easier to create new "channels" for other purposes.
So far so good.

But then it appears what are the responsabilities, At the beggining, I
read the string on the reception thread for that channel, that created a
race because I received the 1st message for that channel before the
channel was fully created (yes, it only happened sometimes, easy to
understand after debugging).  This is the main reason that I changed to
an array of pointers to structs instead of one array of structs.

Then, I had to ve very careful to know when I had created all the
channels threads, because otherwise I ended having races left and right.

I will try to test the ordering that you suggested.

>> +    qemu_thread_create(&p->thread, "multifd_recv", multifd_recv_thread, p,
>> +                       QEMU_THREAD_JOINABLE);
>
> You've lost the nice numbered thread names you had created in the
> previous version of this that you're removing.

I could get them back, but they really were not showing at gdb, where do
they show? ps?

>> +    multifd_recv_state->count++;
>> +
>> +    /* We need to return FALSE for the last channel */
>> +    if (multifd_recv_state->count == thread_count) {
>> +        return FALSE;
>> +    } else {
>> +        return TRUE;
>> +    }
>
> return multifd_recv_state->count != thread_count;   ?

For other reasons I change this functions and now they use a different
way of setting/checking if we have finished.  Look at the new series.

I didn't do as you said because I feel it weird that we return a bool
when we expert a gboolean, but .....

Thanks, Juan.
