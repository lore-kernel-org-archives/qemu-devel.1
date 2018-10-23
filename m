Received: from eggs.gnu.org ([2001:4830:134:3::10]:51409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF5XV-0002Au-Ri
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF5XS-0006My-4W
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:52:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gF5XQ-0005bR-KM
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:52:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id t10-v6so3410741wrn.10
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 15:52:10 -0700 (PDT)
References: <20181022183656.4902-1-sameo@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47cef9f2-b843-db42-efee-40b46620448b@redhat.com>
Date: Wed, 24 Oct 2018 00:52:06 +0200
MIME-Version: 1.0
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/27] ACPI hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org

On 22/10/2018 20:36, Samuel Ortiz wrote:
> This patch set implements support for the ACPI hardware-reduced
> specification.
> 
> The changes are coming from the NEMU [1] project where we're defining
> a new x86 machine type: i386/virt. This is an EFI only, ACPI
> hardware-reduced platform and as such we had to implement support
> for the latter.
> 
> As a preliminary for adding hardware-reduced support to QEMU, we did
> some ACPI code reorganization with the following goals:
> 
> * Share as much as possible of the current ACPI build APIs between
>   legacy and hardware-reduced ACPI.
> * Share the ACPI build code across machine types and architectures and
>   remove the typical PC machine type dependency.
>   Eventually we hope to see arm/virt also re-use much of that code.
> 
> The rest of the patchset adds the hardware-reduced support on top of
> this code reorganization. Here again, the implementation is machine
> type, platform and architecture independent.
> 
> [1] https://github.com/intel/nemu

I think the first part of the series is very valuable, and also the
FirmwareBuildMethods idea is good even though I have some comments on
how to model it in C.  It won't make it in 3.1, but I suppose you
expected that.

Including the second part in QEMU however would be premature, since it
is not used by anything.  As mentioned earlier, my suggestion is that
you convert the ARM virt machine type to FirmwareBuildMethods and
HW-reduced ACPI.  It shouldn't be a large amount of work and it should
let you reduce the ACPI delta between QEMU and NEMU.

Also, I would like to understand if you NEMU people are interested in
refactoring the ACPI builder code to move DSDT-building code closer to
the device, or perhaps have already done that.  For example, the
infamous floppy cannot be disabled right now because of the call to
isa_fdc_get_drive_type in hw/i386/acpi-build.c.  As I understand it,
your initial patches have the side effect of letting you bypass this
issue---because you don't include hw/i386/acpi-build.c in your virt
machine type.  That is totally fine, but of course it doesn't help if
you want to compile the floppy out of a QEMU that supports -M q35 but
not -M pc.  Therefore I would love to know that I'm wrong, or just that
you're planning to fix that too. :)

Paolo
