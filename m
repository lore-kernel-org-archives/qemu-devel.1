Received: from eggs.gnu.org ([2001:4830:134:3::10]:41969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqE4x-0006qT-8P
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqE4t-0006t2-A1
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:24:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqE4t-0006sS-59
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:24:07 -0500
Date: Mon, 26 Feb 2018 09:23:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180226082348.siwgbzomshdpvnmx@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
	<20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
	<CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
	<20180222095917.29eda1d9@w520.home>
	<20180223085322.vhc4awb5aprohe2s@sirius.home.kraxel.org>
	<20180223085841.0f8362ed@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223085841.0f8362ed@w520.home>
Subject: Re: [Qemu-devel] [PATCH v4 4/7] qdev: add hotpluggable to
 DeviceState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laine Stump <laine@redhat.com>, Erik Skultety <eskultet@redhat.com>

  Hi,

> > The connection between QemuConsole and User Interface (i.e. gtk, spice,
> > ...) is a bit more flexible.  But also not really designed for hotplug
> > as QemuConsole is not hotpluggable in the first place ...
> > 
> > We could drop the display property and use two devices instead.
> > 
> >   new vfio-pci would behave like display=off with this series.
> >   added vfio-pci-display has display=on behavior.
> >   display=auto is not possible.
> 
> I expect libvirt and above would balk at creating a separate QEMU
> device for this purpose, easy for QEMU, hard for anything that manages
> QEMU.

Now as you've mentioned libvirt I remember we had the same discussion
before, with usb host adapters.  The uhci and ehci controllers have a
simliar issue:  If they are configured as companion setup (ehci for usb2
and uhci for usb1) they can't be hotplugged, as standalone controller
hotplugging works fine.

We ended up with splitting the controllers into two groups:  The ones
which can be used in a companion setup (basically all ich9-* devices)
which are not hotpluggable.   And the other ones which don't support
companion setups but can be hotplugged.  Commits:

   ec56214f6f usb: tag standalone ehci as hotpluggable
   638ca939d8 usb: tag standalone uhci as hotpluggable

The argument from the libvirt side was that it is actually easier for
them to handle if hotplugging is a fixed property of a device and
doesn't change magically depending on device configuration.  First
because they can query qemu then whenever a given device can be
hotplugged or not, and second because it'll work for both plug-in and
plug-out.

So this patch isn't going to fly, and unless someone can come up with a
better idea I'll go use the two-devices approach.

cheers,
  Gerd
