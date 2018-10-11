Received: from eggs.gnu.org ([2001:4830:134:3::10]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAa4W-0007Xq-Fh
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAa4T-0000IW-8J
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAa4S-0008LD-Vt
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:28:05 -0400
Date: Thu, 11 Oct 2018 14:27:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<1539189387.16655.63.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539189387.16655.63.camel@redhat.com>
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
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: Jonathon Jongsma <jjongsma@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

> > So, if I remember correctly, Gerd recommended returning this value from
> > the function. But I think it needs more explanation here. What exactly
> > is a "monitor_id" supposed to represent? It is not used in your follow-
> > up qemu patch so it's hard to tell.
> 
> It's supposed to be the actual monitor_id that we use in SPICE to
> identify the monitors. I've just spent quite some time looking up where
> the monitor_id actually comes from, and it's actually set all the way
> down in the driver (either xf86-video-qxl or the KMS driver in the
> kernel) and passed through the monitors_config functions to SPICE
> server.

How does all this monitors_config work currently in case multiple
display channels are present?

There is the QXLInterface->client_monitors_config() callback.

There is the spice_qxl_monitors_config_async() function.

Both are linked to a display channel.  The server/client messages go
through the main channel though ...

So what happens if a message from the client arrives?  Is that
broadcasted as-is to all display channels?  The current qemu code
(interface_client_monitors_config in spice-display.c, which is used with
virtio-gpu) simply uses the head as index into the array, so it looks
like spice-server doesn't do any filtering here (like only filling in
the monitors which belong to the display channel).

spice_qxl_monitors_config_async() is never called with virtio-gpu,
except when opengl is enabled.  In that case qemu simply sets
QXLMonitorsConfig->count to 1 and fills in QXLMonitorsConfig->head[0]
(see qemu_spice_gl_monitor_config in spice-display.c).  Which would be
ok in case spice-server merges the configs from all channels before
sending it off to the client.  Not sure this actually happens ...

> Interstingly enough, that seems to be the ID we want to have in the
> device_display_id attribute.  I expect (still need to look that up, I'm
> out of time right now) that for virtio-gpu the ID is a bit different,

Keep in mind that multiple display devices don't really work right now,
and possibly we need to fix not only spice but qemu too.

> And yeah, I didn't use the id in the QEMU patches, as I didn't know
> how, I expect Gerd to have some grand plans for it :)

IIRC the latest plan was to just keep things as is, plan with one
channel per monitor for all future things, and just not support
one-qxl-device-multihead in combination with multiple display channels.

Is that correct?

I don't think we need the monitors_id in qemu then, qemu can simply use
the channel_id (except for the legacy qxl case).

cheers,
  Gerd
