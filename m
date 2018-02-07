Received: from eggs.gnu.org ([2001:4830:134:3::10]:56220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejQj4-0002m1-Er
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejQj0-0003Aw-En
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:29:30 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-10-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c705ee13-168f-1e96-99cf-ef0028b3d758@amsat.org>
Date: Wed, 7 Feb 2018 11:29:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180207042438.15422-10-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 09/14] pci: Use pci_config_size in
 pci_data_* accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

On 02/07/2018 01:24 AM, Andrey Smirnov wrote:
> Use pci_config_size (as opposed to PCI_CONFIG_SPACE_SIZE) in
> pci_data_read() and pci_data_write(), so this function would work for
> both classic PCI and PCIe use-cases.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci/pci_host.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index 5eaa935cb5..ea52ea07cd 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -89,30 +89,35 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
>  void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, int len)
>  {
>      PCIDevice *pci_dev = pci_dev_find_by_addr(s, addr);
> -    uint32_t config_addr = addr & (PCI_CONFIG_SPACE_SIZE - 1);
> +    uint32_t config_addr;
>  
>      if (!pci_dev) {
>          return;
>      }
>  
> +    config_addr = addr & (pci_config_size(pci_dev) - 1);
> +
>      PCI_DPRINTF("%s: %s: addr=%02" PRIx32 " val=%08" PRIx32 " len=%d\n",
>                  __func__, pci_dev->name, config_addr, val, len);
> -    pci_host_config_write_common(pci_dev, config_addr, PCI_CONFIG_SPACE_SIZE,
> +    pci_host_config_write_common(pci_dev, config_addr,
> +                                 pci_config_size(pci_dev),
>                                   val, len);
>  }
>  
>  uint32_t pci_data_read(PCIBus *s, uint32_t addr, int len)
>  {
>      PCIDevice *pci_dev = pci_dev_find_by_addr(s, addr);
> -    uint32_t config_addr = addr & (PCI_CONFIG_SPACE_SIZE - 1);
> +    uint32_t config_addr;
>      uint32_t val;
>  
>      if (!pci_dev) {
>          return ~0x0;
>      }
>  
> +    config_addr = addr & (pci_config_size(pci_dev) - 1);
> +
>      val = pci_host_config_read_common(pci_dev, config_addr,
> -                                      PCI_CONFIG_SPACE_SIZE, len);
> +                                      pci_config_size(pci_dev), len);
>      PCI_DPRINTF("%s: %s: addr=%02"PRIx32" val=%08"PRIx32" len=%d\n",
>                  __func__, pci_dev->name, config_addr, val, len);
>  
> 
