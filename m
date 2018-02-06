Received: from eggs.gnu.org ([2001:4830:134:3::10]:43869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1ej5XQ-00040C-Gi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1ej5XK-0005de-Ok
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:04 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:39988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1ej5XK-0005bD-Er
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:58 -0500
Message-Id: <5A79CF18020000480006831E@prv-mh.provo.novell.com>
Date: Tue, 06 Feb 2018 08:51:52 -0700
From: "Bruce Rogers" <brogers@suse.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH v6 00/23] x86: Secure Encrypted
 Virtualization (AMD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: brijesh.singh@amd.com, qemu-devel@nongnu.org
Cc: Thomas.Lendacky@amd.com, Stefan Hajnoczi <stefanha@gmail.com>, peter.maydell@linaro.org, richard.henderson@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, edgar.iglesias@xilinx.com

>>> On 1/29/2018 at 10:41 AM, <brijesh.singh@amd.com> wrote:
> This patch series provides support for AMD's new Secure Encrypted=20
> Virtualization (SEV) feature.
>=20
> SEV is an extension to the AMD=E2=80=91V architecture which supports =
running
> multiple VMs under the control of a hypervisor. The SEV feature allows
> the memory contents of a virtual machine (VM) to be transparently =
encrypted
> with a key unique to the guest VM. The memory controller contains a
> high performance encryption engine which can be programmed with multiple
> keys for use by a different VMs in the system. The programming and
> management of these keys is handled by the AMD Secure Processor firmware
> which exposes a commands for these tasks.
>=20
> The KVM SEV patch series introduced a new ioctl (KVM_MEMORY_ENCRYPTION_OP=
)
> which is used by qemu to issue the SEV commands to assist performing
> common hypervisor activities such as a launching, running, snapshooting,
> migration and debugging guests.
>=20

As for the reported failure to build on non-x86 hosts, eg:
...
  LINK    i386-softmmu/qemu-system-i386
target/i386/helper.o: In function `get_me_mask':
/var/tmp/patchew-tester-tmp-hek3vjny/src/target/i386/helper.c:735: =
undefined reference to `kvm_arch_get_supported_cpuid'
target/i386/monitor.o: In function `get_me_mask':
/var/tmp/patchew-tester-tmp-hek3vjny/src/target/i386/monitor.c:71: =
undefined reference to `kvm_arch_get_supported_cpuid'

... I've looked at that a bit and find that in target/i386/kvm-stub.c, if =
we get rid of
the #ifndef __OPTIMIZE__ it then builds ok. I'm not sure if the guarding =
done there
with the check for  __OPTIMIZE__ is a relic that no longer applies given =
how qemu
currently builds, but at least it's something to look at.

Bruce
