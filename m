Received: from eggs.gnu.org ([208.118.235.92]:52782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1gXmQb-00089H-E0
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1gXmQa-0006WE-Kq
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:18:49 -0500
References: <94f9fc23-961c-7109-643b-ba1e8c625d92@yandex-team.ru>
	<87h8fkbjyn.fsf@dusky.pond.sub.org>
	<20181211094709.GA31849@localhost.localdomain>
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <56c5a80f-6382-fe4d-7597-65bbf99def69@yandex-team.ru>
Date: Fri, 14 Dec 2018 15:18:40 +0300
MIME-Version: 1.0
In-Reply-To: <20181211094709.GA31849@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] block: Is name of BlockBackend deprecated
 with -blockdev parameter?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>

I want to make it consistent but I'm note sure I understand all aspects=20
of current state and legacy clients we need to support.

The initial idea was to have single function blk_lookup(char* name) and=20
search in all namespaces internally as they are guaranteed to have no=20
intersection. This will work a little slower but I see no hot paths that=20
will be affected. And this way transition will be transparent to users=20
but I'm not sure this can be done in backward compatible way.
Do you have any suggestions how to do it correctly?

On 11/12/2018 12:47, Kevin Wolf wrote:
> [...]
>> Anton Kuchin <antonkuchin@yandex-team.ru> writes:
>> [...]
>>
>> As far as I understand all named backends are stored in
>> monitor_block_backends list, but I can't get what is the point of
>> having this list, and why parse_drive() function doesn't call
>> monitor_add_blk() like blockdev_init() does with -drive option. Can
>> someone give me a hint on this?

And what are monitor_block_backends used for? What does monitor=20
reference mean in this context and how backends in this list differ from=20
all others?

>>> I also noticed that some commands fallback to search by qdev_id or
>>> BDS->node_name,=C2=A0 but at the creation time (both in
>>> bdrv_assing_node_name and monitor_add_blk) it is already checked that
>>> names are unique across these namespaces so may be it would be useful
>>> to introduce generic search function?
> Yes, BlockBackend names are not supposed to be used in the external
> interfaces any more. If the QMP command is about the backend, it will
> take a node name, and if it's about the guest device (which may not eve=
n
> have a node attached with removable media), it will take a qdev ID.
>
> The implementation of qmp_x_block_latency_histogram_set() is incorrect,
> it shouldn't use blk_by_name(). I wonder where it got that pattern from
> because it was added long after all other QMP commands had switched to
> qmp_get_blk() or bdrv_lookup_bs().

Do we still need blk_by_name() to be public? May be we can replace it by=20
new function like blk_lookup() and hide blk_by_name() for internal use=20
only or fix its behavior to search by qdev_id first and if it fails=20
fallback to old way of searching by device_id?

>
> hmp_commit() should indeed use bdrv_lookup_bs() to also accept node
> names.
But it also checks blk state before commit, so I'm not quite sure it can=20
work correctly without blk.
> I think we reviewed QMP to make sure we converted everything
> and forgot about HMP commands that aren't mapped to QMP.
>
> Kevin
>
Anton
