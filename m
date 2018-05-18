Received: from eggs.gnu.org ([2001:4830:134:3::10]:57893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJiZ7-0007oY-G1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJiZ6-0001iG-CE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:49:13 -0400
Date: Fri, 18 May 2018 13:49:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180518164901.GY25013@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518180440-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, May 18, 2018 at 06:30:38PM +0300, Michael S. Tsirkin wrote:
> Hi!
> Right now, QEMU supports multiple machine types within
> a given architecture. This was the case for many architectures
> (like ARM) for a while, somewhat more recently this is the case
> for x86 with I440FX and Q35 options.
> 
> Unfortunately this means that it's no longer possible
> to more or less reliably boot a VM just given a disk image,
> even if you select the correct QEMU binary:
> you must supply the correct machine type.
> 
> Some guests go even further and require specific devices to be present.
> 
> Would it be reasonable to support storing this information in the qcow
> image itself?  For example, I can see it following immediately the
> backing file path within the image.
> 
> As Eduardo pointed out off-list, the format could be a set of key-value
> pairs. Initially qemu-img could gain ability to retrieve and manipulate
> these. Down the road we could teach qemu to use them automatically.
> We could also thinkably warn the user, or drop the image from the boot
> order.

Some additional context:

Currently OpenStack and other management stacks support importing
"guest images", that are often just qcow2 disk images.  Today all
management stacks suppose x86 guest images all work using
pc-i440fx, but this is likely to change with newer guest OS
versions.

Right now it's very convenient for users to simply create disk
images using whatever VM management tools they have (e.g.
virt-image, virt-install, virsh) to install and configure a
guest, and all they need to do is to upload the resulting disk
image.

If information about the machine-type and disk type used to
create the VM is saved in the disk image, OpenStack and other
management stacks can use this information as hints to choose the
right machine-type for a given guest image.  This would also help
the system detect mistakes like using an image for the wrong
architecture.

I don't think QEMU needs to use this information automatically,
necessarily.  I think the first step is to simply make QEMU save
this information in the disk image, and making qemu-img able to
read and write this information.

> 
> Reasonable (IMO) things we could store in such a section:
> - qemu architecture to use with the image
> - machine type

Maybe just the machine-type family would be enough?

> 
> more possibilities:
> - required cpu flags
> - expected frontend devices
> - kernel flags for device tree based guests

All these might be useful in some cases.  I think it's important
to highlight that these would be just hints for systems importing
the disk image, and not mandatory.

> 
> Security considerations
> - If there is a machine type specific security issue,
>   this makes it easier to trick user to hitting it.
>   Not sure how common this is.

Yeah, we need to keep this in mind for every hint we add to this
system.

I would prefer a system with a very limited set of
possible input values, to avoid transforming this into a new
attack vector.

For example, I think the hint needs to specify: only the
machine-type family instead of the full machine-type version;
only expected NIC model instead of NIC model + mac address + PCI
address; only the CPU architecture instead of CPU model name +
flags.

(But "guest kernel flags" seems acceptable, because it's parsed
only by guest code.)

If any management stack requires a more detailed VM description,
they won't be covered by this system, and they can't expect qcow2
disk images to carry all the information they need.


> - We most likely shouldn't get backend parameters from the image

Agreed.

-- 
Eduardo
