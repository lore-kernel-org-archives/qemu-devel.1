Received: from eggs.gnu.org ([2001:4830:134:3::10]:57103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fu8vl-0001Lq-HG
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fu8vi-0003T0-DN
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:15:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fu8vi-0003SX-7i
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:15:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
	<20180816083701.3932-13-armbru@redhat.com>
	<caf8057a-b3cf-30c7-f7b0-a8b7fc41cc22@redhat.com>
Date: Mon, 27 Aug 2018 06:15:01 +0200
In-Reply-To: <caf8057a-b3cf-30c7-f7b0-a8b7fc41cc22@redhat.com> (Eric Blake's
	message of "Fri, 24 Aug 2018 17:41:40 -0500")
Message-ID: <87y3cszbqy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 12/25] tests: Clean up string interpolation
 into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Eric Blake <eblake@redhat.com> writes:

> On 08/16/2018 03:36 AM, Markus Armbruster wrote:
>> When you build QMP input manually like this
>>
>>      cmd = g_strdup_printf("{ 'execute': 'migrate',"
>>                            "'arguments': { 'uri': '%s' } }",
>>                            uri);
>>      rsp = qmp(cmd);
>>      g_free(cmd);
>>
>> you're responsible for escaping the interpolated values for JSON.  Not
>> done here, and therefore works only for sufficiently nice @uri.  For
>> instance, if @uri contained a single "'", qobject_from_vjsonf_nofail()
>> would abort.  A sufficiently nasty @uri could even inject unwanted
>> members into the arguments object.
>>
>> Leaving interpolation into JSON to qmp() is more robust:
>>
>>      rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
>>
>> It's also more concise.
>>
>> Clean up the simple cases where we interpolate exactly a JSON value.
>>
>> Bonus: gets rid of non-literal format strings.  A step towards
>> compile-time format string checking without triggering
>> -Wformat-nonliteral.
>>
>
>> +++ b/tests/test-qga.c
>
>> @@ -446,10 +443,10 @@ static void test_qga_file_ops(gconstpointer fix)
>>         enc = g_base64_encode(helloworld, sizeof(helloworld));
>>       /* write */
>> -    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
>> -                          " 'arguments': { 'handle': %" PRId64 ","
>> -                          " 'buf-b64': '%s' } }", id, enc);
>> -    ret = qmp_fd(fixture->fd, cmd);
>> +    ret = qmp_fd(fixture->fd,
>> +                 "{'execute': 'guest-file-write',"
>> +                 " 'arguments': { 'handle': %" PRId64 ", 'buf-b64': %s } }",
>> +                 id, enc);
>
> This is a temporary regression of commit 1792d7d0, which affects test
> execution on Mac (with its weird %qd expansion for
> PRId64). Fortunately, you later fix it in commit 41, so I won't be
> upset if the pull request goes through without a v2 that avoids 'git
> bisect' breaking on Mac.

Sorry about the accidental revert of your patch.  I rely on Peter's
testing to cover Mac.

This patch became commit 015715f554f, merged in commit c542a9f9794 on
August 16.  The "later fix" is commit 53a0d616fec, merged in commit
cc9821fa9ac on August 25.
