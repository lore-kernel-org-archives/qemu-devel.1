Received: from eggs.gnu.org ([2001:4830:134:3::10]:52298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dX3oD-0000ge-8a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dX3oA-0007Qp-MZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:03:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dX3oA-0007QV-Ga
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:03:22 -0400
Date: Mon, 17 Jul 2017 13:03:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170717130311.4e9d7238@nial.brq.redhat.com>
In-Reply-To: <c838ca67-24a3-aff3-2a42-0f106fa2d898@ilande.co.uk>
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500025208-14827-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170714180907.GM6020@localhost.localdomain>
	<9584b0c7-96f4-f000-e53f-93accd8a39ad@redhat.com>
	<20170714185616.GQ6020@localhost.localdomain>
	<c838ca67-24a3-aff3-2a42-0f106fa2d898@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv9 3/3] fw_cfg: move QOM type defines and
 fw_cfg types into fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com

On Sun, 16 Jul 2017 20:12:13 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 14/07/17 19:56, Eduardo Habkost wrote:
> 
> >>> Why do you need the full struct declaration to be exposed in the
> >>> header?  
> >>
> >> Different board code wants to hook up "comb_iomem" manually to different
> >> address spaces, so they need to access the field directly. This is the
> >> ultimate goal of the entire exercise, IIRC.  
> 
> Yes, that is correct (and I believe is mentioned in the cover letter, too).
> 
> >>> The memory regions are supposed to be visible as QOM
> >>> children to the fw_cfg device, already.  
> >>
> >> I don't understand this. How else can board code work with "comb_iomem"
> >> than described above? If there is a way, I agree it would be preferable.  
> > 
> > object_resolve_path_component(fw_cfg, "fwcfg[0]") and
> > object_resolve_path_component(fw_cfg, "fwcfg.dma[0]") should
> > return fw_cfg->comb_iomem and fw_cfg->dma_iomem, respectively.
> > 
> > I don't know why those names were chosen, though.  Probably it's
> > a good idea to call object_property_add_child() manually with
> > more appropriate names inside the fw_cfg code instead of letting
> > memory_region_init() pick the child name.  
> 
> That's interesting. I did a grep of the codebase for
> object_resolve_path_component and struggled to find an instance where it
> was being used to provide access to a MemoryRegion. Even if it's an
> available feature, it's certainly not one that is widely known about.
Agreed,

we haven't used suggested approach before and I don't see
benefits it will bring in fwcfg case.

Eduardo,

Could you just apply v9, which seems to be good enough and
does the intended job before 2.10 goes into soft-freeze?
we always could do object_resolve_path_component() on top
if it makes sense.


> 
> In terms of the patch, is the v9 revision suitable for commit or does
> this constitute a NACK?
> 
> 
> ATB,
> 
> Mark.
