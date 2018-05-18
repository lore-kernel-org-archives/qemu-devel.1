Received: from eggs.gnu.org ([2001:4830:134:3::10]:36578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fJhLF-0003A1-VM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fJhLF-0004tL-0x
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:30:49 -0400
Date: Fri, 18 May 2018 18:30:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180518180440-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi!
Right now, QEMU supports multiple machine types within
a given architecture. This was the case for many architectures
(like ARM) for a while, somewhat more recently this is the case
for x86 with I440FX and Q35 options.

Unfortunately this means that it's no longer possible
to more or less reliably boot a VM just given a disk image,
even if you select the correct QEMU binary:
you must supply the correct machine type.

Some guests go even further and require specific devices to be present.

Would it be reasonable to support storing this information in the qcow
image itself?  For example, I can see it following immediately the
backing file path within the image.

As Eduardo pointed out off-list, the format could be a set of key-value
pairs. Initially qemu-img could gain ability to retrieve and manipulate
these. Down the road we could teach qemu to use them automatically.
We could also thinkably warn the user, or drop the image from the boot
order.

Reasonable (IMO) things we could store in such a section:
- qemu architecture to use with the image
- machine type

more possibilities:
- required cpu flags
- expected frontend devices
- kernel flags for device tree based guests

Security considerations
- If there is a machine type specific security issue,
  this makes it easier to trick user to hitting it.
  Not sure how common this is.
- We most likely shouldn't get backend parameters from the image

Thoughts?

-- 
MST
