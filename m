Received: from eggs.gnu.org ([2001:4830:134:3::10]:48484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHKWv-0000yc-Hy
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHKWs-0002Y7-AA
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:08:17 -0500
Date: Thu, 15 Dec 2016 12:07:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161215010747.GN32647@umbus>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-3-david@gibson.dropbear.id.au>
	<1481692939.1555.19.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5FetH82qe0Z6y/zI"
Content-Disposition: inline
In-Reply-To: <1481692939.1555.19.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCHv3 2/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: paulus@samba.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--5FetH82qe0Z6y/zI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 04:22:19PM +1100, Suraj Jitindar Singh wrote:
> On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
> > This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
> > H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
> > extension to allow run time resizing of a guest's hash page
> > table.=A0=A0It
> > also adds a new machine property for controlling whether this new
> > facility is available, and logic to check that against availability
> > with KVM (only supported with KVM PR for now).
> >=20
> > Finally, it adds a new string to the hypertas property in the device
> > tree, advertising to the guest the availability of the HPT resizing
> > hypercalls.=A0=A0This is a tentative suggested value, and would need to
> > be
> > standardized by PAPR before being merged.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > =A0hw/ppc/spapr.c=A0=A0=A0=A0=A0=A0=A0=A0=A0| 75
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > =A0hw/ppc/spapr_hcall.c=A0=A0=A0| 36 ++++++++++++++++++++++++
> > =A0hw/ppc/trace-events=A0=A0=A0=A0|=A0=A02 ++
> > =A0include/hw/ppc/spapr.h | 11 ++++++++
> > =A0target-ppc/kvm.c=A0=A0=A0=A0=A0=A0=A0| 25 +++++++++++++++++
> > =A0target-ppc/kvm_ppc.h=A0=A0=A0|=A0=A05 ++++
> > =A06 files changed, 154 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 0f25e83..846ce51 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -760,6 +760,11 @@ static void spapr_dt_rtas(sPAPRMachineState
> > *spapr, void *fdt)
> > =A0=A0=A0=A0=A0if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0add_str(hypertas, "hcall-multi-tce");
> > =A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0if (spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0add_str(hypertas, "hcall-hpt-resize");
> > +=A0=A0=A0=A0}
> > +
> > =A0=A0=A0=A0=A0_FDT(fdt_setprop(fdt, rtas, "ibm,hypertas-functions",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hyper=
tas->str, hypertas->len));
> > =A0=A0=A0=A0=A0g_string_free(hypertas, TRUE);
> > @@ -1839,11 +1844,40 @@ static void ppc_spapr_init(MachineState
> > *machine)
> > =A0=A0=A0=A0=A0long load_limit, fw_size;
> > =A0=A0=A0=A0=A0char *filename;
> > =A0=A0=A0=A0=A0int smt =3D kvmppc_smt_threads();
> > +=A0=A0=A0=A0Error *resize_hpt_err =3D NULL;
> > =A0
> > =A0=A0=A0=A0=A0msi_nonbroken =3D true;
> > =A0
> > =A0=A0=A0=A0=A0QLIST_INIT(&spapr->phbs);
> > =A0
> > +=A0=A0=A0=A0/* Check HPT resizing availability */
> > +=A0=A0=A0=A0kvmppc_check_papr_resize_hpt(&resize_hpt_err);
> > +=A0=A0=A0=A0if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* If the user explicitly requested a mode w=
e should either
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* supply it, or fail completely (which we d=
o below).=A0=A0But
> > if
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* it's not set explicitly, we reset our mod=
e to something
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* that works
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (resize_hpt_err) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spapr->resize_hpt =3D SPAPR_RESIZE=
_HPT_DISABLED;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_free(resize_hpt_err);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0resize_hpt_err =3D NULL;
> > +=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spapr->resize_hpt =3D smc->resize_=
hpt_default;
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0assert(spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DEFAULT);
> > +
> > +=A0=A0=A0=A0if ((spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) &&
> > resize_hpt_err) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* User requested HPT resize, but this host =
can't supply
> > it.=A0=A0Bail out
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > +=A0=A0=A0=A0=A0=A0=A0=A0error_report_err(resize_hpt_err);
> > +=A0=A0=A0=A0=A0=A0=A0=A0exit(1);
> > +=A0=A0=A0=A0}
> > +
> > =A0=A0=A0=A0=A0/* Allocate RMA if necessary */
> > =A0=A0=A0=A0=A0rma_alloc_size =3D kvmppc_alloc_rma(&rma);
> > =A0
> > @@ -2236,6 +2270,40 @@ static void
> > spapr_set_modern_hotplug_events(Object *obj, bool value,
> > =A0=A0=A0=A0=A0spapr->use_hotplug_event_source =3D value;
> > =A0}
> > =A0
> > +static char *spapr_get_resize_hpt(Object *obj, Error **errp)
> > +{
> > +=A0=A0=A0=A0sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +=A0=A0=A0=A0switch (spapr->resize_hpt) {
> > +=A0=A0=A0=A0case SPAPR_RESIZE_HPT_DEFAULT:
> > +=A0=A0=A0=A0=A0=A0=A0=A0return g_strdup("default");
> > +=A0=A0=A0=A0case SPAPR_RESIZE_HPT_DISABLED:
> > +=A0=A0=A0=A0=A0=A0=A0=A0return g_strdup("disabled");
> > +=A0=A0=A0=A0case SPAPR_RESIZE_HPT_ENABLED:
> > +=A0=A0=A0=A0=A0=A0=A0=A0return g_strdup("enabled");
> > +=A0=A0=A0=A0case SPAPR_RESIZE_HPT_REQUIRED:
> > +=A0=A0=A0=A0=A0=A0=A0=A0return g_strdup("required");
> > +=A0=A0=A0=A0}
> > +=A0=A0=A0=A0assert(0);
> > +}
> > +
> > +static void spapr_set_resize_hpt(Object *obj, const char *value,
> > Error **errp)
> > +{
> > +=A0=A0=A0=A0sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +=A0=A0=A0=A0if (strcmp(value, "default") =3D=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DEFAULT;
> > +=A0=A0=A0=A0} else if (strcmp(value, "disabled") =3D=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLE=
D;
> > +=A0=A0=A0=A0} else if (strcmp(value, "enabled") =3D=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->resize_hpt =3D SPAPR_RESIZE_HPT_ENABLED;
> > +=A0=A0=A0=A0} else if (strcmp(value, "required") =3D=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0spapr->resize_hpt =3D SPAPR_RESIZE_HPT_REQUIRE=
D;
> > +=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0error_setg(errp, "Bad value for \"resize-hpt\"=
 property");
> > +=A0=A0=A0=A0}
> > +}
> > +
> > =A0static void spapr_machine_initfn(Object *obj)
> > =A0{
> > =A0=A0=A0=A0=A0sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > @@ -2256,6 +2324,12 @@ static void spapr_machine_initfn(Object *obj)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" place of standard EPOW events
> > when possible"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" (required for memory hot-
> > unplug support)",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0NULL);
> > +
> > +=A0=A0=A0=A0object_property_add_str(obj, "resize-hpt",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0spapr_get_resize_hpt,
> > spapr_set_resize_hpt, NULL);
> > +=A0=A0=A0=A0object_property_set_description(obj, "resize-hpt",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"Resizing of the Hash Page Table
> > (enabled, disabled, required)",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0NULL);
> > =A0}
> > =A0
> > =A0static void spapr_machine_finalizefn(Object *obj)
> > @@ -2707,6 +2781,7 @@ static void
> > spapr_machine_class_init(ObjectClass *oc, void *data)
> > =A0
> > =A0=A0=A0=A0=A0smc->dr_lmb_enabled =3D true;
> > =A0=A0=A0=A0=A0smc->tcg_default_cpu =3D "POWER8";
> > +=A0=A0=A0=A0smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
> > =A0=A0=A0=A0=A0mc->query_hotpluggable_cpus =3D spapr_query_hotpluggable=
_cpus;
> > =A0=A0=A0=A0=A0fwc->get_dev_path =3D spapr_get_fw_dev_path;
> > =A0=A0=A0=A0=A0nc->nmi_monitor_handler =3D spapr_nmi;
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index fd9f1d4..72a9c4d 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -355,6 +355,38 @@ static target_ulong h_read(PowerPCCPU *cpu,
> > sPAPRMachineState *spapr,
> > =A0=A0=A0=A0=A0return H_SUCCESS;
> > =A0}
> > =A0
> > +static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sPAPRMachineState *sp=
apr,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong opcode,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong *args)
> > +{
> > +=A0=A0=A0=A0target_ulong flags =3D args[0];
> > +=A0=A0=A0=A0target_ulong shift =3D args[1];
> > +
> > +=A0=A0=A0=A0if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_AUTHORITY;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0trace_spapr_h_resize_hpt_prepare(flags, shift);
> > +=A0=A0=A0=A0return H_HARDWARE;
> > +}
> > +
> > +static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sPAPRMachineState *spapr,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong opcode,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong *args)
> > +{
> > +=A0=A0=A0=A0target_ulong flags =3D args[0];
> > +=A0=A0=A0=A0target_ulong shift =3D args[1];
> > +
> > +=A0=A0=A0=A0if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return H_AUTHORITY;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0trace_spapr_h_resize_hpt_commit(flags, shift);
> > +=A0=A0=A0=A0return H_HARDWARE;
> > +}
> > +
> > =A0static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAPRMachineState
> > *spapr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target_ulong opcode, target_ulong
> > *args)
> > =A0{
> > @@ -1134,6 +1166,10 @@ static void hypercall_register_types(void)
> > =A0=A0=A0=A0=A0/* hcall-bulk */
> > =A0=A0=A0=A0=A0spapr_register_hypercall(H_BULK_REMOVE, h_bulk_remove);
> > =A0
> > +=A0=A0=A0=A0/* hcall-hpt-resize */
> > +=A0=A0=A0=A0spapr_register_hypercall(H_RESIZE_HPT_PREPARE,
> > h_resize_hpt_prepare);
> > +=A0=A0=A0=A0spapr_register_hypercall(H_RESIZE_HPT_COMMIT,
> > h_resize_hpt_commit);
> > +
> > =A0=A0=A0=A0=A0/* hcall-splpar */
> > =A0=A0=A0=A0=A0spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
> > =A0=A0=A0=A0=A0spapr_register_hypercall(H_CEDE, h_cede);
> > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > index 2297ead..bf59a8f 100644
> > --- a/hw/ppc/trace-events
> > +++ b/hw/ppc/trace-events
> > @@ -16,6 +16,8 @@ spapr_cas_continue(unsigned long n) "Copy changes
> > to the guest: %ld bytes"
> > =A0# hw/ppc/spapr_hcall.c
> > =A0spapr_cas_pvr_try(uint32_t pvr) "%x"
> > =A0spapr_cas_pvr(uint32_t cur_pvr, bool cpu_match, uint32_t new_pvr,
> > uint64_t pcr) "current=3D%x, cpu_match=3D%u, new=3D%x, compat
> > flags=3D%"PRIx64
> > +spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift)
> > "flags=3D0x%"PRIx64", shift=3D%"PRIu64
> > +spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift)
> > "flags=3D0x%"PRIx64", shift=3D%"PRIu64
> > =A0
> > =A0# hw/ppc/spapr_iommu.c
> > =A0spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce,
> > uint64_t ret) "liobn=3D%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64"
> > ret=3D%"PRId64
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index a2d8964..d2c758b 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -31,6 +31,13 @@ typedef struct sPAPRMachineState
> > sPAPRMachineState;
> > =A0#define SPAPR_MACHINE_CLASS(klass) \
> > =A0=A0=A0=A0=A0OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_=
MACHINE)
> > =A0
> > +typedef enum {
> > +=A0=A0=A0=A0SPAPR_RESIZE_HPT_DEFAULT =3D 0,
> > +=A0=A0=A0=A0SPAPR_RESIZE_HPT_DISABLED,
> > +=A0=A0=A0=A0SPAPR_RESIZE_HPT_ENABLED,
> > +=A0=A0=A0=A0SPAPR_RESIZE_HPT_REQUIRED,
> > +} sPAPRResizeHPT;
> > +
> > =A0/**
> > =A0 * sPAPRMachineClass:
> > =A0 */
> > @@ -46,6 +53,7 @@ struct sPAPRMachineClass {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0uint64_t *buid, hwaddr *pio,=A0
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0hwaddr *mmio32, hwaddr *mmio64,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0unsigned n_dma, uint32_t *liobns, Error
> > **errp);
> > +=A0=A0=A0=A0sPAPRResizeHPT resize_hpt_default;
> > =A0};
> > =A0
> > =A0/**
> > @@ -61,6 +69,7 @@ struct sPAPRMachineState {
> > =A0=A0=A0=A0=A0XICSState *xics;
> > =A0=A0=A0=A0=A0DeviceState *rtc;
> > =A0
> > +=A0=A0=A0=A0sPAPRResizeHPT resize_hpt;
> > =A0=A0=A0=A0=A0void *htab;
> > =A0=A0=A0=A0=A0uint32_t htab_shift;
> > =A0=A0=A0=A0=A0hwaddr rma_size;
> > @@ -347,6 +356,8 @@ struct sPAPRMachineState {
> > =A0#define H_XIRR_X=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x2FC
> > =A0#define H_RANDOM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x300
> > =A0#define H_SET_MODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x31C
> > +#define H_RESIZE_HPT_PREPARE=A0=A0=A0=A00x36C
> > +#define H_RESIZE_HPT_COMMIT=A0=A0=A0=A0=A00x370
> > =A0#define H_SIGNAL_SYS_RESET=A0=A0=A0=A0=A0=A00x380
> > =A0#define MAX_HCALL_OPCODE=A0=A0=A0=A0=A0=A0=A0=A0H_SIGNAL_SYS_RESET
> > =A0
> > diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
> > index 15e12f3..39e5753 100644
> > --- a/target-ppc/kvm.c
> > +++ b/target-ppc/kvm.c
> > @@ -22,6 +22,7 @@
> > =A0#include <linux/kvm.h>
> > =A0
> > =A0#include "qemu-common.h"
> > +#include "qapi/error.h"
> > =A0#include "qemu/error-report.h"
> > =A0#include "cpu.h"
> > =A0#include "qemu/timer.h"
> > @@ -2672,3 +2673,27 @@ int kvmppc_enable_hwrng(void)
> > =A0
> > =A0=A0=A0=A0=A0return kvmppc_enable_hcall(kvm_state, H_RANDOM);
> > =A0}
> > +
> > +void kvmppc_check_papr_resize_hpt(Error **errp)
> > +{
> > +=A0=A0=A0=A0if (!kvm_enabled()) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0/* TODO: Check specific capabilities for HPT resize aware =
host
> > kernels */
> > +
> > +=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0* It's tempting to try to check directly if the HPT is =
under
> > our
> > +=A0=A0=A0=A0=A0* control or KVM's, which is what's really relevant her=
e.
> > +=A0=A0=A0=A0=A0* Unfortunately, in order to correctly size the HPT, we=
 need to
> > +=A0=A0=A0=A0=A0* know if we can do resizing, _before_ we attempt to al=
locate
> > it
> > +=A0=A0=A0=A0=A0* with KVM.=A0=A0Before that point, we don't officially=
 know
> > whether
> > +=A0=A0=A0=A0=A0* we'll control the HPT or not.=A0=A0So we have to use =
a fallback
> > +=A0=A0=A0=A0=A0* test for PR vs HV KVM to predict that.
> > +=A0=A0=A0=A0=A0*/
> > +=A0=A0=A0=A0if (kvmppc_is_pr(kvm_state)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0error_setg(errp, "Hash page table resizing not available w=
ith
> > this KVM version");
> > +}
> > diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
> > index 841a29b..3e852ba 100644
> > --- a/target-ppc/kvm_ppc.h
> > +++ b/target-ppc/kvm_ppc.h
> > @@ -59,6 +59,7 @@ bool kvmppc_has_cap_htm(void);
> > =A0int kvmppc_enable_hwrng(void);
> > =A0int kvmppc_put_books_sregs(PowerPCCPU *cpu);
> > =A0PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> > +void kvmppc_check_papr_resize_hpt(Error **errp);
> > =A0
> > =A0#else
> > =A0
> > @@ -270,6 +271,10 @@ static inline PowerPCCPUClass
> > *kvm_ppc_get_host_cpu_class(void)
> > =A0=A0=A0=A0=A0return NULL;
> > =A0}
> > =A0
> > +static inline void kvmppc_check_papr_resize_hpt(Error **errp)
> > +{
> > +=A0=A0=A0=A0return;
> > +}
> > =A0#endif
> > =A0
> > =A0#ifndef CONFIG_KVM
> Since you're adding a new machine option it would be nice if this was
> documented in the help message.

Um.. which help message do you mean exactly?  I've attached a property
description, so we get something in qemu-system-ppc64 -M pseries,?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5FetH82qe0Z6y/zI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUezjAAoJEGw4ysog2bOSECEP/3FT5gpgwB9I66rXlWv/RcqO
W4GyTeMCasXtIICm+FVvLvh+dGNzSzYTJLHtgvc3mtOAooTa0bpcJW2X4MzyPVHD
wPommUF8cdGNOvKzHWCNNhr0GJhTPKpLid8ZdfgeGTaon303aiG0yByvxLQk0m7p
jkbiU0fTFb1/27+ensM38X2yjubOM9HELLANKKlot/oA9agB+zyaAxcx6ZMSNLlI
/ZkN2Nron23X8e5rnYC9UfWZSVL6e5M5CHXSN92+Wf8MAfT8tdnK1QWojPr3fpIy
aaJpq87Fxc8rUsI5QkCKijmyVbzLvTzkuqvg+FRYh4mFpQzlIj4DA5Y8xC7hfVO9
2FhaYogNkex8rYbVUyuub/TelYfjUi1D9wYUTOIk5Ov855YoxZ1VeKL9gtAIgETT
PP5q4FIYR81CamJXYHWrGCWqKIiQNXvdEfw4HfEh5lEHYdUjN+IhIsUaXQ8Mt5qY
ke8oWM36pdQjhSu1oucqPFa2iCBtgJpHHDh2A4gIqHB2A7DWy6Af7MF33qAfAanM
INQJYXXlHNmkhayS9Tqm+6N8VW/urLjdnCKnTTp5yzdtIQIGJa9s2cfNbpDsRgS3
QRKmSQyeK9UXoibf5eaDMyMmXJmg+zlren5+pMkeuaZ5bg/fCRbnt7Y2Hfo643HP
pagn6YEY3lvc0hs1EZpm
=D2Sv
-----END PGP SIGNATURE-----

--5FetH82qe0Z6y/zI--
