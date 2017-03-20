Received: from eggs.gnu.org ([2001:4830:134:3::10]:57709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1cpw0w-0005lf-7k
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1cpw0t-00023W-5B
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:02:18 -0400
Received: from mail.univention.de ([82.198.197.8]:2984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1cpw0s-00020U-Pc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:02:15 -0400
References: <cover.1352938305.git.mtosatti@redhat.com>
	<b0b873a07872f7ab7f66f259c73fb9dd42aa66a9.1352938305.git.mtosatti@redhat.com>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <f8f0ebb7-0c79-8570-3210-dc45c3effda8@univention.de>
Date: Mon, 20 Mar 2017 13:02:10 +0100
MIME-Version: 1.0
In-Reply-To: <b0b873a07872f7ab7f66f259c73fb9dd42aa66a9.1352938305.git.mtosatti@redhat.com>
Content-Type: multipart/mixed; boundary="------------43AAC593821CECD40C2D0C36"
Subject: Re: [Qemu-devel] [PATCH 1/2] acpi_piix4: fix migration of gpe fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

This is a multi-part message in MIME format.
--------------43AAC593821CECD40C2D0C36
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Marcelo, cc:qemu,

Sorry for re-using this old thread, but I have a problem loading some
saved state from qemu-kvm-1.1.2, which fails for piix4_pm.

You following patch was committed as
<http://git.qemu-project.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Db0b873a0787=
2f7ab7f66f259c73fb9dd42aa66a9>:

Am 15.11.2012 um 01:11 schrieb Marcelo Tosatti:
> Migrate 16 bytes for en/sts fields (which is the correct size),
> increase version to 3, and document how to support incoming
> migration from qemu-kvm 1.2.

I my case qemu-kvm-1.1.2/hw/acpi_piix4.c:284
| VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
only saves 4 bytes, not 16 bytes.

> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> ---
>  hw/acpi_piix4.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++-=
---
>  1 files changed, 46 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/acpi_piix4.c b/hw/acpi_piix4.c
> index 15275cf..519269a 100644
> --- a/hw/acpi_piix4.c
> +++ b/hw/acpi_piix4.c
> @@ -235,10 +235,9 @@ static int vmstate_acpi_post_load(void *opaque, in=
t version_id)
>   {                                                                   \
>       .name       =3D (stringify(_field)),                             =
 \
>       .version_id =3D 0,                                               =
 \
> -     .num        =3D GPE_LEN,                                         =
 \
>       .info       =3D &vmstate_info_uint16,                            =
 \
>       .size       =3D sizeof(uint16_t),                                =
 \
> -     .flags      =3D VMS_ARRAY | VMS_POINTER,                         =
 \
> +     .flags      =3D VMS_SINGLE | VMS_POINTER,                        =
 \
>       .offset     =3D vmstate_offset_pointer(_state, _field, uint8_t), =
 \
>   }
> =20
> @@ -267,11 +266,54 @@ static const VMStateDescription vmstate_pci_statu=
s =3D {
>      }
>  };

On load qemu-2.8 uses this function

> +static int acpi_load_old(QEMUFile *f, void *opaque, int version_id)
> +{
> +    PIIX4PMState *s =3D opaque;
> +    int ret, i;
> +    uint16_t temp;
> +
> +    ret =3D pci_device_load(&s->dev, f);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +    qemu_get_be16s(f, &s->ar.pm1.evt.sts);
> +    qemu_get_be16s(f, &s->ar.pm1.evt.en);
> +    qemu_get_be16s(f, &s->ar.pm1.cnt.cnt);
> +
> +    ret =3D vmstate_load_state(f, &vmstate_apm, opaque, 1);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    qemu_get_timer(f, s->ar.tmr.timer);
> +    qemu_get_sbe64s(f, &s->ar.tmr.overflow_time);
> +
> +    qemu_get_be16s(f, (uint16_t *)s->ar.gpe.sts);
> +    for (i =3D 0; i < 3; i++) {
> +        qemu_get_be16s(f, &temp);
> +    }

and the loop loads 6 extra bytes here

> +
> +    qemu_get_be16s(f, (uint16_t *)s->ar.gpe.en);
> +    for (i =3D 0; i < 3; i++) {
> +        qemu_get_be16s(f, &temp);
> +    }

and 6 here.
So in total 12 bytes are read too much and qemu_loadvm_state() ends
somewhere in the middle of the next device state section. (patch 0001
helped me to identify that offset)

If I apply the attached 0002 patch, I can load the old VM state.

> +
> +    ret =3D vmstate_load_state(f, &vmstate_pci_status, opaque, 1);
> +    return ret;
> +}
> +
> +/* qemu-kvm 1.2 uses version 3 but advertised as 2
> + * To support incoming qemu-kvm 1.2 migration, change version_id
> + * and minimum_version_id to 2 below (which breaks migration from
> + * qemu 1.2).
> + *
> + */
>  static const VMStateDescription vmstate_acpi =3D {
>      .name =3D "piix4_pm",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .minimum_version_id_old =3D 1,
> +    .load_state_old =3D acpi_load_old,
>      .post_load =3D vmstate_acpi_post_load,
>      .fields      =3D (VMStateField []) {
>          VMSTATE_PCI_DEVICE(dev, PIIX4PMState),
>=20

Do you remember why 16 bytes were saved in your case?

Thank you in advance.

Philipp

--------------43AAC593821CECD40C2D0C36
Content-Type: text/x-diff;
 name="0002-0007-Bug-38877-fix-qemu-kvm-1.1-piix4_pm-incompatibi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0002-0007-Bug-38877-fix-qemu-kvm-1.1-piix4_pm-incompatibi.pa";
 filename*1="tch"

=46rom 4e43999b0f56975dbbd528e4956231b2ee64c071 Mon Sep 17 00:00:00 2001
Message-Id: <4e43999b0f56975dbbd528e4956231b2ee64c071.1490011194.git.hahn=
@univention.de>
In-Reply-To: <1313efdc0ac664169c5c271f832264efe6659743.1490011194.git.hah=
n@univention.de>
References: <1313efdc0ac664169c5c271f832264efe6659743.1490011194.git.hahn=
@univention.de>
From: Philipp Hahn <hahn@univention.de>
Date: Mon, 20 Mar 2017 12:36:53 +0100
Subject: [PATCH 2/2] 0007-Bug-38877-fix-qemu-kvm-1.1-piix4_pm-incompatibi=
lity
Organization: Univention GmbH, Bremen, Germany
To: qemu-devel@nongnu.org

qemu-kvm-1.1 only saves 2*uint16, but qemu-2.8 tries to load 2*4*uint16.

The code was added by b0b873a07872f7ab7f66f259c73fb9dd42aa66a9 and the
commit message claims 16 bytes are the supposed size, but as UCS never
used qemu-kvm-1.2, fix the case for qemu-kvm-1.1

Gbp: Topic UCS
Signed-off-by: Philipp Hahn <hahn@univention.de>
---
 hw/acpi/piix4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 17d36bd..c756d18 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -232,14 +232,18 @@ static int acpi_load_old(QEMUFile *f, void *opaque,=
 int version_id)
     qemu_get_sbe64s(f, &s->ar.tmr.overflow_time);
=20
     qemu_get_be16s(f, (uint16_t *)s->ar.gpe.sts);
+#if 0 // Bug #38877
     for (i =3D 0; i < 3; i++) {
         qemu_get_be16s(f, &temp);
     }
+#endif
=20
     qemu_get_be16s(f, (uint16_t *)s->ar.gpe.en);
+#if 0 // Bug #38877
     for (i =3D 0; i < 3; i++) {
         qemu_get_be16s(f, &temp);
     }
+#endif
=20
     ret =3D vmstate_load_state(f, &vmstate_pci_status,
         &s->acpi_pci_hotplug.acpi_pcihp_pci_status[ACPI_PCIHP_BSEL_DEFAU=
LT], 1);
--=20
2.1.4


--------------43AAC593821CECD40C2D0C36
Content-Type: text/x-diff;
 name="0001-0006-Bug-38877-debug-loadvm-offset.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-0006-Bug-38877-debug-loadvm-offset.patch"

=46rom 1313efdc0ac664169c5c271f832264efe6659743 Mon Sep 17 00:00:00 2001
Message-Id: <1313efdc0ac664169c5c271f832264efe6659743.1490011194.git.hahn=
@univention.de>
From: Philipp Hahn <hahn@univention.de>
Date: Fri, 17 Mar 2017 12:51:01 +0100
Subject: [PATCH 1/2] 0006-Bug-38877-debug-loadvm-offset
Organization: Univention GmbH, Bremen, Germany
To: qemu-devel@nongnu.org

debug: Print offset on section error:

30143@1489751176.344102:qemu_loadvm_state_section 48@0x364da2

Gbp: Topic debug
Signed-off-by: Philipp Hahn <hahn@univention.de>
---
 include/migration/qemu-file.h | 1 +
 migration/qemu-file.c         | 5 +++++
 migration/savevm.c            | 2 +-
 migration/trace-events        | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.=
h
index abedd46..a570836 100644
--- a/include/migration/qemu-file.h
+++ b/include/migration/qemu-file.h
@@ -126,6 +126,7 @@ int qemu_get_fd(QEMUFile *f);
 int qemu_fclose(QEMUFile *f);
 int64_t qemu_ftell(QEMUFile *f);
 int64_t qemu_ftell_fast(QEMUFile *f);
+int64_t qemu_ftell_internal(QEMUFile *f);
 void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size);
 void qemu_put_byte(QEMUFile *f, int v);
 /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e9fae31..862b8c7 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -543,6 +543,11 @@ int64_t qemu_ftell(QEMUFile *f)
     return f->pos;
 }
=20
+int64_t qemu_ftell_internal(QEMUFile *f)
+{
+    return f->pos - f->buf_size + f->buf_index;
+}
+
 int qemu_file_rate_limit(QEMUFile *f)
 {
     if (qemu_file_get_error(f)) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 0363372..da2a98b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1882,7 +1882,7 @@ static int qemu_loadvm_state_main(QEMUFile *f, Migr=
ationIncomingState *mis)
=20
     while ((section_type =3D qemu_get_byte(f)) !=3D QEMU_VM_EOF) {
         ret =3D 0;
-        trace_qemu_loadvm_state_section(section_type);
+        trace_qemu_loadvm_state_section(section_type, qemu_ftell_interna=
l(f) - 1);
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
diff --git a/migration/trace-events b/migration/trace-events
index 94134f7..49f8458 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -1,7 +1,7 @@
 # See docs/tracing.txt for syntax documentation.
=20
 # migration/savevm.c
-qemu_loadvm_state_section(unsigned int section_type) "%d"
+qemu_loadvm_state_section(unsigned int section_type, uint64_t offset) "%=
d@0x%" PRIx64
 qemu_loadvm_state_section_command(int ret) "%d"
 qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_main(void) ""
--=20
2.1.4


--------------43AAC593821CECD40C2D0C36--
