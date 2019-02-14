Received: from eggs.gnu.org ([209.51.188.92]:43747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guArh-0002ZS-KN
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guAg3-0004sJ-Ce
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:39:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-3-git-send-email-marcolso@amazon.com>
	<72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
	<13cbaa71-82ac-e142-945f-4ece8e3093f6@amazon.com>
	<8a51bd30-40c2-e367-208f-df0f2d225d0f@redhat.com>
	<c2965971-4e19-8d68-d57a-6ee28ecfe22e@amazon.com>
Date: Thu, 14 Feb 2019 07:39:08 +0100
In-Reply-To: <c2965971-4e19-8d68-d57a-6ee28ecfe22e@amazon.com> (Marc Olson via
	Qemu-devel's message of "Wed, 13 Feb 2019 12:49:00 -0800")
Message-ID: <87d0nu3mcz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] blkdebug: Add latency injection
 rule type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson via Qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Marc Olson <marcolso@amazon.com>, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org

Marc Olson via Qemu-devel <qemu-devel@nongnu.org> writes:

> On 2/13/19 7:48 AM, Max Reitz wrote:
>> On 12.02.19 22:21, Marc Olson wrote:
>>> On 1/11/19 7:00 AM, Max Reitz wrote:
>>>> On 12.11.18 08:06, Marc Olson wrote:
>> [...]
>>
>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>> index d4fe710..72f7861 100644
>>>>> --- a/qapi/block-core.json
>>>>> +++ b/qapi/block-core.json
>>>>> @@ -3057,6 +3057,34 @@
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 '*immediately': 'bool' } }
>>>>>  =C2=A0 =C2=A0 ##
>>>>> +# @BlkdebugDelayOptions:
>>>>> +#
>>>>> +# Describes a single latency injection for blkdebug.
>>>>> +#
>>>>> +# @event:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trigger event
>>>>> +#
>>>>> +# @state:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the state identifier b=
lkdebug needs to be in to
>>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 actually trigger the event; defaults to "any"
>>>>> +#
>>>>> +# @latency:=C2=A0=C2=A0=C2=A0=C2=A0 The delay to add to an I/O, in m=
icroseconds.
>>>>> +#
>>>>> +# @sector:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specifies the sector index =
which has to be affected
>>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 in order to actually trigger the event; defaults to
>>>>> "any
>>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sector"
>>>>> +#
>>>>> +# @once:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disables further =
events after this one has been
>>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 triggered; defaults to false
>>>>> +#
>>>>> +# Since: 3.1
>>>> Well, 4.0 now, sorry...
>>> Baking version numbers into code is downright silly. Every single
>>> version of this patch has made a comment along the lines of, "oops, it
>>> didn't get reviewed in time for the next version bump, so you have to
>>> resubmit." With a fast moving project, this is nonsense. If you're
>>> looking at the code, you should have access to the git history as well
>>> to determine the version.
>> True, but these comments are used to generate documentation (e.g.
>> docs/interopt/qemu-qmp-ref.7 in the build directory).  So they are used
>> by people who don't have access to the git history.

Exactly.

>> It might be possible to generate that information from git-blame when
>> generating the documentation, but how would trivial fixes be handled
>> that are no functional changes?  For instance, it seems difficult to me
>> to distinguish between a spelling change for some parameter description
>> and a change in behavior.
>>
>> (Then again, we shouldn't have such behavioral changes, hm.)

Gathering "since" information could be partially automated.  Syntactical
changes are visible in introspection.  Keep a persistent map syntactical
element -> first version, and a program to update it for new stuff in
introspection data since the last release.  Commit the map on release.

Automation would be partial, because we can't rule out the need for
documenting a "since" for a change that isn't syntactical.

While there, have the program report any changes that aren't additions.
These are potential compatibility breakers, and should be reviewed.

>> To me personally, the easiest thing would seem to be some convention to
>> write ***INSERT VERSION HERE*** into the code and then the maintainer
>> can just find an replace all instances of that when applying the
>> patches.  But that sounds a bit silly...

Maintainers are our bottleneck.  Shifting work from submitter to
maintainer makes the bottleneck narrower.

>> (I don't have an issue with adjusting the version numbers myself as they
>> are, but it's just as hard for me to find and replace all of them as it
>> is for you.  And since you're probably going to send a v4 anyway...)
>>
>> In the end, it's up to the QAPI maintainers.
>
> IFF I submit by the end of the week, what version number shall I choose?

IFF you want to be taken seriously, cut the hyperbole.

You raised a valid point.  Don't sabotage yourself.

[...]
