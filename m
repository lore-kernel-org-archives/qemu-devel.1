Received: from eggs.gnu.org ([2001:4830:134:3::10]:51706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dIGNM-0004Q4-87
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dIGNH-0008Gf-N1
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dIGNH-0008GQ-Hv
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:27 -0400
Date: Tue, 6 Jun 2017 18:26:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170606182354-mutt-send-email-mst@kernel.org>
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<ffa2cc4d0706fa522a5e581af14dadb03aec323a.1496387804.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa2cc4d0706fa522a5e581af14dadb03aec323a.1496387804.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] pci: Clean up error checking in
 pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, armbru@redhat.com

On Fri, Jun 02, 2017 at 03:54:37PM +0800, Mao Zhongyi wrote:
> On success, pci_add_capability2() returns a positive value. On
> failure, it sets an error and return a negative value.
> 
> pci_add_capability() laboriously checks this behavior. No other
> caller does. Drop the checks from pci_add_capability().
> 
> Cc: mst@redhat.com
> Cc: marcel@redhat.com
> Cc: armbru@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 98ccc27..53566b8 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2270,12 +2270,8 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>      Error *local_err = NULL;
>  
>      ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
> -    if (local_err) {
> -        assert(ret < 0);
> +    if (ret < 0) {
>          error_report_err(local_err);
> -    } else {
> -        /* success implies a positive offset in config space */
> -        assert(ret > 0);
>      }
>      return ret;
>  }


I don't see why this is a good idea. You drop a bunch of
asserts, so naturally code is slightly tighter. We could gain
the same by building with NDEBUG but we don't, we rather
have more safety.

> -- 
> 2.9.3
> 
> 
> 
