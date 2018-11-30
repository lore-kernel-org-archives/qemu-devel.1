Received: from eggs.gnu.org ([2001:4830:134:3::10]:40697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSZkd-0004IP-Tm
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 22:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSZka-0000gy-Lb
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 22:45:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:48208 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gSZka-0000gA-Aw
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 22:45:56 -0500
References: <20181129100340.13823-1-fli@suse.com>
	<20181129100340.13823-4-fli@suse.com>
	<9e1bf8ec-8b2a-088b-2a5d-d946c1139e59@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <fb01e0b2-c064-f147-07f8-dd86ed722c72@suse.com>
Date: Fri, 30 Nov 2018 11:45:45 +0800
MIME-Version: 1.0
In-Reply-To: <9e1bf8ec-8b2a-088b-2a5d-d946c1139e59@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 3/5] migration: fix the multifd code
 when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org



On 11/29/2018 10:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Fei,
>
> On 29/11/18 11:03, Fei Li wrote:
>> In our current code, when multifd is used during migration, if there
>> is an error before the destination receives all new channels, the
>> source keeps running, however the destination does not exit but keeps
>> waiting until the source is killed deliberately.
>>
>> Fix this by dumping the specific error and let users decide whether
>> to quit from the destination side when failing to receive packet via
>> some channel.
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   migration/channel.c   | 11 ++++++-----
>>   migration/migration.c |  9 +++++++--
>>   migration/migration.h |  2 +-
>>   migration/ram.c       |  7 ++++++-
>>   migration/ram.h       |  2 +-
>>   5 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 33e0e9b82f..20e4c8e2dc 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -30,6 +30,7 @@
>>   void migration_channel_process_incoming(QIOChannel *ioc)
>>   {
>>       MigrationState *s =3D migrate_get_current();
>> +    Error *local_err =3D NULL;
>>  =20
>>       trace_migration_set_incoming_channel(
>>           ioc, object_get_typename(OBJECT(ioc)));
>> @@ -38,13 +39,13 @@ void migration_channel_process_incoming(QIOChannel=
 *ioc)
>>           *s->parameters.tls_creds &&
>>           !object_dynamic_cast(OBJECT(ioc),
>>                                TYPE_QIO_CHANNEL_TLS)) {
>> -        Error *local_err =3D NULL;
>>           migration_tls_channel_process_incoming(s, ioc, &local_err);
>> -        if (local_err) {
>> -            error_report_err(local_err);
>> -        }
>>       } else {
>> -        migration_ioc_process_incoming(ioc);
>> +        migration_ioc_process_incoming(ioc, &local_err);
>> +    }
>> +
>> +    if (local_err) {
>> +        error_report_err(local_err);
>>       }
>>   }
>>  =20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 49ffb9997a..72106bddf0 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -541,7 +541,7 @@ void migration_fd_process_incoming(QEMUFile *f)
>>       migration_incoming_process();
>>   }
>>  =20
>> -void migration_ioc_process_incoming(QIOChannel *ioc)
>> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>   {
>>       MigrationIncomingState *mis =3D migration_incoming_get_current()=
;
>>       bool start_migration;
>> @@ -563,9 +563,14 @@ void migration_ioc_process_incoming(QIOChannel *i=
oc)
>>            */
>>           start_migration =3D !migrate_use_multifd();
>>       } else {
>> +        Error *local_err =3D NULL;
>>           /* Multiple connections */
>>           assert(migrate_use_multifd());
>> -        start_migration =3D multifd_recv_new_channel(ioc);
>> +        start_migration =3D multifd_recv_new_channel(ioc, &local_err)=
;
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>>       }
>>  =20
>>       if (start_migration) {
>> diff --git a/migration/migration.h b/migration/migration.h
>> index e413d4d8b6..02b7304610 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -229,7 +229,7 @@ struct MigrationState
>>   void migrate_set_state(int *state, int old_state, int new_state);
>>  =20
>>   void migration_fd_process_incoming(QEMUFile *f);
>> -void migration_ioc_process_incoming(QIOChannel *ioc);
>> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>>   void migration_incoming_process(void);
>>  =20
>>   bool  migration_has_all_channels(void);
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 7e7deec4d8..e13b9349d0 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1323,7 +1323,7 @@ bool multifd_recv_all_channels_created(void)
>>   }
>>  =20
>>   /* Return true if multifd is ready for the migration, otherwise fals=
e */
>> -bool multifd_recv_new_channel(QIOChannel *ioc)
>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>   {
>>       MultiFDRecvParams *p;
>>       Error *local_err =3D NULL;
>> @@ -1331,6 +1331,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>  =20
>>       id =3D multifd_recv_initial_packet(ioc, &local_err);
>>       if (id < 0) {
>> +        error_propagate_prepend(errp, local_err,
>> +                                "failed to receive packet"
>> +                                " via multifd channel %d: ",
>> +                                multifd_recv_state->count);
> Shouldn't we use atomic_read(&multifd_recv_state->count) here?
Right, will update this in next version. Thanks for pointing it out. :)
BTW, should we do the same update for the below sentence:
` return multifd_recv_state->count =3D=3D migrate_multifd_channels();`?

Have a nice day
Fei
>
> Patch looks good otherwise.
>
> Regards,
>
> Phil.
>
>>           multifd_recv_terminate_threads(local_err);
>>           return false;
>>       }
>> @@ -1340,6 +1344,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>           error_setg(&local_err, "multifd: received id '%d' already se=
tup'",
>>                      id);
>>           multifd_recv_terminate_threads(local_err);
>> +        error_propagate(errp, local_err);
>>           return false;
>>       }
>>       p->c =3D ioc;
>> diff --git a/migration/ram.h b/migration/ram.h
>> index 83ff1bc11a..046d3074be 100644
>> --- a/migration/ram.h
>> +++ b/migration/ram.h
>> @@ -47,7 +47,7 @@ int multifd_save_cleanup(Error **errp);
>>   int multifd_load_setup(void);
>>   int multifd_load_cleanup(Error **errp);
>>   bool multifd_recv_all_channels_created(void);
>> -bool multifd_recv_new_channel(QIOChannel *ioc);
>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>>  =20
>>   uint64_t ram_pagesize_summary(void);
>>   int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_a=
ddr_t len);
>>
>
