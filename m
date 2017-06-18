Received: from eggs.gnu.org ([2001:4830:134:3::10]:44882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMVA5-0005rP-24
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dMVA0-0006OV-4q
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:02:21 -0400
Received: from chuckie.co.uk ([82.165.15.123]:56424
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dMV9z-0006J7-UI
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:02:16 -0400
References: <1497619387-11333-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497619387-11333-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<5aeecfd3-69be-eec2-240d-68624adb3ffc@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <cf548e13-3578-7786-b00c-66bd07da61bf@ilande.co.uk>
Date: Sun, 18 Jun 2017 09:01:51 +0100
MIME-Version: 1.0
In-Reply-To: <5aeecfd3-69be-eec2-240d-68624adb3ffc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 5/5] fw_cfg: move QOM type defines and
 fw_cfg types into fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On 16/06/17 22:28, Laszlo Ersek wrote:

> This patch is generally good, but I'd like to suggest improvements:
> 
> (1) In the commit message, please mention that we are exposing the
> internals of FWCfgIoState and FWCfgMemState so that board code can map
> the MemoryRegion fields (such as comb_iomem) *by name*.
> 
> (2) FWCfgEntry need not be moved from the C file to the header file,
> since we never depend on the *size* of that structure. Instead, please
> add a single line to "include/qemu/typedefs.h":
> 
>    typedef struct FWCfgEntry FWCfgEntry;
> 
> and modify
> 
>     typedef struct FWCfgEntry {
>     ...
>     } FWCfgEntry;
> 
> in "fw_cfg.c" to just
> 
>     struct FWCfgEntry {
>     ...
>     };
> 
> Then "fw_cfg.h" can simply include "typedefs.h" and say
> 
>     ...
>     FWCfgEntry *entries[2];
>     ...
> 
> IOW, it's fine to leave FWCfgEntry an incomplete type in "fw_cfg.h".
> 
> (3) When you fix up patch #1 like I requested, removing the
> "FWCfgIoState.iobase" and "FWCfgIoState.dma_iobase" fields, please don't
> forget to update this patch as well, so that you not re-introduce those
> fields in the header file.
> 
> ... I'm positively satisfied with this series (I plan to "grant" my R-b
> for PATCH v5 5/5, with the above updates), but given that I'm no QOM
> expert by any means, I'd like someone with more QOM experience to review
> the patchset as well.

Thanks for the feedback! I've just revised the patchset based upon your
comments and will post the v5 to the list shortly.


ATB,

Mark.
