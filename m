Received: from eggs.gnu.org ([2001:4830:134:3::10]:36742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1cK58d-0003b2-T1
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1cK58d-0005UW-3v
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:18:35 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1cK58c-0005UK-UH
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:18:35 -0500
Received: by mail-wm0-x236.google.com with SMTP id g23so178431611wme.1
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 07:18:34 -0800 (PST)
Date: Thu, 22 Dec 2016 15:18:31 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20161222151831.GE16872@bivouac.eciton.net>
References: <20161216152319.12494-1-leif.lindholm@linaro.org>
	<20161221115102.251224b8@nial.brq.redhat.com>
	<20161221123509.GC16872@bivouac.eciton.net>
	<20161221145934.219d73fd@nial.brq.redhat.com>
	<d0a8813e-1407-f6a7-a70e-387071aed93a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a8813e-1407-f6a7-a70e-387071aed93a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] smbios: stop ignoring command line options
 for TARGET_ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On Wed, Dec 21, 2016 at 06:58:44PM +0100, Paolo Bonzini wrote:
> On 21/12/2016 14:59, Igor Mammedov wrote:
> >> Apparently a misunderstanding of the underlying command line handling
> >> mechanics.
> >>
> >>> Also this patch would break build for targets that don't link smbios.c
> >>> (i.e. which don't have CONFIG_SMBIOS=y)  
> >> 
> >> Ah, I hadn't spotted that - apologies.
> > 
> > Just do 1 build for all targets before posting patches to avoid
> > such kind of errors.
> > 
> >> So a simpler, and more correct fix would rather be to change the
> >> #ifdef TARGET_I386
> >> in arch_init.c to
> >> #ifdef CONFIG_SMBIOS
> > 
> > it looks better to me than enumerating targets explicitly,
> > CCing Paolo for another opinion
> 
> I don't think CONFIG_SMBIOS is visible from C, is it?

No.
(A bit of context that was drop asked:
"... if there had been a conveniently available CONFIG_SMBIOS.
Would it be acceptable to add one to config-target.h or is that
reserved for host-specific options?"
But that doesn't matter now.)

> However, the solution is to:
> 
> 1) add a smbios-stub.c file to hw/smbios, containing a dummy
> implementation of smbios_entry_add.  For the Makefile magic see
> hw/pci/Makefile.objs.
> 
> 2) add an Error * argument to smbios_entry_add, and make the stub
> version fail
> 
> 3) remove do_smbios_option altogether, and make vl.c call
> smbios_entry_add directly.

Many thanks for the pointers, I've done just that and am sending it
out (as a new patch rather than a v2 because ... it bears no
resemblance to the first one).

Regards,

Leif
