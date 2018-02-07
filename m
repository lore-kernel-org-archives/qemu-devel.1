Received: from eggs.gnu.org ([2001:4830:134:3::10]:50870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejOVD-0002dB-K0
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejOV3-0004tA-Tq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:07:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejOV3-0004sj-PC
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:06:53 -0500
Date: Wed, 7 Feb 2018 13:06:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180207130635.4033f8b8@redhat.com>
In-Reply-To: <ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
	<5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Wed, 7 Feb 2018 07:49:58 +0000
"Tan, Jianfeng" <jianfeng.tan@intel.com> wrote:

> > -----Original Message-----
> > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > Sent: Tuesday, February 6, 2018 1:32 AM
> > To: Igor Mammedov
> > Cc: Tan, Jianfeng; qemu-devel@nongnu.org; Jason Wang; Maxime Coquelin;
> > Michael S . Tsirkin
> > Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as
> > migration
> >=20
> > On 05/02/2018 18:15, Igor Mammedov wrote: =20
> > >>>
> > >>> Then we would have both ram block named pc.ram:
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Block Name=C2=A0=C2=A0=C2=A0 PSize
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc.ram=C2=A0=
=C2=A0=C2=A0=C2=A0 4 KiB
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /objects/pc.ram=C2=A0=C2=A0=C2=A0 2 =
MiB
> > >>>
> > >>> But I assume it's a corner case which not really happen. =20
> > >> Yeah, you're right. :/  I hadn't thought of hotplug.  It can happen =
indeed. =20
> > >
> > > perhaps we should fail object_add memory-backend-foo if it resulted
> > > in creating ramblock with duplicate id =20
> >=20
> > Note that it would only be duplicated with Jianfeng's patch.  So I'm
> > worried that his patch is worse than what we have now, because it may
> > create conflicts with system RAMBlock names are not necessarily
> > predictable.  Right now, -object creates RAMBlock names that are nicely
> > constrained within /object/. =20
>=20
> So we are trading off between the benefit it takes and the bad effect it =
brings.
>=20
> I'm wondering if the above example is the only failed case this patch lea=
ds to, i.e, only there is a ram named "pc.ram" and "/object/pc.ram" in the =
src VM?
>=20
> Please also consider the second option, that adding an alias name for RAM=
Block; I'm not a big fan for that one, as it just pushes the problem to Ope=
nStack/Libvirt.
looking at provided CLI examples it's configuration issue on src and dst,
one shall not mix numa and non numa variants.

> Or any other suggestions?
Fix configuration, namely dst side of it (i.e. use the same -m only variant
without -numa as it's on src).

BTW, what are you trying to achieve adding -numa on dst?

> Thanks,
> Jianfeng
