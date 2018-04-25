Received: from eggs.gnu.org ([2001:4830:134:3::10]:45514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBKgs-0001v2-BR
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBKgn-0003nm-Ie
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:42:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
	<ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
	<w51bmegjzp4.fsf@maestria.local.igalia.com>
	<216e7398-0bc3-4822-d4b0-e0267c714abb@redhat.com>
	<w5136zjsar5.fsf@maestria.local.igalia.com>
	<bc26c382-458f-5a86-de59-3945397fbcac@redhat.com>
Date: Wed, 25 Apr 2018 15:42:26 +0200
Message-ID: <w51wowvqu65.fsf@maestria.local.igalia.com>
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

On Wed 25 Apr 2018 03:06:34 PM CEST, Max Reitz wrote:
>>>>>>>> One other way is to have a more generic replace-node command
>>>>>>>> which would call bdrv_replace_node(), but I don't know if we
>>>>>>>> want to expose that and I don't have any other use case for it
>>>>>>>> at the moment.
>>>>>>>
>>>>>>> I think we do want to expose that.  As far as I'm informed, for
>>>>>>> graph manipulation we want a command that can replace nodes
>>>>>>> (including replacing nothing by a new node or replacing an
>>>>>>> existing node by nothing, if the parent supports that).
>>>>>>
>>>>>> Was there any discussion about this in the mailing list?
>>>>>> (proposed name for this function, features, etc.)
>>>>>
>>>>> Well, there is x-blockdev-change.  But we probably want to expose
>>>>> bdrv_reopen() in the long run.
>>>>
>>>> Exposing bdrv_reopen() itself shouldn't be too much work (it takes
>>>> just two node names, or am I missing something?).
>> 
>> I just realized that I meant "Exposing bdrv_replace_node()" here.
>> 
>>> So from my perspective...  If you think it's easy, why don't you try
>>> it and then we'll see? *cough*
>> 
>> I'm doing it :-)
>> 
>>>> There's still the question of how to update the backing file string
>>>> (on the overlay). stream and commit do it automatically, but if we do
>>>> bdrv_reopen() or the aforementioned modification to blockdev-mirror
>> 
>> bdrv_replace_node() again
>
> But the question stands whether we need simple node replacement when
> we want bdrv_reopen() anyway.  In addition, we don't need just
> replacement, we also need addition and removal (e.g. for backing files
> or quorum children) -- and especially in the case of quorum, that is
> going to be a pain (mostly naming the children).
>
> With bdrv_reopen(), we can just require the user to respecify all
> children, so we don't run into the issue of how to name things at
> least.

So in this example, if you want to replace [B] with [E] you would reopen
[C] specifying the new backing file?

   [A] <- [B] <- [C] <- [D]

          [E]

Berto
