Received: from eggs.gnu.org ([2001:4830:134:3::10]:36196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cisF1-0008Ec-Um
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 19:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cisEy-00082y-Nj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 19:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cisEy-00082n-Gp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 19:35:36 -0500
References: <1486623844-13140-1-git-send-email-liqiang6-s@360.cn>
	<1486623844-13140-3-git-send-email-liqiang6-s@360.cn>
From: John Snow <jsnow@redhat.com>
Message-ID: <9cda5c21-0022-fc56-5afa-d797088fe3d5@redhat.com>
Date: Tue, 28 Feb 2017 19:35:33 -0500
MIME-Version: 1.0
In-Reply-To: <1486623844-13140-3-git-send-email-liqiang6-s@360.cn>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] ide: ahci: call cleanup function in
 ahci unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>



On 02/09/2017 02:04 AM, Li Qiang wrote:
> This can avoid memory leak when hotunplug the ahci device.
> 
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/ide/ahci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 3c19bda..56f68a8 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1485,6 +1485,14 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
>  
>  void ahci_uninit(AHCIState *s)
>  {
> +    int i;
> +
> +    for (i = 0; i < s->ports; i++) {
> +        AHCIDevice *ad = &s->dev[i];
> +
> +        ide_unregister_restart_cb(&ad->port);
> +        ide_exit(&ad->port);
> +    }
>      g_free(s->dev);
>  }
>  
> 

I couldn't actually prove to myself that ahci_uninit runs on an unplug
request. Did you observe improvements to the memory profile after
introducing this patch?

I don't think anyone has taken the care to plumb AHCI to behave well
when hotplugged.

--js
