Received: from eggs.gnu.org ([2001:4830:134:3::10]:43069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1V55-0007GC-NZ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1V50-0008Q2-RZ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d1V50-0008Os-IH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:42:18 -0400
References: <1489558827-28971-1-git-send-email-phil@philjordan.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ba2d971-8527-7d50-8df2-51f1703e3269@redhat.com>
Date: Fri, 21 Apr 2017 11:42:13 +0200
MIME-Version: 1.0
In-Reply-To: <1489558827-28971-1-git-send-email-phil@philjordan.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] hw/i386: Update FADT to Revision 3
 (ACPI 2.0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>



On 15/03/2017 07:20, Phil Dennis-Jordan wrote:
> This updates the FADT generated for x86/64 machine types from
> Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) As
> previously, the goal is to make running macOS/OS X guests smoother.
> With a Rev1 FADT, rebooting such a guest doesn't work, as the OS uses
> the reset register information from the FADT. Switching to a Rev3
> (ACPI 2.0) FADT solves this problem.
> 
> The previous discussion of this raised a bunch of points, which I'll
> address/clarify here as well:
> 
> 1. No runtime option. The preference was expressed that we try to
> stay backwards-compatible with legacy guests as opposed to adding a
> runtime option for different APCI versions. ACPI 2.0/FADT Rev3 is the
> minimum version required for exposing the reset register, and it is
> also backwards-compatible with 1.0/Rev1, so that seemed a good
> version to target.
> 
>  2. Legacy guest testing. I've tested this successfully (no apparent regressions) with:
>    * Windows XP x86 (both "pc" and "q35" machine types, the latter using -device piix4-ide)
>    * Windows 7, both 32-bit and 64-bit editions
>    * Windows 10 x64
>    * Fedora 7 x86 Live image
>    * Fedora 25 x86_64 Live image
>    * Ubuntu 10.04.4 AMD64 Live image
> Any other specific OSes and versions I should check?
> 
> 
>  3. 64-bit and 32-bit pointer fields.
> 
> Only very recent versions of the ACPI spec (6.1 and various errata of
> 5.1 and 6.0) are clear about mutual exclusion of the FADT's 32-bit and
> 64-bit variants of pointers to tables and registers. The 2.0 version
> simply states "This is a required field" for both PM1a_EVT_BLK and
> X_PM1a_EVT_BLK, for example, although it does also state for the former
> that "This field is superseded in ACPI 2.0 by the X_PM1a_EVT_BLK field."
> No requirement is specified explicitly for the DSDT and X_DSDT fields.
> 
> In practice, I have found that Windows 10 will fail to boot with a
> Rev3 FADT unless BOTH the 32-bit and 64-bit variants are filled. The
> exception is X_FIRMWARE_CTRL, which is the first to be explicitly marked
> as mutually exclusive with FIRMWARE_CTRL in an ACPI spec - with a
> preference for FIRMWARE_CTRL if the pointer fits in a 32-bit field.
> Satisfying Windows 10 in this way does not contradict the 2.0
> specification, and it also complies with the 1.0 standard for the fields
> which Rev1 of the FADT already has, so that's what I've gone with in the
> implementation.
> 
> The only problem is that upstream OVMF cannot deal with multiple
> pointers to the same table in the linker commands. This turns out to be
> a bug in OVMF/EDK2[1], and I am submitting a separate patch to EDK2 to
> fix that problem. The fix for a second issue where OVMF would rewrite
> the FADT so the DSDT is erroneously set to 0 has already been
> upstreamed.[2] I don't see a workaround to this other than fixing the
> OVMF code.
> 
>  4. i440FX vs Q35
> 
> Both machine types have the reset register, and it's at the same I/O
> port. To illustrate/document this, the second patch in the series
> adds a build-time assertion that this is indeed so.

Queued for 2.10, thanks.

Paolo
