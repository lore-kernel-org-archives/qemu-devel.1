Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eh2LQ-0004Qr-KL
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eh2LM-0007Sk-51
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:03:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:57318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eh2LL-0007S9-Rf
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:03:08 -0500
Date: Thu, 1 Feb 2018 08:02:40 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180201000240.zmwa6wwnthg2su36@hz-desktop>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
	<CAPcyv4gJyS=yiXg6SHxdiHT9vzmLx2yXsfdyOe3+qTLwzrMDQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gJyS=yiXg6SHxdiHT9vzmLx2yXsfdyOe3+qTLwzrMDQQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 01/31/18 14:25 -0800, Dan Williams wrote:
> On Tue, Jan 30, 2018 at 10:02 PM, Haozhong Zhang
> <haozhong.zhang@intel.com> wrote:
> > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> > files on ext4/xfs file system mounted with '-o dax').
> 
> Wait, MAP_SYNC does not guarantee persistence. It makes sure that the
> metadata is in sync after a fault. However, that does not make
> filesystem-DAX safe for use with QEMU, because we still need to
> coordinate DMA with fileystem operations. There is no way to do that
> coordination from within a guest. QEMU needs to use device-dax if the
> guest might ever perform DMA to a virtual-pmem range. See this patch
> set for more details on the DAX vs DMA problem [1]. I think we need to
> enforce this in the host kernel. I.e. do not allow file backed DAX
> pages to be mapped in EPT entries unless / until we have a solution to
> the DMA synchronization problem. Apologies for not noticing this
> earlier.

QEMU does not truncate or punch holes of the file once it has been
mmap()'ed. Does the problem [1] still exist in such case?

Thanks,
Haozhong

> 
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2017-December/013704.html
