Received: from eggs.gnu.org ([2001:4830:134:3::10]:42987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKQ5q-0005lF-IX
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKQ5p-0004Qu-56
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:50:10 -0500
MIME-Version: 1.0
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-14-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-14-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 7 Nov 2018 19:49:54 +0400
Message-ID: <CAJ+F1CLWy0xbb-Pc7yUNpHh70GsSTKJ=v+TeoTGJOThYO_xE2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 13/14] hw/i386: add
 pc-i440fx-3.2 & pc-q35-3.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Corey Minyard <minyard@acm.org>, amit@kernel.org, hpoussin@reactos.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.ibm.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, atar4qemu@gmail.com, Richard Henderson <rth@twiddle.net>

Hi

On Wed, Nov 7, 2018 at 4:49 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following patch is going to add compatiblity parameters for
> qemu <=3D 3.1.
>

I realize this may be good enough for x86 i440/q35 machines, but what
about other machines & architectures?

What do we officially support, for migration, across different versions?

It seems we have versionized:
- arm "virt" machines
- "s390-ccw-virtio" machines
- ppc "pseries" machines
- x86 piix/q35 machines

At least, I think I should update this patch to add new 3.2 machines for th=
ose.

Is there any way to check compat properties are handled properly for
those various machines? It looks like it is generally lacking. For
example, if there is a new HW_COMPAT, it would be nice if something
failed if a corresponding machine hasn't been added.

It also looks like there is a bit of code duplication and a bit too
much macros :) unfortunately, I don't yet have a good idea how to
improve things...

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/compat.h  |  3 +++
>  include/hw/i386/pc.h |  3 +++
>  hw/i386/pc_piix.c    | 21 ++++++++++++++++++---
>  hw/i386/pc_q35.c     | 19 +++++++++++++++++--
>  4 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 6f4d5fc647..70958328fe 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
>
> +#define HW_COMPAT_3_1 \
> +    /* empty */
> +
>  #define HW_COMPAT_3_0 \
>      /* empty */
>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 136fe497b6..c37d4333a0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -294,6 +294,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>
> +#define PC_COMPAT_3_1 \
> +    HW_COMPAT_3_1
> +
>  #define PC_COMPAT_3_0 \
>      HW_COMPAT_3_0 \
>      {\
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index dc09466b3e..ba371bfcd7 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,21 +428,36 @@ static void pc_i440fx_machine_options(MachineClass =
*m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>  }
>
> -static void pc_i440fx_3_0_machine_options(MachineClass *m)
> +static void pc_i440fx_3_2_machine_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>      m->alias =3D "pc";
>      m->is_default =3D 1;
>  }
>
> +DEFINE_I440FX_MACHINE(v3_2, "pc-i440fx-3.2", NULL,
> +                      pc_i440fx_3_2_machine_options);
> +
> +static void pc_i440fx_3_1_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_3_2_machine_options(m);
> +    m->is_default =3D 0;
> +    m->alias =3D NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
> +}
> +
> +static void pc_i440fx_3_0_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_3_1_machine_options(m);
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> +}
> +
>  DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
>                        pc_i440fx_3_0_machine_options);
>
>  static void pc_i440fx_2_12_machine_options(MachineClass *m)
>  {
>      pc_i440fx_3_0_machine_options(m);
> -    m->is_default =3D 0;
> -    m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>  }
>
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 532241e3f8..64d6ea65d5 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -311,19 +311,34 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus =3D 288;
>  }
>
> -static void pc_q35_3_0_machine_options(MachineClass *m)
> +static void pc_q35_3_2_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias =3D "q35";
>  }
>
> +DEFINE_Q35_MACHINE(v3_2, "pc-q35-3.2", NULL,
> +                   pc_q35_3_2_machine_options);
> +
> +static void pc_q35_3_1_machine_options(MachineClass *m)
> +{
> +    pc_q35_3_2_machine_options(m);
> +    m->alias =3D NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
> +}
> +
> +static void pc_q35_3_0_machine_options(MachineClass *m)
> +{
> +    pc_q35_3_1_machine_options(m);
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> +}
> +
>  DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
>                      pc_q35_3_0_machine_options);
>
>  static void pc_q35_2_12_machine_options(MachineClass *m)
>  {
>      pc_q35_3_0_machine_options(m);
> -    m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>  }
>
> --
> 2.19.1.708.g4ede3d42df
>
>


--=20
Marc-Andr=C3=A9 Lureau
