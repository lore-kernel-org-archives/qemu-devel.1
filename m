Received: from eggs.gnu.org ([209.51.188.92]:48915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtpyB-0006c0-2n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtpy8-00015u-Gh
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:32:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gtpy8-00013c-6m
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:32:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so1414003wrn.12
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 00:32:34 -0800 (PST)
Date: Wed, 13 Feb 2019 09:32:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190213083227.xkih3ckbtiromd2v@steredhat>
References: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
	<20190213080143.GE26332@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213080143.GE26332@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, ldoktor@redhat.com, mst@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Greg Kurz <groug@kaod.org>

On Wed, Feb 13, 2019 at 04:01:43PM +0800, Stefan Hajnoczi wrote:
> On Wed, Feb 13, 2019 at 09:48:57AM +0800, Changpeng Liu wrote:
> > Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features
> > support" added fields to struct virtio_blk_config. This changes
> > the size of the config space and breaks migration from QEMU 3.1
> > and older:
> > 
> > qemu-system-ppc64: get_pci_config_device: Bad config data: i=0x10 read: 41 device: 1 cmask: ff wmask: 80 w1cmask:0
> > qemu-system-ppc64: Failed to load PCIDevice:config
> > qemu-system-ppc64: Failed to load virtio-blk:virtio
> > qemu-system-ppc64: error while loading state for instance 0x0 of device 'pci@800000020000000:01.0/virtio-blk'
> > qemu-system-ppc64: load of migration failed: Invalid argument
> > 
> > Since virtio-blk doesn't support the "discard" and "write zeroes"
> > features, it shouldn't even expose the associated fields in the
> > config space actually. Just include all fields up to num_queues to
> > match QEMU 3.1 and older.
> > 
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > ---
> >  hw/block/virtio-blk.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> Stefano: Please rebase your DISCARD/WRITE_ZEROES series onto this and
> check that the config space is correctly sized.  Machine types before
> 4.0 shouldn't have these fields so that the config space size remains
> unchanged.

Sure!

Since I should set a correct config size checking if new features are
enabled or not at runtime, should be better to add a variable and an array
of sizes like in virtio-net?

Thanks,
Stefano
