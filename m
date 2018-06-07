Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQorc-0006QE-SQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQorb-00045h-T2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:57:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<87tvqjf28u.fsf@dusky.pond.sub.org>
	<3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
	<df356e6b-8559-1a79-17cf-47bdfeb8612d@redhat.com>
	<b088605a-477f-4c80-34d8-c6677cfdb37e@redhat.com>
Date: Thu, 07 Jun 2018 08:57:32 +0200
In-Reply-To: <b088605a-477f-4c80-34d8-c6677cfdb37e@redhat.com> (Thomas Huth's
	message of "Tue, 5 Jun 2018 06:02:17 +0200")
Message-ID: <87d0x33wyr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 05.06.2018 00:40, Eric Blake wrote:
>> On 06/04/2018 05:34 AM, Thomas Huth wrote:
>>> On 04.06.2018 09:18, Markus Armbruster wrote:
>>>> Roman Kagan <rkagan@virtuozzo.com> writes:
>>>>
>>>>> Add helper functions to query the block drivers actually supported by
>>>>> QEMU using "-drive format=3D?".=C2=A0 This allows to skip certain tes=
ts that
>>>>> require drivers not built in or whitelisted in QEMU.
>>>>>
>>=20
>>>>> +=C2=A0=C2=A0=C2=A0 supported_formats=3D$($QEMU_PROG $QEMU_OPTIONS -d=
rive format=3D\?
>>>>> 2>&1 | \
>>>>
>>>> Use of '?' to get help is deprecated.=C2=A0 Please use 'format=3Dhelp'=
, and
>>>> update your commit message accordingly.
>>>
>>> Is it? Where did we document that?
>>=20
>> Hmm, we haven't documented it yet, but it's been that way since commit
>> c8057f95, in Aug 2012, when we added 'help' as the preferred synonym,
>> and have tried to avoid mention of '?' in new documentation (as it
>> requires additional shell quoting).=C2=A0 I'm guessing we'll probably se=
e a
>> patch from you to start an official deprecation window?
>
> I'm using '?' regularly on my own, so don't expect a patch from
> my side here ;-)
> Anyway, we still use the question mark in our documentation, e.g.:
>
> options
>
>     is a comma separated list of format specific options in a name=3Dvalu=
e format.
>     Use -o ? for an overview of the options supported by the used format =
or see
>     the format descriptions below for details.
>
> or:
>
> -b, --blacklist=3Dlist
>
>     Comma-separated list of RPCs to disable (no spaces, =E2=80=98?=E2=80=
=99 to list available RPCs)

These are bugs, and we need to fix them.

> So calling it deprecated sounds wrong to me.

Our intent to deprecate it was pretty clear in commit c8057f95:

    /**
     * is_help_option:
     * @s: string to test
     *
     * Check whether @s is one of the standard strings which indicate
     * that the user is asking for a list of the valid values for a
     * command option like -cpu or -M. The current accepted strings
-->  * are 'help' and '?'. '?' is deprecated (it is a shell wildcard
     * which makes it annoying to use in a reliable way) but provided
     * for backwards compatibility.
     *
     * Returns: true if @s is a request for a list.
     */
    static inline bool is_help_option(const char *s)

Predates today's more formal deprecation policy.  Simpler times.

There's no real need to kill off '?', unless it gets in the way of
steering people towards 'help'.  We should steer them toward 'help',
because '?' is a trap for insufficiently sophisticated users of
shell[*].

Every use of '?' in our source tree works against that goal, and thus
works towards a removal of '?'.



[*] In the wider sense, approximately 99.99% of shell users are
insufficiently sophisticated, including myself.  In the narrower sense
of being prone to fall into the '?' trap, the fraction is lower, but
still significant.
