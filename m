Received: from eggs.gnu.org ([2001:4830:134:3::10]:52190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gM44N-0008VS-Jg
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 23:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gM44J-00066p-Dp
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 23:43:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:59382 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gM44I-000632-HM
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 23:43:23 -0500
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-6-fli@suse.com> <20181102023738.GD7804@xz-x1>
	<39af00cd-fb54-de7d-154e-d9047156ab43@suse.com>
	<20181102033241.GF7804@xz-x1> <20181102163334.GC2387@work-vm>
From: Fei Li <fli@suse.com>
Message-ID: <a1b6af26-09ef-4957-354b-1b62c8db48b4@suse.com>
Date: Mon, 12 Nov 2018 12:43:11 +0800
MIME-Version: 1.0
In-Reply-To: <20181102163334.GC2387@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v7 5/9] migration: fix the multifd code
 when sending less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, famz@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

Hi Juan,

Kindly ping, as this multifd migration topic needs your suggestions. :)

Have a nice day, thanks
Fei

On 11/03/2018 12:33 AM, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
>> On Fri, Nov 02, 2018 at 11:00:24AM +0800, Fei Li wrote:
>>>
>>> On 11/02/2018 10:37 AM, Peter Xu wrote:
>>>> On Thu, Nov 01, 2018 at 06:17:11PM +0800, Fei Li wrote:
>>>>> Set the migration state to "failed" instead of "setup" when failing
>>>>> to send packet via some channel.
>>>> Could you please provide more information in the commit message?
>>>> E.g., what will happen if without this patch?  Will it crash the
>>>> source or stall the source migration or others?  Otherwise it's a bi=
t
>>>> hard for me to understand what's this patch for.
>>> Sorry for the inadequate description , I was intended to say that whe=
n
>>> failing
>>> to do the live migration using multifd, e.g. sending less channels, t=
he src
>>> status displays "setup" when running `info migrate`. I assume we shou=
ld tell
>>> users that the "Migration status" is "failed" now (and along with the
>>> failure reason).
>>>
>>> The current src status when failed inmultifd_new_send_channel_async()=
=EF=BC=9A
>>>
>>>
>>> (qemu) migrate_set_capability x-multifd on
>>> (qemu) migrate_set_parameter x-multifd-channels 4
>>> (qemu) migrate -d tcp:192.168.190.98:4444
>>> (qemu) qemu-system-x86_64: failed in multifd_new_send_channel_async d=
ue to
>>> ...
>>> (qemu) info migrate
>>> globals:
>>> store-global-state: on
>>> only-migratable: off
>>> send-configuration: on
>>> send-section-footer: on
>>> decompress-error-check: on
>>> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-b=
locks:
>>> off compress: off events: off postcopy-ram: off x-colo: off release-r=
am: off
>>> block: off return-path: off pause-before-switchover: off x-multifd: o=
n
>>> dirty-bitmaps: off postcopy-blocktime: off late-block-activate: off
>>> Migration status: setup
>>> total time: 0 milliseconds
>> Thanks for the information.
>>
>> I had a quick look.  For now we do this:
>>
>>          multifd_save_setup (without waiting for channels to be ready)
>>          create thread migration_thread
>>                  (in thread)
>>                  ram_save_setup
>>                          multifd_send_sync_main (wait for the channels=
)
>>
>> The thing is that we didn't get the notification when one of the
>> multifd channel is failed.  IMHO instead of setting the global
>> migration state in a per-channel function, we should just report the
>> error upwards, then the main thread should decide how to change the
>> state machine of the migration.
> Best to wait for Juan on that; I've got vague memories that reporting
> errors among the threads was a bit tricky.
>
> Dave
>
>> And we have set it in migrate_set_error() after all so the main thread
>> should be able to know somehow (though IMHO I'll even prefer to have a
>> per-channel variable to keep the state of the channel, then the
>> per-channel functions won't touch any globals which offers better
>> isolation).
>>
>> I'm not sure how Juan thinks about it, but I'd prefer some work to
>> provide such isolation and also some mechanism to allow the main
>> thread to detect the per-channel errors not only during setup phase
>> but also during the migration (e.g., when network is suddenly down).
>> Then we don't touch any globals (e.g., we shouldn't call
>> migrate_get_current in any per-channel function like
>> multifd_new_send_channel_async).
>>
>>>> Normally I would prefer to not touch global states in feature specif=
ic
>>>> code path, but I'd like to know the problem more first...
>>>>
>>>> Thanks,
>>>>
>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>> ---
>>>>>    migration/ram.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>>> index 4db3b3e8f4..c84d164fc8 100644
>>>>> --- a/migration/ram.c
>>>>> +++ b/migration/ram.c
>>>>> @@ -1072,6 +1072,7 @@ out:
>>>>>    static void multifd_new_send_channel_async(QIOTask *task, gpoint=
er opaque)
>>>>>    {
>>>>>        MultiFDSendParams *p =3D opaque;
>>>>> +    MigrationState *s =3D migrate_get_current();
>>>>>        QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
>>>>>        Error *local_err =3D NULL;
>>>>> @@ -1083,6 +1084,7 @@ static void multifd_new_send_channel_async(QI=
OTask *task, gpointer opaque)
>>>>>            if (multifd_save_cleanup(&local_err) !=3D 0) {
>>>>>                migrate_set_error(migrate_get_current(), local_err);
>>>>>            }
>>>>> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FA=
ILED);
>>>>>        } else {
>>>>>            p->c =3D QIO_CHANNEL(sioc);
>>>>>            qio_channel_set_delay(p->c, false);
>>>>> --=20
>>>>> 2.13.7
>>>>>
>>>> Regards,
>>>>
>> Regards,
>>
>> --=20
>> Peter Xu
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>
