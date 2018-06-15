Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTjY3-0005ZB-BH
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTjY2-0006PP-Kn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:53:31 -0400
Date: Fri, 15 Jun 2018 09:53:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180615075314.fc3jattcaizpf6yd@sirius.home.kraxel.org>
References: <20180613084149.14523-1-kraxel@redhat.com>
	<20180613084149.14523-4-kraxel@redhat.com>
	<20180613135047.5c1ce227@w520.home>
	<20180613223625.lf6xkzgipzkfslit@sirius.home.kraxel.org>
	<20180614094856.GD2220@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614094856.GD2220@beluga.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, libvir-list@redhat.com, Laine Stump <laine@redhat.com>

> > Well, it's simliar to qxl vs. qxl-vga.  It's not qxl,vga={on,off} and
> > libvirt has no problems to deal with that ...
> >
> > Another more technical reason is (again) hotplug.  ramfb needs an fw_cfg
> > entry for configuration, and fw_cfg entries can't be hotplugged.  So
> > hotplugging vfio-pci with ramfb=on isn't going to fly.  So we need a
> > separate device with hotplug turned off.
> 
> Well if that's not supposed to work ever, libvirt's hotplug code could format
> the following FWIW:
> "-device vfio-pci [opts],ramfb=off"
> 
> As such, new device wouldn't be that of an issue for libvirt if vfio-pci and
> vfio-pci-ramfb are back to back compatible with all the device options that are
> available for vfio-pci (I mean in terms of using an mdev). Because in that
> case, what libvirt could do is to look whether we're supposed to turn on the
> display, if so, then we need support for this in capabilities to query and then
> we could prefer this new device over the "legacy" vfio-pci one. However, if we
> expect a case where QEMU would succeed to start with an mdev mapped to this
> new ramfb device but not with vfio-pci, then that's an issue.

vfio-pci and vfio-pci-ramfb are identical, except for the later having a
boot display (with display=on), and vfio-pci-ramfb not being
hotplugable.  So, yes, all pcu/mdev devices should work with both
vfio-pci variants.

> But I'm still curious about the ramfb=off possibility I asked above
> for hotplug nonetheless.

Well, the problem is introspection.  qemu can report via qmp whenever a
specific device supports hotplug.  A device which can both be
hot-pluggable or not hot-pluggable depending on some condition is a
problem here ...

cheers,
  Gerd
