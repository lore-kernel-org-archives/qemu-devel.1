Received: from eggs.gnu.org ([2001:4830:134:3::10]:60592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1di2mt-0005oL-IO
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 14:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1di2mq-0001zX-DF
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 14:11:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1di2mq-0001z9-3Q
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 14:11:24 -0400
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
	<87pobv1oeo.fsf@dusky.pond.sub.org>
	<77e7be70-4d71-56ba-18e3-92cb2b24b38e@redhat.com>
Date: Wed, 16 Aug 2017 20:11:19 +0200
In-Reply-To: <77e7be70-4d71-56ba-18e3-92cb2b24b38e@redhat.com> (Eric Blake's
	message of "Wed, 16 Aug 2017 12:13:39 -0500")
Message-ID: <874lt7wfg8.fsf@dusky.pond.sub.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>

Eric Blake <eblake@redhat.com> writes:

> On 08/16/2017 11:13 AM, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>> 
>
>>>
>>> Conclusion: no consensus, yet.
>> 
>> All right, let's start over and try to resolve the impasse and/or
>> misunderstanding.
>> 
>> Type BlockIOThrottle lives in qapi/block-core.json, and is used by QMP
>> command block_set_io_throttle.  Since 1.1.
>> 
>> Pradeep has a use case for throttling in fsdev.  Instead of duplicating
>> the relevant parts of BlockIOThrottle, qmp_block_set_io_throttle() and
>> hmp_block_set_io_throttle(), he factors them out smartly, into
>> 
>> * [PATCH 2] IOThrottle, base type of BlockIOThrottle
>> 
>> * [PATCH 3] throttle_set_io_limits(), called by
>>   qmp_block_set_io_throttle()
>> 
>> * [PATCH 4] hmp_initialize_io_throttle(), called by
>>   hmp_block_set_io_throttle()
>> 
>> throttle_set_io_limits() goes into existing util/throttle.c, and
>> hmp_initialize_io_throttle() goes into existing hmp.c.  The question is
>> where IOThrottle should go.
>
> Good summary.
>
>> 
>> Pradeep proposes to put it in new qapi/throttle.json.  Certainly
>> defensible, but I really don't like putting every little thing shared
>> across subsystem boundaries into its own schema file.
>
> I agree with the dislike of creating new files, if an existing file is
> adequate.
>
>> 
>> Let me step back and discuss why we split the QAPI schema into multiple
>> files in the first place.  For me, the one and only reason is
>> MAINTAINERS.
>
> Indeed, that's a good description of why splits would be appropriate.
> So the obvious next question is if this is a case that needs a new
> maintainer.
>
>> 
>> If the block folks should continue to maintain IOThrottle, then it
>> should stay put in block-core.json.
>
> I think Manos' work on making throttling a filter driver at the block
> layer is proof enough that it it is still fine to keep throttling
> maintained in block-core.json.
>
>> 
>> If somebody else should start maintaining it, it should move.  We'd need
>> a suitable entry in MAINTAINERS then.
>> 
>> I don't see why maintenance should change, and therefore believe it
>> should stay put.
>> 
>> Eric?
>
> I think we're in violent agreement: don't create a new file, and having
> the new factored type live in block-core.json is the best fit because we
> haven't come up with any reasons why it needs to be split.

Thanks, Eric.

Pradeep, please put IOThrottle right before BlocIOThrottle in
block-core.json.  Use it in fsdev.json without including
block-core.json.  Sorry for the delay.
