Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cqg36-0007Ki-M6
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cqg33-0002PP-Fw
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:11:36 -0400
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1490051325-3770-59-git-send-email-mdroth@linux.vnet.ibm.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <637f61f2-fcef-2ad9-c837-b30d00486516@redhat.com>
Date: Wed, 22 Mar 2017 09:11:30 -0400
MIME-Version: 1.0
In-Reply-To: <1490051325-3770-59-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 58/81] ahci: advertise HOST_CAP_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 03/20/2017 07:08 PM, Michael Roth wrote:
> From: Ladi Prosek <lprosek@redhat.com>
> 
> The AHCI emulation code supports 64-bit addressing and should advertise this
> fact in the Host Capabilities register. Both Linux and Windows drivers test
> this bit to decide if the upper 32 bits of various registers may be written
> to, and at least some versions of Windows have a bug where DMA is attempted
> with an address above 4GB but, in the absence of HOST_CAP_64, the upper 32
> bits are left unititialized which leads to a memory corruption.
> 
> [Maintainer edit:
> 
> This fixes https://bugzilla.redhat.com/show_bug.cgi?id=1411105,
> which affects Windows Server 2008 SP2 in some cases.]
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> Message-id: 1484305370-6220-1-git-send-email-lprosek@redhat.com
> [Amended commit message --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> (cherry picked from commit 98cb5dccb192b0082626080890dac413473573c6)
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/ide/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 3c19bda..6a17acf 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -488,7 +488,7 @@ static void ahci_reg_init(AHCIState *s)
>      s->control_regs.cap = (s->ports - 1) |
>                            (AHCI_NUM_COMMAND_SLOTS << 8) |
>                            (AHCI_SUPPORTED_SPEED_GEN1 << AHCI_SUPPORTED_SPEED) |
> -                          HOST_CAP_NCQ | HOST_CAP_AHCI;
> +                          HOST_CAP_NCQ | HOST_CAP_AHCI | HOST_CAP_64;
>  
>      s->control_regs.impl = (1 << s->ports) - 1;
>  
> 

A reminder that if this is backported to 2.8.1, that you will need to
include the relevant seaBIOS fixes as well. Otherwise, rebooting under
that firmware breaks!

--js
