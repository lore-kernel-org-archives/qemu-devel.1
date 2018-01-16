Received: from eggs.gnu.org ([2001:4830:134:3::10]:34690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebMOL-0003wM-VP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 03:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebMOI-0000Kv-O5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 03:14:45 -0500
References: <76a29a1e-7fdb-37a8-9f79-df618d385b05@virtuozzo.com>
	<9e11cf33-cbe1-9fd5-f265-180e4e14dfa7@redhat.com>
	<6a2d73cc-5042-54c8-364d-18d273547f27@virtuozzo.com>
	<e5e834f9-5482-addc-0e45-00b39186e92f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9fbb6a54-e978-d14a-2805-ef51bac59aaf@virtuozzo.com>
Date: Tue, 16 Jan 2018 11:14:22 +0300
MIME-Version: 1.0
In-Reply-To: <e5e834f9-5482-addc-0e45-00b39186e92f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] qcow2 autoloading bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

16.01.2018 00:26, John Snow wrote:
>
> On 01/11/2018 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 11.01.2018 17:43, Eric Blake wrote:
>>> On 01/11/2018 08:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>>> # @autoload: the bitmap will be automatically loaded when the image it
>>>> is stored
>>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
 is opened. This flag may only be specified for persistent
>>>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
tmaps. Default is false for block-dirty-bitmap-add.
>>>> (Since: 2.10)
>>>>
>>>> so, if we consider only enabled bitmaps it is ok to direct map autoloa=
d
>>>> <=3D> auto.
>>>>
>>>> But now we've faced into necessity of load/store disabled bitmaps.
>>>>
>>>> Current behavior is definitely wrong: user sets autoload flag for
>>>> disabled bitmap, but on next
>>>> Qemu start the bitmap will be autoloaded and enabled.
>>> Can we make it an error to set autoload to true when requesting a
>>> disabled bitmap? Or can we not even request a disabled bitmap?
>> currently, autoload is set on bitmap creation, so it is always enabled
>> at this time.
>>
>>>> Proposed solution:
>>>>  =C2=A0- deprecate @autoload flag for bitmap creation, ignore it
>>> Is there ever a case where you'd create an enabled persistent
>>> dirty-tracking bitmap, but not want it to be re-enabled the next time
>>> the image is created?
>> looks like we do not. For now we use only persistent+autoload.
>>
>>> Your argument for ignoring/deleting the parameter
>>> is that you can decide whether to set the "auto" flag solely based on
>>> whether the bitmap is both persistent and enabled, without needing any
>>> additional user input?
>> The main point is that, when we want to load/store disabled bitmaps this
>> parameter is confusing: In user's point of view it's ok to have autoload=
ing
>> disabled bitmap, which he wants to be autoloaded and disabled on next Qe=
mu
>> start. So, to maintain this flag (autoload) for disabled bitmaps, we
>> will need
>> to add some additional flag "disabled" to Qcow2 spec, to make it possibl=
e to
>> have "auto" but "disabled" bitmaps. And we will have to change qcow2 "au=
to"
>> specification, to consider "disabled" bit set in parallel. But all this
>> looks
>> superfluous for now. We already have type "dirty tracking bitmaps" in qc=
ow2
>> spec for dirty bitmaps. So, for now, "auto" flag set on "dirty tracking
>> bitmaps" means that it is enabled. It is logical to assume that all othe=
r
>> "dirty tracking bitmaps" are disabled.
>>
> Oh, so you want to be able to "autoload" a disabled bitmap, is that right=
?

yes.

>
> Is it important to distinguish these two cases?
> (1) A bitmap is saved to the qcow2, but autoload is set to false
> (2) A bitmap is saved to the qcow2, autoload is true, but a (new)
> disabled bit is set.

there no "autoload" bitmaps in qcow2. there are "auto" ones, which has a=20
bit different
meaning, see above. And, if we create bitmaps with "auto" and "disabled"=20
bits set to true,
it will contradict with current "auto" definition.

actually "auto" definition looks more like "enabled" bit (which requires=20
autoloading, if we are
going to write to the drive, to not break this enabled bitmap).

the concept of "autoloading" exists only in qapi, and actually it=20
doesn't support disabled bitmaps.
And I think the most simple way to unravel all this mess is to drop this=20
concept for now, as it
is one of the following:
1) it is useless (if we don't support persistent disabled bitmaps)
2) it is broken (if we support persistent disabled bitmaps)

hmm, sorry. a lot of words, but I'm not sure that I've directly answered=20
your question.
if we have "autoload" instead of "auto" in qcow2, then it should be:
autoload=3Dtrue, disabled=3Dfalse - normal autoloading enabled bitmap
autoload=3Dtrue, disabled=3Dtrue - normal autoloading disabled bitmap
autoload=3Dfalse, disabled=3Dtrue - not-autoloading disabled bitmap. (the=20
case, which we can't
realize with my proposed approach, of loading all bitmaps, but I do not=20
think that this is bad,
and I think that "autoload" is wrong concep for qcow2)
autoload=3Dfalse, disabled=3Dfalse - looks like something wrong. enabled=20
bitmap, which should not be
autoloaded? Does it mean that we should open disk read-only, if we do=20
not load this bitmap? Anyway,
this doesn't look very useful.


>
> Is it okay, basically, to always autoload bitmaps in a disabled state?

"auto" bitmaps should be enabled to track dirtiness, as described in spec


> Is it imperative we add the new bit?

I think new bit is a bit of redundant information, as, actually, all=20
bitmaps in qcow2 with type=3D"dirty tracking bitmap" and with auto=3Dfalse=
=20
are actually disabled

>
> (Genuinely asking. I'm not sure.)
>
>> On the other hand, "autoloading" is a bad property for disabled bitmap
>> at all.
>> Disabled bitmap is simpler than enabled (or "auto") bitmap, it doesn't
>> require
>> any care like "auto" bitmap. So, it is more natural to let Qemu decide
>> to load
>> or not any disabled bitmaps.
>>
> If we don't autoload the disabled ones, I imagine you'll eventually want
> some way to manually load them into memory to manipulate them for
> various reasons.

Yes, I thought about it. But now for simplicity I propose just to load=20
all of them.
And later it may be optimized to "lazy load", so we actually will load=20
such bitmaps only on real
request to its data, however it will be in list and in query-block from=20
qemu start. It should be
comfortable for user.

However, other strategy (by hand) of loading may be implemented in=20
future. It also may be needed to
load bitmap through NBD.

>
>>
>>>>  =C2=A0- save persistent enabled bitmaps with "auto" flag
>>>>  =C2=A0- save persistent disabled bitmaps without "auto" flag
>>>>  =C2=A0- on Qemu start load all bitmaps, mapping "auto" flag state to
>>>> "enabled" state.
>>> So if I follow the argument, the state of the 'auto' flag stored into
>>> the file on BDS close (often at qemu exit) is based on whether the
>>> bitmap was currently enabled, and the user can then control whether to
>>> enable/disable the bitmap on the fly to control whether the 'auto' flag
>>> is stored; thus, having the flag at creation time is redundant.
>> Yes.
>>
>>>> Note: we may store a lot of disabled bitmaps in qcow2 image, but loadi=
ng
>>>> them all into RAM may be
>>>> inefficient. Actually such bitmap will be needed only on demand (for
>>>> export through nbd or
>>>> making some kind of backup). So in future it may be optimized by "lazy
>>>> load" of disabled bitmaps,
>>>> postponing their actual load up to first read or enabling. This
>>>> optimization doesn't need changing
>>>> of qapi or qcow2 format (at first sight).
>>>>
>>>>
>>>> Note2: now there is no way to disable/enable bitmaps, but there is a
>>>>  =C2=A0 [PATCH for-2.12 0/4] qmp dirty bitmap API
>>>> with big conversation, but I hope, I'll post a new version with a smal=
l
>>>> fix soon and it will be merged.
>>> In other words, you can incorporate your QAPI tweaks proposed here into
>>> your respin of that series.
>>>
>> right idea, I'll do so, just wait a bit for others to comment here.
>>
> Stay tuned...
>
>> --=20
>> Best regards,
>> Vladimir
>>


--=20
Best regards,
Vladimir
