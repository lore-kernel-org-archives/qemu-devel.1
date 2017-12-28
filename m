Received: from eggs.gnu.org ([2001:4830:134:3::10]:52659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUUIS-0000Nr-Ix
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUUIP-0003OR-BF
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:16:16 -0500
Received: from mail-eopbgr20090.outbound.protection.outlook.com
	([40.107.2.90]:49152
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eUUIO-0003MT-RJ
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:16:13 -0500
References: <20170801160419.14180-1-marcandre.lureau@redhat.com>
	<b3ccb2a7-efe3-2b0b-62ee-a3ab126e0205@virtuozzo.com>
	<20171228021931.GB22514@xz-mi>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <223c3177-fae6-c218-1165-dc01e73c2e14@virtuozzo.com>
Date: Thu, 28 Dec 2017 12:16:04 +0300
MIME-Version: 1.0
In-Reply-To: <20171228021931.GB22514@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] migration: fix small leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

28.12.2017 05:19, Peter Xu wrote:
> On Wed, Dec 27, 2017 at 03:25:23PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> Hmm, looks like leak is not fixed here: I've checked it while running io=
test
>> 181, that
>> migration_instance_finalize is not called.
>>
>> If I understand correct, to call it we need unref current_migration obje=
ct
>> somewhere.
>>
>> Or, may be I'm missing something..
> I think you are right.
>
> It does not matter much though since we don't dynamically allocate
> migration object (there is only one and it lives forever).  Do you
> want to post a patch?  I guess the safest place to unref it is at the
> end of main() to make sure no one will be using it any more.
>
> (Hmm, the incoming migration state is still static)
>
> Thanks,

Ok, I'll send a patch.

>
>> 01.08.2017 19:04, Marc-Andr=C3=A9 Lureau wrote:
>>> Spotted thanks to valgrind and tests/device-introspect-test:
>>>
>>> =3D=3D11711=3D=3D 1 bytes in 1 blocks are definitely lost in loss recor=
d 6 of 14,537
>>> =3D=3D11711=3D=3D    at 0x4C2EB6B: malloc (vg_replace_malloc.c:299)
>>> =3D=3D11711=3D=3D    by 0x1E0CDBD8: g_malloc (gmem.c:94)
>>> =3D=3D11711=3D=3D    by 0x1E0E696E: g_strdup (gstrfuncs.c:363)
>>> =3D=3D11711=3D=3D    by 0x695693: migration_instance_init (migration.c:=
2226)
>>> =3D=3D11711=3D=3D    by 0x717C4B: object_init_with_type (object.c:344)
>>> =3D=3D11711=3D=3D    by 0x717E80: object_initialize_with_type (object.c=
:375)
>>> =3D=3D11711=3D=3D    by 0x7182EB: object_new_with_type (object.c:483)
>>> =3D=3D11711=3D=3D    by 0x718328: object_new (object.c:493)
>>> =3D=3D11711=3D=3D    by 0x4B8A29: qmp_device_list_properties (qmp.c:542=
)
>>> =3D=3D11711=3D=3D    by 0x4A9561: qmp_marshal_device_list_properties (q=
mp-marshal.c:1425)
>>> =3D=3D11711=3D=3D    by 0x819D4A: do_qmp_dispatch (qmp-dispatch.c:104)
>>> =3D=3D11711=3D=3D    by 0x819E82: qmp_dispatch (qmp-dispatch.c:131)
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    migration/migration.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 085c32c994..c3fe0ed9ca 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2214,6 +2214,15 @@ static void migration_class_init(ObjectClass *kl=
ass, void *data)
>>>        dc->props =3D migration_properties;
>>>    }
>>> +static void migration_instance_finalize(Object *obj)
>>> +{
>>> +    MigrationState *ms =3D MIGRATION_OBJ(obj);
>>> +    MigrationParameters *params =3D &ms->parameters;
>>> +
>>> +    g_free(params->tls_hostname);
>>> +    g_free(params->tls_creds);
>>> +}
>>> +
>>>    static void migration_instance_init(Object *obj)
>>>    {
>>>        MigrationState *ms =3D MIGRATION_OBJ(obj);
>>> @@ -2282,6 +2291,7 @@ static const TypeInfo migration_type =3D {
>>>        .class_size =3D sizeof(MigrationClass),
>>>        .instance_size =3D sizeof(MigrationState),
>>>        .instance_init =3D migration_instance_init,
>>> +    .instance_finalize =3D migration_instance_finalize,
>>>    };
>>>    static void register_migration_types(void)
>>
>> --=20
>> Best regards,
>> Vladimir
>>
>>


--=20
Best regards,
Vladimir
