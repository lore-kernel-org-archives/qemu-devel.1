Received: from eggs.gnu.org ([2001:4830:134:3::10]:45477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAbyg-0000KI-Kc
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAbyd-0006Tq-7P
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:30:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gAbyc-0006TN-WD
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:30:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so9958560wrt.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 07:30:10 -0700 (PDT)
Message-ID: <1539268208.16655.144.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Thu, 11 Oct 2018 16:30:08 +0200
In-Reply-To: <20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<1539189387.16655.63.camel@redhat.com>
	<20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
	<1539263541.16655.110.camel@redhat.com>
	<20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jonathon Jongsma <jjongsma@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Thu, 2018-10-11 at 15:43 +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > How does all this monitors_config work currently in case multiple
> > > display channels are present?
> > > 
> > > There is the QXLInterface->client_monitors_config() callback.
> > > 
> > > There is the spice_qxl_monitors_config_async() function.
> > > 
> > > Both are linked to a display channel.  The server/client messages go
> > > through the main channel though ...
> > 
> > Not really, it actually is like this:
> > 
> >        display channel
> > server --------------> client
> > 
> > 
> >         main channel
> > client --------------> server
> > 
> > So the monitors_configs go each on its own display channel to the
> > client, the client puts it all together and sends back an aggregated
> > list on the main channel.
> 
> Ok.
> 
> > > So what happens if a message from the client arrives?  Is that
> > > broadcasted as-is to all display channels?  The current qemu code
> > > (interface_client_monitors_config in spice-display.c, which is used with
> > > virtio-gpu) simply uses the head as index into the array, so it looks
> > > like spice-server doesn't do any filtering here (like only filling in
> > > the monitors which belong to the display channel).
> > 
> > Correct, the spice server doesn't do any filtering and sends the whole
> > monitors_config to all the interfaces...
> 
> Ok.  We probably should fix interface_client_monitors_config() to use
> the channel_id instead of qemu_console_get_head() then.

It's not that simple. This would break the QXL with multiple monitors
per channel case.

I think we should fix spice server to actually do the filtering and
only send monitors_config that belongs to the device to the QXL
interface. As Frediano mentioned, it looks more like a bug.

> > > spice_qxl_monitors_config_async() is never called with virtio-gpu,
> > > except when opengl is enabled.  In that case qemu simply sets
> > > QXLMonitorsConfig->count to 1 and fills in QXLMonitorsConfig->head[0]
> > > (see qemu_spice_gl_monitor_config in spice-display.c).
> > 
> > As a side note, I have no idea about opengl. I got a slight impression
> > from some earlier conversation that this is actually not used, but I
> > don't really know.
> 
> Not by default, but when virgl is enabled (-spice gl=on -vga virtio).
> 
> > My wild guess at this moment is, that if you don't call
> > spice_qxl_monitors_config_async() with virtio-gpu, meaning you don't
> > send any monitors config, a simple one containing a single monitor for
> > the surface is created somewhere along the way.
> 
> Probably.
> 
> > > Which would be
> > > ok in case spice-server merges the configs from all channels before
> > > sending it off to the client.  Not sure this actually happens ...
> > 
> > A bit differently, as I said, but the configs are merged on the client,
> > which should be an equivalent outcome.
> 
> Indeed.  So the qemu_spice_gl_monitor_config() function is correct then.

I don't follow you reasoning for this conclusion... Is it correct
because it sends a single monitor in the monitors_config? Why is this
function needed for the opengl case and not for regular virtio-gpu
case?

> > > > Interstingly enough, that seems to be the ID we want to have in the
> > > > device_display_id attribute.  I expect (still need to look that up, I'm
> > > > out of time right now) that for virtio-gpu the ID is a bit different,
> > > 
> > > Keep in mind that multiple display devices don't really work right now,
> > > and possibly we need to fix not only spice but qemu too.
> > 
> > What exactly do you mean by multiple devices not working?
> 
> qxl + vgpu (which is why we are discussing this).
> qxl + virtio-gpu will have simliar issues I think.

Ok, I see.

> > > I don't think we need the monitors_id in qemu then, qemu can simply use
> > > the channel_id (except for the legacy qxl case).
> > 
> > Ok. Given the fact that the monitor_ids actually come from the driver,
> > QEMU should actually know them already, right?
> 
> Yes.
> 
> > No need to pass them back anyway? (except for the virtio-gpu case,
> > which doesn't send monitors_config and so a single monitor_id = 0 is
> > deduced in spice server)
> 
> When virtio-gpu sends monitors_config monitor_id will be zero too,
> because we have one channel per monitor.

Right.

> Another story is linking display channels to device heads, i.e.
> virtio-gpu registers one display channel per head, each channel
> registers the same device path of course, and now you need to
> figure in the guest agent which xrandr output is which head.

This is actually the reason for the
spice_qxl_device_monitor_add_display_id(qxl, device_display_id)
function (using this opportunity to merge the other email thread
discussion into one).

So for example if you have 3 heads on a virtio-gpu device, and you call
it on qxl instance id (i.e. channel_id) = 2, the device_display_id
argument will be 2 (as it is the head ID) and in the current state
(which I agree with Jonathon is unintuitive and we should probably
change it) spice will associate the first call of this function with
monitor_id 0, so it will know that monitor_id 0 on this qxl instance
has the device_display_id 2.

> Simplest way would be to require display channels being registered in
> order, so the channel with the smallest channel_id is head 0, ...

I don't like this, you once again rely on implicit information derived
from the order of registration of the channels. We should make this
explicit, so that it doesn't cause trouble in the future...

Cheers,
Lukas

> cheers,
>   Gerd
> 
