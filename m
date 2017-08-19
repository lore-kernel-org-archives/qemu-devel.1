Received: from eggs.gnu.org ([2001:4830:134:3::10]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1disN0-0003LP-Oo
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 21:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1disMz-0004lX-Bn
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 21:16:10 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:34711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1disMz-0004jf-4Y
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 21:16:09 -0400
Received: by mail-qk0-x233.google.com with SMTP id u139so61269992qka.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 18:16:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ2SuL=F3oAA6KbURSQRaqNS_DPSZ7tGOjgEcgNkfzdXxw7tTQ@mail.gmail.com>
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
	<874lt7wfg8.fsf@dusky.pond.sub.org>
	<CAJ2SuLnH9dvfWs1XX-Pd+GE9s0kZP_3LkMs_Crt9QTkz48NsyA@mail.gmail.com>
	<CAJ2SuL=F3oAA6KbURSQRaqNS_DPSZ7tGOjgEcgNkfzdXxw7tTQ@mail.gmail.com>
From: Pradeep Kiruvale <pradeepkiruvale@gmail.com>
Date: Sat, 19 Aug 2017 03:16:06 +0200
Message-ID: <CAJ2SuLkyJCMXpD1Z3XwwWJch0oPsPp8nFSdjJhXoc=n1pHuErg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, greg kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

On Aug 16, 2017 11:41 PM, "Markus Armbruster" <armbru@redhat.com> wrote:

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


Thanks for all the clarifications, sure I will move iothrottle code to
block-core.json.

Thanks,
Pradeep
