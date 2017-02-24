Received: from eggs.gnu.org ([2001:4830:134:3::10]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch96v-000880-Qi
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch96q-00040h-PJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:12:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ch96q-00040U-HC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:12:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBCBE7FB7C
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:12:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-4-git-send-email-armbru@redhat.com>
	<052e93bd-fce0-93bc-69f5-bdf893d5f508@redhat.com>
Date: Fri, 24 Feb 2017 07:12:01 +0100
In-Reply-To: <052e93bd-fce0-93bc-69f5-bdf893d5f508@redhat.com> (Eric Blake's
	message of "Thu, 23 Feb 2017 17:05:34 -0600")
Message-ID: <87r32o2k3y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/21] qmp-test: New,
 covering basic QMP protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/23/2017 03:44 PM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/Makefile.include |   5 +-
>>  tests/libqtest.c       |  17 ++++--
>>  tests/libqtest.h       |   8 +++
>>  tests/qmp-test.c       | 139 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 163 insertions(+), 6 deletions(-)
>>  create mode 100644 tests/qmp-test.c
>> 
>
>> +++ b/tests/libqtest.h
>> @@ -32,6 +32,14 @@ extern QTestState *global_qtest;
>>  QTestState *qtest_init(const char *extra_args);
>>  
>>  /**
>> + * qtest_init:
>
> Wrong name (too much copy-and-paste)

One of the several reasons why I detest this comment style.  I'll fix
it, of course.

>> + * @extra_args: other arguments to pass to QEMU.
>> + *
>> + * Returns: #QTestState instance.
>> + */
>> +QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>> +
>> +/**
>>   * qtest_quit:
>>   * @s: #QTestState instance to operate on.
>>   *
>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> new file mode 100644
>> index 0000000..405e49e
>> --- /dev/null
>> +++ b/tests/qmp-test.c
>
>> +
>> +static void test_malformed(void)
>> +{
>> +    QDict *resp;
>> +
>> +    /* Not even a dictionary */
>> +    resp = qmp("null");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    QDECREF(resp);
>> +
>
> Shall we test an array, integer, and/or boolean literal as well?

Not necessary for code coverage.  Wouldn't hurt, of course.

>> +    /* No "execute" key */
>> +    resp = qmp("{}");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    QDECREF(resp);
>> +
>> +    /* "execute" isn't a string */
>> +    resp = qmp("{ 'execute': true }");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    QDECREF(resp);
>> +
>> +    /* "arguments" isn't a dictionary */
>> +    resp = qmp("{ 'execute': 'no-such-cmd', 'arguments': [] }");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    QDECREF(resp);
>> +
>> +    /* extra key */
>> +    resp = qmp("{ 'execute': 'no-such-cmd', 'extra': true }");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    QDECREF(resp);
>
> Worth testing "{ 'arguments': {} }"?

Likewise.

>> +}
>> +
>> +static void test_qmp_protocol(void)
>> +{
>> +    QDict *resp, *q, *ret;
>> +    QList *capabilities;
>> +
>> +    global_qtest = qtest_init_without_qmp_handshake(common_args);
>> +
>> +    /* Test greeting */
>> +    resp = qmp_receive();
>> +    q = qdict_get_qdict(resp, "QMP");
>> +    g_assert(q);
>> +    test_version(qdict_get(q, "version"));
>> +    capabilities = qdict_get_qlist(q, "capabilities");
>> +    g_assert(capabilities && qlist_empty(capabilities));
>> +    QDECREF(resp);
>> +
>> +    /* Test valid command before handshake */
>> +    resp = qmp("{ 'execute': 'query-version' }");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
>> +    QDECREF(resp);
>> +
>> +    /* Test malformed commands before handshake */
>> +    test_malformed();
>> +
>> +    /* Test handshake */
>> +    resp = qmp("{ 'execute': 'qmp_capabilities' }");
>> +    ret = qdict_get_qdict(resp, "return");
>> +    g_assert(ret && !qdict_size(ret));
>> +    QDECREF(resp);
>> +
>> +    /* Test repeated handshake */
>> +    resp = qmp("{ 'execute': 'qmp_capabilities' }");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
>> +    QDECREF(resp);
>> +
>> +    /* Test valid command */
>> +    resp = qmp("{ 'execute': 'query-version' }");
>> +    test_version(qdict_get(resp, "return"));
>> +    QDECREF(resp);
>> +
>> +    /* Test malformed commands */
>> +    test_malformed();
>> +
>> +    /* Test 'id' */
>> +    resp = qmp("{ 'execute': 'query-name', 'id': 'cookie#1' }");
>> +    ret = qdict_get_qdict(resp, "return");
>> +    g_assert(ret);
>> +    g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
>> +    QDECREF(resp);
>> +
>> +    /* Test command failure with 'id' */
>> +    resp = qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
>> +    QDECREF(resp);
>
> id can be _any JSON_ (at one point, QMP crashed if id included a null
> literal); so maybe we should have more id tests such as "'id': null,",
> "'id': [ { }, true ]"
>
> But any tests at all is better than our previous state of none, so even
> if you don't add tests, but just fix the typo:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'm in a bit of a time squeeze, so I'll take your offer to just fix the
typo for now.

Thanks!
