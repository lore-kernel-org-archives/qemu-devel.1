Received: from eggs.gnu.org ([2001:4830:134:3::10]:37247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gIPhR-000875-CY
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 23:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gIPhM-0000ws-ED
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 23:00:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:38800 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gIPhK-0000uK-OT
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 23:00:35 -0400
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-6-fli@suse.com> <20181102023738.GD7804@xz-x1>
From: Fei Li <fli@suse.com>
Message-ID: <39af00cd-fb54-de7d-154e-d9047156ab43@suse.com>
Date: Fri, 2 Nov 2018 11:00:24 +0800
MIME-Version: 1.0
In-Reply-To: <20181102023738.GD7804@xz-x1>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, quintela@redhat.com



On 11/02/2018 10:37 AM, Peter Xu wrote:
> On Thu, Nov 01, 2018 at 06:17:11PM +0800, Fei Li wrote:
>> Set the migration state to "failed" instead of "setup" when failing
>> to send packet via some channel.
> Could you please provide more information in the commit message?
> E.g., what will happen if without this patch?  Will it crash the
> source or stall the source migration or others?  Otherwise it's a bit
> hard for me to understand what's this patch for.
Sorry for the inadequate description , I was intended to say that when=20
failing
to do the live migration using multifd, e.g. sending less channels, the s=
rc
status displays "setup" when running `info migrate`. I assume we should t=
ell
users that the "Migration status" is "failed" now (and along with the=20
failure reason).

The current src status when failed inmultifd_new_send_channel_async()=EF=BC=
=9A


(qemu) migrate_set_capability x-multifd on
(qemu) migrate_set_parameter x-multifd-channels 4
(qemu) migrate -d tcp:192.168.190.98:4444
(qemu) qemu-system-x86_64: failed in multifd_new_send_channel_async due=20
to ...
(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off=20
zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off=20
release-ram: off block: off return-path: off pause-before-switchover:=20
off x-multifd: on dirty-bitmaps: off postcopy-blocktime: off=20
late-block-activate: off
Migration status: setup
total time: 0 milliseconds

>
> Normally I would prefer to not touch global states in feature specific
> code path, but I'd like to know the problem more first...
>
> Thanks,
>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   migration/ram.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 4db3b3e8f4..c84d164fc8 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1072,6 +1072,7 @@ out:
>>   static void multifd_new_send_channel_async(QIOTask *task, gpointer o=
paque)
>>   {
>>       MultiFDSendParams *p =3D opaque;
>> +    MigrationState *s =3D migrate_get_current();
>>       QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
>>       Error *local_err =3D NULL;
>>  =20
>> @@ -1083,6 +1084,7 @@ static void multifd_new_send_channel_async(QIOTa=
sk *task, gpointer opaque)
>>           if (multifd_save_cleanup(&local_err) !=3D 0) {
>>               migrate_set_error(migrate_get_current(), local_err);
>>           }
>> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILE=
D);
>>       } else {
>>           p->c =3D QIO_CHANNEL(sioc);
>>           qio_channel_set_delay(p->c, false);
>> --=20
>> 2.13.7
>>
> Regards,
>
