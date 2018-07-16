Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fewyR-0003zk-Qw
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fewyO-0006W8-Li
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:27:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fewyO-0006Vm-FK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:27:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-12-armbru@redhat.com>
	<7ae3d760-7097-c95e-67a5-266cc9357964@amsat.org>
Date: Mon, 16 Jul 2018 08:27:02 +0200
In-Reply-To: <7ae3d760-7097-c95e-67a5-266cc9357964@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	12 Jul 2018 11:30:30 -0300")
Message-ID: <87tvozitl5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/20] tests: Clean up string interpolation
 into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Markus,
>
> On 07/12/2018 08:12 AM, Markus Armbruster wrote:
>> When you build QMP input manually like this
>>=20
>>     cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
>>                           "'arguments': { 'uri': '%s' } }",
>>                           uri);
>>     rsp =3D qmp(cmd);
>>     g_free(cmd);
>>=20
>> you're responsible for escaping the interpolated values for JSON.  Not
>> done here, and therefore works only for sufficiently nice @uri.  For
>> instance, if @uri contained a single "'", qobject_from_vjsonf_nofail()
>> would abort.  A sufficiently nasty @uri could even inject unwanted
>> members into the arguments object.
>>=20
>> Leaving interpolation into JSON to qmp() is more robust:
>>=20
>>     rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", =
uri);
>>=20
>> It's also more concise.
>>=20
>> Clean up the simple cases where we interpolate exactly a JSON value.
>>=20
>> Bonus: gets rid of non-literal format strings.  A step towards
>> compile-time format string checking without triggering
>> -Wformat-nonliteral.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/libqos/pci-pc.c   |   9 +--
>>  tests/libqtest.c        |   7 +-
>>  tests/migration-test.c  |   8 +--
>>  tests/test-qga.c        | 150 ++++++++++++++++++----------------------
>>  tests/tpm-util.c        |   9 +--
>>  tests/vhost-user-test.c |   6 +-
>>  6 files changed, 77 insertions(+), 112 deletions(-)
>>=20
>> diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
>> index a7803308b7..585f5289ec 100644
>> --- a/tests/libqos/pci-pc.c
>> +++ b/tests/libqos/pci-pc.c
>> @@ -160,14 +160,9 @@ void qpci_free_pc(QPCIBus *bus)
>>  void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
>>  {
>>      QDict *response;
>> -    char *cmd;
>>=20=20
>> -    cmd =3D g_strdup_printf("{'execute': 'device_del',"
>> -                          " 'arguments': {"
>> -                          "   'id': '%s'"
>> -                          "}}", id);
>> -    response =3D qmp(cmd);
>> -    g_free(cmd);
>> +    response =3D qmp("{'execute': 'device_del', 'arguments': {'id': %s}=
}",
>> +                   id);
>>      g_assert(response);
>>      g_assert(!qdict_haskey(response, "error"));
>>      qobject_unref(response);
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index 3bfb062fcb..e36cc5ede3 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -1079,12 +1079,9 @@ void qtest_qmp_device_add(const char *driver, con=
st char *id, const char *fmt,
>>  void qtest_qmp_device_del(const char *id)
>>  {
>>      QDict *response1, *response2, *event =3D NULL;
>> -    char *cmd;
>>=20=20
>> -    cmd =3D g_strdup_printf("{'execute': 'device_del',"
>> -                          " 'arguments': { 'id': '%s' }}", id);
>> -    response1 =3D qmp(cmd);
>> -    g_free(cmd);
>> +    response1 =3D qmp("{'execute': 'device_del', 'arguments': {'id': %s=
}}",
>> +                    id);
>>      g_assert(response1);
>>      g_assert(!qdict_haskey(response1, "error"));
>>=20=20
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index 086f727b34..bbb9d3da31 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -529,14 +529,12 @@ static void test_migrate_end(QTestState *from, QTe=
stState *to, bool test_dest)
>>  static void deprecated_set_downtime(QTestState *who, const double value)
>>  {
>>      QDict *rsp;
>> -    gchar *cmd;
>>      char *expected;
>>      int64_t result_int;
>>=20=20
>> -    cmd =3D g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
>> -                          "'arguments': { 'value': %g } }", value);
>> -    rsp =3D qtest_qmp(who, cmd);
>> -    g_free(cmd);
>> +    rsp =3D qtest_qmp(who,
>> +                    "{ 'execute': 'migrate_set_downtime',"
>> +                    " 'arguments': { 'value': %f } }", value);
>
> I suppose you changed %g -> %f because the downtime is expected
> to be greater than 1e-4 :)

Actually, I changed it to %f, because %g would crash :)

qtest_qmp()'s function comment provides a clue:

 * @fmt...: QMP message to send to qemu; formats arguments through
 * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').

This isn't your ordinary printf()-like formatting, it's JSON
interpolation.  JSON interpolation borrows its escapes from printf() to
get some compile-time checking out of GCC function attribute 'format',
namely catching arguments that don't match escapes.  It can't catch
escapes JSON interpolation doesn't support.  Much better than nothing.

In particular, JSON interpolation supports %f but not %g.

Hmm, the comment's claim "json-lexer.c" is perhaps overly specific.
json-lexer.c recognizes valid %-escapes, but the actual interpolation is
done by json-parser.c's parse_escape().

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

[...]
