Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQph7-0008MY-Lh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQph6-0001cV-LP
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:50:53 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<87tvqjf28u.fsf@dusky.pond.sub.org>
	<3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
	<df356e6b-8559-1a79-17cf-47bdfeb8612d@redhat.com>
	<b088605a-477f-4c80-34d8-c6677cfdb37e@redhat.com>
	<87d0x33wyr.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <19326638-6980-5473-dea9-79c7aabdf710@redhat.com>
Date: Thu, 7 Jun 2018 09:50:41 +0200
MIME-Version: 1.0
In-Reply-To: <87d0x33wyr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 07.06.2018 08:57, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 05.06.2018 00:40, Eric Blake wrote:
>>> On 06/04/2018 05:34 AM, Thomas Huth wrote:
>>>> On 04.06.2018 09:18, Markus Armbruster wrote:
>>>>> Roman Kagan <rkagan@virtuozzo.com> writes:
>>>>>
>>>>>> Add helper functions to query the block drivers actually supported=
 by
>>>>>> QEMU using "-drive format=3D?".=C2=A0 This allows to skip certain =
tests that
>>>>>> require drivers not built in or whitelisted in QEMU.
>>>>>>
>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 supported_formats=3D$($QEMU_PROG $QEMU_OPTIONS=
 -drive format=3D\?
>>>>>> 2>&1 | \
>>>>>
>>>>> Use of '?' to get help is deprecated.=C2=A0 Please use 'format=3Dhe=
lp', and
>>>>> update your commit message accordingly.
>>>>
>>>> Is it? Where did we document that?
>>>
>>> Hmm, we haven't documented it yet, but it's been that way since commi=
t
>>> c8057f95, in Aug 2012, when we added 'help' as the preferred synonym,
>>> and have tried to avoid mention of '?' in new documentation (as it
>>> requires additional shell quoting).=C2=A0 I'm guessing we'll probably=
 see a
>>> patch from you to start an official deprecation window?
>>
>> I'm using '?' regularly on my own, so don't expect a patch from
>> my side here ;-)
>> Anyway, we still use the question mark in our documentation, e.g.:
>>
>> options
>>
>>     is a comma separated list of format specific options in a name=3Dv=
alue format.
>>     Use -o ? for an overview of the options supported by the used form=
at or see
>>     the format descriptions below for details.
>>
>> or:
>>
>> -b, --blacklist=3Dlist
>>
>>     Comma-separated list of RPCs to disable (no spaces, =E2=80=98?=E2=80=
=99 to list available RPCs)
>=20
> These are bugs, and we need to fix them.
>=20
>> So calling it deprecated sounds wrong to me.
>=20
> Our intent to deprecate it was pretty clear in commit c8057f95:
>=20
>     /**
>      * is_help_option:
>      * @s: string to test
>      *
>      * Check whether @s is one of the standard strings which indicate
>      * that the user is asking for a list of the valid values for a
>      * command option like -cpu or -M. The current accepted strings
> -->  * are 'help' and '?'. '?' is deprecated (it is a shell wildcard
>      * which makes it annoying to use in a reliable way) but provided
>      * for backwards compatibility.
>      *
>      * Returns: true if @s is a request for a list.
>      */
>     static inline bool is_help_option(const char *s)
>=20
> Predates today's more formal deprecation policy.  Simpler times.

Sure, but finding such messages in the sources can be quite cumbersome...

> There's no real need to kill off '?', unless it gets in the way of
> steering people towards 'help'.  We should steer them toward 'help',
> because '?' is a trap for insufficiently sophisticated users of
> shell[*].

... and I agree with your points here.

=3D> I think we need a second list of deprecated feature (maybe we should
call them "legacy features" instead of "deprecated"?), i.e. a list of
features which we don't recommend for new code / scripts anymore, but
which we do not intend to remove via our official deprecation policy any
time soon. Things like "--enable-kvm" / "-no-kvm" or maybe even "-net"
go into the same category.

If you agree, I can try to come up with a patch (should the list go into
qemu-doc.texi or a separate document in the the documentation folder?).

 Thomas
