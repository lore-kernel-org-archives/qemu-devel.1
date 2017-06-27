Received: from eggs.gnu.org ([2001:4830:134:3::10]:53576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dPtlD-00084h-6L
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dPt6n-0004mx-U0
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:13:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55537
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dPt6n-0004mV-MC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:12:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5RG8ulD111944
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 12:12:56 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bbqym8yct-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 12:12:55 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 27 Jun 2017 12:12:55 -0400
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 12:12:50 -0400
MIME-Version: 1.0
In-Reply-To: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>

On 06/14/2017 09:51 AM, Laszlo Ersek wrote:
> Hi Stefan,
>
> the MAINTAINERS file doesn't seem to cover any of the TPM-related files
> in the tree:
>
>    backends/tpm.c
>    hw/tpm/
>    include/hw/acpi/tpm.h
>    include/sysemu/tpm*
>    tpm.c
>
> but I have a gut feeling that you are semi-officially maintaining TPM
> anyway, so I'm going to ask you. :)
>
> Can you please write a document, to be placed under docs/specs/, that
> describes the TPM device from a guest perspective, also explaining how
> the guest-visible bits are connected to (current) TPM backend(s)?
>
> The document wouldn't have to be very long; I think all standardized
> interfaces could be mentioned by reference only (by spec names and
> locations). The document should however describe any QEMU specifics, and
> how the relevant specs are brought together in the implementation.
>
> Some text files I'm familiar with and can recommend as examples:
> - docs/specs/fw_cfg.txt
> - docs/specs/pvpanic.txt
> - docs/specs/vmgenid.txt
>
> (There may be more and/or better examples of course.)
>
> This document should be the starting point for developers that want to
> support QEMU's TPM(s) in guest firmware that is different from SeaBIOS.
> (You've been maintaining the related SeaBIOS feature.)
>
> Would you be willing to author such a design document?

Here's what I have so far with pointers to TCG specs. Does that go in 
the right direction?


QEMU TPM Device
===============

= Guest-side Hardware Interface =

The QEMU TPM emulation implements a TPM TIS hardware interface following
the Trusted Computing Group's specification "TCG PC Client Specific TPM
Interface Specification (TIS)", Specifcation Version 1.3, 21 March 2013.
This specification, or a later version of it, can be accessed from the
following URL:

https://trustedcomputinggroup.org/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/

The TIS interface makes a memory mapped IO region in the area 0xfed40000 -
0xfed44fff available to the guest operating system.

= ACPI Interface =

The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and 
passes
it into the guest through the fw_cfg device. The device description contains
the base address of the TIS interface  0xfed40000 and the size of the 
MMIO area
(0x5000). In case a TPM2 is used by QEMU, a TPM2 ACPI table is also 
provided. The
device is described to be used in polling mode rather than interrupt 
mode primarily
because no unused IRQ could be found.

To support measurements logs to be written by the firmware, e.g. 
SeaBIOS, a TCPA
table is implemented. This table provides a 64kb buffer where the 
firmware can
write its log into.

The TCPA and TPM2 ACPI tables follow the Trusted Computing Group 
specification
"TCG ACPI Specification" Family "1.2" and "2.0", Level 00 Revision 
00.37. This
specification, or a later version of it, can be accessed from the following
URL:

https://trustedcomputinggroup.org/tcg-acpi-specification/


= TPM backend devices =

The TPM implementation is split into two parts. The one part is the hardware
interface, such as the TPM TIS interface described earlier, and the TPM 
backend
interface. The backend interfaces implement the interaction with a TPM 
device,
which may be a physical or an emulated device. The split between the front-
and backend devices allows a frontend to be connected with any available
backend. This enables the TIS interface to be used with the passthrough 
backend
or the (future) swtpm backend.


== The QEMU TPM passthrough device ==

In case QEMU is run on Linux as the host operating system it is possible to
make the hardware TPM device available to a single QEMU guest. In this 
case the
user must make sure that no other program is using the device, e.g., 
/dev/tpm0,
before trying to start QEMU with it.

The passthrough driver uses the host's TPM device for sending TPM commands
and receiving responses from. Besides that it accesses the TPM device's 
sysfs
entry for support of command cancellation. Since none of the state of a 
hardware
TPM can be migrated between hosts, virtual machine migration is disabled 
when
the TPM passthrough driver is used.

Since the host's TPM device will already be initialize by the host's 
firmware, certain
commands, e.g. TPM_Startup(), sent by the virtual firmware for device 
initialization
will fail. In this case the firmware should simply not use the TPM.

Sharing the device with the host is generally not a recommended usage 
scenario
for a TPM device. The primary reason for this is that two operating 
systems can then
access the device's single set of resources, such as platform configuration
registers (PCRs), that applications are not expecting to share.


>
> Thank you,
> Laszlo
>
