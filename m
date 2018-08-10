Received: from eggs.gnu.org ([2001:4830:134:3::10]:35416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7qX-0003RA-4Y
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7qT-0002Ja-2T
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:52:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo7qS-0002JD-T0
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:52:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-6-armbru@redhat.com>
	<36518ac8-f022-c54d-2e57-6a709b3678ce@redhat.com>
Date: Fri, 10 Aug 2018 15:52:46 +0200
In-Reply-To: <36518ac8-f022-c54d-2e57-6a709b3678ce@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 08:42:36 -0500")
Message-ID: <87d0uqmiq9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/56] qmp-test: Cover syntax and lexical
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/libqtest.c | 17 +++++++++++++++++
>>   tests/libqtest.h | 11 +++++++++++
>>   tests/qmp-test.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 67 insertions(+)
>>
>
>> +    /* lexical error: impossible byte outside string */
>> +    qtest_qmp_send_raw(qts, "{\xFF");
>
> \xff is an impossible byte inside a string as well; plus it has
> special meaning to at least QMP for commanding a parser reset. Is a
> better byte more appropriate (maybe \x7f), either in replacement to
> \xff or as an additional test?

\xFF is documented to have special meaning for QGA, but as far as the
code's concerned, it's a lexical error like any other.  I'm fixing the
documentation in PATCH 56.  Want me to move that patch to the front of
the series?

>> +    resp = qtest_qmp_receive(qts);
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    qobject_unref(resp);
>> +    g_assert(recovered(qts));
>> +
>> +    /* lexical error: impossible byte in string */
>> +    qtest_qmp_send_raw(qts, "{'bad \xFF");
>
> Same question about \xff being special as the parser reset command, so
> should we test a different byte instead/as well?
>
>> +    resp = qtest_qmp_receive(qts);
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    qobject_unref(resp);
>> +    g_assert(recovered(qts));
>> +
>> +    /* lexical error: interpolation */
>> +    qtest_qmp_send_raw(qts, "%%p\n");
>> +    resp = qtest_qmp_receive(qts);
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    qobject_unref(resp);
>> +    g_assert(recovered(qts));
>> +
>>       /* Not even a dictionary */
>>       resp = qtest_qmp(qts, "null");
>>       g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>>
