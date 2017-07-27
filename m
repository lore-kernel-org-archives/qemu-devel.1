Received: from eggs.gnu.org ([2001:4830:134:3::10]:45559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1daeHb-0002fM-Rs
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1daeHX-00035m-Ls
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1daeHX-00034f-CN
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:36:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32E72C085EF8
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:36:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-10-git-send-email-armbru@redhat.com>
	<c7a634ae-bdd9-3690-c87e-349888736ffc@redhat.com>
Date: Thu, 27 Jul 2017 10:36:27 +0200
In-Reply-To: <c7a634ae-bdd9-3690-c87e-349888736ffc@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 10:04:42 -0500")
Message-ID: <87bmo6ff90.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 9/9] tests/libqtest: Enable compile-time
 format string checking
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

> On 07/21/2017 08:53 AM, Markus Armbruster wrote:
>> qtest_qmp() & friends pass their format string and variable arguments
>> to qobject_from_jsonv().  Unlike qobject_from_jsonv(), they aren't
>> decorated with GCC_FMT_ATTR().  Fix that to get compile-time format
>> string checking.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/libqtest.h | 40 ++++++++++++++++++++++++----------------
>>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> Don't know how much of this to merge with my fixed version of 2/9.  But
> matches what I had locally after my version 1, before I ripped it all
> back out again prior to posting my v2 when dealing with gcc fallout,
> that you've now corrected.
>
>> @@ -65,7 +66,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
>>   *
>>   * Sends a QMP message to QEMU and returns the response.
>>   */
>> -QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
>> +QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
>> +    GCC_FMT_ATTR(2, 3);
>
> This would fit on one line; any reason we need the line wrap?

Pretty sure I didn't have reasons.  But I can make some up after the
fact!  Putting the attribute on a separate line can be a bit more
legible.  It can also confuse simple tools to recognize a definition
instead of a declaration.  Anyway, I don't really care about this line
break.
