Received: from eggs.gnu.org ([2001:4830:134:3::10]:50114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vrozenfe@redhat.com>) id 1ceFWf-0000Du-Si
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vrozenfe@redhat.com>) id 1ceFWc-0003i5-PK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:26:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vrozenfe@redhat.com>) id 1ceFWc-0003hu-GS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:26:42 -0500
Message-ID: <1487226392.17184.50.camel@redhat.com>
From: Vadim Rozenfeld <vrozenfe@redhat.com>
Date: Thu, 16 Feb 2017 17:26:32 +1100
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
	<2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
	<1486980300.17184.28.camel@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Hangaohuai <hangaohuai@huawei.com>, Yan Vugenfirer <yvugenfi@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>

On Thu, 2017-02-16 at 01:31 +0000, Gonglei (Arei) wrote:
> Hi,
>=20
> >=20
> >=20
> > On Sat, 2017-02-11 at 10:39 -0500, Paolo Bonzini wrote:
> > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > On 10/02/2017 10:31, Gonglei (Arei) wrote:
> > > > > >=20
> > > > > >=20
> > > > > > But We tested the same cases on Xen platform and VMware,
> > > > > > and
> > > > > > the guest booted successfully.
> > > > >=20
> > > > > Were these two also tested with enlightenments enabled?=C2=A0=C2=
=A0TCG
> > > > > surely isn't.
> > > >=20
> > > > About TCG, I just remove ' accel=3Dkvm,' and 'hy_releaxed' from
> > > > the
> > > > below QEMU
> > > > Command line, I thought the hyper-V enabled then. Sorry about
> > > > that.
> > > >=20
> > > > But for Xen, we set 'viridian=3D1' which be thought the Hyper-V
> > > > is
> > > > enabled.
> > > >=20
> > > > For VMWare we also enabled the Hyper-V enlightenments.
> > If I'm not mistaken, even Hyper-V server doesn't allow specify more
> > than 64 vCPUs for Generation 1 VMs.
>=20
> Normally yes, but I found the explanation from Microsoft document
> about it:
>=20
> Maximum Supported Virtual Processors
>=20
> On Windows operating systems versions through Windows Server 2008
> R2,=C2=A0
> reporting the HV#1 hypervisor interface limits the Windows virtual
> machine=C2=A0
> to a maximum of 64 VPs, regardless of what is reported via
> CPUID.40000005.EAX.
> Starting with Windows Server 2012 and Windows 8, if
> CPUID.40000005.EAX=C2=A0
> contains a value of -1, Windows assumes that the hypervisor imposes
> no specific
> limit to the number of VPs. In this case, Windows Server 2012 guest
> VMs may
> use more than 64 VPs, up to the maximum supported number of
> processors=C2=A0
> applicable to the specific Windows version being used.
>=20
> Link: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-wind
> ows/reference/tlfs
>=20
> "Requirements for Implementing the Microsoft Hypervisor Interface"
>=20
> And the below patch works for me, I can support max 255 vcpus for
> WS2012
> with hyper-v enlightenments.
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 27fd050..efe3cbc 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -772,7 +772,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c =3D &cpuid_data=
.entries[cpuid_i++];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->function =3D H=
YPERV_CPUID_IMPLEMENT_LIMITS;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->eax =3D 0x40;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->eax =3D -1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->ebx =3D 0x40;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvm_base =3D KVM_=
CPUID_SIGNATURE_NEXT;
>=20

Nice.
I tried the following patch some time ago. Unfortunately it didn't work
for me for some reason:

@@ -772,8 +773,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c =3D &cpuid_data.e=
ntries[cpuid_i++];
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->function =3D HYP=
ERV_CPUID_IMPLEMENT_LIMITS;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->eax =3D 0x40;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->ebx =3D 0x40;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->eax =3D 0x000000f0;//=
0x40;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->ebx =3D 0x00000200;//=
0x40;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->ecx =3D 0x00000648;

I used the same numbers as provided by WS2016 for both Gen1 and Gen2
VMs.

> >=20
> > > >=20
> > In any case, if you are only interested in hv_relaxed, you can drop
> > it
> > off for WS2012 as long as you have cpu hypervisor flag
> > (CPUID.1:ECX=C2=A0[bit=C2=A031]=3D1) turned on.
> >=20
> hy_relaxed is just a example of enabling hyperv-v enlightenments.
>=20
> Thanks,
> -Gonglei
