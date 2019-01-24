Received: from eggs.gnu.org ([209.51.188.92]:35440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmkK2-0005Ws-PL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmkK1-00009n-MU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:05:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gmkK1-00009I-CY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:05:53 -0500
Date: Thu, 24 Jan 2019 14:05:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190124140522-mutt-send-email-mst@kernel.org>
References: <cover.1548136274.git.yi.z.zhang@linux.intel.com>
	<78014185dc40dea43750eaa50ae093806e3dab66.1548136274.git.yi.z.zhang@linux.intel.com>
	<20190123145050.GU4136@habkost.net>
	<20190124112102.GA9821@tiger-server>
	<20190124165926.GY4136@habkost.net>
	<20190124123824-mutt-send-email-mst@kernel.org>
	<20190124182839.GZ4136@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124182839.GZ4136@habkost.net>
Subject: Re: [Qemu-devel] [PATCH V10 4/4] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Thu, Jan 24, 2019 at 04:28:39PM -0200, Eduardo Habkost wrote:
> On Thu, Jan 24, 2019 at 12:45:54PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 24, 2019 at 02:59:26PM -0200, Eduardo Habkost wrote:
> > > On Thu, Jan 24, 2019 at 07:21:03PM +0800, Yi Zhang wrote:
> > > > On 2019-01-23 at 12:50:50 -0200, Eduardo Habkost wrote:
> > > > > On Wed, Jan 23, 2019 at 11:00:02AM +0800, Zhang, Yi wrote:
> > > > > > From: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > > > > 
> > > > > > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> [...]
> > > > > > + - 'pmem' option of memory-backend-file is 'on':
> > > > > > +   The backend is a file supporting DAX, e.g., a file on an ext4 or
> > > > > > +   xfs file system mounted with '-o dax'. if your pmem=on ,but the backend is
> > > > > > +   not a file supporting DAX, mapping with this flag results in an EOPNOTSUPP
> > > > > > +   error.
> > > > > 
> > > > > Won't this break existing configurations that work today on QEMU
> > > > > 3.1.0?  Why exactly it is OK to break compatibility here?
> > > > won't, pmem option default is off, if people who start VM don't know what
> > > > backend file is, it is suggested and *default to set pmem=off,
> > > > if people well know the backend file have dax capbility. it is suggest
> > > > to set pmem=on. 
> > > > 
> > > > For a special case that we use /dev/dax as backend, we already have a
> > > > patch to add MAP_SYNC falg mapiing from device dax mode.
> > > > see https://lkml.org/lkml/2018/4/22/524 
> > > > 
> > > > So, if people force set pmem=on, mapping a regular file, it will results
> > > > in an EOPNOTSUPP error. 
> > > 
> > > This is where compatibility is being broken, isn't it?  People
> > > currently using pmem=on on a regular file will start getting
> > > errors after a QEMU upgrade.  Existing VMs with pmem=on may stop
> > > booting.  Maybe this is OK, but we need to be able to explain why
> > > it is OK.
> > 
> > I think it's OK since pmem explicitly means "persistent":
> > 
> > The @option{pmem} option specifies whether the backing file specified
> > by @option{mem-path} is in host persistent memory that can be accessed
> > using the SNIA NVM programming model (e.g. Intel NVDIMM).
> > If @option{pmem} is set to 'on', QEMU will take necessary operations to
> > guarantee the persistence of its own writes to @option{mem-path}
> > (e.g. in vNVDIMM label emulation and live migration).
> 
> If it's OK, let's at least explicitly document that we are
> breaking compatibility in those cases.
> 
> 
> > > > 
> [...]
> > I think generally MAP_SYNC is required.
> > But for compatibility reasons we might need to support
> > !MAP_SYNC on old kernels even though it's risky.
> 
> What about making MAP_SYNC optional only on older machine-types?

I don't think this makes sense. It's not a guest visible change,
machine types are for that.

> -- 
> Eduardo
