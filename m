Received: from eggs.gnu.org ([2001:4830:134:3::10]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dGqds-0007s3-TT
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dGqdp-0000Cu-Q2
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dGqdb-0000AW-NJ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:45:41 -0400
Date: Fri, 2 Jun 2017 14:45:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170602174516.GH4294@thinpad.lan.raisama.net>
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<f573260f6359ed94206d9b549a282b1f18c4bf6e.1496387804.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f573260f6359ed94206d9b549a282b1f18c4bf6e.1496387804.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] pci: Make errp the last parameter
 of pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, dmitry@daynix.com, jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, armbru@redhat.com

On Fri, Jun 02, 2017 at 03:54:41PM +0800, Mao Zhongyi wrote:
> Add Error argument for pci_add_capability() to leverage the errp
> to pass info on errors. This way is helpful for its callers to
> make a better error handling when moving to 'realize'.
> 
> Cc: mst@redhat.com
> Cc: pbonzini@redhat.com
> Cc: rth@twiddle.net
> Cc: ehabkost@redhat.com
> Cc: dmitry@daynix.com
> Cc: jasowang@redhat.com
> Cc: marcel@redhat.com
> Cc: alex.williamson@redhat.com
> Cc: armbru@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
[...]
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 62e989c..f24046a 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -494,7 +494,7 @@ static void eepro100_fcp_interrupt(EEPRO100State *s)
>  }
>  #endif
>  
> -static void e100_pci_reset(EEPRO100State *s)
> +static void e100_pci_reset(EEPRO100State *s, Error **errp)
>  {
>      E100PCIDeviceInfo *info = eepro100_get_class(s);
>      uint32_t device = s->device;
> @@ -570,9 +570,13 @@ static void e100_pci_reset(EEPRO100State *s)
>          /* Power Management Capabilities */
>          int cfg_offset = 0xdc;
>          int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
> -                                   cfg_offset, PCI_PM_SIZEOF);
> -        assert(r > 0);
> -        pci_set_word(pci_conf + cfg_offset + PCI_PM_PMC, 0x7e21);
> +                                   cfg_offset, PCI_PM_SIZEOF,
> +                                   errp);
> +        if (r > 0) {
> +            pci_set_word(pci_conf + cfg_offset + PCI_PM_PMC, 0x7e21);
> +        } else {
> +            return;
> +        }
>  #if 0 /* TODO: replace dummy code for power management emulation. */
>          /* TODO: Power Management Control / Status. */
>          pci_set_word(pci_conf + cfg_offset + PCI_PM_CTRL, 0x0000);
> @@ -1863,7 +1867,10 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
>  
>      s->device = info->device;
>  
> -    e100_pci_reset(s);
> +    e100_pci_reset(s, errp);
> +    if (errp && *errp) {
> +        return;
> +    }

This doesn't look right.  The behavior of the function shouldn't
be different depending on the value of errp.

If you need to check for e100_pci_reset() errors inside
e100_nic_realize(), you'll need a local Error* variable and an
error_propagate() call.  See the "Receive an error and pass it on
to the caller" example at include/qapi/error.h.

>  
>      /* Add 64 * 2 EEPROM. i82557 and i82558 support a 64 word EEPROM,
>       * i82559 and later support 64 or 256 word EEPROM. */

-- 
Eduardo
