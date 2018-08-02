Received: from eggs.gnu.org ([2001:4830:134:3::10]:45837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1flIOI-0002p2-BG
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 14:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1flIOF-0008BX-3V
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 14:32:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1flIOE-0008AX-Sf
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 14:31:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
	<55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
	<9244e265-82fe-42b4-330c-9005bde0a983@redhat.com>
	<87in4x1bfb.fsf@dusky.pond.sub.org>
	<3f3d6599-0b3c-8a2f-88a7-895d5dfe35ed@redhat.com>
	<87k1p98j34.fsf@dusky.pond.sub.org>
	<09821695-41b4-093c-9852-14f27493f64f@redhat.com>
Date: Thu, 02 Aug 2018 20:31:55 +0200
In-Reply-To: <09821695-41b4-093c-9852-14f27493f64f@redhat.com> (Thomas Huth's
	message of "Thu, 2 Aug 2018 07:30:33 +0200")
Message-ID: <87va8sliw4.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

Thomas Huth <thuth@redhat.com> writes:

> On 08/02/2018 06:53 AM, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> On 07/30/2018 08:32 AM, Markus Armbruster wrote:
>>>> Eric Blake <eblake@redhat.com> writes:
>>>>
>>>>> On 07/27/2018 11:46 AM, Thomas Huth wrote:
>>>>>> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>>>>>>> qtest_qmp_discard_response(...) is shorthand for
>>>>>>> qobject_unref(qtest_qmp(...), except it's not actually shorter.
>>>>>>
>>>>>> But the latter is IMHO harder to read.
>>>>
>>>> Doing things sloppily looks a bit uglier now.  That's a feature.
>>>>
>>>>> Maybe, but then it lends itself well to:
>>>>>
>>>>> QObject *rsp = qtest_qmp(...);
>>>>> qobject_unref(rsp);
>>>>>
>>>>> which is where you do insert tests for valid responses.
>>>>>
>>>>>> And it might be shorter in the compiled binary (one function call vs. two).
>>>>
>>>> I'd be quite sympathetic to this argument...
>>>>
>>>>> The size of the test binaries is not our biggest concern.
>>>>
>>>> ... outside tests/.
>>>>
>>>>>>> Moreover, the presence of these functions encourage sloppy testing.
>>>>>>
>>>>>> Shouldn't we then rather fix the tests to check for valid responses
>>>>>> instead of replacing this function with harder-to-read code?
>>>>
>>>> I'd welcome such patches, but this series is already pretty long.
>>>
>>> Then maybe rather drop this patch from this series, and fix the issues
>>> in a separate series instead?
>> 
>> Do you insist?
>
> No. But I'd still like to convince you that this patch is unnecessary
> right now.
>
>> I fail to see how changing
>> 
>>     qmp_discard_response("{ 'execute': 'system_reset' }");
>> 
>> to
>> 
>>     qobject_unref(qmp("{ 'execute': 'system_reset' }"));
>> 
>> is so awful it would justify demanding I pause my work on libqtest to
>> first figure out which parts of ignored responses are worth checking,
>> then code up the checks.
>
> First, you don't have to pause this series just because of this, since
> the remaining two patches do not depend on this one.

I intend to swap with the previous patch in v3 to reduce churn.

> Then, I still fail to see the real benefit here. You've found something
> that needs proper clean up later (by adding checks for valid responses).
> So IMHO simply add a big fat warning comment to the description of
> qmp_discard_response would be sufficient.

Warnings in function comments are ineffective at counterproliferation.
People copy code without examining the called functions' comments.

>                                           Then you can easily grep for
> "qmp_discard_response" later to find the spots that need fixing. If you
> replace it with that ugly nested construct instead, we still should fix
> it later, but it's a little bit harder to grep, and since we need to
> change it later again anyway, it just sounds like unnecessary code churn
> to me. So do you really need this so badly (for your later work?), or
> could you simply skip this patch?
>
>> Would you accept
>> 
>>     rsp = qmp("{ 'execute': 'system_reset' }"));
>>     qobject_unref(rsp);
>> 
>> ?
>
> While this is easier to read, I think we lose the easy way to grep for
> the spots that need fixing later here, so let's better not do this.
>
>> If none of the above is acceptable to you, then I'll push the crap that
>> needs to go from libqtest into the crap-using tests, like this:
>> 
>>     /* TODO actually test the results and get rid of this */
>>     #define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__));
>
> Fine for me.

Sold.
