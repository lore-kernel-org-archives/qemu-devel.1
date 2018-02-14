Received: from eggs.gnu.org ([2001:4830:134:3::10]:35652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1em1eE-00067j-0h
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1em1eA-0001KJ-M4
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:19:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51516
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1em1eA-0001Ji-Gd
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:19:10 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EIE4p1033001
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 13:19:09 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4nw6mvv8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 13:19:09 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 13:19:08 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180214165040.GA2508@work-vm>
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
	<20180214165040.GA2508@work-vm>
Date: Wed, 14 Feb 2018 12:18:58 -0600
Message-Id: <151863233842.4211.15732702297985774243@sif>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Quoting Dr. David Alan Gilbert (2018-02-14 10:50:40)
> * Michael Roth (mdroth@linux.vnet.ibm.com) wrote:
> > This blog entry is intended as a follow-up to the original entry in
> > January regarding Spectre/Meltdown and the proposed changes to address
> > them in the upcoming 2.11.1 release.
> > =

> > This entry is meant to accompany the 2.11.1 release (planned for
> > 2018-02-14) and document how to make use of the new options for
> > various architectures.
> > =


<snip>

> > +
> > +
> > +## enabling mitigations for x86 KVM guests
> > +
> > +For x86 guests there are 2 additional CPU flags associated with
> > +Spectre/Meltdown mitigation: **spec-ctrl**, and **ibpb**. These flags
> > +expose additional functionality made available through new microcode
> > +updates for certain Intel/AMD processors that can be used to mitigate
> > +various attack vectors related to Spectre. (Meltdown mitigation via KP=
TI
> > +does not require additional CPU functionality or microcode, and does n=
ot
> > +require an updated QEMU, only the related guest/host kernel patches).
> > +
> > +These CPU flags:
> > +
> > +* spec-ctrl: exposes Indirect Branch Restricted Speculation (IBRS)
> > +* ibpb: exposes Indirect Branch Prediction Barriers
> > +
> > +are both features requiring guest/host kernel updates, as well as
> > +microcode updates for Intel and recent AMD processors. The status of
> > +these kernel patches upstream is still in flux, but most supported
> > +distros have some form of the patches that is sufficient to make use
> > +of the features. The current status/availability of microcode updates
> > +depends on your CPU architecture/model. Please check with your
> > +vendor/distro to confirm these prerequisites are available/installed.
> > +
> > +Generally, for Intel CPUs with updated microcode, **spec-ctrl** will
> > +enable both IBRS and IBPB functionality. For AMD EPYC processors,
> > +**ibpb** can be used to enable IBPB specifically, and is thought to
> > +be sufficient by itself that particular architecture.
> > +
> > +These flags can be set in a similar manner as other CPU flags, i.e.:
> > +
> > +    qemu-system-x86_64 -cpu qemu64,+spec-ctrl,... ...
> > +    qemu-system-x86_64 -cpu IvyBridge,+spec-ctrl,... ...
> > +    qemu-system-x86_64 -cpu EPYC,+ibpb
> > +    etc...
> > +
> > +Additionally, for management stacks that lack support for setting
> > +specific CPU flags, a set of new CPU types have been added which
> > +enable the appropriate CPU flags automatically:
> > +
> > +    qemu-system-x86_64 -cpu Nehalem-IBRS ...
> > +    qemu-system-x86_64 -cpu Westmere-IBRS ...
> > +    qemu-system-x86_64 -cpu SandyBridge-IBRS ...
> > +    qemu-system-x86_64 -cpu IvyBridge-IBRS ...
> > +    qemu-system-x86_64 -cpu Haswell-IBRS ...
> > +    qemu-system-x86_64 -cpu Haswell-noTSX-IBRS ...
> > +    qemu-system-x86_64 -cpu Broadwell-IBRS ...
> > +    qemu-system-x86_64 -cpu Broadwell-noTSX-IBRS ...
> > +    qemu-system-x86_64 -cpu Skylake-Client-IBRS ...
> > +    qemu-system-x86_64 -cpu Skylake-Server-IBRS ...
> > +    qemu-system-x86_64 -cpu EPYC-IBPB ...
> > +
> > +With these settings enabled, guests may still require additional
> > +configuration to enable IBRS/IBPB, which may vary somewhat from one
> > +distro to another. For RHEL guests, the following resource may be
> > +useful:
> > +
> > +* https://access.redhat.com/articles/3311301
> > +
> > +WRT migration compatibility, **spec-ctrl**/**ibrs** (or the correspond=
ing
> > +CPU type) should be set the same on both source/target to maintain
> > +compatibility. Thus, guests will need to be rebooted to make use of
> > +the new features.
> =

> There is an unfortunate wrinkle with respect to CPU type compatibility
> on x86;  the retpoline code is looking like it has to do special
> cases for Skylake and other recent CPUs (fluching the return buffer) and
> it does this on the basis of CPUid/model rather than flags;  so from
> QEMUs point of view, the normal trick we do about giving guests a false
> earlier CPU name (e.g. -cpu IvyBridge) and expecting them to run across
> a wide range of more modern hardware may not be secure.

Hmm, that's referring to this thread and Eduardo's concerns?
  https://lkml.org/lkml/2018/1/20/162

In the context of enabling IBRS in guests, wouldn't
Skylake host <-> non-Skylake host migration still be safe, assuming the
IBRS bits are properly enabled? Even with the patches proposed in that
thread?

For the purposes of this document I was sort of staying away from
retpoline since AFAIK IBRS is still considered more complete and seems
to be more widely deployed. But perhaps we can add note to clarify and
maybe help users plan better for future developments of the sort. Maybe
something like the following?


Note that this document centers around Spectre mitigation via IBRS/IBPB
features. Alternative approaches to addressing Spectre exist in the form
of 'retpoline'-enabled kernels and are outside the scope of this
document. However, if you plan on utilizing such a kernel in place of IBRS,
either now or in the future, note that some proposed forms of the code
still rely on IBRS as a fallback for certain architectures like Skylake.
In such cases it may be necessary to ensure that guests running on Skylake
hosts utilize a matching -cpu Skylake* model with appropriate IBRS options
enabled, otherwise such fallbacks may be unavailable and leave the guest
vulnerable. For more background on this particular consideration you can
view the discussion here:

https://lkml.org/lkml/2018/1/29/634

> =

> Dave
> =


<snip>

> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
