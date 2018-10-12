Received: from eggs.gnu.org ([2001:4830:134:3::10]:44292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAu9X-0005i6-BC
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAu9S-0002Kd-2j
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:54:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gAu9R-0002JA-QW
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:54:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so11635895wmg.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 02:54:33 -0700 (PDT)
Message-ID: <1539338070.16655.161.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Fri, 12 Oct 2018 11:54:30 +0200
In-Reply-To: <20181012092700.np256rvz6octswia@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<1539189387.16655.63.camel@redhat.com>
	<20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
	<1539263541.16655.110.camel@redhat.com>
	<20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
	<1539268208.16655.144.camel@redhat.com>
	<20181011150944.5qfaflgkcekdlz3o@sirius.home.kraxel.org>
	<1539272266.16655.154.camel@redhat.com>
	<20181012092700.np256rvz6octswia@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Fri, 2018-10-12 at 11:27 +0200, Gerd Hoffmann wrote:
> On Thu, Oct 11, 2018 at 05:37:46PM +0200, Lukáš Hrázký wrote:
> > On Thu, 2018-10-11 at 17:09 +0200, Gerd Hoffmann wrote:
> > > > > Ok.  We probably should fix interface_client_monitors_config() to use
> > > > > the channel_id instead of qemu_console_get_head() then.
> > > > 
> > > > It's not that simple. This would break the QXL with multiple monitors
> > > > per channel case.
> > > 
> > > It is that simple.
> > > 
> > > qxl doesn't use that code path and has its own version of the callback
> > > (in qxl.c).  Fixing it there is a bit more tricky.
> > 
> > Ok.. and what's actually the problem using qemu_console_get_head()? It
> > just doesn't feel right to me using channel_id as an index into this
> > array. It is not the right index strictly speaking.
> 
> Assume you have one qxl and one virtio-gpu device (one head each), for
> example:
> 
>    00:02.0   qxl          channel 0
>    00:03.0   virtio-gpu   channel 1
> 
> So the client will assign display 0 to qxl and display 1 to virtio-gpu.
> In interface_client_monitors_config() we have to pick the correct array
> entry.
> 
> When using the channel_id it works correctly.
> 
> When using qemu_console_get_head() it doesn't work correctly, it would
> use the qxl card's data.  It would work if spice-server would filter the
> list to only include the entries for the given display channel before
> calling the ->client_monitors_config() callback.  But it doesn't, we get
> the complete set.
> 
> > > > I think we should fix spice server to actually do the filtering and
> > > > only send monitors_config that belongs to the device to the QXL
> > > > interface. As Frediano mentioned, it looks more like a bug.
> > > 
> > > Only problem is changing the callback semantics changes the library api.
> > > We could add a second version of the callback which gets called with a
> > > filtered list (if present).  Not sure this is worth the effort though.
> > 
> > That's right. But if we don't actually break any currently supported
> > use cases, it might be fine? The only thing we would be breaking is
> > the virtio-gpu, I think?  Is that already something we don't want to
> > break?
> 
> It would break any multihead configuration which uses multiple display
> channels.  Yes, virtio-gpu is one case.  Breaking that would not be very
> nice, but maybe acceptable.  The other case is multiple qxl devices
> (i.e.  windows guest style multihead).  Breaking that is out of
> question.

The windows QXL driver doesn't support the monitors_config callback, at
least that's what Frediano said here:

https://lists.freedesktop.org/archives/spice-devel/2018-October/045965.html

So I don't think this is a problem and if breaking virtio-gpu would be
acceptable, we should probably consider fixing the interface...

Cheers,
Lukas

> cheers,
>   Gerd
> 
