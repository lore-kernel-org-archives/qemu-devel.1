Received: from eggs.gnu.org ([2001:4830:134:3::10]:34197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gZozR-0007vX-RJ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gZozO-0005Ea-JE
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:27:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:52648 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gZozO-0005D4-4v
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:27:10 -0500
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-4-fli@suse.com>
	<87wooec5md.fsf@dusky.pond.sub.org>
	<67eb7e9e-b128-a6ec-2063-24faf2ffe4aa@suse.com>
	<874lb9hahz.fsf@dusky.pond.sub.org>
From: Fei Li <fli@suse.com>
Message-ID: <40f29c08-60b4-bff0-4e85-c80a6421aa35@suse.com>
Date: Thu, 20 Dec 2018 11:27:04 +0800
MIME-Version: 1.0
In-Reply-To: <874lb9hahz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 3/7] migration: fix the multifd
 code when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 12/19/2018 10:11 PM, Markus Armbruster wrote:
> Fei Li <fli@suse.com> writes:
>
>> On 12/13/2018 02:17 PM, Markus Armbruster wrote:
>>> Fei Li <fli@suse.com> writes:
>>>
>>>> In our current code, when multifd is used during migration, if there
>>>> is an error before the destination receives all new channels, the
>>>> source keeps running, however the destination does not exit but keeps
>>>> waiting until the source is killed deliberately.
>>>>
>>>> Fix this by dumping the specific error and let users decide whether
>>>> to quit from the destination side when failing to receive packet via
>>>> some channel.
>>>>
>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
> [...]
>>>> diff --git a/migration/migration.h b/migration/migration.h
>>>> index e413d4d8b6..02b7304610 100644
>>>> --- a/migration/migration.h
>>>> +++ b/migration/migration.h
>>>> @@ -229,7 +229,7 @@ struct MigrationState
>>>>    void migrate_set_state(int *state, int old_state, int new_state);
>>>>      void migration_fd_process_incoming(QEMUFile *f);
>>>> -void migration_ioc_process_incoming(QIOChannel *ioc);
>>>> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>>>>    void migration_incoming_process(void);
>>>>      bool  migration_has_all_channels(void);
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index 7e7deec4d8..c7e3d6b0fd 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -1323,7 +1323,7 @@ bool multifd_recv_all_channels_created(void)
>>>>    }
>>>>      /* Return true if multifd is ready for the migration, otherwise
>>>> false */
>>>> -bool multifd_recv_new_channel(QIOChannel *ioc)
>>>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>>>    {
>>>>        MultiFDRecvParams *p;
>>>>        Error *local_err = NULL;
>>>> @@ -1331,6 +1331,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>>>          id = multifd_recv_initial_packet(ioc, &local_err);
>>>>        if (id < 0) {
>>>> +        error_propagate_prepend(errp, local_err,
>>>> +                                "failed to receive packet"
>>>> +                                " via multifd channel %d: ",
>>>> +                                atomic_read(&multifd_recv_state->count));
>>>>            multifd_recv_terminate_threads(local_err);
>>>>            return false;
>>> Here, we return false without setting an error.
>> I am not sure whether I understand correctly, but here I think the above
>> error_propagate_prepend() set the error to errp.
> You're right, I got confused.
>
> However, you shouldn't access @local_err after error_propagate() or
> similar.  Please insert error_propagate_prepend() after
> multifd_recv_terminate_threads(), lik you do in the next hunk.
Right, thanks for the reminder.

Have a nice day :)
Fei
>
>>>>        }
>>>> @@ -1340,6 +1344,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>>>            error_setg(&local_err, "multifd: received id '%d' already setup'",
>>>>                       id);
>>>>            multifd_recv_terminate_threads(local_err);
>>>> +        error_propagate(errp, local_err);
>>>>            return false;
>>> Here, we return false with setting an error.
>>>
>>>>        }
>>>>        p->c = ioc;
>>>> @@ -1351,7 +1356,8 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>>>        qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>>>>                           QEMU_THREAD_JOINABLE);
>>>>        atomic_inc(&multifd_recv_state->count);
>>>> -    return multifd_recv_state->count == migrate_multifd_channels();
>>>> +    return atomic_read(&multifd_recv_state->count) ==
>>>> +           migrate_multifd_channels();
>>> Here, we return either true of false without setting an error.
>> yes.
>>> Taken together, there are three cases:
>>>
>>> 1. Succeed and return true
>> Yes, when all multifd channels are correctly received.
>>> 2. Succeed and return false
>> Yes, when the current multifd channel is received correctly, but
>> have not received all the channels.
> Aha.
>
>>> 3. Fail (set an error) and return false.
>> Yes. And with the propagated error, the code just returns and
>> report the error in migration_channel_process_incoming().
>>> Assuming that's what we want: please update the function comment to
>>> spell them out.
>> Ok, I will update the three cases in the comment to clarify in detail.
>>
>> Have a nice day, thanks :)
> You're welcome!
>
>
