Received: from eggs.gnu.org ([2001:4830:134:3::10]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJDvL-0005rS-28
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJDvF-0007wC-TB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:06:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJDvF-0007w2-NZ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:06:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1526029534-35771-2-git-send-email-anton.nefedov@virtuozzo.com>
	<877eo6nm99.fsf@dusky.pond.sub.org>
	<1839ed60-ffd9-42c1-bf52-6d6121abb224@redhat.com>
	<87h8n9l7wq.fsf@dusky.pond.sub.org>
	<95ab24a5-d600-67b5-9c7e-e5290f42f520@redhat.com>
	<87a7t0u8az.fsf@dusky.pond.sub.org>
	<419b57a2-157e-b18c-944e-96ecdb391711@virtuozzo.com>
Date: Thu, 17 May 2018 10:05:59 +0200
In-Reply-To: <419b57a2-157e-b18c-944e-96ecdb391711@virtuozzo.com> (Anton
	Nefedov's message of "Wed, 16 May 2018 18:05:13 +0300")
Message-ID: <87fu2qogew.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: allow flat unions with empty
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Anton Nefedov <anton.nefedov@virtuozzo.com> writes:

> On 15/5/2018 8:40 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 05/15/2018 02:01 AM, Markus Armbruster wrote:
>>>
>>>>>> QAPI language design alternatives:
>>>>>>
>>>>>> 1. Having unions cover all discriminator values explicitly is useful.
>>>
>>>>>> 2. Having unions repeat all the discriminator values explicitly is not
>>>>>> useful.  All we need is replacing the code enforcing that by code
>>>>>> defaulting missing ones to the empty type.
>>>>>>
>>>>>> 3. We can't decide, so we do both (this patch).
>>>>>>
>>>
>>>> I'd prefer a more opinionated design here.
>>>>
>>>> Either we opine making people repeat the tag values is an overall win.
>>>> Then make them repeat them always, don't give them the option to not
>>>> repeat them.  Drop this patch.  To reduce verbosity, we can add a
>>>> suitable way to denote a predefined empty type.
>>>>
>>>> Or we opine it's not.  Then let them not repeat them, don't give them
>>>> the option to make themselves repeat them.  Evolve this patch into one
>>>> that makes flat union variants optional and default to empty.  If we
>>>> later find we still want a way to denote a predefined empty type, we can
>>>> add it then.
>>>>
>>>> My personal opinion is it's not.
>>>
>>> I followed the arguments up to the last sentence, but then I got lost
>>> on whether you meant:
>>>
>>> This patch is not an overall win, so let's drop it and keep status quo
>>> and/or implement a way to write 'branch':{} (option 1 above)
>>>
>>> or
>>>
>>> Forcing repetition is not an overall win, so let's drop that
>>> requirement by using something similar to this patch (option 2 above)
>>> but without adding a 'partial-data' key.
>>
>> Sorry about that.  I meant the latter.
>>
>>> But you've convinced me that option 3 (supporting a compact branch
>>> representation AND supporting missing branches as defaulting to an
>>> empty type) is more of a maintenance burden (any time there is more
>>> than one way to write something, it requires more testing that both
>>> ways continue to work) and thus not worth doing without strong
>>> evidence that we need both ways (which we do not currently have).
>
> I agree that neither option 3 nor this patch are the best way to handle
> this, so it's 1 or 2.
>
> (2) sure brings some prettiness into jsons; I wonder when it might harm;
> e.g. a person adds another block driver: it would be difficult to get
> round BlockdevOptionsFoo, and what can be missed is something
> optional like BlockdevStatsFoo, which is harmless if left empty and
> probably would be made an empty branch anyway. The difference is that
> an empty branch is something one might notice during a review and
> object.

Yes, forcing reviewer attention is the one real advantage of 1. I can
see.  I agree with you that reviewers missing the "main" union (such as
BlockdevOptions) is unlikely.  Missing "secondary" unions is more
plausible.  Let's see how many of unions sharing a tag enumeration type
we have.  A quick hack to introspect.py coughs up:

    Flat union type                  Tag enum type
    --------------------------------------------------------------
    BlockdevCreateOptions            BlockdevDriver
    BlockdevOptions                  BlockdevDriver
    BlockdevQcow2Encryption          BlockdevQcow2EncryptionFormat
    ImageInfoSpecificQCow2Encryption BlockdevQcow2EncryptionFormat
    BlockdevQcowEncryption           BlockdevQcowEncryptionFormat
    CpuInfo                          CpuInfoArch
    GuestPanicInformation            GuestPanicInformationType
    QCryptoBlockCreateOptions        QCryptoBlockFormat
    SchemaInfo                       SchemaMetaType
    SheepdogRedundancy               SheepdogRedundancyType
    SocketAddress                    SocketAddressType
    SshHostKeyCheck                  SshHostKeyCheckMode
    CpuInfoFast                      SysEmuTarget
    UsernetConnection                UsernetType

Two pairs.  We'll live.

> I think I'd vote for 2 (never enforce all-branches coverage) as well.

Eric, what do you think?

One more thought: if we ever get around to provide more convenient flat
union syntax so users don't have to enumerate the variant names twice,
we'll need a way to say "empty branch".  Let's worry about that problem
when we have it.
