Received: from eggs.gnu.org ([2001:4830:134:3::10]:57128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cim8R-0008Sj-8C
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cim8Q-0000ok-Jj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:04:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-6-git-send-email-armbru@redhat.com>
	<20170228162101.GH4090@noname.redhat.com>
Date: Tue, 28 Feb 2017 19:04:17 +0100
In-Reply-To: <20170228162101.GH4090@noname.redhat.com> (Kevin Wolf's message
	of "Tue, 28 Feb 2017 17:21:01 +0100")
Message-ID: <878toqp4ym.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/24] test-keyval: Cover use with qobject
 input visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>> +static void test_keyval_visit_size(void)
>> +{
>> +    Error *err = NULL;
>> +    Visitor *v;
>> +    QDict *qdict;
>> +    uint64_t sz;
>> +
>> +    /* Lower limit zero */
>> +    qdict = keyval_parse("sz1=0", NULL, &error_abort);
>> +    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
>> +    QDECREF(qdict);
>> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
>> +    visit_type_size(v, "sz1", &sz, &error_abort);
>> +    g_assert_cmpuint(sz, ==, 0);
>> +    visit_check_struct(v, &error_abort);
>> +    visit_end_struct(v, NULL);
>> +    visit_free(v);
>> +
>> +    /* Note: precision is 53 bits since we're parsing with strtod() */
>> +
>> +    /* Around limit of precision: 2^53-1, 2^53, 2^54 */
>> +    qdict = keyval_parse("sz1=9007199254740991,"
>> +                         "sz2=9007199254740992,"
>> +                         "sz3=9007199254740993",
>
> That's 2^53+1, not 2^54. With the comment fixed:

D'oh!

> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks!
