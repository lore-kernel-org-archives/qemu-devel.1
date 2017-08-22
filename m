Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7CU-0008Sx-SP
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7CT-0003Z4-LC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:26 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dk7CT-0003Yp-Fn
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:25 -0400
Received: by mail-vk0-x242.google.com with SMTP id r199so7615168vke.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:18:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87h8x6k104.fsf@dusky.pond.sub.org>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-19-marcandre.lureau@redhat.com>
	<87h8x6k104.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Aug 2017 13:18:24 +0200
Message-ID: <CAJ+F1C+SQGcwW+vWQFm6Y3-jksS-p0brsx-i1s4OiKumGjj4xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/26] qapi: add conditions to REPLICATION
 type/commands on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

Hi

On Thu, Aug 17, 2017 at 11:16 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
>> code accordingly.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi-schema.json | 12 ++++++++----
>>  migration/colo.c | 14 ++------------
>>  monitor.c        |  5 -----
>>  3 files changed, 10 insertions(+), 21 deletions(-)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index bcee3157b0..2f4528c769 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -6337,7 +6337,8 @@
>>  # Since: 2.9
>>  ##
>>  { 'command': 'xen-set-replication',
>> -  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' }=
 }
>> +  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' }=
,
>> +  'if': 'defined(CONFIG_REPLICATION)' }
>>
>>  ##
>>  # @ReplicationStatus:
>> @@ -6352,7 +6353,8 @@
>>  # Since: 2.9
>>  ##
>>  { 'struct': 'ReplicationStatus',
>> -  'data': { 'error': 'bool', '*desc': 'str' } }
>> +  'data': { 'error': 'bool', '*desc': 'str' },
>> +  'if': 'defined(CONFIG_REPLICATION)' }
>>
>>  ##
>>  # @query-xen-replication-status:
>> @@ -6369,7 +6371,8 @@
>>  # Since: 2.9
>>  ##
>>  { 'command': 'query-xen-replication-status',
>> -  'returns': 'ReplicationStatus' }
>> +  'returns': 'ReplicationStatus',
>> +  'if': 'defined(CONFIG_REPLICATION)' }
>>
>>  ##
>>  # @xen-colo-do-checkpoint:
>> @@ -6385,7 +6388,8 @@
>>  #
>>  # Since: 2.9
>>  ##
>> -{ 'command': 'xen-colo-do-checkpoint' }
>> +{ 'command': 'xen-colo-do-checkpoint',
>> +  'if': 'defined(CONFIG_REPLICATION)' }
>>
>>  ##
>>  # @GICCapability:
>> diff --git a/migration/colo.c b/migration/colo.c
>> index a4255432ac..3bff9fc9a4 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -147,11 +147,11 @@ void colo_do_failover(MigrationState *s)
>>      }
>>  }
>>
>> +#ifdef CONFIG_REPLICATION
>>  void qmp_xen_set_replication(bool enable, bool primary,
>>                               bool has_failover, bool failover,
>>                               Error **errp)
>>  {
>> -#ifdef CONFIG_REPLICATION
>>      ReplicationMode mode =3D primary ?
>>                             REPLICATION_MODE_PRIMARY :
>>                             REPLICATION_MODE_SECONDARY;
>> @@ -170,14 +170,10 @@ void qmp_xen_set_replication(bool enable, bool pri=
mary,
>>          }
>>          replication_stop_all(failover, failover ? NULL : errp);
>>      }
>> -#else
>> -    abort();
>> -#endif
>>  }
>>
>>  ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
>>  {
>> -#ifdef CONFIG_REPLICATION
>>      Error *err =3D NULL;
>>      ReplicationStatus *s =3D g_new0(ReplicationStatus, 1);
>>
>> @@ -192,19 +188,13 @@ ReplicationStatus *qmp_query_xen_replication_statu=
s(Error **errp)
>>
>>      error_free(err);
>>      return s;
>> -#else
>> -    abort();
>> -#endif
>>  }
>>
>>  void qmp_xen_colo_do_checkpoint(Error **errp)
>>  {
>> -#ifdef CONFIG_REPLICATION
>>      replication_do_checkpoint_all(errp);
>> -#else
>> -    abort();
>> -#endif
>>  }
>> +#endif
>>
>>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>>                                Error **errp)
>> diff --git a/monitor.c b/monitor.c
>> index 4bf6a3ea2e..383c84d162 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -970,11 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
ect **ret_data,
>>   */
>>  static void qmp_unregister_commands_hack(void)
>>  {
>> -#ifndef CONFIG_REPLICATION
>> -    qmp_unregister_command(&qmp_commands, "xen-set-replication");
>> -    qmp_unregister_command(&qmp_commands, "query-xen-replication-status=
");
>> -    qmp_unregister_command(&qmp_commands, "xen-colo-do-checkpoint");
>> -#endif
>>  #ifndef TARGET_I386
>>      qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
>>  #endif
>
> Same drill as for PATCH 16.
>
> Commands you make conditional:
>
> * xen-set-replication, query-xen-replication-status,
>   xen-colo-do-checkpoint
>
>   Before the patch, we first register the commands unconditionally in
>   generated code (requires a stub), then conditionally unregister in
>   qmp_unregister_commands_hack().
>
>   Afterwards, we register only when CONFIG_REPLICATION.  The command
>   fails exactly the same, with CommandNotFound.
>
>   Improvement, because now query-qmp-schema is accurate, and we're one
>   step close to killing qmp_unregister_commands_hack().
>
> Check for completeness by reviewing the case insensitive occurrences of
> replication in the schema not covered by your patch, and review uses of
> CONFIG_REPLICATION for possible schema connections (I did that for
> CONFIG_VNC [PATCH 16] and CONFIG_SPICE [PATCH 17], too):
>
> * enum BlockdevDriver value "replication" in command blockdev-add
>
> * Makefile.objs:block-obj-$(CONFIG_REPLICATION) +=3D replication.o
>   block/Makefile.objs:block-obj-$(CONFIG_REPLICATION) +=3D replication.o
>
> I think the following should be ifdef CONFIG_REPLICATION: enum
> BlockdevDriver value @replication BlockdevOptions variant @replication,
> BlockdevOptionsReplication, BlockdevOptionsReplicationMode.

Added

>
> Some of this analysis should perhaps be worked into the commit message.
>

Done

thanks


--=20
Marc-Andr=C3=A9 Lureau
