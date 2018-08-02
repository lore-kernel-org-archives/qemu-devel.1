Received: from eggs.gnu.org ([2001:4830:134:3::10]:50840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fl5ca-0008PM-F3
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 00:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fl5cX-0003eQ-DI
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 00:53:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fl5cX-0003du-8o
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 00:53:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
	<55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
	<9244e265-82fe-42b4-330c-9005bde0a983@redhat.com>
	<87in4x1bfb.fsf@dusky.pond.sub.org>
	<3f3d6599-0b3c-8a2f-88a7-895d5dfe35ed@redhat.com>
Date: Thu, 02 Aug 2018 06:53:51 +0200
In-Reply-To: <3f3d6599-0b3c-8a2f-88a7-895d5dfe35ed@redhat.com> (Thomas Huth's
	message of "Wed, 1 Aug 2018 08:46:46 +0200")
Message-ID: <87k1p98j34.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 21/23] libqtest: Remove
 qtest_qmp_discard_response() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org

Thomas Huth <thuth@redhat.com> writes:

> On 07/30/2018 08:32 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 07/27/2018 11:46 AM, Thomas Huth wrote:
>>>> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>>>>> qtest_qmp_discard_response(...) is shorthand for
>>>>> qobject_unref(qtest_qmp(...), except it's not actually shorter.
>>>>
>>>> But the latter is IMHO harder to read.
>> 
>> Doing things sloppily looks a bit uglier now.  That's a feature.
>> 
>>> Maybe, but then it lends itself well to:
>>>
>>> QObject *rsp = qtest_qmp(...);
>>> qobject_unref(rsp);
>>>
>>> which is where you do insert tests for valid responses.
>>>
>>>> And it might be shorter in the compiled binary (one function call vs. two).
>> 
>> I'd be quite sympathetic to this argument...
>> 
>>> The size of the test binaries is not our biggest concern.
>> 
>> ... outside tests/.
>> 
>>>>> Moreover, the presence of these functions encourage sloppy testing.
>>>>
>>>> Shouldn't we then rather fix the tests to check for valid responses
>>>> instead of replacing this function with harder-to-read code?
>> 
>> I'd welcome such patches, but this series is already pretty long.
>
> Then maybe rather drop this patch from this series, and fix the issues
> in a separate series instead?

Do you insist?

I fail to see how changing

    qmp_discard_response("{ 'execute': 'system_reset' }");

to

    qobject_unref(qmp("{ 'execute': 'system_reset' }"));

is so awful it would justify demanding I pause my work on libqtest to
first figure out which parts of ignored responses are worth checking,
then code up the checks.

Would you accept

    rsp = qmp("{ 'execute': 'system_reset' }"));
    qobject_unref(rsp);

?

If none of the above is acceptable to you, then I'll push the crap that
needs to go from libqtest into the crap-using tests, like this:

    /* TODO actually test the results and get rid of this */
    #define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__));
