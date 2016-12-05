Received: from eggs.gnu.org ([2001:4830:134:3::10]:60642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cDxAI-0007ma-VC
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cDxAF-0000KT-OB
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:34:58 -0500
Date: Mon, 5 Dec 2016 17:34:48 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161205173448.GS2498@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148095126363.31351.4484514300033863622.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Dec 05, 2016 at 04:21:22PM +0100, Greg Kurz wrote:
> The current code recursively applies global properties from child up to
> parent. So, if you have:
> 
> -global virtio-pci.disable-modern=on
> -global virtio-blk-pci.disable-modern=off
> 
> Then the default value of disable-modern for a virtio-blk-pci device is on,
> which looks wrong from an OOP perspective.
> 
> This patch reverses the logic, so that a child property always prevail.
> 
> This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220d8a
> hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
> HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
> would silently override global properties passed on the command line for
> virtio subtypes.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
> tag to pass global properties to QEMU. This patch ensures that XML files
> used with older machine types remain valid with newer versions of QEMU.

FYI, we explicitly do *not* guarantee any kind of stability/compatibility
if you use  qemu:commandline. Users should expect it to break when they
upgrade QEMU and/or libvirt.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
