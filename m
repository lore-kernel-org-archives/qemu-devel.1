Received: from eggs.gnu.org ([2001:4830:134:3::10]:60600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDCj2-00045b-EL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDCiy-0002pV-FH
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:32:00 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:60860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDCiy-0002od-5v
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:56 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BBF9DF779A
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 18:31:54 +0200 (CEST)
Date: Tue, 23 May 2017 18:31:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170523183146.3525dd7c@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170523111812.13469-3-lvivier@redhat.com>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/jrjXXfNBmRjOm/oIZpOFwYb";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] spapr: add option vector 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

--Sig_/jrjXXfNBmRjOm/oIZpOFwYb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017 13:18:10 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> This allows to know when the OS is started and its type.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr.c              | 36 ++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall.c        |  5 ++++-
>  hw/ppc/spapr_ovec.c         |  8 ++++++++
>  include/hw/ppc/spapr.h      |  2 ++
>  include/hw/ppc/spapr_ovec.h |  7 +++++++
>  5 files changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0e8d8d1..eceb4cc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1369,6 +1369,7 @@ static void ppc_spapr_reset(void)
>      first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
> =20
>      spapr->cas_reboot =3D false;
> +    spapr->os_name =3D OV6_NONE;
>  }
> =20
>  static void spapr_create_nvram(sPAPRMachineState *spapr)
> @@ -1524,10 +1525,41 @@ static const VMStateDescription vmstate_spapr_pat=
b_entry =3D {
>      },
>  };
> =20
> +static bool spapr_os_name_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    return smc->need_os_name;

So this will have the subsection migrated unconditionally even if the value=
 wasn't
changed from the default yet ? Also, it looks weird to involve a machine co=
mpat
flag here... if the concern is backwards migration then I guess you should =
check
the compat flag in h_client_architecture_support() and not set @os_name for=
 older
machines.

> +}
> +
> +static const VMStateDescription vmstate_spapr_os_name =3D {
> +    .name =3D "spapr_os_name",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_os_name_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(os_name, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static int spapr_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    /* if the os_name is not migrated from the source,
> +     * we must allow hotplug, so set os_name to linux
> +     */
> +    spapr->os_name =3D OV6_LINUX;

But maybe the source was in SLOF and I guess you don't want @os_name
to be set in this case... The correct way to restore older machines
behavior is to set @os_name to OV6_LINUX according to the compat flag.

> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
>      .minimum_version_id =3D 1,
> +    .pre_load =3D spapr_pre_load,
>      .post_load =3D spapr_post_load,
>      .fields =3D (VMStateField[]) {
>          /* used to be @next_irq */
> @@ -1542,6 +1574,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_os_name,
>          NULL
>      }
>  };
> @@ -3216,6 +3249,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       * in which LMBs are represented and hot-added
>       */
>      mc->numa_mem_align_shift =3D 28;
> +    smc->need_os_name =3D true;

The name seems to indicate the machine requires this, which is obviously not
the case... what about @parse_os_name instead ?

>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -3293,9 +3327,11 @@ static void spapr_machine_2_9_instance_options(Mac=
hineState *machine)
> =20
>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>      spapr_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
>      mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> +    smc->need_os_name =3D false;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0d608d6..5dbe3c7 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1058,7 +1058,8 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      uint32_t max_compat =3D cpu->max_compat;
>      uint32_t best_compat =3D 0;
>      int i;
> -    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> +    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates,
> +                      *ov6_guest;
>      bool guest_radix;
> =20
>      /*
> @@ -1112,6 +1113,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
> =20
>      ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
>      ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
> +    ov6_guest =3D spapr_ovec_parse_vector(ov_table, 6);
>      if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
>          error_report("guest requested hash and radix MMU, which is inval=
id.");
>          exit(EXIT_FAILURE);
> @@ -1154,6 +1156,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      }
>      spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
>                                                            OV1_PPC_3_00);
> +    spapr->os_name =3D spapr_ovec_byte(ov6_guest, OV6_OS_NAME);

Is there a reason not to have these lines grouped ?

+    ov6_guest =3D spapr_ovec_parse_vector(ov_table, 6);
+    spapr->os_name =3D spapr_ovec_byte(ov6_guest, OV6_OS_NAME);

>      if (!spapr->cas_reboot) {
>          spapr->cas_reboot =3D
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 41df4c3..7adc9e6 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -160,6 +160,14 @@ static uint8_t guest_byte_from_bitmap(unsigned long =
*bitmap, long bitmap_offset)
>      return entry;
>  }
> =20
> +uint8_t spapr_ovec_byte(sPAPROptionVector *ov, long bitnr)
> +{
> +    g_assert(ov);
> +    g_assert(bitnr < OV_MAXBITS);
> +
> +    return guest_byte_from_bitmap(ov->bitmap, bitnr);
> +}
> +
>  static target_ulong vector_addr(target_ulong table_addr, int vector)
>  {
>      uint16_t vector_count, vector_len;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f88..041ce19 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -52,6 +52,7 @@ struct sPAPRMachineClass {
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> +    bool need_os_name;
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by defau=
lt */
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
> @@ -90,6 +91,7 @@ struct sPAPRMachineState {
>      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
>      bool cas_reboot;
>      bool cas_legacy_guest_workaround;
> +    uint8_t os_name;
> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index f088833..c728bb3 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -56,6 +56,12 @@ typedef struct sPAPROptionVector sPAPROptionVector;
>  #define OV5_MMU_RADIX_300       OV_BIT(24, 1) /* 1=3DRadix only, 0=3DHas=
h only */
>  #define OV5_MMU_RADIX_GTSE      OV_BIT(26, 1) /* Radix GTSE */
> =20
> +/* option vector 6 */
> +#define OV6_OS_NAME             OV_BIT(3, 0)
> +#define OV6_NONE                0x00
> +#define OV6_AIX                 0x01
> +#define OV6_LINUX               0x02
> +
>  /* interfaces */
>  sPAPROptionVector *spapr_ovec_new(void);
>  sPAPROptionVector *spapr_ovec_clone(sPAPROptionVector *ov_orig);
> @@ -69,6 +75,7 @@ void spapr_ovec_cleanup(sPAPROptionVector *ov);
>  void spapr_ovec_set(sPAPROptionVector *ov, long bitnr);
>  void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr);
>  bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr);
> +uint8_t spapr_ovec_byte(sPAPROptionVector *ov, long bitnr);
>  sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int =
vector);
>  int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
>                             sPAPROptionVector *ov, const char *name);


--Sig_/jrjXXfNBmRjOm/oIZpOFwYb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkkY/IACgkQAvw66wEB28J0pwCdErpVbZtjZuH56NOvg4kZpZTp
PvMAn0jKLRCR0bueZQKJs3F8iW3xVCIT
=vfw7
-----END PGP SIGNATURE-----

--Sig_/jrjXXfNBmRjOm/oIZpOFwYb--
