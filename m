Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eAdVP-0004bv-9Q
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eAdVM-0004g3-6U
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eAdVL-0004f0-UY
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:03:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C73C6A7C5
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 15:03:30 +0000 (UTC)
Date: Fri, 3 Nov 2017 17:03:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171103170239-mutt-send-email-mst@kernel.org>
References: <20171102133115.19195-1-lprosek@redhat.com>
	<20171102163348-mutt-send-email-mst@kernel.org>
	<CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Don't force Subsystem Vendor
 ID = Vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Vadim Rozenfeld <vrozenfe@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>

On Fri, Nov 03, 2017 at 07:25:16AM +0100, Ladi Prosek wrote:
> On Thu, Nov 2, 2017 at 3:52 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Nov 02, 2017 at 02:31:15PM +0100, Ladi Prosek wrote:
> >> The statement being removed doesn't change anything as virtio PCI devices already
> >> have Subsystem Vendor ID set to pci_default_sub_vendor_id (0x1af4), same as Vendor
> >> ID. And the Virtio spec does not require the two to be equal, either:
> >>
> >>   "The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect the PCI
> >>   Vendor and Device ID of the environment (for informational purposes by the driver)."
> >>
> >> Background:
> >>
> >> Following the recent virtio-win licensing change, several vendors are planning to
> >> ship their own certified version of Windows guest Virtio drivers, potentially taking
> >> advantage of Windows Update as a distribution channel. It is therefore critical that
> >> each vendor uses their own PCI Subsystem Vendor ID for Virtio devices to prevent
> >> drivers from other vendors binding to it.
> >>
> >> This would be trivially done by adding:
> >>
> >>   k->subsystem_vendor_id = ...
> >>
> >> to virtio_pci_class_init(). Except for the problematic statement deleted by this
> >> patch, which reverts the Subsystem Vendor ID back to 0x1af4 for legacy devices for
> >> no good reason.
> >>
> >> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> >
> > I wonder whether it's a problem that legacy devices ignore
> > the subsystem ID (that's part of spec).
> 
> I don't understand this comment. I don't see anything in the spec
> related to ignoring the subsystem ID.

The code just below your patch overwrites the subsystem ID even if
supplied by user, and the reason is that legacy drivers
relied on this.


> >> ---
> >>  hw/virtio/virtio-pci.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> index e92837c42b..cb74aa3d85 100644
> >> --- a/hw/virtio/virtio-pci.c
> >> +++ b/hw/virtio/virtio-pci.c
> >> @@ -1589,8 +1589,6 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
> >>              return ;
> >>          }
> >>          /* legacy and transitional */
> >> -        pci_set_word(config + PCI_SUBSYSTEM_VENDOR_ID,
> >> -                     pci_get_word(config + PCI_VENDOR_ID));
> >
> >
> > This happens to work because the default subsystem vendor id
> > within qemu is 0x1af4. Let's add a comment to that end.
> 
> Sure, will do.
> 
> >>          pci_set_word(config + PCI_SUBSYSTEM_ID, virtio_bus_get_vdev_id(bus));
> >>      } else {
> >>          /* pure virtio-1.0 */
> >> --
> >> 2.13.5
