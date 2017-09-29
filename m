Received: from eggs.gnu.org ([2001:4830:134:3::10]:41567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dy3Iu-0008FB-Mg
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dy3Iq-0006MF-BY
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:58:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dy3Iq-0006Lg-29
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:58:36 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <11d514ce-5752-d1a9-852c-9f091d2791e2@redhat.com>
Date: Fri, 29 Sep 2017 23:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
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
To: Richard Relph <richard.relph@amd.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Side topic; sorry if it has been mentioned elsewhere:

On 09/27/17 21:06, Richard Relph wrote:

> Whether the "BIOS" is a "static shim" as Michael suggests, or a full
> BIOS, or even a BIOS+kernel+initrd is really not too significant. What
> is significant is that the GO has a basis for trusting all code that is
> imported in to their VM by the CP. And that NONE of the code provided by
> the CP is "unknown" and unauditable by the GO. If the CP has a way to
> inject code unknown to the GO in to the guest VM, the trust model is
> broken and both GO and CP suffer the consequences.

The expansion ROMs (containing UEFI drivers) of emulated PCI devices,
and the same of assigned physical PCI devices, constitute another
channel through which code enters the guest from the outside (i.e., from
the Cloud Provider). The ROM BARs from which the guest firmware reads
the UEFI binaries are not guest RAM, they are MMIO. (For execution, the
drivers are copied into encrypted guest RAM.)

If the guest has Secure Boot enabled, then the oproms are verified[*]
(and not launched if verification fails), but this is slightly different
from what I understand under audit-by-GO. It means the GO wouldn't get a
measurement of the oproms for one-by-one clearing, when about to
green-light a guest startup. Instead the GO would ensure that Secure
Boot be enabled with the right certificates (and/or executable hashes)
enrolled off the bat, and then implicitly trust all oprom drivers
accepted by those certs / hashes. It's another layer of indirection.

This is likely nothing new qualitatively, but "the devil is in the
details", so I thought it was worth raising.

[*] For edk2 / OvmfPkg specifics, I'll mention

  gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy

The SecurityPkg default is 0x04 ("Deny execution when there is security
violation"). However, OVMF sets it to 0x00 ("Always trust the image").
Please see the following commit for the reasons:

  https://github.com/tianocore/edk2/commit/1fea9ddb4e3fd

Brijesh, for SEV guests, we likely want to flip this PCD to 0x04, in the
AmdSevInitialize() function, in "OvmfPkg/PlatformPei/AmdSev.c". For that
we'll also have to change the PCD from fixed-at-build to dynamic, but
that in turn will require a change to "SecurityPkg.dec" itself
(currently it only allows fixed-at-build or patchable, not dynamic). Do
you want me to file a BZ in the TianoCore tracker for this, and assign
it to you? If you don't have time for writing the patch, I'm glad to do
it too, but then the review could be slower; both other OvmfPkg
co-maintainers are busy with other things.)

Thanks!
Laszlo
