Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRiV6-0000eZ-Bz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRiV1-0001D1-ND
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRiV1-0001C4-EN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:45:15 -0500
Date: Thu, 12 Jan 2017 14:45:12 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112164512.GO3565@thinpad.lan.raisama.net>
References: <20170111173457.30455-1-lersek@redhat.com>
	<20170111173457.30455-3-lersek@redhat.com>
	<20170112131053.GA27893@thinpad.lan.raisama.net>
	<899dc23a-b6c0-e9c8-c31a-03e4cc8e7b7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <899dc23a-b6c0-e9c8-c31a-03e4cc8e7b7e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 wave 1 2/4] fw-cfg: turn
 FW_CFG_FILE_SLOTS into a device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "Gabriel L. Somlo" <somlo@cmu.edu>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Jan 12, 2017 at 05:30:42PM +0100, Laszlo Ersek wrote:
> On 01/12/17 14:10, Eduardo Habkost wrote:
> > On Wed, Jan 11, 2017 at 06:34:55PM +0100, Laszlo Ersek wrote:
> > [...]
> >>  static Property fw_cfg_io_properties[] = {
> >>      DEFINE_PROP_UINT32("iobase", FWCfgIoState, iobase, -1),
> >>      DEFINE_PROP_UINT32("dma_iobase", FWCfgIoState, dma_iobase, -1),
> >>      DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
> >>                       true),
> >> +    DEFINE_PROP_UINT16("file_slots", FWCfgIoState, parent_obj.file_slots,
> >> +                       FW_CFG_FILE_SLOTS_MIN),
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >> @@ -1027,6 +1066,13 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
> > 
> > I'm not sure what is more important here: following the QOM
> > property name convention using "-" instead of "_", or being
> > consistent with the other existing properties.
> 
> Right, when working with the compat settings, I saw both schemes. I
> couldn't decide. I figured I'd stick with the underscore seen with
> "dma_enabled".
> 
> > 
> > In either case, we could add a "x-" prefix to indicate it is not
> > supposed to be configured directly by the user.
> 
> I thought "x-" meant "experimental"; i.e., the property could be changed
> or could go away at any moment. That's a slightly different meaning than
> "not meant for users".

That's true: it means the property could be changed or go away.
And that's the only mechanism we have to indicate that users
shouldn't rely on the property being always available on the
command-line in future versions.

(Yes, this should be better documented. We found out very
recently that people have very different expectations about what
QOM properties should be used for, so we are still figuring out
what should be the best practices and didn't write everything
down yet.)

> 
> BTW I think the same (== not meant for the user) applies to a number of
> other properties (dma_enabled is one of them, but other devices have
> this kind too); do we consistently call them x-*?

We don't, but that's because we haven't been paying attention to
that until recently. Renaming existing properties is possible,
but risks breaking existing software and scripts.

> 
> > 
> > [...]
> >> @@ -1063,6 +1109,8 @@ static Property fw_cfg_mem_properties[] = {
> >>      DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
> >>      DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
> >>                       true),
> >> +    DEFINE_PROP_UINT16("file_slots", FWCfgMemState, parent_obj.file_slots,
> >> +                       FW_CFG_FILE_SLOTS_MIN),
> > 
> > It looks like you can add the property to the TYPE_FW_CFG parent
> > class instead of duplicating it on the subclasses. The existing
> > "dma_enabled" property could be moved there as well.
> 
> I would prefer if someone could pick up that task, separately.
> 
> The idea crossed my mind when I was working on the common base class,
> originally, wrt. dma_enabled. I vaguely remember that there was some
> problem with moving up the property. Ultimately the reviewers didn't
> expect me, or suggest, to move it up, hence the current status.
> 
> I think it's out of scope for this series. If you (or someone else) can
> do it, I agree it would be an improvement, but I'd rather learn the
> method from someone else's patch than experiment with it myself.

Agreed.

> 
> 
> If there's a consensus on the x- prefix and/or the underscore/hyphen
> question, I'm happy to send a v6 with those changes.

I don't mind about the underscore, but IMO the "x-" prefix is
important.

-- 
Eduardo
