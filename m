Received: from eggs.gnu.org ([2001:4830:134:3::10]:60040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cGpto-00023I-NW
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cGptm-0002hg-1H
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:25:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cGptl-0002hO-S1
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:25:49 -0500
Date: Tue, 13 Dec 2016 18:25:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161213181733-mutt-send-email-mst@kernel.org>
References: <1480677386-16192-1-git-send-email-ppandit@redhat.com>
	<alpine.LFD.2.20.1612131541330.4886@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1612131541330.4886@wniryva>
Subject: Re: [Qemu-devel] [PATCH] i386: amd_iommu: fix MMIO register count
 and access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Azureyang <azureyang@tencent.com>

On Tue, Dec 13, 2016 at 03:42:13PM +0530, P J P wrote:
> +-- On Fri, 2 Dec 2016, P J P wrote --+
> | IOMMU MMIO registers are divided in two groups by their offsets.
> | Low offsets(<0x2000) registers are grouped into 'amdvi_mmio_low'
> | table and higher offsets(>=0x2000) registers are grouped into
> | 'amdvi_mmio_high' table. No of registers in each table is given
> | by macro 'AMDVI_MMIO_REGS_LOW' and 'AMDVI_MMIO_REGS_HIGH' resp.
> | Values of these two macros were swapped, resulting in an OOB
> | access when reading 'amdvi_mmio_high' table. Correct these two
> | macros. Also read from 'amdvi_mmio_low' table for lower address.
> | 
> | Reported-by: Azureyang <azureyang@tencent.com>
> | Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> | ---
> |  hw/i386/amd_iommu.c | 2 +-
> |  hw/i386/amd_iommu.h | 4 ++--
> |  2 files changed, 3 insertions(+), 3 deletions(-)
> | 
> | diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> | index 47b79d9..e0732cc 100644
> | --- a/hw/i386/amd_iommu.c
> | +++ b/hw/i386/amd_iommu.c
> | @@ -562,7 +562,7 @@ static void amdvi_mmio_trace(hwaddr addr, unsigned size)
> |          trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
> |      } else {
> |          index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
> | -        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
> | +        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
> |      }
> |  }
> |  
> | diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> | index 884926e..0d3dc6a 100644
> | --- a/hw/i386/amd_iommu.h
> | +++ b/hw/i386/amd_iommu.h
> | @@ -49,8 +49,8 @@
> |  #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
> |  
> |  /* No. of used MMIO registers */
> | -#define AMDVI_MMIO_REGS_HIGH  8
> | -#define AMDVI_MMIO_REGS_LOW   7
> | +#define AMDVI_MMIO_REGS_HIGH  7
> | +#define AMDVI_MMIO_REGS_LOW   8
> |  
> |  /* MMIO registers */
> |  #define AMDVI_MMIO_DEVICE_TABLE       0x0000
> 
> 
> Ping..!


Sorry missed 2.8. Wil be in 2.8.1
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
