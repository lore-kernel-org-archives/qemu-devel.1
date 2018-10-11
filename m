Received: from eggs.gnu.org ([2001:4830:134:3::10]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAd2A-00011m-Um
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAd25-0004Zk-Qs
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:37:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gAd25-0004Z5-JR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:37:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so10229470wrt.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 08:37:49 -0700 (PDT)
Message-ID: <1539272266.16655.154.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Thu, 11 Oct 2018 17:37:46 +0200
In-Reply-To: <20181011150944.5qfaflgkcekdlz3o@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<1539189387.16655.63.camel@redhat.com>
	<20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
	<1539263541.16655.110.camel@redhat.com>
	<20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
	<1539268208.16655.144.camel@redhat.com>
	<20181011150944.5qfaflgkcekdlz3o@sirius.home.kraxel.org>
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

On Thu, 2018-10-11 at 17:09 +0200, Gerd Hoffmann wrote:
> > > Ok.  We probably should fix interface_client_monitors_config() to use
> > > the channel_id instead of qemu_console_get_head() then.
> > 
> > It's not that simple. This would break the QXL with multiple monitors
> > per channel case.
> 
> It is that simple.
> 
> qxl doesn't use that code path and has its own version of the callback
> (in qxl.c).  Fixing it there is a bit more tricky.

Ok.. and what's actually the problem using qemu_console_get_head()? It
just doesn't feel right to me using channel_id as an index into this
array. It is not the right index strictly speaking.

> > I think we should fix spice server to actually do the filtering and
> > only send monitors_config that belongs to the device to the QXL
> > interface. As Frediano mentioned, it looks more like a bug.
> 
> Only problem is changing the callback semantics changes the library api.
> We could add a second version of the callback which gets called with a
> filtered list (if present).  Not sure this is worth the effort though.

That's right. But if we don't actually break any currently supported
use cases, it might be fine? The only thing we would be breaking is the
virtio-gpu, I think? Is that already something we don't want to break?

> > > > A bit differently, as I said, but the configs are merged on the client,
> > > > which should be an equivalent outcome.
> > > 
> > > Indeed.  So the qemu_spice_gl_monitor_config() function is correct then.
> > 
> > I don't follow you reasoning for this conclusion... Is it correct
> > because it sends a single monitor in the monitors_config?
> 
> Yes (again, qxl doesn't run this code path so it'll only see the
> one-monitor-per-channel cases).
> 
> > Why is this
> > function needed for the opengl case and not for regular virtio-gpu
> > case?
> 
> Not fully sure why opengl needs this.  Maybe because the texture can be
> larger than the actual scanout (for padding reasons) so we need to
> communicate the scanout rectangle.
> 
> > > Another story is linking display channels to device heads, i.e.
> > > virtio-gpu registers one display channel per head, each channel
> > > registers the same device path of course, and now you need to
> > > figure in the guest agent which xrandr output is which head.
> > 
> > This is actually the reason for the
> > spice_qxl_device_monitor_add_display_id(qxl, device_display_id)
> > function (using this opportunity to merge the other email thread
> > discussion into one).
> 
> Ah, ok.  We should *not* call this thing display_id then, that'll be
> confusing.  Or at very least rename the function to something like ...
> 
> spice_qxl_monitor_add_device_display_id()
>                       ^^^^^^^^^^^^^^^^^   don't split this
> 
> ... to make more clear this is something else than the display_id.

Ok.

> > > Simplest way would be to require display channels being registered in
> > > order, so the channel with the smallest channel_id is head 0, ...
> > 
> > I don't like this, you once again rely on implicit information derived
> > from the order of registration of the channels. We should make this
> > explicit, so that it doesn't cause trouble in the future...
> 
> Fine with me too.
> 
> I'd suggest to split the patches, one for the path and one for the
> device_display_id thing (or whatever else we call this to make it less
> likely being confused with display_id, even though I don't have a good
> suggestion offhand).

Sure, no problem.

> cheers,
>   Gerd
> 
