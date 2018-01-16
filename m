Received: from eggs.gnu.org ([2001:4830:134:3::10]:43956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebGdt-0005TG-BI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebGdq-0007ch-6Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:06:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebGdp-0007bw-VI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:06:22 -0500
Date: Tue, 16 Jan 2018 04:06:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116040030-mutt-send-email-mst@kernel.org>
References: <20180114090147.39255-1-marcel@redhat.com>
	<20180114090147.39255-4-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180114090147.39255-4-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V7 3/5] docs: add pvrdma device
 documentation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, f4bug@amsat.org

On Sun, Jan 14, 2018 at 11:01:45AM +0200, Marcel Apfelbaum wrote:
> +5. Limitations
> +==============

Limitations are fine but need to cause init failures since users
don't poke in the internal documentation.

> +- The device obviously is limited by the Guest Linux Driver features implementation
> +  of the VMware device API.
> +- Memory registration mechanism requires mremap for every page in the buffer in order
> +  to map it to a contiguous virtual address range. Since this is not the data path
> +  it should not matter much.

Depends on the size of the region I guess. Did you try this with several
gigabytes of memory? If we are talking seconds of downtime,
it's worth documenting so people aren't surprised.
Alternatively, limit the max size of MR?

> +- The device requires target page size to be the same as the host page size.

Pls add code to fail init when this is not the case.

> +- QEMU cannot map guest RAM from a file descriptor if a pvrdma device is attached,
> +  so it can't work with huge pages. The limitation will be addressed in the future,
> +  however QEMU allocates Guest RAM with MADV_HUGEPAGE so if there are enough huge
> +  pages available, QEMU will use them.

Same here.

> +- As previously stated, migration is not supported yet, however with some hardware
> +  support can be done.

I don't see a migration blocker.



-- 
MST
