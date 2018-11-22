Received: from eggs.gnu.org ([2001:4830:134:3::10]:45617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gPopg-00082l-D4
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gPopd-0000VS-Ab
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:15:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:48526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gPopd-0000Po-2N
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:15:45 -0500
Date: Thu, 22 Nov 2018 08:11:20 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20181122131110.GA31906@joy-OptiPlex-7040>
References: <20181016021439.6212-1-yan.y.zhao@intel.com>
	<F22B14EC3CFBB843AD3E03B6B78F2C6A4ACFD80C@SHSMSX104.ccr.corp.intel.com>
	<20181018145636.k6ptvn4iszabjhxw@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181018145636.k6ptvn4iszabjhxw@mac.bytemobile.com>
Subject: Re: [Qemu-devel] [PATCH] Xen PCI passthrough: fix passthrough
 failure when irq map failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Thu, Oct 18, 2018 at 03:56:36PM +0100, Roger Pau Monné wrote:
> On Thu, Oct 18, 2018 at 08:22:41AM +0000, Zhao, Yan Y wrote:
> > Hi
> > The background for this patch is that: for some pci device, even it's PCI_INTERRUPT_PIN is not 0, it actually does not support INTx mode, so we should just report error, disable INTx mode and continue the passthrough.
> > However, the commit 5a11d0f7 regards this as error condition and let qemu quit passthrough, which is too rigorous.
> > 
> > Error message is below:
> > libxl: error: libxl_qmp.c:287:qmp_handle_error_response: Domain 2:received an error message from QMP server: Mapping machine irq 0 to pirq -1 failed: Operation not permitted
> 
> I'm having issues figuring out what's happening here.
> s->real_device.irq is 0, yet the PCI config space read of
> PCI_INTERRUPT_PIN returns something different than 0.
> 
> AFAICT this is due to some kind of error in Linux, so that even when
> the device is supposed to have a valid IRQ the sysfs node it is set to
> 0, do you know the actual underlying cause of this?
> 
> Thanks, Roger.
Hi Roger
Sorry for the later reply, I just missed this mail...
On my side, it's because the hardware actually does not support INTx mode,
but its configuration space does not report PCI_INTERRUPT_PIN to 0. It's a
hardware bug, but previous version of qemu can tolerate it, switch to MSI
and make passthrough work.

Thanks
Yan
