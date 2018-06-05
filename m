Received: from eggs.gnu.org ([2001:4830:134:3::10]:52679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQBpW-0006Go-8I
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQBpT-0004eh-53
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:16:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fQBpS-0004eY-Vz
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:16:51 -0400
Date: Tue, 5 Jun 2018 15:16:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180605131649.fu3cellm7vwaf4ao@sirius.home.kraxel.org>
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
	<1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
	<20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
	<4b65af58-8451-a365-6c81-52c49e42b6ff@redhat.com>
	<20180605110647.7ctaj7fiy6x4ewdw@sirius.home.kraxel.org>
	<a3fe57cf-1569-834d-5528-d85847b29f9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3fe57cf-1569-834d-5528-d85847b29f9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

On Tue, Jun 05, 2018 at 02:07:27PM +0200, Laszlo Ersek wrote:
> On 06/05/18 13:06, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >>>> I could imagine an OvmfPkg-specific PCI capability that said, "all PCI
> >>>> drivers in OvmfPkg that could otherwise drive this device, ignore it --
> >>>> another (platform) driver in OvmfPkg will pick it up instead".
> >>>
> >>> pci capability for ramfb could be useful (also for linux).  I'll keep it
> >>> in mind for now.
> >>
> >> Please do. :)
> > 
> > Hmm, well.  Virtio 1.0 uses vendor specific capabilities already to
> > define the regions, and they don't have a fixed field saying "this is
> > for virtio".  So adding another vendor specific capability for something
> > else on the same device is a bit problematic ...
> 
> Can we invent a non-PCI method, e.g. fw_cfg, that tells QemuVideoDxe and
> Virtio10Dxe not to bind some PCI S/B/D/Fs? Something like:

Well, from edk2 point of view Virtio10Dxe is the only problematic case
because there is a is a native driver.  For cirrus/stdvga a version with
ramfb is rather pointless.  A qxl-ramfb device might make sense, but
QemuVideoDxe would ignore such a device like it ignores qxl today as it
can only handle the vga mode of qxl-vga devices.

Also I'd prefer to provide informations (device foo has ramfb at <addr>)
not instructions (please ignore device foo).

Maybe we should for now just scratch the idea of an virtio-ramfb device.
Linux doesn't need it, and windows wouldn't use the virtio part of it so
a standalone ramfb device would work equally well.

cheers,
  Gerd
