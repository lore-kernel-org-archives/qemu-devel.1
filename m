Received: from eggs.gnu.org ([2001:4830:134:3::10]:49290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gU5K8-0004jK-FH
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gU5K2-0007rw-9x
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:40:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:17226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gU5K0-0007q7-AU
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:40:46 -0500
Date: Tue, 4 Dec 2018 02:36:18 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20181204073618.GB8671@joy-OptiPlex-7040>
References: <20181203050438.6034-1-yan.y.zhao@intel.com>
	<f056b5d1-02c2-2ee7-3e37-bc5e4869f0cb@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f056b5d1-02c2-2ee7-3e37-bc5e4869f0cb@citrix.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2] xen/pt: Fix a xen
 passthrough failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: anthony.perard@citrix.com, sstabellini@kernel.org, roger.pau@citrix.com, JBeulich@suse.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org

hi Andrew,

It's a pci device that does not support legacy intx mode, but it accidently
reports PCI_INTERRUPT_PIN as 1, which should be 0 instead.
So, in dom0, the machine irq is 0, which will cause later
xc_physdev_map_pirq() fail and passthrough failure.

Therefore, we treat this case as PCI_INTERRUPT_PIN is 0 and report to guest
the right value (0) of PCI_INTERRUPT_PIN.
Then in guest, it's able to use msi mode and function normally.

On Mon, Dec 03, 2018 at 02:12:58PM +0000, Andrew Cooper wrote:
> On 03/12/2018 05:04, Zhao Yan wrote:
> > For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
> > doesn't support INTx mode, so its machine irq read from host sysfs is 0.
> > In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
> > continue.
> 
> What causes this problem?  It it a non-PCI compliant device?  Is it a
> device which has legacy lines prohibited?
> 
> ~Andrew
