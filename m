Received: from eggs.gnu.org ([2001:4830:134:3::10]:48813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gUnBp-0004Vy-Jk
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gUnBl-0006AM-7N
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:31:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:37406 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gUnBk-00067l-Pw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:31:09 -0500
From: Fei Li <fli@suse.com>
References: <20181129100340.13823-1-fli@suse.com>
	<20181129100340.13823-4-fli@suse.com>
	<9e1bf8ec-8b2a-088b-2a5d-d946c1139e59@redhat.com>
	<fb01e0b2-c064-f147-07f8-dd86ed722c72@suse.com>
Message-ID: <62bd4a18-7995-15b5-c8c9-b7905173b404@suse.com>
Date: Thu, 6 Dec 2018 14:31:01 +0800
MIME-Version: 1.0
In-Reply-To: <fb01e0b2-c064-f147-07f8-dd86ed722c72@suse.com>
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



On 11/30/2018 11:45 AM, Fei Li wrote:
>
>
> On 11/29/2018 10:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Fei,
>>
>> On 29/11/18 11:03, Fei Li wrote:
>>> In our current code, when multifd is used during migration, if there
>>> is an error before the destination receives all new channels, the
>>> source keeps running, however the destination does not exit but keeps
>>> waiting until the source is killed deliberately.
>>>
>>> Fix this by dumping the specific error and let users decide whether
>>> to quit from the destination side when failing to receive packet via
>>> some channel.
>>>
>>> Signed-off-by: Fei Li <fli@suse.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> ---
>>> =C2=A0 migration/channel.c=C2=A0=C2=A0 | 11 ++++++-----
>>> =C2=A0 migration/migration.c |=C2=A0 9 +++++++--
>>> =C2=A0 migration/migration.h |=C2=A0 2 +-
>>> =C2=A0 migration/ram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 =
++++++-
>>> =C2=A0 migration/ram.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
>>> =C2=A0 5 files changed, 21 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/migration/channel.c b/migration/channel.c
>>> index 33e0e9b82f..20e4c8e2dc 100644
>>> --- a/migration/channel.c
>>> +++ b/migration/channel.c
>>> @@ -30,6 +30,7 @@
>>> =C2=A0 void migration_channel_process_incoming(QIOChannel *ioc)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigrationState *s =3D migrate_get_curr=
ent();
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_migration_set_incoming_ch=
annel(
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioc, object_ge=
t_typename(OBJECT(ioc)));
>>> @@ -38,13 +39,13 @@ void=20
>>> migration_channel_process_incoming(QIOChannel *ioc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *s->parameters=
.tls_creds &&
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !object_dynami=
c_cast(OBJECT(ioc),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_QIO_CHANNEL_TLS)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migration_tls_=
channel_process_incoming(s, ioc, &local_err);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report_err(local_err);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migration_ioc_process_inc=
oming(ioc);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migration_ioc_process_inc=
oming(ioc, &local_err);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_er=
r);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> =C2=A0 diff --git a/migration/migration.c b/migration/migration.c
>>> index 49ffb9997a..72106bddf0 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -541,7 +541,7 @@ void migration_fd_process_incoming(QEMUFile *f)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migration_incoming_process();
>>> =C2=A0 }
>>> =C2=A0 -void migration_ioc_process_incoming(QIOChannel *ioc)
>>> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigrationIncomingState *mis =3D migrat=
ion_incoming_get_current();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool start_migration;
>>> @@ -563,9 +563,14 @@ void migration_ioc_process_incoming(QIOChannel=20
>>> *ioc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_migratio=
n =3D !migrate_use_multifd();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Multiple co=
nnections */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(migrate=
_use_multifd());
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_migration =3D multi=
fd_recv_new_channel(ioc);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_migration =3D multi=
fd_recv_new_channel(ioc, &local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_propagate(errp, local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (start_migration) {
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index e413d4d8b6..02b7304610 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -229,7 +229,7 @@ struct MigrationState
>>> =C2=A0 void migrate_set_state(int *state, int old_state, int new_stat=
e);
>>> =C2=A0 =C2=A0 void migration_fd_process_incoming(QEMUFile *f);
>>> -void migration_ioc_process_incoming(QIOChannel *ioc);
>>> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>>> =C2=A0 void migration_incoming_process(void);
>>> =C2=A0 =C2=A0 bool=C2=A0 migration_has_all_channels(void);
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 7e7deec4d8..e13b9349d0 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -1323,7 +1323,7 @@ bool multifd_recv_all_channels_created(void)
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 /* Return true if multifd is ready for the migration, o=
therwise=20
>>> false */
>>> -bool multifd_recv_new_channel(QIOChannel *ioc)
>>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MultiFDRecvParams *p;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> @@ -1331,6 +1331,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D multifd_recv_initial_pac=
ket(ioc, &local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (id < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate_prepend(e=
rrp, local_err,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to receive packet"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " via multifd channel %d: ",
>>> + multifd_recv_state->count);
>> Shouldn't we use atomic_read(&multifd_recv_state->count) here?
> Right, will update this in next version. Thanks for pointing it out. :)
> BTW, should we do the same update for the below sentence:
> ` return multifd_recv_state->count =3D=3D migrate_multifd_channels();`?
>
> Have a nice day
> Fei
Kindly ping. :)
Thanks in advance.
>>
>> Patch looks good otherwise.
>>
>> Regards,
>>
>> Phil.
>>
>>> multifd_recv_terminate_threads(local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -1340,6 +1344,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&lo=
cal_err, "multifd: received id '%d' already=20
>>> setup'",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_t=
erminate_threads(local_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->c =3D ioc;
>>> diff --git a/migration/ram.h b/migration/ram.h
>>> index 83ff1bc11a..046d3074be 100644
>>> --- a/migration/ram.h
>>> +++ b/migration/ram.h
>>> @@ -47,7 +47,7 @@ int multifd_save_cleanup(Error **errp);
>>> =C2=A0 int multifd_load_setup(void);
>>> =C2=A0 int multifd_load_cleanup(Error **errp);
>>> =C2=A0 bool multifd_recv_all_channels_created(void);
>>> -bool multifd_recv_new_channel(QIOChannel *ioc);
>>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>>> =C2=A0 =C2=A0 uint64_t ram_pagesize_summary(void);
>>> =C2=A0 int ram_save_queue_pages(const char *rbname, ram_addr_t start,=
=20
>>> ram_addr_t len);
>>>
>>
>
