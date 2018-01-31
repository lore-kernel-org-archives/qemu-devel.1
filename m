Received: from eggs.gnu.org ([2001:4830:134:3::10]:33138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1egsdb-0003xC-Hk
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1egsdW-0004Ab-NF
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:41:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1egsdW-00049a-GC
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:41:14 -0500
Date: Wed, 31 Jan 2018 11:41:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180131134102.GI26425@localhost.localdomain>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-6-brijesh.singh@amd.com>
	<20180130174957.GD2536@work-vm>
	<c60b5f53-2f50-1866-a2b9-fda8b7c2be39@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c60b5f53-2f50-1866-a2b9-fda8b7c2be39@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/23] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Jan 30, 2018 at 03:46:45PM -0600, Brijesh Singh wrote:
>=20
>=20
> On 1/30/18 11:49 AM, Dr. David Alan Gilbert wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >> AMD EPYC processors support memory encryption feature. The feature
> >> is reported through CPUID 8000_001F[EAX].
> >>
> >> Fn8000_001F [EAX]:
> >>  Bit 0   Secure Memory Encryption (SME) supported
> >>  Bit 1   Secure Encrypted Virtualization (SEV) supported
> >>  Bit 2   Page flush MSR supported
> >>  Bit 3   Ecrypted State (SEV-ES) support
> >>
> >> when memory encryption feature is reported, CPUID 8000_001F[EBX] sho=
uld
> >> provide additional information regarding the feature (such as which =
page
> >> table bit is used to mark pages as encrypted etc). The information i=
n EBX
> >> and ECX may vary from one family to another hence we use the host cp=
uid
> >> to populate the EBX information.
> > That's going to make it interesting for migration.  If the guest need=
s
> > to know that C-bit position then you presumably can't migrate between
> > those two host types, but we wouldn't have anything that currently
> > stops us.
> > We already have similar problems with variations in physical address
> > size but normally get away with that, especially on smaller VMs.
>=20
> Dave,
>=20
> While building the page tables guest need to know the C-bit position.
> The C-bit position in the guest is same as C-bit position on the host.
> For migration case, we should be able to migrate SEV guest on same host
> type (i.e all EPYC and Ryzen CPUs are based on family 17 and we should
> be okay migrating the SEV guests among those host types).=A0 Since C-bi=
t
> position is not fixed hence migrating to different host family will be
> an issue.

Thanks for the explanation.  If this affects ability to migrate,
you need to either:
a) not report the "sev" property on
   query-cpu-model-expansion type=3Dstatic output (because the
   feature is not migration-safe); or
b) make the C-bit position configurable, and let management
   explicitly specify it.  In this case, you need to validate the
   configured C-bit position and prevent the VM from running if
   it doesn't match the host.  This is more work, but would make
   the feature migration-safe and more useful for management
   software.

Option (b) is preferred because it lets management software
ensure the VM is migratable to a host before starting migration.

There was a very recent discussion about migration-safe features
and the problems with relaying host CPUID data directly to the
guest.  Look for the "i386: Add Intel Processor Trace feature
support" threads in qemu-devel for more info.

I'm looking for a way to document these rules concisely so people
touching the CPUID code are aware of the available options.

--=20
Eduardo
