Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAalU-00071T-4A
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAalO-0002N1-3Z
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:12:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gAalM-0002LP-BI
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:12:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so8896663wmg.0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 06:12:24 -0700 (PDT)
Message-ID: <1539263541.16655.110.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Thu, 11 Oct 2018 15:12:21 +0200
In-Reply-To: <20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<1539189387.16655.63.camel@redhat.com>
	<20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
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

On Thu, 2018-10-11 at 14:27 +0200, Gerd Hoffmann wrote:
> > > So, if I remember correctly, Gerd recommended returning this value from
> > > the function. But I think it needs more explanation here. What exactly
> > > is a "monitor_id" supposed to represent? It is not used in your follow-
> > > up qemu patch so it's hard to tell.
> > 
> > It's supposed to be the actual monitor_id that we use in SPICE to
> > identify the monitors. I've just spent quite some time looking up where
> > the monitor_id actually comes from, and it's actually set all the way
> > down in the driver (either xf86-video-qxl or the KMS driver in the
> > kernel) and passed through the monitors_config functions to SPICE
> > server.
> 
> How does all this monitors_config work currently in case multiple
> display channels are present?
> 
> There is the QXLInterface->client_monitors_config() callback.
> 
> There is the spice_qxl_monitors_config_async() function.
> 
> Both are linked to a display channel.  The server/client messages go
> through the main channel though ...

Not really, it actually is like this:

       display channel
server --------------> client


        main channel
client --------------> server

So the monitors_configs go each on its own display channel to the
client, the client puts it all together and sends back an aggregated
list on the main channel.

> So what happens if a message from the client arrives?  Is that
> broadcasted as-is to all display channels?  The current qemu code
> (interface_client_monitors_config in spice-display.c, which is used with
> virtio-gpu) simply uses the head as index into the array, so it looks
> like spice-server doesn't do any filtering here (like only filling in
> the monitors which belong to the display channel).

Correct, the spice server doesn't do any filtering and sends the whole
monitors_config to all the interfaces...

> spice_qxl_monitors_config_async() is never called with virtio-gpu,
> except when opengl is enabled.  In that case qemu simply sets
> QXLMonitorsConfig->count to 1 and fills in QXLMonitorsConfig->head[0]
> (see qemu_spice_gl_monitor_config in spice-display.c).

As a side note, I have no idea about opengl. I got a slight impression
from some earlier conversation that this is actually not used, but I
don't really know.

My wild guess at this moment is, that if you don't call
spice_qxl_monitors_config_async() with virtio-gpu, meaning you don't
send any monitors config, a simple one containing a single monitor for
the surface is created somewhere along the way.

> Which would be
> ok in case spice-server merges the configs from all channels before
> sending it off to the client.  Not sure this actually happens ...

A bit differently, as I said, but the configs are merged on the client,
which should be an equivalent outcome.

> > Interstingly enough, that seems to be the ID we want to have in the
> > device_display_id attribute.  I expect (still need to look that up, I'm
> > out of time right now) that for virtio-gpu the ID is a bit different,
> 
> Keep in mind that multiple display devices don't really work right now,
> and possibly we need to fix not only spice but qemu too.

What exactly do you mean by multiple devices not working?

> > And yeah, I didn't use the id in the QEMU patches, as I didn't know
> > how, I expect Gerd to have some grand plans for it :)
> 
> IIRC the latest plan was to just keep things as is, plan with one
> channel per monitor for all future things, and just not support
> one-qxl-device-multihead in combination with multiple display channels.
> 
> Is that correct?

Correct.

> I don't think we need the monitors_id in qemu then, qemu can simply use
> the channel_id (except for the legacy qxl case).

Ok. Given the fact that the monitor_ids actually come from the driver,
QEMU should actually know them already, right? No need to pass them
back anyway? (except for the virtio-gpu case, which doesn't send
monitors_config and so a single monitor_id = 0 is deduced in spice
server)

Cheers,
Lukas

> cheers,
>   Gerd
> 
