Received: from eggs.gnu.org ([2001:4830:134:3::10]:56513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSb6p-0001gu-70
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 00:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSb6k-0005OL-7w
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 00:12:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:55492 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gSb6j-0005Nu-Tk
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 00:12:54 -0500
References: <20181129100340.13823-1-fli@suse.com>
	<20181129100340.13823-5-fli@suse.com>
	<35413c93-dd69-83bd-e144-444a7e94c001@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <fc6d956d-a2cf-49f3-4e70-216661ba3e10@suse.com>
Date: Fri, 30 Nov 2018 13:12:47 +0800
MIME-Version: 1.0
In-Reply-To: <35413c93-dd69-83bd-e144-444a7e94c001@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/5] migration: remove unused
 &local_err parameter in multifd_save_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org



On 11/29/2018 10:50 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 29/11/18 11:03, Fei Li wrote:
>> Always call migrate_set_error() to set the error state without relying
>> on whether multifd_save_cleanup() succeeds.  As the passed &local_err
>> is never used in multifd_save_cleanup(), remove it. And make the
>> function be: void multifd_save_cleanup(void).
> Reading this after your patch 1/5, maybe multifd_save_cleanup() lacks
> error reporting on failure. So the actual prototype is correct, we just
> need to use **errp in that function (like reporting invalid thread
> instead of calling qemu_thread_join()).
Sorry that maybe the patch sequences causethe mis-understanding.
The patch "2/5: qemu_thread_join: fix segmentation fault" is added to
fix another problem when qemu_thread_create() fails.

The qemu_thread_join() =3D> pthread_join in multifd_save_cleanup() is
used to terminate the already created/running thread, so I do not
think it should be replaced. Besides, do we need to report the
invalid thread for users?
But for multifd_save_cleanup() itself, it is called when
1. fails to send one multifd channel. In this way, the error reason has
 =C2=A0=C2=A0=C2=A0 been stored in MigrationState->error, but not be prin=
ted. I think we
 =C2=A0=C2=A0=C2=A0 can add a `error_report_err(local_err)` in=20
multifd_new_send_channel_async()
 =C2=A0=C2=A0=C2=A0 just as follows:

@@ -1070,6 +1070,7 @@ static void multifd_new_send_channel_async(QIOTask=20
*task, gpointer opaque)
 =C2=A0=C2=A0=C2=A0=C2=A0 if (qio_task_propagate_error(task, &local_err))=
 {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrate_set_error(migra=
te_get_current(), local_err);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_save_cleanup();
 =C2=A0=C2=A0=C2=A0=C2=A0 } else {

BTW, we also need to notify the main thread that the migrate_state
is failed in this case, but currently this issue is still under discussio=
n.
Please see patch 5/9 in"[PATCH RFC v7 0/9] qemu_thread_create:
propagate errors to callers to check." for more details. :)
2. migrate_fd_cleanup() is called to do the cleanup (In this way, the rea=
l
 =C2=A0 =C2=A0 error reason is stored and also will be printed inside in=20
migrate_fd_cleanup()
 =C2=A0=C2=A0=C2=A0 or before migrate_fd_cleanup() is called. Thus IMO no=
 update is=20
needed here.)

Have a nice day, thanks
Fei
>> Signed-off-by: Fei Li <fli@suse.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   migration/migration.c |  5 +----
>>   migration/ram.c       | 11 ++++-------
>>   migration/ram.h       |  2 +-
>>   3 files changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 72106bddf0..0537fc0c26 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1386,7 +1386,6 @@ static void migrate_fd_cleanup(void *opaque)
>>       qemu_savevm_state_cleanup();
>>  =20
>>       if (s->to_dst_file) {
>> -        Error *local_err =3D NULL;
>>           QEMUFile *tmp;
>>  =20
>>           trace_migrate_fd_cleanup();
>> @@ -1397,9 +1396,7 @@ static void migrate_fd_cleanup(void *opaque)
>>           }
>>           qemu_mutex_lock_iothread();
>>  =20
>> -        if (multifd_save_cleanup(&local_err) !=3D 0) {
>> -            error_report_err(local_err);
>> -        }
>> +        multifd_save_cleanup();
>>           qemu_mutex_lock(&s->qemu_file_lock);
>>           tmp =3D s->to_dst_file;
>>           s->to_dst_file =3D NULL;
>> diff --git a/migration/ram.c b/migration/ram.c
>> index e13b9349d0..c44cb6f56d 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -917,13 +917,12 @@ static void multifd_send_terminate_threads(Error=
 *err)
>>       }
>>   }
>>  =20
>> -int multifd_save_cleanup(Error **errp)
>> +void multifd_save_cleanup(void)
>>   {
>>       int i;
>> -    int ret =3D 0;
>>  =20
>>       if (!migrate_use_multifd()) {
>> -        return 0;
>> +        return;
>>       }
>>       multifd_send_terminate_threads(NULL);
>>       for (i =3D 0; i < migrate_multifd_channels(); i++) {
>> @@ -953,7 +952,6 @@ int multifd_save_cleanup(Error **errp)
>>       multifd_send_state->pages =3D NULL;
>>       g_free(multifd_send_state);
>>       multifd_send_state =3D NULL;
>> -    return ret;
>>   }
>>  =20
>>   static void multifd_send_sync_main(void)
>> @@ -1071,9 +1069,8 @@ static void multifd_new_send_channel_async(QIOTa=
sk *task, gpointer opaque)
>>       Error *local_err =3D NULL;
>>  =20
>>       if (qio_task_propagate_error(task, &local_err)) {
>> -        if (multifd_save_cleanup(&local_err) !=3D 0) {
>> -            migrate_set_error(migrate_get_current(), local_err);
>> -        }
>> +        migrate_set_error(migrate_get_current(), local_err);
>> +        multifd_save_cleanup();
>>       } else {
>>           p->c =3D QIO_CHANNEL(sioc);
>>           qio_channel_set_delay(p->c, false);
>> diff --git a/migration/ram.h b/migration/ram.h
>> index 046d3074be..936177b3e9 100644
>> --- a/migration/ram.h
>> +++ b/migration/ram.h
>> @@ -43,7 +43,7 @@ uint64_t ram_bytes_remaining(void);
>>   uint64_t ram_bytes_total(void);
>>  =20
>>   int multifd_save_setup(void);
>> -int multifd_save_cleanup(Error **errp);
>> +void multifd_save_cleanup(void);
>>   int multifd_load_setup(void);
>>   int multifd_load_cleanup(Error **errp);
>>   bool multifd_recv_all_channels_created(void);
>>
>
