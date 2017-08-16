Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1di0wt-0006VD-IA
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1di0ws-0001gp-KN
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1di0ws-0001gL-At
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:13:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<87bmoxcuvn.fsf@dusky.pond.sub.org>
	<61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
	<87shh3fn7d.fsf@dusky.pond.sub.org>
	<w511soml2kh.fsf@maestria.local.igalia.com>
	<34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
	<w51shh2jfi9.fsf@maestria.local.igalia.com>
	<87wp6e6qb7.fsf@dusky.pond.sub.org>
	<dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
	<66aac45f-6319-2eca-3703-aaab43557e00@redhat.com>
	<87shgz8k5q.fsf@dusky.pond.sub.org>
Date: Wed, 16 Aug 2017 18:13:35 +0200
In-Reply-To: <87shgz8k5q.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 10 Aug 2017 18:25:21 +0200")
Message-ID: <87pobv1oeo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 08/10/2017 09:06 AM, Pradeep Jagadeesh wrote:
>>
>>>>> It's not "moving it back", it's keeping it where it is. But I see no big
>>>>> problem with moving it to a common file either.
>>>>
>>>> I'd rather not put every struct shared across subsystem boundaries in
>>>> its own file.
>>>>
>>>> We can keep it right where it is for now.  Bonus: more readable diff.
>>>> If we start sharing more throttle-related material than just a struct,
>>>> we can reconsider.
>>>>
>>>> We could also move it to the existing file for common stuff:
>>>> qapi/common.json.  Not a great fit, though.
>>>
>>> So, the final conclusion is to move to common.json?
>>
>> No.
>>
>> If more than one .json file would benefit by including the definition,
>> then put it in a separate file that both .json include from.
>
> This is the case.
>
> Your opinion is incompatible with mine, stated above.
>
>> But if only one .json file would be including a new file, then just
>> inline the struct directly into that one original file (in this case,
>> block-core.json) instead of creating a separate file (so no to needing
>> iothrottle.json), or putting the code in yet a different file than the
>> one that is using the struct (so no to putting it in common.json).
>
> This is no longer the case.
>
> Conclusion: no consensus, yet.

All right, let's start over and try to resolve the impasse and/or
misunderstanding.

Type BlockIOThrottle lives in qapi/block-core.json, and is used by QMP
command block_set_io_throttle.  Since 1.1.

Pradeep has a use case for throttling in fsdev.  Instead of duplicating
the relevant parts of BlockIOThrottle, qmp_block_set_io_throttle() and
hmp_block_set_io_throttle(), he factors them out smartly, into

* [PATCH 2] IOThrottle, base type of BlockIOThrottle

* [PATCH 3] throttle_set_io_limits(), called by
  qmp_block_set_io_throttle()

* [PATCH 4] hmp_initialize_io_throttle(), called by
  hmp_block_set_io_throttle()

throttle_set_io_limits() goes into existing util/throttle.c, and
hmp_initialize_io_throttle() goes into existing hmp.c.  The question is
where IOThrottle should go.

Pradeep proposes to put it in new qapi/throttle.json.  Certainly
defensible, but I really don't like putting every little thing shared
across subsystem boundaries into its own schema file.

Let me step back and discuss why we split the QAPI schema into multiple
files in the first place.  For me, the one and only reason is
MAINTAINERS.

If the block folks should continue to maintain IOThrottle, then it
should stay put in block-core.json.

If somebody else should start maintaining it, it should move.  We'd need
a suitable entry in MAINTAINERS then.

I don't see why maintenance should change, and therefore believe it
should stay put.

Eric?
