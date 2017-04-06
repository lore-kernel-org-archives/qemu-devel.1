Received: from eggs.gnu.org ([2001:4830:134:3::10]:37114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvviT-0005TE-8n
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 20:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvviS-0005sR-CP
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 20:56:01 -0400
Date: Wed, 5 Apr 2017 20:55:49 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170406005549.GN1135@localhost.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<6c82b83fae72a5b5909993f0cf65a90f12efb669.1491416061.git.jcody@redhat.com>
	<4a5f39ab-50ad-6071-130a-fe77493221ec@redhat.com>
	<a0d3bd42-682c-fe21-eeaa-28e189386e57@redhat.com>
	<20170406002028.GK1135@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406002028.GK1135@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/9] block: honor
 BDRV_O_ALLOW_RDWR when clearing bs->read_only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Wed, Apr 05, 2017 at 08:20:28PM -0400, Jeff Cody wrote:
> On Wed, Apr 05, 2017 at 02:26:53PM -0500, Eric Blake wrote:
> > On 04/05/2017 02:20 PM, John Snow wrote:
> > 
> > > Conceptually straightforward.
> > > 
> > > looks like this might change behavior for... RBD and vvfat, right?
> > > RBD is the subject of this series so we'll just assume that was broken
> > > and stupid.
> > > 
> 
> Yes on RBD, and that change is intentional.
> 
> > > What's vvfat's story? It always set the read-only property to false
> > > regardless of what you asked for?
> > 
> > vvfat is even stupider than that - it has its own independent property
> > 'rw' that determines whether to allow write operations, separate from
> > the inherited BDS readonly property.
> >
> 
> Yes, it is very odd.  But if we have copy_on_read enabled, or explicitly set
> the block device to read-only via QAPI or -drive, I think that those should
> take precedence.
>

I meant to add an example - currently, with this drive commandline:

"-drive format=vvfat,dir=/tmp/vvfat,rw,if=virtio,readonly=on"

The drive is not read-only, but writable.  That seems broken.

After this patch, this ends up throwing an error now (which I think is a
logical thing to do):

qemu-system-x86_64: -drive format=vvfat,dir=/tmp/vvfat,rw,if=virtio,readonly=on: Node '#block238' is read only

How this affects vvfat (and rbd) should be documented in the commit message,
however, so I should ammend that if we keep this behavior.

One other possible option is to treat the vvfat 'rw' option as meaning
"enable writes, iff the block device is writable".  With that
interpretation, we could do something different in the above scenario:
silently fail to set bs->read_only to 'true' in the vvfat driver, and keep
it r/o.
