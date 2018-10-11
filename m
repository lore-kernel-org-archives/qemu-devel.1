Received: from eggs.gnu.org ([2001:4830:134:3::10]:47006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAaVF-0002yD-Vg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAaVC-0005OE-PC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:55:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gAaVC-0005M8-Hi
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:55:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so9557124wru.8
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:55:42 -0700 (PDT)
Message-ID: <1539262539.16655.99.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Thu, 11 Oct 2018 14:55:39 +0200
In-Reply-To: <20181010103704.jqgfp3kiaiqu4hzt@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<20181010103704.jqgfp3kiaiqu4hzt@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>, Jonathon Jongsma <jjongsma@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

Hi Gerd,

On Wed, 2018-10-10 at 12:37 +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > + * Sets the hardware (e.g. PCI) path of the graphics device
> > > represented by this QXL interface instance.
> > 
> > So, this comment suggests that the caller might be able to provide a
> > path that is not a PCI path. But the implementation below (mostly the
> > debug output, I suppose...) assumes a PCI path. Do we need to support
> > non-PCI paths?
> 
> Certainly not for the initial revision, maybe never.
> 
> But thanks to the "pci/" prefix we should be able to add support for
> other paths later in case it turns out we need it.
> 
> > > + * Returns: The actual SPICE server monitor_id associated with the
> > > display
> > 
> > So, if I remember correctly, Gerd recommended returning this value from
> > the function. But I think it needs more explanation here. What exactly
> > is a "monitor_id" supposed to represent? It is not used in your follow-
> > up qemu patch so it's hard to tell.
> 
> IIRC the plan was to ditch the global monior_id idea and use the
> (channel_id, display_id) tuple everywhere ...

Not sure what exactly you mean here by "global monitor_id". Not sure
about "use the (channel_id, display_id)" either, it doesn't seem quite
correct.

The plan was (and still is) to limit the use cases to the following
two:

* Legacy QXL on linux with multiple monitors per display channel, but
only this single display channel. Multiple display channels are not
supported in this case, so no streaming etc.

* Limit the number of monitors per display channel to one for all other
cases.

With these limitations, the display_id = channel_id + monitor_id
formula that is used on the client remains unique. With one more
condition, that I think I should add, and that is that monitor_id is
always 0 for the multiple display channel case. It seems it may come up
that the monitor_id could be non-zero, e.g. for the virtio-gpu case...

So the IDs used are:

monitors_config server -> client:
(channel_id, monitor_id)

monitors_config client -> server and possibly server -> vd_agent:
display_id

I hope it's clear like this :)

Cheers,
Lukas

> cheers,
>   Gerd
> 
