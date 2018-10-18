Received: from eggs.gnu.org ([2001:4830:134:3::10]:45925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=822dd159c=roger.pau@citrix.com>)
	id 1gD9kk-0004D3-1K
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=822dd159c=roger.pau@citrix.com>)
	id 1gD9kZ-0007ho-DE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:58:18 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:13020
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=822dd159c=roger.pau@citrix.com>)
	id 1gD9kZ-0007cn-1S
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:58:11 -0400
Date: Thu, 18 Oct 2018 15:56:36 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Message-ID: <20181018145636.k6ptvn4iszabjhxw@mac.bytemobile.com>
References: <20181016021439.6212-1-yan.y.zhao@intel.com>
	<F22B14EC3CFBB843AD3E03B6B78F2C6A4ACFD80C@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <F22B14EC3CFBB843AD3E03B6B78F2C6A4ACFD80C@SHSMSX104.ccr.corp.intel.com>
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
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony.perard@citrix.com" <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Oct 18, 2018 at 08:22:41AM +0000, Zhao, Yan Y wrote:
> Hi
> The background for this patch is that: for some pci device, even it's PCI_INTERRUPT_PIN is not 0, it actually does not support INTx mode, so we should just report error, disable INTx mode and continue the passthrough.
> However, the commit 5a11d0f7 regards this as error condition and let qemu quit passthrough, which is too rigorous.
> 
> Error message is below:
> libxl: error: libxl_qmp.c:287:qmp_handle_error_response: Domain 2:received an error message from QMP server: Mapping machine irq 0 to pirq -1 failed: Operation not permitted

I'm having issues figuring out what's happening here.
s->real_device.irq is 0, yet the PCI config space read of
PCI_INTERRUPT_PIN returns something different than 0.

AFAICT this is due to some kind of error in Linux, so that even when
the device is supposed to have a valid IRQ the sysfs node it is set to
0, do you know the actual underlying cause of this?

Thanks, Roger.
