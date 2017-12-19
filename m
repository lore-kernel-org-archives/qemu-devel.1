Received: from eggs.gnu.org ([2001:4830:134:3::10]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRCpT-0007ic-Mu
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRCpO-0001K8-AF
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:00:47 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:44371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eRCpO-0001JI-2A
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:00:42 -0500
Received: by mail-it0-x241.google.com with SMTP id b5so1745050itc.3
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 00:00:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 19 Dec 2017 09:00:20 +0100
Message-ID: <CACXAS8DRKEGkC8YFN4PFf1d7kGeerN6cNPcS94zk2YvNoVLgSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/8] sparc: IOMMU tidy-up and reorganisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sun, Nov 26, 2017 at 2:35 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Following on from the previous sun4u patchset, here is the next step of
> IOMMU-related updates for 2.12.
>
> This patchset does 2 main things: firstly it moves the sun4m IOMMU
> device out of hw/dma and into hw/sparc to match existing architectures.
> With this (and the previous sun4m DMA rework) the old sun4m.h header can
> now be completely removed.
>
> Secondly in a similar manner, we split the sun4u IOMMU functionality out
> from the APB device into a new sun4u-iommu device in hw/sparc64, adding in
> a conversion from DPRINTF macros to trace-events for good measure while
> we are here.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

> Based-on: 1511699686-12605-1-git-send-email-mark.cave-ayland@ilande.co.uk ([PATCHv2 00/15] sun4u: tidy-up CPU, APB and ebus)
>
>
> Mark Cave-Ayland (8):
>   sun4m: move sun4m_iommu.c from hw/dma to hw/sparc
>   sun4m: move IOMMU declarations from sun4m.h to sun4m_iommu.h
>   sun4m: remove include/hw/sparc/sun4m.h and all references to it
>   apb: QOMify IOMMU
>   sun4u: split IOMMU device out from apb.c to sun4u_iommu.c
>   sun4u_iommu: update to reflect IOMMU is no longer part of the APB
>     device
>   sun4u_iommu: convert from IOMMU_DPRINTF to trace-events
>   sun4u_iommu: add trace event for IOMMU translations
>
>  hw/dma/Makefile.objs           |    1 -
>  hw/dma/sparc32_dma.c           |    2 +-
>  hw/dma/sun4m_iommu.c           |  406 ---------------------------------------
>  hw/dma/trace-events            |   10 -
>  hw/intc/slavio_intctl.c        |    1 -
>  hw/net/lance.c                 |    2 +-
>  hw/pci-host/apb.c              |  256 +------------------------
>  hw/sparc/Makefile.objs         |    2 +-
>  hw/sparc/sun4m.c               |    2 +-
>  hw/sparc/sun4m_iommu.c         |  407 ++++++++++++++++++++++++++++++++++++++++
>  hw/sparc/trace-events          |   10 +
>  hw/sparc64/Makefile.objs       |    1 +
>  hw/sparc64/sun4u.c             |    8 +-
>  hw/sparc64/sun4u_iommu.c       |  342 +++++++++++++++++++++++++++++++++
>  hw/sparc64/trace-events        |    5 +
>  hw/timer/slavio_timer.c        |    1 -
>  include/hw/pci-host/apb.h      |   53 +-----
>  include/hw/sparc/sun4m.h       |   35 ----
>  include/hw/sparc/sun4m_iommu.h |   51 +++++
>  include/hw/sparc/sun4u_iommu.h |   50 +++++
>  20 files changed, 889 insertions(+), 756 deletions(-)
>  delete mode 100644 hw/dma/sun4m_iommu.c
>  create mode 100644 hw/sparc/sun4m_iommu.c
>  create mode 100644 hw/sparc64/sun4u_iommu.c
>  delete mode 100644 include/hw/sparc/sun4m.h
>  create mode 100644 include/hw/sparc/sun4m_iommu.h
>  create mode 100644 include/hw/sparc/sun4u_iommu.h
>
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
