Received: from eggs.gnu.org ([2001:4830:134:3::10]:41620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1elgOy-0005dG-CU
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1elgOv-0005KP-8S
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:38:04 -0500
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:40939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1elgOv-0005Js-1G
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:38:01 -0500
Received: by mail-qk0-x230.google.com with SMTP id e20so23834389qkm.7
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 11:38:00 -0800 (PST)
Date: Tue, 13 Feb 2018 14:37:58 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20180213193758.GA21083@morn.lan>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212204609.GB30111@morn.lan>
	<b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
	<e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>

On Tue, Feb 13, 2018 at 05:16:49PM +0100, Laszlo Ersek wrote:
> On 02/12/18 21:49, Stefan Berger wrote:
> > On 02/12/2018 03:46 PM, Kevin O'Connor wrote:
> >> I'm not sure I fully understand the goals of the PPI interface.
> >> Here's what I understand so far:
> >>
> >> The TPM specs define some actions that are considered privileged.  An
> >> example of this would be disabling the TPM itself.  In order to
> >> prevent an attacker from performing these actions without
> >> authorization, the TPM specs define a mechanism to assert "physical
> >> presence" before the privileged action can be done.  They do this by
> >> having the firmware present a menu during early boot that permits
> >> these privileged operations, and then the firmware locks the TPM chip
> >> so the actions can no longer be done by any software that runs after
> >> the firmware.  Thus "physical presence" is asserted by demonstrating
> >> one has console access to the machine during early boot.
> >>
> >> The PPI spec implements a work around for this - presumably some found
> >> the enforcement mechanism too onerous.  It allows the OS to provide a
> >> request code to the firmware, and on the next boot the firmware will
> >> take the requested action before it locks the chip.  Thus allowing the
> >> OS to indirectly perform the privileged action even after the chip has
> >> been locked.  Thus, the PPI system seems to be an "elaborate hack" to
> >> allow users to circumvent the physical presence mechanism (if they
> >> choose to).
> > 
> > Correct.
> >>
> >> Here's what I understand the proposed implementation involves:
> >>
> >> 1 - in addition to emulating the TPM device itself, QEMU will also
> >>      introduce a virtual memory device with 0x400 bytes.
> > Correct.
> >>
> >> 2 - on first boot the firmware (seabios and uefi) will populate the
> >>      memory region created in step 1.  In particular it will fill an
> >>      array with the list of request codes it supports.  (Each request
> >>      is an 8bit value, the array has 256 entries.)
> > Correct. Each firmware would fill out the 256 byte array depending on
> > what it supports. The 8 bit values are basically flags and so on.
> >> 3 - QEMU will produce AML code implementing the standard PPI ACPI
> >>      interface.  This AML code will take the request, find the table
> >>      produced in step 1, compare it to the list of accepted requests
> >>      produced in step 2, and then place the 8bit request in another
> >>      qemu virtual memory device (at 0xFFFF0000 or 0xFED45000).
> > 
> > Correct.
> > 
> > Now EDK2 wants to store the code in a UEFI variable in NVRAM. We
> > therefore would need to trigger an SMI. In SeaBIOS we wouldn't have to
> > do this.
> > 
> >> 4 - the OS will signal a reboot, qemu will do its normal reboot logic,
> >>      and the firmware will be run again.
> >>
> >> 5 - the firmware will extract the code written in stage 3, and if the
> >>      tpm device has been configured to accept PPI codes from the OS, it
> >>      will invoke the requested action.
> > 
> > SeaBIOS would look into memory to find the code. EDK2 will read the code
> > from a UEFI variable.
> > 
> >> Did I understand the above correctly?
> > I think so. With the fine differences between SeaBIOS and EDK2 pointed out.
> 
> Here's what I suggest:
> 
> Please everyone continue working on this, according to Kevin's &
> Stefan's description, but focus on QEMU and SeaBIOS *only*. Ignore edk2
> for now.

If this were targetted at SeaBIOS, I'd look for a simpler
QEMU/firmware interface.  Something like:

A - QEMU produces AML code implementing the standard PPI ACPI
    interface that generates a request code and stores it in the
    device memory of an existing device (eg, writable fw_cfg or an
    extension field in the existing emulated TPM device).

B - after a reboot the firmware extracts the PPI request code
    (produced in step A) and performs the requested action (if the TPM
    is configured to accept OS generated codes).

That is, skip steps 1 and 2 from the original proposal.

-Kevin
