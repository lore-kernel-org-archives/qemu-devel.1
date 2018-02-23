Received: from eggs.gnu.org ([2001:4830:134:3::10]:51129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1epFkL-0006zc-Jj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1epFkG-0003xp-KY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:58:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1epFkG-0003wu-De
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:58:48 -0500
Date: Fri, 23 Feb 2018 08:58:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180223085841.0f8362ed@w520.home>
In-Reply-To: <20180223085322.vhc4awb5aprohe2s@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
	<20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
	<CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
	<20180222095917.29eda1d9@w520.home>
	<20180223085322.vhc4awb5aprohe2s@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laine Stump <laine@redhat.com>, Erik Skultety <eskultet@redhat.com>

On Fri, 23 Feb 2018 09:53:22 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > > What type of device is only sometimes hotpluggable ?
> > > The commit message says "display devices" and "consoles",
> > > but I would expect those to both be types of device which
> > > have a class which is never hotpluggable, so you can mark
> > > them non-hotpluggable with the existing class flag rather
> > > than needing a per-instance flag.  
> > 
> > With this series, a vfio-pci device optionally supports a display.  The
> > vfio-pci device is hotpluggable, but QEMU display support is not.  So
> > the solution here is to make the vfio-pci device non-hotpluggable only
> > when it supports and enables a display.
> > 
> > Gerd, is there another solution that the display object is instantiated
> > separately from the vfio-pci object and the display support in the
> > vfio-pci device references the display object via an id.  
> 
> Well, not really.  At least not without putting much of qemu display
> support upside down.  The qemu display (aka QemuConsole) is created and
> managed by the display devices, they can't be created independant from
> a device ...
> 
> The connection between QemuConsole and User Interface (i.e. gtk, spice,
> ...) is a bit more flexible.  But also not really designed for hotplug
> as QemuConsole is not hotpluggable in the first place ...
> 
> We could drop the display property and use two devices instead.
> 
>   new vfio-pci would behave like display=off with this series.
>   added vfio-pci-display has display=on behavior.
>   display=auto is not possible.

I expect libvirt and above would balk at creating a separate QEMU
device for this purpose, easy for QEMU, hard for anything that manages
QEMU.  Thanks,

Alex
