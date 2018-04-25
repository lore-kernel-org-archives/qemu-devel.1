Received: from eggs.gnu.org ([2001:4830:134:3::10]:33126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBK0k-00043e-3X
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBK0h-0007Jl-0N
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:59:02 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
Date: Wed, 25 Apr 2018 14:58:54 +0200
Message-ID: <w5136zjsar5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri 20 Apr 2018 03:13:49 PM CEST, Max Reitz wrote:
>>>>>> One other way is to have a more generic replace-node command
>>>>>> which would call bdrv_replace_node(), but I don't know if we want
>>>>>> to expose that and I don't have any other use case for it at the
>>>>>> moment.
>>>>>
>>>>> I think we do want to expose that.  As far as I'm informed, for
>>>>> graph manipulation we want a command that can replace nodes
>>>>> (including replacing nothing by a new node or replacing an
>>>>> existing node by nothing, if the parent supports that).
>>>>
>>>> Was there any discussion about this in the mailing list? (proposed
>>>> name for this function, features, etc.)
>>>
>>> Well, there is x-blockdev-change.  But we probably want to expose
>>> bdrv_reopen() in the long run.
>> 
>> Exposing bdrv_reopen() itself shouldn't be too much work (it takes
>> just two node names, or am I missing something?).

I just realized that I meant "Exposing bdrv_replace_node()" here.

> So from my perspective...  If you think it's easy, why don't you try
> it and then we'll see? *cough*

I'm doing it :-)

>> There's still the question of how to update the backing file string
>> (on the overlay). stream and commit do it automatically, but if we do
>> bdrv_reopen() or the aforementioned modification to blockdev-mirror

bdrv_replace_node() again

>> we'd need to do it explicitly with change-backing-file, or extend the
>> API to allow for that.
>
> Well, the December notes do say that we probably want an option to
> specify the target's filename which is what will be written into the
> overlays of @to_replace as their backing file string, so I think
> extending the API should be fine.

Yes, but how do you find out what the overlays are (without an
additional parameter, that is)? I thought we didn't want to support
walking the backing chain in reverse direction.

Berto
