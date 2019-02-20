Received: from eggs.gnu.org ([209.51.188.92]:50386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gwUb9-0005Qm-7j
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1gwUaz-0005IJ-TO
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:19:43 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1gwUax-0004tb-LZ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:19:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id z19so41136636otm.2
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:19:09 -0800 (PST)
MIME-Version: 1.0
References: <729515484.1572396.1550250571940.ref@mail.yahoo.com>
	<729515484.1572396.1550250571940@mail.yahoo.com>
	<20190220153635.GC30403@stefanha-x1.localdomain>
In-Reply-To: <20190220153635.GC30403@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Feb 2019 08:18:57 -0800
Message-ID: <CAPcyv4i46wzWv1Fg7CWHdBBa=p_Bw7gGsJzAR9MnynEwy2rH+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why only devdax guarantees guest data persistence ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "bipin.tomar@yahoo.com" <bipin.tomar@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Ross Zwisler <zwisler@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Pankaj Gupta <pagupta@redhat.com>

On Wed, Feb 20, 2019 at 7:37 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Feb 15, 2019 at 05:09:31PM +0000, bipin.tomar--- via Qemu-devel wrote:
> > Text from "docs/nvdimm.txt" says:
> > Guest Data Persistence
> > ----------------------
> >
> > Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > currently the only one that can guarantee the guest write persistence
> > is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> > which all guest access do not involve any host-side kernel cache.
> >
> > I think here "host-side kernel cache" imply "page cache". Why does fsdax NOT have the same persistence guarantees as devdax for vNVDIMM?
> > Both the modes avoid using page cache then why is devdax explicitly called out?
>
> File systems may require msync(2)/fsync(2) to guarantee persistence even
> with DAX (just a cache flush instruction may not be enough!).  Emulated
> NVDIMM devices lack an fsync interface so guests are unable to fsync the
> host file system.
>
> This is not an issue with devdax since there is no host file system.
>
> virtio-pmem is an effort to add a paravirtualized fsync-style interface
> and should solve this problem in the future:
> https://lkml.org/lkml/2019/1/9/541

A para-virtualized flush is only necessary if the host implements
caches and dirty-metadata that cannot be coordinated / flushed by
MAP_SYNC. virtio-pmem is not a solution to a problem, virtio-pmem is a
non-DAX alternative implementation of persistent memory that requires
the guest to coordinate metadata and host page cache flushing.
