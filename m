Received: from eggs.gnu.org ([2001:4830:134:3::10]:53654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.ksingh@gmail.com>) id 1elcfg-0000OC-P8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.ksingh@gmail.com>) id 1elcff-0003ev-LI
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:39:04 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brijesh.ksingh@gmail.com>)
	id 1elcff-0003ek-FB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:39:03 -0500
Received: by mail-qk0-x243.google.com with SMTP id g129so8383969qkb.13
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:39:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212211948.GK14422@pd.tnic>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-6-brijesh.singh@amd.com>
	<20180212183803.GR13981@localhost.localdomain>
	<4a1f22d9-da2e-618b-1423-629817389948@amd.com>
	<20180212211948.GK14422@pd.tnic>
From: Brijesh Singh <brijesh.ksingh@gmail.com>
Date: Tue, 13 Feb 2018 09:39:01 -0600
Message-ID: <CA+HCGMYvh081neh=aF45qG0WF2vpJwkZ4unnLPLwhEkDNPWZsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 05/28] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Borislav Petkov <bp@suse.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Stefan Hajnoczi <stefanha@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Alistair Francis <alistair.francis@xilinx.com>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Mon, Feb 12, 2018 at 3:19 PM, Borislav Petkov <bp@suse.de> wrote:

> On Mon, Feb 12, 2018 at 03:07:26PM -0600, Brijesh Singh wrote:
> > In current implementation, when -cpu ...,+sev is passed without
> > appropriate SEV configuration then we populate the Fn8000_001F CPUID bu=
t
> > VMCB will not have SEV bit set hence a guest will be launched as
> > non-SEV.
>
> I think we should fail the guest init if sev is not really supported by
> the host. Otherwise people might get mislead.
>
>

Sure I will do that. We can simplify this patch if we don't fill the CPUID
for non SEV guest. I am thinking of doing something like this:

"If SEV configration is provided in QEMU command line then
automatically increase xlevel to 0x8000_001F and populate the EAX and EBX
registers"



> > > Changing existing CPU models is possible only on very specific
> > > circumstances (where VMs that are currently runnable would always
> > > stay runnable), and would require compat_props entries to keep
> > > compatibility on existing machine-types.
> >
> > Ah I didn't consider that case. What is recommendation, should we creat=
e
> > a new CPU Model (EPYC-SEV) ?
>
> Can we please stop creating a new CPU model with every new CPUID feature
> support added? This is just ridiculous.
>
> If this is about live migration, then by all means, fail the migration
> if the feature bits are not compatible. But replicating CPU models and
> then adding one new differing feature doesn't make any sense.
>
>
Yes, I think we should be able to avoid creating new CPU model to handle
this case.
I am leaning towards dropping this patch and implement logic to populate th=
e
CPUID 0x8000_001F only when SEV is enabled. This should not require any
changes
in existing CPU model feature flag and live migration of existing guest
should work fine.



> --
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB
> 21284 (AG N=C3=BCrnberg)
> --
>
>
