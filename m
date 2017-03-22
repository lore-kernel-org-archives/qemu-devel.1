Received: from eggs.gnu.org ([2001:4830:134:3::10]:37397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cqimS-000772-0y
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cqimN-0002Co-Ro
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cqimN-0002Bh-Lc
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:31 -0400
Date: Wed, 22 Mar 2017 18:06:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170322180319-mutt-send-email-mst@kernel.org>
References: <20170322155906.10679-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322155906.10679-1-rkrcmar@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pc: q35: bump max_cpus to INT32_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Mar 22, 2017 at 04:59:06PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
> QEMU does not allocate based on machine's max_cpus, but only uses it to
> limit the maximum selected by user and the actual limit of VCPUs is
> enfoced by other components:
>  - machine without vIOMMU ends at 255 VCPUs
>  - TCG currently doesn't support x2APIC, so it also ends below 256
>  - KVM with vIOMMU cannot exceed the KVM limit (currently 288)
>=20
> Using a big value should bring no drawbacks and the benefit is that
> components (especially out-of-tree KVM) can bump their limits without
> touching machine's max_cpus.
>=20
> max_cpus is unsigned, but it is treated as signed at least in printf an=
d
> the other two billion VCPU won't be needed for a while, so we can ignor=
e
> possible bugs by using signed max.
>=20
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> ---
>   Should the 2.9 machine type still have 288?

It doesn't look like a bugfix to me.
So if we can defer past 2.9 that would be best IMO.


> ---
>  hw/i386/pc_q35.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index dd792a8547b3..3d5710ca20e0 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -298,7 +298,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_display =3D "std";
>      m->no_floppy =3D 1;
>      m->has_dynamic_sysbus =3D true;
> -    m->max_cpus =3D 288;
> +    m->max_cpus =3D INT32_MAX;
>  }
> =20
>  static void pc_q35_2_9_machine_options(MachineClass *m)
> @@ -314,6 +314,7 @@ static void pc_q35_2_8_machine_options(MachineClass=
 *m)
>  {
>      pc_q35_2_9_machine_options(m);
>      m->alias =3D NULL;
> +    m->max_cpus =3D 288;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
>  }
> =20
> --=20
> 2.12.0
