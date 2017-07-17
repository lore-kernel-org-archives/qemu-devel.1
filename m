Received: from eggs.gnu.org ([2001:4830:134:3::10]:44506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXA3p-0006bJ-Gw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXA3m-0005tb-Td
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXA3m-0005st-Kl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:43:54 -0400
Date: Mon, 17 Jul 2017 14:43:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170717174348.GV6020@localhost.localdomain>
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500025208-14827-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170714180907.GM6020@localhost.localdomain>
	<9584b0c7-96f4-f000-e53f-93accd8a39ad@redhat.com>
	<20170714185616.GQ6020@localhost.localdomain>
	<c838ca67-24a3-aff3-2a42-0f106fa2d898@ilande.co.uk>
	<20170717130311.4e9d7238@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717130311.4e9d7238@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laszlo Ersek <lersek@redhat.com>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com

On Mon, Jul 17, 2017 at 01:03:11PM +0200, Igor Mammedov wrote:
> On Sun, 16 Jul 2017 20:12:13 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
> > On 14/07/17 19:56, Eduardo Habkost wrote:
> > 
> > >>> Why do you need the full struct declaration to be exposed in the
> > >>> header?  
> > >>
> > >> Different board code wants to hook up "comb_iomem" manually to different
> > >> address spaces, so they need to access the field directly. This is the
> > >> ultimate goal of the entire exercise, IIRC.  
> > 
> > Yes, that is correct (and I believe is mentioned in the cover letter, too).
> > 
> > >>> The memory regions are supposed to be visible as QOM
> > >>> children to the fw_cfg device, already.  
> > >>
> > >> I don't understand this. How else can board code work with "comb_iomem"
> > >> than described above? If there is a way, I agree it would be preferable.  
> > > 
> > > object_resolve_path_component(fw_cfg, "fwcfg[0]") and
> > > object_resolve_path_component(fw_cfg, "fwcfg.dma[0]") should
> > > return fw_cfg->comb_iomem and fw_cfg->dma_iomem, respectively.
> > > 
> > > I don't know why those names were chosen, though.  Probably it's
> > > a good idea to call object_property_add_child() manually with
> > > more appropriate names inside the fw_cfg code instead of letting
> > > memory_region_init() pick the child name.  
> > 
> > That's interesting. I did a grep of the codebase for
> > object_resolve_path_component and struggled to find an instance where it
> > was being used to provide access to a MemoryRegion. Even if it's an
> > available feature, it's certainly not one that is widely known about.
> Agreed,
> 
> we haven't used suggested approach before and I don't see
> benefits it will bring in fwcfg case.
> 
> Eduardo,
> 
> Could you just apply v9, which seems to be good enough and
> does the intended job before 2.10 goes into soft-freeze?
> we always could do object_resolve_path_component() on top
> if it makes sense.

I was hoping Michael would apply it (as fw_cfg is currently
closer to PC code than to i386 or machine core).  But I can apply
it if he didn't queue it yet.

-- 
Eduardo
