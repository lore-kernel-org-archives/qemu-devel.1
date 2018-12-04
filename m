Received: from eggs.gnu.org ([2001:4830:134:3::10]:35378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869b7dada=roger.pau@citrix.com>)
	id 1gU72e-0006gZ-4F
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869b7dada=roger.pau@citrix.com>)
	id 1gU72a-0005Jh-RL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:30:56 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:23380
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=869b7dada=roger.pau@citrix.com>)
	id 1gU72a-0005Hf-EU
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:30:52 -0500
Date: Tue, 4 Dec 2018 10:30:18 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Message-ID: <20181204093018.d6vhfdwg276pf7ja@mac>
References: <20181204075049.10285-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204075049.10285-1-yan.y.zhao@intel.com>
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
To: Zhao Yan <yan.y.zhao@intel.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, Jan Beulich <JBeulich@suse.com>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On Tue, Dec 04, 2018 at 02:50:49AM -0500, Zhao Yan wrote:
> For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
> doesn't support INTx mode, so its machine irq read from host sysfs is 0.
> In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
> continue.
> 
> Cc: Roger Pau Monné <roger.pau@citrix.com>
> Cc: Jan Beulich <JBeulich@suse.com>
> Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

One nit below.

> 
> ---
> v2: fix some coding style issue
> v3:
>    1. let subject be more descriptive (roger)
>    2. disable INTx assertion if machine irq is 0.(roger)
>    3. in xen_pt_irqpin_reg_init(), drop the else branch as the default
> value for *data is 0. (roger)
> ---
>  hw/xen/xen_pt.c             | 7 +++++++
>  hw/xen/xen_pt_config_init.c | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index e5a6eff..b563837 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -847,6 +847,13 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
>      }
>  
>      machine_irq = s->real_device.irq;
> +    if (machine_irq == 0) {
> +        XEN_PT_LOG(d, "machine irq is 0\n");
> +        cmd |= PCI_COMMAND_INTX_DISABLE;
> +        s->machine_irq = 0;

AFAICT this is already initialized to 0, so you can drop setting
machine_irq.

Thanks, Roger.
