Received: from eggs.gnu.org ([2001:4830:134:3::10]:37919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6fP-0001JF-Uf
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6fM-00077d-NS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:20:39 -0400
Date: Wed, 30 Aug 2017 18:20:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830172033.GE24565@stefanha-x1.localdomain>
References: <20170818133118.8650-1-stefanha@redhat.com>
	<72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
	<37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
	<a3fb2086-5c6c-4b0a-cb05-2061fbfea1e6@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3fb2086-5c6c-4b0a-cb05-2061fbfea1e6@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 02:56:00PM +1000, Alexey Kardashevskiy wrote:
> On 19/08/17 12:46, Alexey Kardashevskiy wrote:
> > On 19/08/17 01:18, Eric Blake wrote:
> >> On 08/18/2017 08:31 AM, Stefan Hajnoczi wrote:
> >>> Most qcow2 files are uncompressed so it is wasteful to allocate (32 + 1)
> >>> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
> >>> s->cluster_data when the first read operation is performance on a
> >>> compressed cluster.
> >>>
> >>> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has any
> >>> code paths that can allocate these buffers, so remove the free functions
> >>> in the error code path.
> >>>
> >>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>> Cc: Kevin Wolf <kwolf@redhat.com>
> >>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> ---
> >>> Alexey: Does this improve your memory profiling results?
> >>
> >> Is this a regression from earlier versions? 
> > 
> > Hm, I have not thought about this.
> > 
> > So. I did bisect and this started happening from
> > 9a4c0e220d8a4f82b5665d0ee95ef94d8e1509d5
> > "hw/virtio-pci: fix virtio behaviour"
> > 
> > Before that, the very same command line would take less than 1GB of
> > resident memory. That thing basically enforces virtio-1.0 for QEMU <=2.6
> > which means that upstream with "-machine pseries-2.6" works fine (less than
> > 1GB), "-machine pseries-2.7" does not (close to 7GB, sometime even 9GB).
> > 
> > Then I tried bisecting again, with
> > "scsi=off,disable-modern=off,disable-legacy=on" on my 150 virtio-block
> > devices, started from
> > e266d421490e0 "virtio-pci: add flags to enable/disable legacy/modern" (it
> > added the disable-modern switch) which uses 2GB of memory.
> > 
> > I ended up with ada434cd0b44 "virtio-pci: implement cfg capability".
> > 
> > Then I removed proxy->modern_as on v2.10.0-rc3 (see below) and got 1.5GB of
> > used memory (yay!)
> > 
> > I do not really know how to reinterpret all of this, do you?
> 
> 
> Anyone, ping? Should I move the conversation to the original thread? Any
> hacks to try with libc?

I suggest a new top-level thread with Michael Tsirkin CCed.

Stefan
