Received: from eggs.gnu.org ([2001:4830:134:3::10]:34246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejPCc-0003S1-2p
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejPCX-0002AG-QX
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:51:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:14217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1ejPCX-00028D-H4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:51:49 -0500
Date: Wed, 7 Feb 2018 20:51:41 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180207125141.cajtcvlsatwplfxh@hz-desktop>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-6-haozhong.zhang@intel.com>
	<20180207113841.GB2665@work-vm>
	<20180207115207.qeqld4v3hl246qu4@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207115207.qeqld4v3hl246qu4@hz-desktop>
Subject: Re: [Qemu-devel] [PATCH v2 5/8] migration/ram: ensure write
 persistence on loading zero pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 02/07/18 19:52 +0800, Haozhong Zhang wrote:
> On 02/07/18 11:38 +0000, Dr. David Alan Gilbert wrote:
> > * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> > > When loading a zero page, check whether it will be loaded to
> > > persistent memory If yes, load it by libpmem function
> > > pmem_memset_nodrain().  Combined with a call to pmem_drain() at the
> > > end of RAM loading, we can guarantee all those zero pages are
> > > persistently loaded.
> > 
> > I'm surprised pmem is this invasive to be honest;   I hadn't expected
> > the need for special memcpy's etc everywhere.  We're bound to miss some.
> > I assume there's separate kernel work needed to make postcopy work;
> > certainly the patches here don't seem to touch the postcopy path.
> 
> This link at
> https://wiki.qemu.org/Features/PostCopyLiveMigration#Conflicts shows
> that postcopy with memory-backend-file requires kernel support. Can
> you point me the details of the required kernel support, so that I can
> understand what would be needed to NVDIMM postcopy?

I saw test_ramblock_postcopiable() requires the ram block not be
mmap'ed with MAP_SHARED. The only pmem device (i.e., device DAX e.g.,
/dev/dax0.0) that can be safely used as the backend of vNVDIMM must be
shared mapped which is required by kernel, so postcopy does not work
with pmem right now. Even if the private mmap was supported for device
dax, it would still make little sense to private mmap it in QEMU,
because vNVDIMM intends to be non-volatile.

Haozhong
