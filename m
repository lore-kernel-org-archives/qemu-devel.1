Received: from eggs.gnu.org ([2001:4830:134:3::10]:47808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1erUKF-0003bB-KI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1erUKC-0001Le-I9
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:57:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1erUKC-0001LP-D5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:57:08 -0500
Date: Thu, 1 Mar 2018 20:56:16 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20180301195616.GA29001@flask>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-3-git-send-email-babu.moger@amd.com>
	<20180228180858.GB8418@flask>
	<CY4PR12MB17687EBCC5940ACFEB3E4D7C95C60@CY4PR12MB1768.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR12MB17687EBCC5940ACFEB3E4D7C95C60@CY4PR12MB1768.namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pixo@polepetko.eu" <pixo@polepetko.eu>, "Hook, Gary" <Gary.Hook@amd.com>

2018-03-01 15:55+0000, Moger, Babu:
> Radim, Thanks for your comments. I am working on the changes.
> But, I need few clarifications on your comments. Please see inline.=20
>=20
> > -----Original Message-----
> > From: Radim Kr=C4=8Dm=C3=A1=C5=99 [mailto:rkrcmar@redhat.com]
> > Sent: Wednesday, February 28, 2018 12:09 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > mtosatti@redhat.com; qemu-devel@nongnu.org; kvm@vger.kernel.org;
> > pixo@polepetko.eu; Hook, Gary <Gary.Hook@amd.com>
> > Subject: Re: [PATCH v2 2/5] target/i386: Populate AMD Processor Cache
> > Information
> >=20
> > 2018-02-23 21:30-0500, Babu Moger:
> > > From: Stanislav Lanci <pixo@polepetko.eu>
> > >
> > > Adds information about cache size and topology from cpuid 0x8000001=
D
> > leaf
> > > for different cache types on AMD processors.
> > >
> > > Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > ---
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > @@ -3590,6 +3594,78 @@ void cpu_x86_cpuid(CPUX86State *env,
> > > +                *ebx =3D (L1D_LINE_SIZE - 1) | \
> > > +                       ((L1D_PARTITIONS - 1) << 12) | \
> > > +                       ((L1D_ASSOCIATIVITY - 1) << 22);
> > > +                *ecx =3D L1D_SETS - 1;
> >=20
> > These numbers seem to have the same meaning as CPUID 4, but have
> > conflicting values.
>=20
> I am not sure about conflicting values. Looking at the specs(page 78 CP=
UID_Fn8000001D_EBX_x00)
>  https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.p=
df
>  It looks correct to me.

I agree.  My comment is misplaced -- it should have been under the place
that uses *_AMD macros.

I wanted to point out that CPUID in QEMU is very Intel-focused and
always contains CPUID leaf 4, which has fields of the very same meaning,
but with different values.

> > I think we should not expose CPUID 4 with AMD CPUs or at least when t=
hey
> > have CPUID_EXT3_TOPOEXT (the latter is easier wrt. compatibility).
>=20
> Can you please elaborate on these comments?=20
> Did you mean we should remove the check CPUID_EXT3_TOPOEXT and remove a=
ll CPUID 4 references?=20

CPUID 4 should have never been present when emulating AMD CPUs, but it's
worse now that the numbers are conflicting.

I meant to hide CPUID 4 for all AMD CPUs on future machine types, or at
least when CPUID_EXT3_TOPOEXT is enabled.

Keeping the current logic not a big problem as CPUID 4 should never be
used by operating systems on AMD nor trusted inside a VM.  Bringing the
emulation closer to real state would be nice, but this can definitely be
done later (aka never).

> > The numbers looks like real hardware,
>=20
> Do you want me to change anything here?

No, I was just commending,

thanks.
