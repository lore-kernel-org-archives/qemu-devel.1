Received: from eggs.gnu.org ([2001:4830:134:3::10]:35452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYiZn-0002bX-8I
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 21:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYiZj-0003sF-9O
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 21:24:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gYiZj-0003mq-26
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 21:24:07 -0500
Date: Sun, 16 Dec 2018 21:24:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181216212319-mutt-send-email-mst@kernel.org>
References: <1545003279-17233-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545003279-17233-1-git-send-email-dongli.zhang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] msix: correct pba size calculation
 used for msix_exclusive_bar initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com

On Mon, Dec 17, 2018 at 07:34:39AM +0800, Dongli Zhang wrote:
> The bar_pba_size is more than what the pba is expected to have, although
> this usually would not affect the bar_size used for dev->msix_exclusive_bar
> initialization.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>


If this does ever have an effect, we need a compat config
for old machine types.
Could you explain a bit more? Are there configs affected?
What are these?


> ---
>  hw/pci/msix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 702dac4..234c0a3 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -345,7 +345,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
>      char *name;
>      uint32_t bar_size = 4096;
>      uint32_t bar_pba_offset = bar_size / 2;
> -    uint32_t bar_pba_size = (nentries / 8 + 1) * 8;
> +    uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
>  
>      /*
>       * Migration compatibility dictates that this remains a 4k
> -- 
> 2.7.4
