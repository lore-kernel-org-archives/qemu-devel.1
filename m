Received: from eggs.gnu.org ([209.51.188.92]:50349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1goAAR-00022h-Os
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1goAAQ-0004SC-Qz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:53:51 -0500
References: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
	<20190128144720.GB5756@localhost.localdomain>
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <d5c28554-fee3-5c12-3528-150c0d048903@yandex-team.ru>
Date: Mon, 28 Jan 2019 19:53:44 +0300
MIME-Version: 1.0
In-Reply-To: <20190128144720.GB5756@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] block: add blk_lookup() for getting
 device by node_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 28/01/2019 17:47, Kevin Wolf wrote:
> Am 28.01.2019 um 15:27 hat Anton Kuchin geschrieben:
>> Some HMP and QMP commands are targeting BlockBackend but
>> for hotplugged devices name of BB is deprecated, instead
>> name of root BlockDriverState is set. These patches add
>> functions to search BB by attached root BDS name.
>>
>> This approach isn't perfect, but I couldn't invent a better
>> one and I belive it's more convinient than accessing BB
>> by QOM path.
> There could be more than one BlockBackend attached to a single node, so
> this approach is simply wrong.

I was thinking about this but couldn't imagine configuration when it's 
having more than one root. Can you give an example, please, so I 
understand this case better.

> I think the qdev ID is actually not only a pretty convenient way, but in
> fact the only logical way to address a guest device (and BlockBackends
> that can be accessed by the monitor are essentially a part of the guest
> device).

As far as I remember backends currently have emply qdev ID so the only 
way to address them now is QOM path like 
".../my_hotplug_drive/virtio-backend". So I have to remember the name of 
the root driver it is connected to and also add this "/virtio-backend" 
suffix.

Can you explain a bit what are "monitor referenced" backends and which 
one can be accessed from monitor and which can not.

> Does your series allow to perform any operation that isn't possible
> currently? If so, it's probably this operation that needs to be fixed to
> either accept node names (if it's a backend operation) or a device ID
> (if it's a frontend operation).

Yes. It fixes latency histogram setting, nbd server binding to remove 
event and a couple of hmp comands. I also suspect that this can affect 
migration but I could't figure out what name is used for identifying drives.

Some of this code is also linked to utilities (qemu-img, qemu-io-cmds 
...) which require linking all QAPI stuff to them, that seems to be an 
overkill. I'll prepare the patch to eliminate this dependency and allow 
using QOM here if we decide that this is the best way.

> Kevin
>
