Received: from eggs.gnu.org ([2001:4830:134:3::10]:44393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eX49f-0005FN-4j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eX49a-0006C5-EQ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:57:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eX49a-00069R-5W
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:57:46 -0500
Date: Thu, 4 Jan 2018 09:57:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180104115707.GC3143@localhost.localdomain>
References: <20171227065620.20889-1-haozhong.zhang@intel.com>
	<20180102175733-mutt-send-email-mst@kernel.org>
	<20180103031639.26c6iixwzs4auhxr@hz-desktop>
	<20180103134528.GF6405@localhost.localdomain>
	<20180104012328.j4n2vuiq27rix3ss@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180104012328.j4n2vuiq27rix3ss@hz-desktop>
Subject: Re: [Qemu-devel] [PATCH] util/mmap-alloc: support MAP_SYNC in
 qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Thu, Jan 04, 2018 at 09:23:28AM +0800, Haozhong Zhang wrote:
> On 01/03/18 11:45 -0200, Eduardo Habkost wrote:
> > On Wed, Jan 03, 2018 at 11:16:39AM +0800, Haozhong Zhang wrote:
> > > On 01/02/18 18:02 +0200, Michael S. Tsirkin wrote:
> > > > On Wed, Dec 27, 2017 at 02:56:20PM +0800, Haozhong Zhang wrote:
> > > > > When a file supporting DAX is used as vNVDIMM backend, mmap it with
> > > > > MAP_SYNC flag in addition can guarantee the persistence of guest write
> > > > > to the backend file without other QEMU actions (e.g., periodic fsync()
> > > > > by QEMU).
> > > > > 
> > > > > By using MAP_SHARED_VALIDATE flag with MAP_SYNC, we can ensure mmap
> > > > > with MAP_SYNC fails if MAP_SYNC is not supported by the kernel or the
> > > > > backend file. On such failures, QEMU retries mmap without MAP_SYNC and
> > > > > MAP_SHARED_VALIDATE.
> > > > > 
> > > > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > > 
> > > > If users rely on MAP_SYNC then don't you need to fail allocation
> > > > if you can't use it?
> > > 
> > > MAP_SYNC is supported since Linux kernel 4.15 and only needed for mmap
> > > files on nvdimm. qemu_ram_mmap() has no way to check whether its
> > > parameter 'fd' points to files on nvdimm, except by looking up
> > > sysfs. However, accessing sysfs may be denied by certain SELinux
> > > policies.
> > > 
> > > The missing of MAP_SYNC should not affect the primary functionality of
> > > vNVDIMM when using files on host nvdimm as backend, except the
> > > guarantee of write persistence in case of qemu/host crash.
> > > 
> > > We may check the kernel support of MAP_SYNC and the type of vNVDIMM
> > > backend in some management utility (e.g., libvirt?), and deny to
> > > launch QEMU if MAP_SYNC is not supported while files on host NVDIMM
> > > are in use.
> > 
> > Instead of making libvirt check if MAP_SYNC is supported and just
> > hope it won't fail, it would be safer to let libvirt tell QEMU
> > that MAP_SYNC must never fail.
> 
> For example, add an option "sync" to memory-backend-file, and pass the
> it to qemu_ram_mmap()?

Yes.  It could be a OnOffAuto option, "auto" would make QEMU try
to use MAP_SYNC but not fail if it's unavailable. "on" would
make QEMU ensure MAP_SYNC is really enabled.

> 
> > 
> > However, it looks like kernel 4.14 won't even fail if MAP_SYNC is
> > specified.  How exactly can userspace detect if MAP_SYNC is
> > really supported?
> 
> Use MAP_SYNC with MAP_SHARED_VALIDATE (both introduced in 4.15
> kernel). Linux kernel 4.15 and later validate whether the MAP_SYNC is
> supported. Because MAP_SHARED_VALIDATE is defined equally to
> (MAP_SHARED | MAP_PRIVATE), it always fails on older kernels which do
> not support MAP_SYNC as well.

Nice.

> 
> If we agree to introduce an option "sync" or likelihood, we can do the
> above check in qemu_ram_mmap().

Sounds good to me.  Thanks!

-- 
Eduardo
