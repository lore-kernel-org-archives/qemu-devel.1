Received: from eggs.gnu.org ([2001:4830:134:3::10]:53200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87ii-0004JS-TX
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87id-0000bA-Va
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:42:56 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:51099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87id-0000aR-RG
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:42:51 -0400
Received: by mail-qt0-x241.google.com with SMTP id d9so9153707qtd.7
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:42:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <de8125f4-fb99-1f9e-f7a8-7f1f9c4f0b5a@amsat.org>
Date: Fri, 27 Oct 2017 13:42:43 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 00/13] sun4m: sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

Hi Mark,

On 10/25/2017 12:59 PM, Mark Cave-Ayland wrote:
> This patchset aims to tidy-up the sparc32_dma code by improving the
> modelling of the espdma/ledma devices using both QOM and the memory
> API which didn't exist when the code was first written.
> 
> The result is that it is now possible to remove both the iommu_opaque
> and is_ledma workarounds from the code, and the code for wiring up
> the espdma/ledma and respective devices is also a lot more readable.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The whole series:

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

If you don't accept my comments (or don't have time) about keeping
"hw/sparc/sparc32_dma.h" generic and moving network/scsi parts in
"hw/sparc/sun4m.h" you can still add to your series:

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Also while testing your series on a Debian image, I noted your series
results faster, I timed:

master: 104s
your series: 85s (>20% faster!)

Regards,

Phil.

> 
> v4:
> - Rebase onto git master
> - Update patch 9 to move lance QOM macros/SysBusPCNetState from sun4m.h to lance.h as suggested by Peter
> - Add Reviewed-by from Peter for patch 7
> 
> v3:
> - Add missing sysbus.h include to esp.h in patch 7
> 
> v2:
> - Make esp/lance devices children of espdma/ledma devices respectively
> - Add len parameter to ledma/espdma tracepoints
> 
> 
> Mark Cave-Ayland (13):
>   sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
>   sparc32_dma: split esp and le into separate DMA devices
>   sparc32_dma: move type declarations from sparc32_dma.c to
>     sparc32_dma.h
>   sun4m: move DMA device wiring from sparc32_dma_init() to
>     sun4m_hw_init()
>   sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
>   sparc32_dma: use object link instead of qdev property to pass IOMMU
>     reference
>   esp: move TYPE_ESP and SysBusESPState from esp.c to esp.h
>   sparc32_dma: make esp device child of espdma device
>   lance: move TYPE_LANCE and SysBusPCNetState from lance.c to lance.h
>   sparc32_dma: make lance device child of ledma device
>   sparc32_dma: introduce new SPARC32_DMA type container object
>   sparc32_dma: remove is_ledma hack and replace with memory region
>     alias
>   sparc32_dma: add len to esp/le DMA memory tracing
> 
>  hw/dma/sparc32_dma.c           |  235 +++++++++++++++++++++++++++++-----------
>  hw/dma/sun4m_iommu.c           |   14 ---
>  hw/dma/trace-events            |    8 +-
>  hw/net/lance.c                 |   11 +-
>  hw/scsi/esp.c                  |   13 ---
>  hw/sparc/sun4m.c               |   82 ++++++--------
>  include/hw/net/lance.h         |   41 +++++++
>  include/hw/scsi/esp.h          |   14 +++
>  include/hw/sparc/sparc32_dma.h |   55 ++++++++++
>  include/hw/sparc/sun4m.h       |   16 +++
>  10 files changed, 336 insertions(+), 153 deletions(-)
>  create mode 100644 include/hw/net/lance.h
> 
