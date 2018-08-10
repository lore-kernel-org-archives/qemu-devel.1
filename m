Received: from eggs.gnu.org ([2001:4830:134:3::10]:36817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7vM-0005gu-U9
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7vI-0006ZZ-SN
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:57:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo7vI-0006Yt-ML
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:57:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-7-armbru@redhat.com>
	<0ebb3c17-fcd4-a52e-d402-73881f68b105@redhat.com>
Date: Fri, 10 Aug 2018 15:57:44 +0200
In-Reply-To: <0ebb3c17-fcd4-a52e-d402-73881f68b105@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 08:46:55 -0500")
Message-ID: <878t5emihz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/56] test-qga: Clean up how we test QGA
 synchronization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> To permit recovering from arbitrary JSON parse errors, the JSON parser
>> resets itself on lexical errors.  We recommend sending a 0xff byte for
>> that purpose, and test-qga covers this usage since commit 5229564b832.
>> That commit had to add an ugly hack to qmp_fd_vsend() to make capable
>> of sending this byte (it's designed to send only valid JSON).
>>
>> The previous commit added a way to send arbitrary text.  Put that to
>> use for this purpose, and drop the hack from qmp_fd_vsend().
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/libqtest.c | 39 +++++++++++++++++++++------------------
>>   tests/libqtest.h |  2 ++
>>   tests/test-qga.c |  8 ++++----
>>   3 files changed, 27 insertions(+), 22 deletions(-)
>>
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index c02fc91b37..9c844874e4 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -489,16 +489,6 @@ void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
>>   {
>>       QObject *qobj;
>>   -    /*
>> -     * qobject_from_vjsonf_nofail() chokes on leading 0xff as invalid
>> -     * JSON, but tests/test-qga.c needs to send that to test QGA
>> -     * synchronization
>> -     */
>> -    if (*fmt == '\377') {
>> -        socket_send(fd, fmt, 1);
>> -        fmt++;
>> -    }
>> -
>>       /* Going through qobject ensures we escape strings properly */
>>       qobj = qobject_from_vjsonf_nofail(fmt, ap);
>
> This does JSON interpolation...
>
>>   @@ -586,23 +576,36 @@ void qtest_qmp_send(QTestState *s, const
>> char *fmt, ...)
>>       va_end(ap);
>>   }
>>   -void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>> +void qmp_fd_vsend_raw(int fd, const char *fmt, va_list ap)
>>   {
>>       bool log = getenv("QTEST_LOG") != NULL;
>> -    va_list ap;
>> -    char *str;
>> -
>> -    va_start(ap, fmt);
>> -    str = g_strdup_vprintf(fmt, ap);
>> -    va_end(ap);
>> +    char *str = g_strdup_vprintf(fmt, ap);
>
> ...while the new code does printf interpolation...
>
>> +++ b/tests/test-qga.c
>> @@ -147,10 +147,10 @@ static void test_qga_sync_delimited(gconstpointer fix)
>>       unsigned char c;
>>       QDict *ret;
>>   -    qmp_fd_send(fixture->fd,
>> -                "\xff{'execute': 'guest-sync-delimited',"
>> -                " 'arguments': {'id': %u } }",
>> -                r);
>> +    qmp_fd_send_raw(fixture->fd,
>> +                    "\xff{'execute': 'guest-sync-delimited',"
>> +                    " 'arguments': {'id': %u } }",
>> +                    r);
>
> ...and your test was relying on interpolation. Fortunately, your only

Yes, my patch is a bit lazy there.

> thing being interpolated (%u) happens to result in valid JSON - but
> you may want to split this into:
>
> qmp_fd_send_raw(fixture->fd, "\xff");
> qmp_fd_send(fixutre->fd, "{'execute ... %u}}", f);
>
> to make it less questionable. If not, then call it out in the commit
> message and/or a comment on the code itself.

Splitting is easier than explaining, so that's what I'll do.
