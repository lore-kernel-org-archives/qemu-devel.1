Received: from eggs.gnu.org ([2001:4830:134:3::10]:56187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eskwC-0005lc-Pb
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eskw9-0005KR-El
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:53:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:16839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eskw9-0005K3-68
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 02:53:33 -0500
Date: Mon, 5 Mar 2018 15:53:28 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180305075328.6i77el735gnqf3gt@hz-desktop>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
	<20171207101812.23602-4-haozhong.zhang@intel.com>
	<20180227164147.GB1799@perard.uk.xensource.com>
	<20180228075654.gv22h2zd73peuyxm@hz-desktop>
	<20180302115009.GF1799@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302115009.GF1799@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v4 03/10] hostmem-xen: add a host
 memory backend for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 03/02/18 11:50 +0000, Anthony PERARD wrote:
> On Wed, Feb 28, 2018 at 03:56:54PM +0800, Haozhong Zhang wrote:
> > On 02/27/18 16:41 +0000, Anthony PERARD wrote:
> > > On Thu, Dec 07, 2017 at 06:18:05PM +0800, Haozhong Zhang wrote:
> > > > @@ -108,7 +109,10 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> > > >      }
> > > >  
> > > >      memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
> > > > -    vmstate_register_ram(vmstate_mr, dev);
> > > > +    /* memory-backend-xen is not backed by RAM. */
> > > > +    if (!xen_enabled()) {
> > > 
> > > Is it possible to have the same condition as the one used in
> > > host_memory_backend_memory_complete? i.e. base on whether the memory
> > > region is mapped or not (backend->mr.ram_block).
> > 
> > Like "if (!xen_enabled() || backend->mr.ram_block))"? No, it will mute
> > the abortion (vmstate_register_ram --> qemu_ram_set_idstr ) caused by
> > the case that !backend->mr.ram_block in the non-xen environment.
> 
> In non-xen environment, vmstate_register_ram() will be called, because
> !xen_enabled() is true, it would not matter if there is a ram_block or
> not.

Sorry, I really meant 'if (backend->mr.ram_block)', which may mute the
abortion in non-xen environment. 'if (!xen_enabled())' keeps the
original semantics in non-xen environment, so it's unlikely to break
the non-xen usage.

Haozhong

> 
> But if there is a memory-backend that can run in a xen environment that
> have a ram_block, vmstate_register_ram would not be called in the
> origial patch, but if we use (!xen_enabled() || vmstate_mr->ram_block)
> as condition then vmstate_register_ram will be called.
> 
> Is this make sense?
> 
> > > > +        vmstate_register_ram(vmstate_mr, dev);
> > > > +    }
> > > >      numa_set_mem_node_id(addr, memory_region_size(mr), dimm->node);
> > > >  
> > > >  out:
> 
> -- 
> Anthony PERARD
> 
