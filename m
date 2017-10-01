Received: from eggs.gnu.org ([2001:4830:134:3::10]:37644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dyaNf-0002nE-1p
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 05:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dyaNa-0005h6-UZ
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 05:17:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dyaNa-0005ew-ME
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 05:17:42 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
	<11d514ce-5752-d1a9-852c-9f091d2791e2@redhat.com>
	<210c74c8-5ced-94cd-2025-29f94c71fdf2@amd.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fc4e1267-0fd3-6412-b7af-5082b122c309@redhat.com>
Date: Sun, 1 Oct 2017 11:17:33 +0200
MIME-Version: 1.0
In-Reply-To: <210c74c8-5ced-94cd-2025-29f94c71fdf2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, Richard Relph <richard.relph@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 10/01/17 02:09, Brijesh Singh wrote:
> 
> 
> On 9/29/17 4:58 PM, Laszlo Ersek wrote:
> ...
>> The expansion ROMs (containing UEFI drivers) of emulated PCI devices,
>> and the same of assigned physical PCI devices, constitute another
>> channel through which code enters the guest from the outside (i.e., from
>> the Cloud Provider). The ROM BARs from which the guest firmware reads
>> the UEFI binaries are not guest RAM, they are MMIO. (For execution, the
>> drivers are copied into encrypted guest RAM.)
>>
>> If the guest has Secure Boot enabled, then the oproms are verified[*]
>> (and not launched if verification fails), but this is slightly different
>> from what I understand under audit-by-GO. It means the GO wouldn't get a
>> measurement of the oproms for one-by-one clearing, when about to
>> green-light a guest startup. Instead the GO would ensure that Secure
>> Boot be enabled with the right certificates (and/or executable hashes)
>> enrolled off the bat, and then implicitly trust all oprom drivers
>> accepted by those certs / hashes. It's another layer of indirection.
>>
>> This is likely nothing new qualitatively, but "the devil is in the
>> details", so I thought it was worth raising.
>>
>> [*] For edk2 / OvmfPkg specifics, I'll mention
>>
>>   gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy
>>
>> The SecurityPkg default is 0x04 ("Deny execution when there is security
>> violation"). However, OVMF sets it to 0x00 ("Always trust the image").
>> Please see the following commit for the reasons:
>>
>>   https://github.com/tianocore/edk2/commit/1fea9ddb4e3fd
>>
>> Brijesh, for SEV guests, we likely want to flip this PCD to 0x04, in the
>> AmdSevInitialize() function, in "OvmfPkg/PlatformPei/AmdSev.c". For that
>> we'll also have to change the PCD from fixed-at-build to dynamic, but
>> that in turn will require a change to "SecurityPkg.dec" itself
>> (currently it only allows fixed-at-build or patchable, not dynamic). Do
>> you want me to file a BZ in the TianoCore tracker for this, and assign
>> it to you? If you don't have time for writing the patch, I'm glad to do
>> it too, but then the review could be slower; both other OvmfPkg
>> co-maintainers are busy with other things.)
> 
> Very good point Laszlo. Please submit the BZ and assign it me - thank
> you. we will take a look at implementing the required support.

I've filed:

https://bugzilla.tianocore.org/show_bug.cgi?id=728

Another thought: once we delegate part of the protection that SEV
provides to the Secure Boot implementation in the guest, the pflash chip
that stores the UEFI variables (i.e., certificates for SB as well)
becomes a target of attacks not just from within the guest, but also
from the host.

This is a big problem because the pflash chip is MMIO, nor RAM. So it is
not encrypted, and the Cloud Provider can tamper with it at will -- even
if the variable store file that backs the pflash chip (with the
certificates pre-enrolled) comes from the Guest Owner initially, and/or
passes the GO's measurement check.

Put differently, even if we set PcdOptionRomImageVerificationPolicy to
0x04, it doesn't help if the CP can poke any UEFI executable hash or
self-signed certificate into the varstore, which in turn will "verify"
the CP's malicious oprom driver.

The varstore pflash chip has never been considered to be under attack
from the *host* side; all the guest-SMM work was focused on protecting
pflash (and guest firmware in general) from the *guest* OS (and 3rd
party *guest* UEFI apps).

Theoretically, I see three ways to mitigate this:

(1) Eliminate pflash from OVMF altogether. This would be a huge project,
affecting OVMF, QEMU and libvirt. It would also throw the current
in-guest protections provided by SB out the window.

(2) Keep pflash as-is, but do not off-load any SEV protections to
guest-side Secure Boot. This means that the guest firmware must be
comprehensively restricted to load binaries only from media that the GO
measured and the CP cannot tamper with. No option ROMs, no PXE boot, no
plaintext ISOs, no plaintext hard disk images. (And booting from
encrypted ISOs / hard disk images would require a LUKS driver for OVMF.)

(3) Implement SEV encryption for pflash. A pflash chip can be in one of
two modes: (a) it reads and executes as ROM, or (b) it behaves like a
programmable (r/w) device with MMIO registers. Switching between both
modes is explicit (see
"OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlash.c"); perhaps some SEV
controls could be hooked in there.

Thanks
Laszlo
