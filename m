Received: from eggs.gnu.org ([2001:4830:134:3::10]:43441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Xs8-0002DD-9D
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Xs5-0007mh-71
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6Xs5-0007mS-0U
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:41:49 -0400
Date: Fri, 5 May 2017 15:41:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170505074143.GB21435@lemon.lan>
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/5] Enable virtio-scsi boot from
 /dev/sgX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 04/26 16:46, Eric Farman wrote:
> The short version of what happens is the host device driver rejects our
> requests because the transfer lengths are too long for it to satisfy.
> A virtio-scsi disk connected via scsi-generic is fine as a non-boot device
> because the guest kernel is able to break up the requests for us.  So we just
> need to handle this situation for the boot process.
> 
> Patches 2-N in this series do that, but rely on us to specify the max_sectors
> parameter for the virtio-scsi-ccw device:
> 
>   /usr/bin/qemu-system-s390x ...
>     -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001,max_sectors=2048

Can you instead do an INQUIRY from the bios code to check the Block Limits page?
The response is intercepted by hw/scsi/scsi-generic.c to merge in the host LUN's
limits. That's how Linux kernel finds the granularity for request splitting.

That way, patch 1 is not necessary too. I don't like it because it doesn't
always work considering LUN hotplug.

Fam
