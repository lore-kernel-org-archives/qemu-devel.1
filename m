Received: from eggs.gnu.org ([209.51.188.92]:40067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtoL-0001nD-NE
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggtoD-0004AG-W5
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:01:01 -0500
Received: from m15-114.126.com ([220.181.15.114]:45003)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1ggto8-0003mN-2z
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:00:50 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: fei <lifei1214@126.com>
In-Reply-To: <87ftu4mli7.fsf@dusky.pond.sub.org>
Date: Wed, 9 Jan 2019 00:00:21 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <8450A2A5-2204-4FCE-8F02-E8B2FD003057@126.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-9-fli@suse.com>
	<87ftu4mli7.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 08/16] qemu_thread: supplement
 error handling for qmp_dump_guest_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>



> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:21=EF=BC=8CMarkus A=
rmbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Fei Li <fli@suse.com> writes:
>=20
>> Utilize the existed errp to propagate the error instead of the
>> temporary &error_abort.
>>=20
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>> dump.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/dump.c b/dump.c
>> index c35d6ddd22..ef5ea324fa 100644
>> --- a/dump.c
>> +++ b/dump.c
>> @@ -2020,9 +2020,10 @@ void qmp_dump_guest_memory(bool paging, const char=
 *file,
>>     if (detach_p) {
>>         /* detached dump */
>>         s->detached =3D true;
>> -        /* TODO: let the further caller handle the error instead of abor=
t() */
>> -        qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
>> -                           s, QEMU_THREAD_DETACHED, &error_abort);
>> +        if (!qemu_thread_create(&s->dump_thread, "dump_thread", dump_thr=
ead,
>> +                           s, QEMU_THREAD_DETACHED, errp)) {
>> +            /* keep 'if' here in case there is further error handling lo=
gic */
>> +        }
>=20
> I don't think keeping the conditional "just in case" is worthwhile.
> Plain
>=20
>           qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
>                              s, QEMU_THREAD_DETACHED, errp);
>=20
> should do fine.
Ok, will simplify this in next version.

Have a nice day, thanks
Fei
>=20
>>     } else {
>>         /* sync dump */
>>         dump_process(s, errp);
