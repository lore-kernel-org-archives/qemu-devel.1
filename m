Received: from eggs.gnu.org ([209.51.188.92]:41792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1ghZzj-0005By-De
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1ghZzd-0006rb-Uz
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:03:33 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:40147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1ghZzU-0006mn-HB
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:03:23 -0500
Received: by mail-qt1-x82e.google.com with SMTP id k12so12494952qtf.7
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 05:03:15 -0800 (PST)
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
	<20190110112508.GA6361@linux.fritz.box> <20190110114113.GC2589@work-vm>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <2c44ef87-d69e-4adb-ca6b-5bdf246c01bc@gmail.com>
Date: Thu, 10 Jan 2019 11:03:09 -0200
MIME-Version: 1.0
In-Reply-To: <20190110114113.GC2589@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, muriloo@linux.ibm.com



On 1/10/19 9:41 AM, Dr. David Alan Gilbert wrote:
> * Kevin Wolf (kwolf@redhat.com) wrote:
>> Am 09.01.2019 um 20:02 hat Eric Blake geschrieben:
>>> On 1/9/19 12:51 PM, Kevin Wolf wrote:
>>>
>>>>> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
>>>>> human-monitor-command, since there is no QMP counterpart for internal
>>>>> snapshot.  Even though lately we consistently tell people that internal
>>>>> snapshots are underdeveloped and you should use external snapshots, it
>>>>> does not get away from the fact that libvirt has been using 'savevm' to
>>>>> drive internal snapshots for years now, and that we MUST consider
>>>>> back-compat and/or add an introspectible QMP interface before making
>>>>> changes that would break libvirt.
>>>> Okay, so what does libvirt do when you request a snapshot with a
>>>> numerical name? Without having looked at the code, the best case I would
>>>> expect that it forbids them, and more realistically I suspect that we
>>>> may actually fix a bug for libvirt by changing the semantics.
>>>>
>>>> Or does libvirt really use snapshot IDs rather than names?
>>> At the moment, libvirt does not place any restriction on internal
>>> snapshot names, but passes the user's name through without thought of
>>> whether it is an id or a name.
>>>
>>> So yes, arguably tightening the semantics fixes a libvirt bug for
>>> libvirt having allowed internal snapshots to get into an inconsistent
>>> state.
>> So there are two scenarios to consider with respect to breaking
>> backwards compatibility:
>>
>> 1. There may be code out there that relies on numeric arguments being
>>     interpreted as IDs. This code will break if we make this change and
>>     numeric snapshot names exist. That such code exists is speculation
>>     (even though plausible) and we don't know how widespread it is.
>>
>> 2. There may be code out there that blindly assumes that whatever it
>>     passes is interpreted as a name. Nobody considered that with a
>>     numeric snapshot name, it maybe misinterpreted as an ID. We know that
>>     this is true for libvirt, the single most used management tool for
>>     QEMU. More code like this may (and probably does) exist.
>>
>> Essentially the same two categories exist for human users: those who
>> somehow found out that QEMU accepts IDs as monitor command arguments and
>> are using those (mitigated by not displaying IDs any more), and those
>> who are trapped because they wanted to access a numeric name, but
>> surprisingly got it interpreted as an ID. Both are speculation to some
>> degree, but my guess is that the latter group is larger.
>>
>> Given all this, this is a no-brainer for me. We simplify the interface,
>> we simplify the code, we make things less confusing for manual users and
>> we fix the management tool that everybody uses. How could we not make
>> this change?
>>
>>> But again, it falls in the category of "properly fixing this
>>> requires a lot of auditing, time, mental power, and unit tests", which
>>> makes it a rather daunting task to state for certain.
>> Fix the world before we can fix anything?
> Can't we break this loop for the savevm command fairly easily; it's
> currently documnted as:
>
> savevm [tag|id]
>
> If we made that:
>
> savevm [-t] [-i] [tag|id]
>
> then:
>    a) with neither -t or -i  it would behave in the same roulette way
>       as it does in the moment, and it might be a tag or id

The roulette we have today is too confusing IMO. For starters, we're not 
creating
snapshot using ID at this moment. The ID is being auto-generated by doing
max_ID_found + 1.

Quick example: savevm 4 isn't creating a snapshot with ID=4 and an empty 
tag - it is
creating a snapshot with ID=ID_MAX + 1 and tag = 4. Let's say that 
ID_MAX was 9,
so this new snapshot would be ID=10, tag=4.

Now, the user wants to delete this snapshot. "delvm 4" will  first match 
ID, then tag.
If there is a snapshot with ID=4, it will be mistakenly erased. Note 
that this isn't
a bug - even with tweaks here and there, savevm/delvm (number) will always
be ambiguous because the API is allowing the user to interpret an input 
anyway
he/she wants. This is an API design issue.

The only way I see to reliably make this id|tag API to work is to always 
interpret
numerical arguments as ID. Then we can safely assume what the user wants 
to do.
We wouldn't even need the other 2 options you mentioned (-t and -i). But 
then,
as I've said somewhere in this thread, users would complain that "savevm 
4" isn't
doing what it was doing before. "savevm 4 is creating snapshots with 
auto-generated
tag instead of  tag=4". I can see the bugzillas already.



DHB



>
>    b) with -t we'd explicitly treat the parameter as a tag and it
>       would error if it wasn't found
>
>    c) With -i we'd explicitly treat the parameter as an id and
>       it would error if it wasn't found
>
> Since we still allow (a) it doesn't break any existing code.
>
> Dave
>
>
>> Kevin
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
