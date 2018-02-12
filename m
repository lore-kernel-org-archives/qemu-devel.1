Received: from eggs.gnu.org ([2001:4830:134:3::10]:57002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1elKzQ-0008Uj-FR
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1elKzM-0002lC-HV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:46:16 -0500
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:44683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1elKzM-0002kM-AH
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:46:12 -0500
Received: by mail-qk0-x236.google.com with SMTP id n188so19971955qkn.11
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 12:46:12 -0800 (PST)
Date: Mon, 12 Feb 2018 15:46:09 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20180212204609.GB30111@morn.lan>
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
> The PPI device in this patch series allocates 0x400 bytes. 0x200 bytes are
> used by the OperationRegion() in this patch series. The rest was thought of
> for future extensions.
>
> To allow both firmwares to use PPI, we would need to be able to have the
> OperationRegion() be flexible and located at 0xFFFF 0000 for EDK2 and 0xFED4
> 5000 for SeaBIOS, per choice of the firmware. One way to achieve this would
> be to have the firmwares choose their operation region base address by
> writing into the PPI memory device at offset 0x200 (for example). A '1'
> there would mean that we want the OperationRegion() at 0xFFFF 0000, and a
> '2' would mean at the base address of the PPI device (0xFED4 5000). This
> could be achieved by declaring a 2nd OperationRegion() in the ACPI code that
> is located at 0xFED4 5200 and we declare that 1st OperationRegion()'s
> address based on findings from there. Further, a flags variable at offset
> 0x201 could indicate whether an SMI is needed to enter SMM or not.
> Obviously, the ACPI code would become more complex to be able to support
> both firmwares at the same time.
>
> This is a lot of details but I rather post this description before posting
> more patches. To make these changes and get it to work with at least SeaBIOS
> is probably fairly easy. But is this acceptable?

I'm not sure I fully understand the goals of the PPI interface.
Here's what I understand so far:

The TPM specs define some actions that are considered privileged.  An
example of this would be disabling the TPM itself.  In order to
prevent an attacker from performing these actions without
authorization, the TPM specs define a mechanism to assert "physical
presence" before the privileged action can be done.  They do this by
having the firmware present a menu during early boot that permits
these privileged operations, and then the firmware locks the TPM chip
so the actions can no longer be done by any software that runs after
the firmware.  Thus "physical presence" is asserted by demonstrating
one has console access to the machine during early boot.

The PPI spec implements a work around for this - presumably some found
the enforcement mechanism too onerous.  It allows the OS to provide a
request code to the firmware, and on the next boot the firmware will
take the requested action before it locks the chip.  Thus allowing the
OS to indirectly perform the privileged action even after the chip has
been locked.  Thus, the PPI system seems to be an "elaborate hack" to
allow users to circumvent the physical presence mechanism (if they
choose to).

Here's what I understand the proposed implementation involves:

1 - in addition to emulating the TPM device itself, QEMU will also
    introduce a virtual memory device with 0x400 bytes.

2 - on first boot the firmware (seabios and uefi) will populate the
    memory region created in step 1.  In particular it will fill an
    array with the list of request codes it supports.  (Each request
    is an 8bit value, the array has 256 entries.)

3 - QEMU will produce AML code implementing the standard PPI ACPI
    interface.  This AML code will take the request, find the table
    produced in step 1, compare it to the list of accepted requests
    produced in step 2, and then place the 8bit request in another
    qemu virtual memory device (at 0xFFFF0000 or 0xFED45000).

4 - the OS will signal a reboot, qemu will do its normal reboot logic,
    and the firmware will be run again.

5 - the firmware will extract the code written in stage 3, and if the
    tpm device has been configured to accept PPI codes from the OS, it
    will invoke the requested action.

Did I understand the above correctly?

Separately, is there someone clamoring for PPI support today?  That
is, is the goal to implement PPI to make QEMU more spec compliant, or
is there someone struggling to perform a particular task today that
this support would improve?

Thanks,
-Kevin
