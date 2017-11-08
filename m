Received: from eggs.gnu.org ([2001:4830:134:3::10]:51773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCG86-0000n0-4R
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCG82-0005eh-Vw
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:30:14 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eCG82-0005eB-RC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:30:10 -0500
Received: by mail-pl0-x241.google.com with SMTP id 30so320485pla.2
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:30:10 -0800 (PST)
References: <1510060738-25975-1-git-send-email-s1seetee@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7426dac9-67bf-a70a-bb5b-307de4602263@ozlabs.ru>
Date: Wed, 8 Nov 2017 13:30:04 +1100
MIME-Version: 1.0
In-Reply-To: <1510060738-25975-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] spapr_pci: fix the path
 while fetching loc-code from host DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 08/11/17 00:18, Seeteena Thoufeek wrote:
> The function spapr_phb_vfio_get_loc_code uses wrong path for
> fetching loc-code from host DT
> 
> this is the call that needs to be fixed:
> /* Construct and read from host device tree the loc-code */
> path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);


I do not see why would extra '/' hurt but where does it really fail?

My machines have leading '/' in devspec, do not yours?

aik@garrison2:~$ cat /sys/bus/pci/devices/0009:03:00.0/devspec && echo -e '\n'
/pciex@3fffe40500000/pci@0/pci@0/pci@1/usb-xhci@0




> 
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5a3122a..ae86322 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -762,7 +762,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
>      g_free(path);
>  
>      /* Construct and read from host device tree the loc-code */
> -    path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
> +    path = g_strdup_printf("/proc/device-tree/%s/ibm,loc-code", buf);
>      g_free(buf);
>      if (!g_file_get_contents(path, &buf, NULL, NULL)) {
>          goto err_out;
> 


-- 
Alexey
