Received: from eggs.gnu.org ([2001:4830:134:3::10]:41444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1OW-0006zo-8C
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1OR-0003U5-9B
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:11:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk1OR-0003Tx-34
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:10:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-16-armbru@redhat.com>
	<fb83fdef-2a97-4c9f-893d-61df0fa21d90@redhat.com>
Date: Mon, 30 Jul 2018 08:10:52 +0200
In-Reply-To: <fb83fdef-2a97-4c9f-893d-61df0fa21d90@redhat.com> (Eric Blake's
	message of "Fri, 27 Jul 2018 11:00:57 -0500")
Message-ID: <877eld2qz7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/23] tests: New helper
 qtest_qmp_receive_success()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>, f4bug@amsat.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 07/27/2018 10:13 AM, Markus Armbruster wrote:
>> Commit b21373d0713 copied wait_command() from tests/migration-test.c
>> to tests/tpm-util.c.  Replace both copies by new libqtest helper
>> qtest_qmp_receive_success().  Also use it to simplify
>> qtest_qmp_device_del().
>>
>> Bonus: gets rid of a non-literal format string.  A step towards
>> compile-time format string checking without triggering
>> -Wformat-nonliteral.
>
> Where? [1]
>
>>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>
>> +++ b/tests/libqtest.c
>> @@ -1029,6 +1029,35 @@ void qtest_cb_for_every_machine(void (*cb)(const =
char *machine))
>>       qobject_unref(response);
>>   }
>>   +QDict *qtest_qmp_receive_success(QTestState *s,
>> +                                 void (*event_cb)(void *opaque,
>> +                                                  const char *event,
>> +                                                  QDict *data),
>> +                                 void *opaque)
>> +{
>
> I like the new signature!
>
>> +++ b/tests/migration-test.c
>
>>   /*
>>    * Events can get in the way of responses we are actually waiting for.
>>    */
>>   static QDict *wait_command(QTestState *who, const char *command)
>>   {
>
> [1] This is still taking a format non-literal command...
>
>> -    const char *event_string;
>> -    QDict *response, *ret;
>> -
>> -    response =3D qtest_qmp(who, command);
> ...
>> +    qtest_qmp_send(who, command);
>
> and is passing it on through.

No worse than before.  Will be fixed in the next two patches.

>> +    return qtest_qmp_receive_success(who, stop_cb, NULL);
>>   }
>>=20=20=20
>
>> +++ b/tests/tpm-util.c
>
>> -/*
>> - * Events can get in the way of responses we are actually waiting for.
>> - */
>> -static QDict *tpm_util_wait_command(QTestState *who, const char *comman=
d)
>> -{
>
> Maybe you were counting this instance,
>

    -    const char *event_string;
    -    QDict *response;
    -
    -    response =3D qtest_qmp(who, command);

/work/armbru/qemu/tests/tpm-util.c: In function =E2=80=98tpm_util_wait_comm=
and=E2=80=99:
/work/armbru/qemu/tests/tpm-util.c:258:5: warning: format not a string lite=
ral and no format arguments [-Wformat-security]
     response =3D qtest_qmp(who, command);
     ^~~~~~~~

    -
    -    while (qdict_haskey(response, "event")) {
    -        /* OK, it was an event */
    -        event_string =3D qdict_get_str(response, "event");
    -        if (!strcmp(event_string, "STOP")) {
    -            got_stop =3D true;
    -        }
    -        qobject_unref(response);
    -        response =3D qtest_qmp_receive(who);
    -    }
    -    return response;
    -}
>>   void tpm_util_wait_for_migration_complete(QTestState *who)
>>   {
>>       while (true) {
>> -        QDict *rsp, *rsp_return;
>> +        QDict *rsp_return;
>>           bool completed;
>>           const char *status;
>>   -        rsp =3D tpm_util_wait_command(who, "{ 'execute':
>> 'query-migrate' }");
>> -        rsp_return =3D qdict_get_qdict(rsp, "return");
>> +        qtest_qmp_send(who, "{ 'execute': 'query-migrate' }");
>
> where you did indeed drop a format non-literal?

> But on the assumption that there's more cleanups later in the series,
> this is indeed incrementally better, so
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
