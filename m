Received: from eggs.gnu.org ([2001:4830:134:3::10]:32907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ebSZY-0004lW-8r
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ebSZV-0005Ay-4n
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:50:44 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2248 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1ebSZT-00057u-SE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:50:41 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 16 Jan 2018 14:50:29 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA516CF3@DGGEMA505-MBX.china.huawei.com>
References: <20180109154519.25634-1-ehabkost@redhat.com>
	<20180109154519.25634-4-ehabkost@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA5109CD@DGGEMA505-MBX.china.huawei.com>
	<20180115122302.GK6646@localhost.localdomain>
In-Reply-To: <20180115122302.GK6646@localhost.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/7] i386: Add spec-ctrl CPUID bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Monday, January 15, 2018 8:23 PM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; Paolo Bonzini
> Subject: Re: [Qemu-devel] [PATCH 3/7] i386: Add spec-ctrl CPUID bit
>=20
> On Sat, Jan 13, 2018 at 03:04:44AM +0000, Gonglei (Arei) wrote:
> >
> > > -----Original Message-----
> > > From: Qemu-devel
> > > [mailto:qemu-devel-bounces+arei.gonglei=3Dhuawei.com@nongnu.org] On
> > > Behalf Of Eduardo Habkost
> > > Sent: Tuesday, January 09, 2018 11:45 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: Paolo Bonzini
> > > Subject: [Qemu-devel] [PATCH 3/7] i386: Add spec-ctrl CPUID bit
> > >
> > > Add the feature name and a CPUID_7_0_EDX_SPEC_CTRL macro.
> > >
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  target/i386/cpu.h | 1 +
> > >  target/i386/cpu.c | 2 +-
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > index 07f47997d6..de387c1311 100644
> > > --- a/target/i386/cpu.h
> > > +++ b/target/i386/cpu.h
> > > @@ -667,6 +667,7 @@ typedef uint32_t
> > > FeatureWordArray[FEATURE_WORDS];
> > >
> > >  #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural
> > > Network Instructions */
> > >  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply
> > > Accumulation Single Precision */
> > > +#define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation
> Control
> > > */
> > >
> > >  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
> > >  #define CPUID_XSAVE_XSAVEC     (1U << 1)
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 9f4f949899..1be1642eb2 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -459,7 +459,7 @@ static FeatureWordInfo
> > > feature_word_info[FEATURE_WORDS] =3D {
> > >              NULL, NULL, NULL, NULL,
> > >              NULL, NULL, NULL, NULL,
> > >              NULL, NULL, NULL, NULL,
> > > -            NULL, NULL, NULL, NULL,
> > > +            NULL, NULL, "spec-ctrl", NULL,
> > >              NULL, NULL, NULL, NULL,
> > >          },
> > >          .cpuid_eax =3D 7,
> > > --
> > > 2.14.3
> > >
> > Don't we need to pass-through cupid_7_edx to guest when configuring '-c=
pu
> host'?
> > Otherwise how guests use IBPB/IBRS/STIPB capabilities?
>=20
> We already do.  See the check for cpu->max_features at
> x86_cpu_expand_features().
>=20
> Do you see something else missing?
>=20
No, thank you. My bad. :(

Thanks,
-Gonglei
