Received: from eggs.gnu.org ([2001:4830:134:3::10]:48214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eK0jy-0000dm-7D
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eK0jt-0007h5-7Z
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:41:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eK0js-0007gt-VG
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:41:17 -0500
Date: Wed, 29 Nov 2017 09:41:09 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171129114109.GZ3037@localhost.localdomain>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-7-david@gibson.dropbear.id.au>
	<9b0e9672-e0d7-53c3-9a42-ab3f6011b59b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b0e9672-e0d7-53c3-9a42-ab3f6011b59b@redhat.com>
Subject: Re: [Qemu-devel] [for-2.12 6/7] pci: Eliminate redundant
 PCIDevice::bus pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On Wed, Nov 29, 2017 at 12:54:04PM +0200, Marcel Apfelbaum wrote:
> On 29/11/2017 10:46, David Gibson wrote:
> > The bus pointer in PCIDevice is basically redundant with QOM information.
> > It's always initialized to the qdev_get_parent_bus(), the only difference
> > is the type.
> > 
> > Therefore this patch eliminates the field, instead creating a pci_get_bus()
> > helper to do the type mangling to derive it conveniently from the QOM
> > Device object underneath.
> > 
> 
> 
> Hi David,
> 
> I personally don't see why the caching of the bus bothers you.
> It makes the code a little easier to read, but indeed is a duplication
> of data; let's see what Michael has to say, is a matter of
> taste I suppose.

I'm all for removing duplication of data because it makes the
code less fragile.  We don't even take care of clearing
pci_dev->bus when the device is removed from the bus, so there's
a window between unplugging a device and actually freeing the
object where pci_dev->bus can become a dangling pointer.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
