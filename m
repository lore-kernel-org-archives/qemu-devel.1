Received: from eggs.gnu.org ([2001:4830:134:3::10]:46037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ep96x-0006a1-B3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ep96s-0006sq-GR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:53:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ep96s-0006se-B4
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:53:42 -0500
Date: Fri, 23 Feb 2018 09:53:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180223085322.vhc4awb5aprohe2s@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
	<20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
	<CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
	<20180222095917.29eda1d9@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222095917.29eda1d9@w520.home>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> > What type of device is only sometimes hotpluggable ?
> > The commit message says "display devices" and "consoles",
> > but I would expect those to both be types of device which
> > have a class which is never hotpluggable, so you can mark
> > them non-hotpluggable with the existing class flag rather
> > than needing a per-instance flag.
> 
> With this series, a vfio-pci device optionally supports a display.  The
> vfio-pci device is hotpluggable, but QEMU display support is not.  So
> the solution here is to make the vfio-pci device non-hotpluggable only
> when it supports and enables a display.
> 
> Gerd, is there another solution that the display object is instantiated
> separately from the vfio-pci object and the display support in the
> vfio-pci device references the display object via an id.

Well, not really.  At least not without putting much of qemu display
support upside down.  The qemu display (aka QemuConsole) is created and
managed by the display devices, they can't be created independant from
a device ...

The connection between QemuConsole and User Interface (i.e. gtk, spice,
...) is a bit more flexible.  But also not really designed for hotplug
as QemuConsole is not hotpluggable in the first place ...

We could drop the display property and use two devices instead.

  new vfio-pci would behave like display=off with this series.
  added vfio-pci-display has display=on behavior.
  display=auto is not possible.

cheers,
  Gerd
