Received: from eggs.gnu.org ([209.51.188.92]:50000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1ghP7C-0006ZY-MQ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1ghP7A-0005dT-AX
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:26:34 -0500
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:12078)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1ghP78-0005Zo-17
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:26:30 -0500
Date: Thu, 10 Jan 2019 12:26:17 +1100
From: Dave Chinner <david@fromorbit.com>
Message-ID: <20190110012617.GA4205@dastard>
References: <20190109144736.17452-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109144736.17452-1-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] kvm "virtio pmem" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, david@redhat.com, jmoyer@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, rjw@rjwysocki.net

On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
>  This patch series has implementation for "virtio pmem". 
>  "virtio pmem" is fake persistent memory(nvdimm) in guest 
>  which allows to bypass the guest page cache. This also
>  implements a VIRTIO based asynchronous flush mechanism.  

Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
like a good idea, but.....

This means the guest VM can now run timing attacks to observe host
side page cache residency, and depending on the implementation I'm
guessing that the guest will be able to control host side page
cache eviction, too (e.g. via discard or hole punch operations).

Which means this functionality looks to me like a new vector for
information leakage into and out of the guest VM via guest
controlled host page cache manipulation.

https://arxiv.org/pdf/1901.01161

I might be wrong, but if I'm not we're going to have to be very
careful about how guest VMs can access and manipulate host side
resources like the page cache.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
