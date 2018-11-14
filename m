Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMt07-0006fJ-IU
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMt02-0003k5-E5
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:06:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMt02-0003jW-5l
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:06:22 -0500
References: <20181101021226.6353-1-zhangckid@gmail.com>
	<20181114104720.GB3955@xz-x1>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <74cca5d1-d2b4-6b44-32fe-332136b8b171@redhat.com>
Date: Wed, 14 Nov 2018 12:06:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181114104720.GB3955@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 2018-11-14 11:47, Peter Xu wrote:
> On Thu, Nov 01, 2018 at 10:12:26AM +0800, Zhang Chen wrote:
>> This compilation issue will occur when user use --disable-replication
>> to config Qemu.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>=20
> Hi,
>=20
> How's the status of this patch?  Are we gonna merge it for 3.1?
>=20
> I just posted a similar one without knowing this (until Dave pointed
> it out).  IMHO it can be a good candidate for 3.1.

Maybe Peter Maydell could apply this directly to the repo as a built fix?

And maybe one of our docker wizards could add a test to check
compilation with everything disabled a la:

./configure --enable-werror --disable-tcg --disable-slirp \
  --disable-libxml2 --disable-capstone --disable-live-block-migration \
  --disable-glusterfs --disable-replication --disable-coroutine-pool \
  --disable-smartcard --disable-guest-agent --disable-curses \
  --disable-curl --disable-tpm --disable-qom-cast-debug \
  --disable-spice --disable-vhost-vsock  --disable-vhost-net \
  --disable-vhost-crypto --disable-vhost-user

?

I don't use docker (yet), but I've had this in my gitlab ci patch,
that's how I noticed this problem (see
https://www.mail-archive.com/qemu-devel@nongnu.org/msg559990.html)

 Thomas


>=20
>> ---
>>  migration/colo.c | 28 +++++++++++++++++++++++++++-
>>  1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 956ac236b7..fcff04c78c 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -59,6 +59,8 @@ static bool colo_runstate_is_stopped(void)
>> =20
>>  static void secondary_vm_do_failover(void)
>>  {
>> +/* COLO needs enable block-replication */
>> +#ifdef CONFIG_REPLICATION
>>      int old_state;
>>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>>      Error *local_err =3D NULL;
>> @@ -121,10 +123,14 @@ static void secondary_vm_do_failover(void)
>>      if (mis->migration_incoming_co) {
>>          qemu_coroutine_enter(mis->migration_incoming_co);
>>      }
>> +#else
>> +    abort();
>> +#endif
>>  }
>> =20
>>  static void primary_vm_do_failover(void)
>>  {
>> +#ifdef CONFIG_REPLICATION
>>      MigrationState *s =3D migrate_get_current();
>>      int old_state;
>>      Error *local_err =3D NULL;
>> @@ -165,6 +171,9 @@ static void primary_vm_do_failover(void)
>> =20
>>      /* Notify COLO thread that failover work is finished */
>>      qemu_sem_post(&s->colo_exit_sem);
>> +#else
>> +    abort();
>> +#endif
>>  }
>> =20
>>  COLOMode get_colo_mode(void)
>> @@ -415,11 +424,16 @@ static int colo_do_checkpoint_transaction(Migrat=
ionState *s,
>>      /* Disable block migration */
>>      migrate_set_block_enabled(false, &local_err);
>>      qemu_mutex_lock_iothread();
>> +
>> +#ifdef CONFIG_REPLICATION
>>      replication_do_checkpoint_all(&local_err);
>>      if (local_err) {
>>          qemu_mutex_unlock_iothread();
>>          goto out;
>>      }
>> +#else
>> +        abort();
>> +#endif
>> =20
>>      colo_send_message(s->to_dst_file, COLO_MESSAGE_VMSTATE_SEND, &loc=
al_err);
>>      if (local_err) {
>> @@ -523,11 +537,15 @@ static void colo_process_checkpoint(MigrationSta=
te *s)
>>      object_unref(OBJECT(bioc));
>> =20
>>      qemu_mutex_lock_iothread();
>> +#ifdef CONFIG_REPLICATION
>>      replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
>>      if (local_err) {
>>          qemu_mutex_unlock_iothread();
>>          goto out;
>>      }
>> +#else
>> +        abort();
>> +#endif
>> =20
>>      vm_start();
>>      qemu_mutex_unlock_iothread();
>> @@ -690,11 +708,15 @@ void *colo_process_incoming_thread(void *opaque)
>>      object_unref(OBJECT(bioc));
>> =20
>>      qemu_mutex_lock_iothread();
>> +#ifdef CONFIG_REPLICATION
>>      replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
>>      if (local_err) {
>>          qemu_mutex_unlock_iothread();
>>          goto out;
>>      }
>> +#else
>> +        abort();
>> +#endif
>>      vm_start();
>>      trace_colo_vm_state_change("stop", "run");
>>      qemu_mutex_unlock_iothread();
>> @@ -785,18 +807,22 @@ void *colo_process_incoming_thread(void *opaque)
>>              goto out;
>>          }
>> =20
>> +#ifdef CONFIG_REPLICATION
>>          replication_get_error_all(&local_err);
>>          if (local_err) {
>>              qemu_mutex_unlock_iothread();
>>              goto out;
>>          }
>> +
>>          /* discard colo disk buffer */
>>          replication_do_checkpoint_all(&local_err);
>>          if (local_err) {
>>              qemu_mutex_unlock_iothread();
>>              goto out;
>>          }
>> -
>> +#else
>> +        abort();
>> +#endif
>>          /* Notify all filters of all NIC to do checkpoint */
>>          colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
>> =20
>> --=20
>> 2.17.1
>>
>>
>=20
> Regards,
>=20
