Received: from eggs.gnu.org ([2001:4830:134:3::10]:35749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fl6C8-0000iK-EO
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fl6C4-0007ub-DP
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:30:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fl6C4-0007uF-6O
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 01:30:36 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
	<55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
	<9244e265-82fe-42b4-330c-9005bde0a983@redhat.com>
	<87in4x1bfb.fsf@dusky.pond.sub.org>
	<3f3d6599-0b3c-8a2f-88a7-895d5dfe35ed@redhat.com>
	<87k1p98j34.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09821695-41b4-093c-9852-14f27493f64f@redhat.com>
Date: Thu, 2 Aug 2018 07:30:33 +0200
MIME-Version: 1.0
In-Reply-To: <87k1p98j34.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org

On 08/02/2018 06:53 AM, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 07/30/2018 08:32 AM, Markus Armbruster wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> On 07/27/2018 11:46 AM, Thomas Huth wrote:
>>>>> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>>>>>> qtest_qmp_discard_response(...) is shorthand for
>>>>>> qobject_unref(qtest_qmp(...), except it's not actually shorter.
>>>>>
>>>>> But the latter is IMHO harder to read.
>>>
>>> Doing things sloppily looks a bit uglier now.  That's a feature.
>>>
>>>> Maybe, but then it lends itself well to:
>>>>
>>>> QObject *rsp =3D qtest_qmp(...);
>>>> qobject_unref(rsp);
>>>>
>>>> which is where you do insert tests for valid responses.
>>>>
>>>>> And it might be shorter in the compiled binary (one function call v=
s. two).
>>>
>>> I'd be quite sympathetic to this argument...
>>>
>>>> The size of the test binaries is not our biggest concern.
>>>
>>> ... outside tests/.
>>>
>>>>>> Moreover, the presence of these functions encourage sloppy testing=
.
>>>>>
>>>>> Shouldn't we then rather fix the tests to check for valid responses
>>>>> instead of replacing this function with harder-to-read code?
>>>
>>> I'd welcome such patches, but this series is already pretty long.
>>
>> Then maybe rather drop this patch from this series, and fix the issues
>> in a separate series instead?
>=20
> Do you insist?

No. But I'd still like to convince you that this patch is unnecessary
right now.

> I fail to see how changing
>=20
>     qmp_discard_response("{ 'execute': 'system_reset' }");
>=20
> to
>=20
>     qobject_unref(qmp("{ 'execute': 'system_reset' }"));
>=20
> is so awful it would justify demanding I pause my work on libqtest to
> first figure out which parts of ignored responses are worth checking,
> then code up the checks.

First, you don't have to pause this series just because of this, since
the remaining two patches do not depend on this one.
Then, I still fail to see the real benefit here. You've found something
that needs proper clean up later (by adding checks for valid responses).
So IMHO simply add a big fat warning comment to the description of
qmp_discard_response would be sufficient. Then you can easily grep for
"qmp_discard_response" later to find the spots that need fixing. If you
replace it with that ugly nested construct instead, we still should fix
it later, but it's a little bit harder to grep, and since we need to
change it later again anyway, it just sounds like unnecessary code churn
to me. So do you really need this so badly (for your later work?), or
could you simply skip this patch?

> Would you accept
>=20
>     rsp =3D qmp("{ 'execute': 'system_reset' }"));
>     qobject_unref(rsp);
>=20
> ?

While this is easier to read, I think we lose the easy way to grep for
the spots that need fixing later here, so let's better not do this.

> If none of the above is acceptable to you, then I'll push the crap that
> needs to go from libqtest into the crap-using tests, like this:
>=20
>     /* TODO actually test the results and get rid of this */
>     #define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__));

Fine for me.

 Thomas
