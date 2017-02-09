Received: from eggs.gnu.org ([2001:4830:134:3::10]:57142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cbtLd-0004nw-E6
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cbtLa-0004rb-0p
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:21:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cbtLZ-0004rV-P8
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:21:33 -0500
Date: Thu, 9 Feb 2017 20:21:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170209201918-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
	<20170209182316.71d5df5f@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170209182316.71d5df5f@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, ben@skyportsystems.com, qemu-devel@nongnu.org

On Thu, Feb 09, 2017 at 06:23:16PM +0100, Igor Mammedov wrote:
> On Wed, 8 Feb 2017 01:48:42 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
> > On 02/05/17 10:12, ben@skyportsystems.com wrote:
> > > From: Ben Warren <ben@skyportsystems.com>
> [...]
> 
> > (2) Structure of the vmgenid fw_cfg blob, AKA "why that darn offset 40
> > decimal".
> > 
> > I explained it under points (6) and (7) in the following message:
> > 
> > Message-Id: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com>
> > URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.html
> > 
> > The story is that *wherever* an ADD_POINTER command points to -- that
> > is, at the *exact* target address --, OVMF will look for an ACPI table
> > header, somewhat heuristically. If it finds a byte pattern that (a) fits
> > into the remaining blob and (b) passes some superficial ACPI table
> > header checks, such as length and checksum, then OVMF assumes that the
> > blob contains an ACPI table there, and passes the address (again, the
> > exact, relocated, absolute target address of ADD_POINTER) to
> > EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable().
> > 
> > We want to disable this heuristic for the vmgenid blob. *If* the blob
> > contained only 16 bytes (for the GUID), then the heuristic would
> > automatically disable itself, because the ACPI table header (36 bytes)
> > is larger than 16 bytes, so OVMF wouldn't even look. However, for the
> > caching and other VMGENID requirements, we need to allocate a full page
> > with the blob (4KB), hence OVMF *will* look. If we placed the GUID right
> > at the start of the page, then OVMF would sanity-check it as an ACPI
> > table header. The check would *most likely* not pass, so things would be
> > fine in practice, but we can do better than that: just put 40 zero bytes
> > at the front of the blob.
> > 
> > And this is why the ADD_POINTER command has to point to the beginning of
> > the blob (i.e., 36 zero bytes), to "suppress the OVMF ACPI SDT header
> > detection". (The other 4 bytes are for arriving at an address divisible
> > by 8, which is a VMGENID requirement for the GUID.)
> > 
> > The consequence is that both the ADDR method and QEMU's guest memory
> > access code have to add 40 manually.
> The longer I look "suppress the OVMF ACPI SDT header detection",
> the less I like approach.
> 
> It looks somewhat backwards where a firmware forces QEMU
> to use non obvious offsets to workaround OVMF ACPI table detection
> heuristics.
> Can we add and use explicit flag to mark blobs as ACPI tables,
> so that OVMF won't have to guess whether to hand off table
> as ACPI to UEFI stack or just keep it to yourself?

Seems like the minor enough hack.

At this stage I'm inclined to say let's merge with the current approach,
and we can do a patch on top if we have the time.

> 
> [...]
> > Thanks
> > Laszlo
> > 
