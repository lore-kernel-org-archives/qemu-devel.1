Received: from eggs.gnu.org ([2001:4830:134:3::10]:47748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gUPLx-0007Tp-3h
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gUPLq-0000lP-VV
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:04:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:49913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gUPLn-0000f8-EY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:03:57 -0500
Date: Tue, 4 Dec 2018 23:59:24 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20181205045924.GA12364@joy-OptiPlex-7040>
References: <20181204075049.10285-1-yan.y.zhao@intel.com>
	<20181204093018.d6vhfdwg276pf7ja@mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204093018.d6vhfdwg276pf7ja@mac>
Subject: Re: [Qemu-devel] [PATCH v3] xen/pt: allow passthrough of devices
 with bogus interrupt pin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, Jan Beulich <JBeulich@suse.com>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On Tue, Dec 04, 2018 at 10:30:18AM +0100, Roger Pau Monné wrote:
> On Tue, Dec 04, 2018 at 02:50:49AM -0500, Zhao Yan wrote:
> > For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
> > doesn't support INTx mode, so its machine irq read from host sysfs is 0.
> > In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
> > continue.
> > 
> > Cc: Roger Pau Monné <roger.pau@citrix.com>
> > Cc: Jan Beulich <JBeulich@suse.com>
> > Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
> 
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> One nit below.
Got it. Thank you!
:)
> 
> > 
> > ---
> > v2: fix some coding style issue
> > v3:
> >    1. let subject be more descriptive (roger)
> >    2. disable INTx assertion if machine irq is 0.(roger)
> >    3. in xen_pt_irqpin_reg_init(), drop the else branch as the default
> > value for *data is 0. (roger)
> > ---
> >  hw/xen/xen_pt.c             | 7 +++++++
> >  hw/xen/xen_pt_config_init.c | 4 +++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> > index e5a6eff..b563837 100644
> > --- a/hw/xen/xen_pt.c
> > +++ b/hw/xen/xen_pt.c
> > @@ -847,6 +847,13 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
> >      }
> >  
> >      machine_irq = s->real_device.irq;
> > +    if (machine_irq == 0) {
> > +        XEN_PT_LOG(d, "machine irq is 0\n");
> > +        cmd |= PCI_COMMAND_INTX_DISABLE;
> > +        s->machine_irq = 0;
> 
> AFAICT this is already initialized to 0, so you can drop setting
> machine_irq.
> 
> Thanks, Roger.
