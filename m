Received: from eggs.gnu.org ([2001:4830:134:3::10]:55981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdHF-00073e-TC
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdGB-00071W-Pq
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:21 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <476998d1-7dc0-0606-86da-aa2d5e2346f3@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
	<c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
	<w51r2q46eg2.fsf@maestria.local.igalia.com>
	<476998d1-7dc0-0606-86da-aa2d5e2346f3@redhat.com>
Date: Fri, 02 Feb 2018 10:41:09 +0100
Message-ID: <w51y3kbzq2y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 17/39] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Thu 01 Feb 2018 07:15:23 PM CET, Max Reitz <mreitz@redhat.com> wrote:
>>>> -static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
>>>> +static int l2_allocate(BlockDriverState *bs, int l1_index)
>>>>  {
>>>>      BDRVQcow2State *s = bs->opaque;
>>>>      uint64_t old_l2_offset;
>>>> -    uint64_t *l2_table = NULL;
>>>> +    uint64_t *l2_slice = NULL;
>>>> +    unsigned slice, slice_size2, n_slices;
>>>
>>> I'd personally prefer size_t, but oh well.
>> 
>> I don't see any reason not to use int / unsigned. The size of a slice
>> is always <= cluster_size (an int), and both slice and n_slices are
>> smaller than that.
>
> Well, what's the reason to use unsigned? :-)
> The type of the expression used to set slice_size2 simply is size_t.

I tend to choose the type of a variable based on what it's going to
hold, and use int (signed or not) whenever possible.

In this case a normal integer can certainly hold all possible values of
slice_size2. And unsigned because it's never going to be negative. It
could also be signed, it's not going to be any different in practice,
it's just more explicit.

Berto
