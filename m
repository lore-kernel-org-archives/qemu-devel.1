Received: from eggs.gnu.org ([2001:4830:134:3::10]:57152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciKAa-0006aQ-5A
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciKAW-0007dI-0F
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:12:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57616
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1ciKAV-0007dB-Pf
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:12:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RC5WAm082407
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:12:41 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u863kew2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:12:41 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 27 Feb 2017 12:12:39 -0000
Date: Mon, 27 Feb 2017 13:12:34 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <64a9099a-717d-230c-fa58-5757186f5791@redhat.com>
References: <20170223122025.10420-1-cornelia.huck@de.ibm.com>
	<20170223122025.10420-2-cornelia.huck@de.ibm.com>
	<64a9099a-717d-230c-fa58-5757186f5791@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170227131234.5c859d05.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] elf-loader: Allow late loading of
 elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Farhan Ali <alifm@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com

On Sat, 25 Feb 2017 07:05:27 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 23.02.2017 13:20, Cornelia Huck wrote:
> > From: Farhan Ali <alifm@linux.vnet.ibm.com>
> > 
> > The current QEMU ROM infrastructure rejects late loading of ROMs.
> > And ELFs are currently loaded as ROM, this prevents delayed loading
> > of ELFs. So when loading ELF, allow the user to specify if ELF should
> > be loaded as ROM or not.
> > 
> > If an ELF is not loaded as ROM, then they are not restored on a
> > guest reboot/reset and so its upto the user to handle the reloading.
> > 
> > Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> > Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/core/loader.c     | 17 +++++++++++++++--
> >  include/hw/elf_ops.h | 13 +++++++++----
> >  include/hw/loader.h  | 13 ++++++++++++-
> >  3 files changed, 36 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index ee5abd6eb7..9d1af1f6f3 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -435,6 +435,19 @@ int load_elf_as(const char *filename,
> >                  uint64_t *highaddr, int big_endian, int elf_machine,
> >                  int clear_lsb, int data_swab, AddressSpace *as)
> >  {
> > +    return load_elf_ram(filename, translate_fn, translate_opaque,
> > +                        pentry, lowaddr, highaddr, big_endian, elf_machine,
> > +                        clear_lsb, data_swab, as, true);
> > +}
> > +
> > +/* return < 0 if error, otherwise the number of bytes loaded in memory */
> > +int load_elf_ram(const char *filename,
> > +                 uint64_t (*translate_fn)(void *, uint64_t),
> > +                 void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
> > +                 uint64_t *highaddr, int big_endian, int elf_machine,
> > +                 int clear_lsb, int data_swab, AddressSpace *as,
> > +                 bool load_rom)
> > +{
> >      int fd, data_order, target_data_order, must_swab, ret = ELF_LOAD_FAILED;
> >      uint8_t e_ident[EI_NIDENT];
> 
> <bikeshedpaintingsofeelfreetoignoreme>
> 
> The patch looks basically fine to me, but I think it's a little bit
> confusing to have a function called load_elf_ram() which can also be
> used to load ROMs with a load_rom=1 parameter. If I read
> "load_elf_ram()", I'd expect a function that can only read ELFs to RAM.
> So what about adding the "load_rom" parameter to load_elf_as() instead
> and then making load_elf_ram() a wrapper function to that one with
> load_rom=0 ? AFAICS there is only one additional caller to load_elf_as
> (in the generic-loader), so the additional effort here should be OK, I
> think.
> 
> </bikeshedpaintingsofeelfreetoignoreme>
> 
>  Thomas
> 

I think both approaches are fine, but I'd prefer to keep the bikeshed
colour to avoid a re-spin :)
