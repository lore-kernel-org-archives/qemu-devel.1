Received: from eggs.gnu.org ([209.51.188.92]:38292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goBFD-0004Nj-10
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goBF9-0001Yu-06
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:48 -0500
Date: Mon, 28 Jan 2019 19:02:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128180219.GM5756@localhost.localdomain>
References: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
	<20190128144720.GB5756@localhost.localdomain>
	<d5c28554-fee3-5c12-3528-150c0d048903@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c28554-fee3-5c12-3528-150c0d048903@yandex-team.ru>
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
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Am 28.01.2019 um 17:53 hat Anton Kuchin geschrieben:
> On 28/01/2019 17:47, Kevin Wolf wrote:
> > Am 28.01.2019 um 15:27 hat Anton Kuchin geschrieben:
> > > Some HMP and QMP commands are targeting BlockBackend but
> > > for hotplugged devices name of BB is deprecated, instead
> > > name of root BlockDriverState is set. These patches add
> > > functions to search BB by attached root BDS name.
> > > 
> > > This approach isn't perfect, but I couldn't invent a better
> > > one and I belive it's more convinient than accessing BB
> > > by QOM path.
> > There could be more than one BlockBackend attached to a single node, so
> > this approach is simply wrong.
> 
> I was thinking about this but couldn't imagine configuration when it's
> having more than one root. Can you give an example, please, so I understand
> this case better.

You can configure such setups explicitly by just using the same -device
drive=node-name twice, though I admit this is unusual.

The more practical case are internal BlockBackends for use by block jobs
or the NBD server. In that case, the user might modify a completely
different BlockBackend than they had in mind.

> > I think the qdev ID is actually not only a pretty convenient way, but in
> > fact the only logical way to address a guest device (and BlockBackends
> > that can be accessed by the monitor are essentially a part of the guest
> > device).
> 
> As far as I remember backends currently have emply qdev ID so the only way
> to address them now is QOM path like ".../my_hotplug_drive/virtio-backend".
> So I have to remember the name of the root driver it is connected to and
> also add this "/virtio-backend" suffix.

virtio-blk is ugly, indeed, because the device is split in two halves
and the half with the assigned ID isn't the half that owns the
BlockBackend. But the paths are relative to /machine/peripheral, so I
think just "my_hotplug_drive/virtio-backend" should work.

For all other devices, it's just the ID, as far as I know.

> Can you explain a bit what are "monitor referenced" backends and which one
> can be accessed from monitor and which can not.

The user isn't supposed to access internal BlockBackends, like those of
block jobs and the NBD server.

> > Does your series allow to perform any operation that isn't possible
> > currently? If so, it's probably this operation that needs to be fixed to
> > either accept node names (if it's a backend operation) or a device ID
> > (if it's a frontend operation).
> 
> Yes. It fixes latency histogram setting, nbd server binding to remove event
> and a couple of hmp comands. I also suspect that this can affect migration
> but I could't figure out what name is used for identifying drives.

qmp_x_block_latency_histogram_set() uses blk_by_name() to get the
BlockBackend. The fix is to make it use qmp_get_blk() instead.

I'm not sure what the exact NBD thing is you mean.

Kevin
