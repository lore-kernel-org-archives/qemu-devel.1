Received: from eggs.gnu.org ([209.51.188.92]:49349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyf1A-0000yY-5e
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyf19-0002M9-AL
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:51:40 -0500
Date: Tue, 26 Feb 2019 16:51:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190226155131.GC4598@linux.fritz.box>
References: <20190226145930.5000-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226145930.5000-1-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: propagate discard aligment from
 format drivers to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, armbru@redhat.com, dgilbert@redhat.com

Am 26.02.2019 um 15:59 hat Denis V. Lunev geschrieben:
> Nowaday SCSI drivers in guests are able to alight UNMAP requests before

Is s/alight/align/ what you mean?

The subject line has an "alignment" typo, too.

> sending to the device. Right now QEMU provides an ability to set
> this via "discard_granularity" property of the block device which could
> be used by management layer.
> 
> Though, in particular, from the point of QEMU, there is
> pdiscard_granularity on the format driver level, f.e. on QCOW2 or iSCSI.
> It would be beneficial to pass this value as a default for this
> property.
> 
> Technically this should reduce the amount of useless UNMAP requests
> from the guest to the host.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Fam Zheng <fam@euphon.net>

I'm not doing things like this very often, but you're touching the guest
ABI here, which is a bit tricky. The main point is that the same command
line must result in the same guest view.

You'll need at least some machine type magic to make old machine types
use the old defaults. I'm not sure if there's something else to consider
for migration compatibility.

Kevin
