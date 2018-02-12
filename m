Received: from eggs.gnu.org ([2001:4830:134:3::10]:33223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1elK2n-0006CD-06
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1elK2i-0004kB-5w
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:45:41 -0500
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:41689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1elK2h-0004iH-LO
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:45:36 -0500
Received: by mail-qt0-x231.google.com with SMTP id a9so949723qtj.8
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:45:33 -0800 (PST)
Date: Mon, 12 Feb 2018 14:45:31 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20180212194531.GA26349@morn.lan>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, lersek@redhat.com, mst@redhat.com

On Fri, Feb 09, 2018 at 03:19:31PM -0500, Stefan Berger wrote:
> I have played around with this patch and some modifications to EDK2. Though
> for EDK2 the question is whether to try to circumvent their current
> implementation that uses SMM or use SMM. With this patch so far I circumvent
> it, which is maybe not a good idea.
> 
> The facts for EDK2's PPI:
> 
> - from within the OS a PPI code is submitted to ACPI and ACPI enters SMM via
> an SMI and the PPI code is written into a UEFI variable. For this ACPI uses
> the memory are at 0xFFFF 0000 to pass parameters from the OS (via ACPI) to
> SMM. This is declared in ACPI with an OperationRegion() at that address.
> Once the machine is rebooted, UEFI reads the variable and finds the PPI code
> and reacts to it.

I'm a bit confused by this.  The top 1M of the first 4G of ram is
generally mapped to the flash device on real machines.  Indeed, this
is part of the mechanism used to boot an X86 machine - it starts
execution from flash at 0xfffffff0.  This is true even on modern
machines.

So, it seems strange that UEFI is pushing a code through a memory
device at 0xffff0000.  I can't see how that would be portable.  Are
you sure the memory write to 0xffff0000 is not just a trigger to
invoke the SMI?

It sounds as if the ultimate TPM interface that must be supported is
the ACPI DSDT methods.  Since you're crafting the DSDT table yourself,
why does there need to be two different backends - why can't the same
mechanism be used for both SeaBIOS and UEFI?  Is this because you are
looking to reuse TPM code already in UEFI that requires a specific
interface?

-Kevin
