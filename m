Received: from eggs.gnu.org ([2001:4830:134:3::10]:34277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pjones@redhat.com>) id 1dQEnV-0004UQ-3n
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pjones@redhat.com>) id 1dQEnR-0002D9-Tx
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pjones@redhat.com>) id 1dQEnR-0002CR-LJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:22:25 -0400
Date: Wed, 28 Jun 2017 11:22:15 -0400
From: Peter Jones <pjones@redhat.com>
Message-ID: <20170628152214.3qhegqrjfpfh2sgs@redhat.com>
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>

On Tue, Jun 27, 2017 at 12:12:50PM -0400, Stefan Berger wrote:
> On 06/14/2017 09:51 AM, Laszlo Ersek wrote:
> > Hi Stefan,
> > 
> > the MAINTAINERS file doesn't seem to cover any of the TPM-related files
> > in the tree:
> > 
> >    backends/tpm.c
> >    hw/tpm/
> >    include/hw/acpi/tpm.h
> >    include/sysemu/tpm*
> >    tpm.c
> > 
> > but I have a gut feeling that you are semi-officially maintaining TPM
> > anyway, so I'm going to ask you. :)
> > 
> > Can you please write a document, to be placed under docs/specs/, that
> > describes the TPM device from a guest perspective, also explaining how
> > the guest-visible bits are connected to (current) TPM backend(s)?
> > 
> > The document wouldn't have to be very long; I think all standardized
> > interfaces could be mentioned by reference only (by spec names and
> > locations). The document should however describe any QEMU specifics, and
> > how the relevant specs are brought together in the implementation.
> > 
> > Some text files I'm familiar with and can recommend as examples:
> > - docs/specs/fw_cfg.txt
> > - docs/specs/pvpanic.txt
> > - docs/specs/vmgenid.txt
> > 
> > (There may be more and/or better examples of course.)
> > 
> > This document should be the starting point for developers that want to
> > support QEMU's TPM(s) in guest firmware that is different from SeaBIOS.
> > (You've been maintaining the related SeaBIOS feature.)
> > 
> > Would you be willing to author such a design document?
> 
> Here's what I have so far with pointers to TCG specs. Does that go in the
> right direction?
> 
> 
> QEMU TPM Device
> ===============
> 
> = Guest-side Hardware Interface =
> 
> The QEMU TPM emulation implements a TPM TIS hardware interface following
> the Trusted Computing Group's specification "TCG PC Client Specific TPM
> Interface Specification (TIS)", Specifcation Version 1.3, 21 March 2013.
> This specification, or a later version of it, can be accessed from the
> following URL:
> 
> https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> 
> The TIS interface makes a memory mapped IO region in the area 0xfed40000 -
> 0xfed44fff available to the guest operating system.
> 
> = ACPI Interface =
> 
> The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT
> and passes it into the guest through the fw_cfg device. The device
> description contains the base address of the TIS interface  0xfed40000
> and the size of the MMIO area (0x5000). In case a TPM2 is used by
> QEMU, a TPM2 ACPI table is also provided. The device is described to
> be used in polling mode rather than interrupt mode primarily because
> no unused IRQ could be found.
> 
> To support measurements logs to be written by the firmware, e.g.
> SeaBIOS, a TCPA table is implemented. This table provides a 64kb
> buffer where the firmware can write its log into.

How does this work if we boot with edk2?  Do we get what's described in 
https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
instead of this interface?  As well as it?  It'd be good to have some
text about this here.

-- 
  Peter
