Received: from eggs.gnu.org ([209.51.188.92]:55783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gwUkA-0004KI-5Z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gwUk9-0006gs-2m
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:29:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gwUk8-0006YK-Ql
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:29:09 -0500
Date: Wed, 20 Feb 2019 11:22:01 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1908184345.5542912.1550679721051.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190220153635.GC30403@stefanha-x1.localdomain>
References: <729515484.1572396.1550250571940.ref@mail.yahoo.com>
	<729515484.1572396.1550250571940@mail.yahoo.com>
	<20190220153635.GC30403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Why only devdax guarantees guest data persistence ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bipin tomar <bipin.tomar@yahoo.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Dan Williams <dan.j.williams@intel.com>, Ross Zwisler <zwisler@kernel.org>, Jeff Moyer <jmoyer@redhat.com>


> wrote:
> > Text from "docs/nvdimm.txt" says:
> > Guest Data Persistence
> > ----------------------
> > 
> > Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > currently the only one that can guarantee the guest write persistence
> > is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> > which all guest access do not involve any host-side kernel cache.
> > 
> > I think here "host-side kernel cache" imply "page cache". Why does fsdax
> > NOT have the same persistence guarantees as devdax for vNVDIMM?
> > Both the modes avoid using page cache then why is devdax explicitly called
> > out?
> 
> File systems may require msync(2)/fsync(2) to guarantee persistence even
> with DAX (just a cache flush instruction may not be enough!).  Emulated
> NVDIMM devices lack an fsync interface so guests are unable to fsync the
> host file system.

Just want to add to what Stefan already said.
 
For emulated vNVDIMM on regular storage like SSD we require an additional 
fsync on host backing file to guarantee write persistence (i.e fsync host 
page cache pages) and consistent host metadata.

If backing file is real NVDIMM, write persistence is taken care by host NVDIMM
driver and MAP_SYNC support takes care of metadata consistency in-case of guest
crash. 
> 
> This is not an issue with devdax since there is no host file system.

Yes.

> 
> virtio-pmem is an effort to add a paravirtualized fsync-style interface
> and should solve this problem in the future:
> https://lkml.org/lkml/2019/1/9/541
> 
> Stefan
> 
