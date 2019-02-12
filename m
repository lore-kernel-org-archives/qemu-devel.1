Received: from eggs.gnu.org ([209.51.188.92]:36947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtSSM-0006Sy-Ha
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gtSFH-0001hE-Ez
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:12:45 -0500
Received: from 8.mo7.mail-out.ovh.net ([46.105.77.114]:52284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gtSFD-0001bm-KU
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:12:41 -0500
Received: from player735.ha.ovh.net (unknown [10.109.160.217])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id A98CEFF685
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 08:12:34 +0100 (CET)
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-12-clg@kaod.org>
	<20190212010151.GF1884@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9bee8eef-0389-de01-9b71-691124eecf5e@kaod.org>
Date: Tue, 12 Feb 2019 08:12:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190212010151.GF1884@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/13] spapr: check for the activation of
 the KVM IRQ device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/12/19 2:01 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:39:44PM +0100, C=E9dric Le Goater wrote:
>> The activation of the KVM IRQ device depends on the interrupt mode
>> chosen at CAS time by the machine and some methods used at reset or by
>> the migration need to be protected.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive_kvm.c | 28 ++++++++++++++++++++++++++++
>>  hw/intc/xics_kvm.c       | 25 ++++++++++++++++++++++++-
>>  2 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index 93ea8e71047a..d35814c1992e 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -95,9 +95,15 @@ static void kvmppc_xive_cpu_set_state(XiveTCTX *tct=
x, Error **errp)
>> =20
>>  void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
>>  {
>> +    sPAPRXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
>>      uint64_t state[4] =3D { 0 };
>>      int ret;
>> =20
>> +    /* The KVM XIVE device is not in use */
>> +    if (xive->fd =3D=3D -1) {
>> +        return;
>> +    }
>> +
>>      ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
>>      if (ret !=3D 0) {
>>          error_setg_errno(errp, errno,
>> @@ -151,6 +157,11 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Erro=
r **errp)
>>      unsigned long vcpu_id;
>>      int ret;
>> =20
>> +    /* The KVM XIVE device is not in use */
>> +    if (xive->fd =3D=3D -1) {
>> +        return;
>> +    }
>> +
>>      /* Check if CPU was hot unplugged and replugged. */
>>      if (kvm_cpu_is_enabled(tctx->cs)) {
>>          return;
>> @@ -234,9 +245,13 @@ static void kvmppc_xive_source_get_state(XiveSour=
ce *xsrc)
>>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>>  {
>>      XiveSource *xsrc =3D opaque;
>> +    sPAPRXive *xive =3D SPAPR_XIVE(xsrc->xive);
>>      struct kvm_irq_level args;
>>      int rc;
>> =20
>> +    /* The KVM XIVE device should be in use */
>> +    assert(xive->fd !=3D -1);
>> +
>>      args.irq =3D srcno;
>>      if (!xive_source_irq_is_lsi(xsrc, srcno)) {
>>          if (!val) {
>> @@ -580,6 +595,11 @@ int kvmppc_xive_pre_save(sPAPRXive *xive)
>>      Error *local_err =3D NULL;
>>      CPUState *cs;
>> =20
>> +    /* The KVM XIVE device is not in use */
>> +    if (xive->fd =3D=3D -1) {
>> +        return 0;
>> +    }
>> +
>>      /* Grab the EAT */
>>      kvmppc_xive_get_eas_state(xive, &local_err);
>>      if (local_err) {
>> @@ -612,6 +632,9 @@ int kvmppc_xive_post_load(sPAPRXive *xive, int ver=
sion_id)
>>      Error *local_err =3D NULL;
>>      CPUState *cs;
>> =20
>> +    /* The KVM XIVE device should be in use */
>> +    assert(xive->fd !=3D -1);
>=20
> I'm guessing this is an assert() because the handler shouldn't be
> registered when we're not in KVM mode.  But wouldn't that also be true
> of the pre_save hook, which errors out rather than asserting?

The handlers are not symetric.

The pre_save is registered in the vmstate of the sPAPRXive model and the=20
post_load is handled at the machine level after all XIVE state have been
transferred.

C.

>=20
>>      /* Restore the ENDT first. The targetting depends on it. */
>>      CPU_FOREACH(cs) {
>>          kvmppc_xive_set_eq_state(xive, cs, &local_err);
>> @@ -649,6 +672,11 @@ void kvmppc_xive_synchronize_state(sPAPRXive *xiv=
e, Error **errp)
>>      CPUState *cs;
>>      Error *local_err =3D NULL;
>> =20
>> +    /* The KVM XIVE device is not in use */
>> +    if (xive->fd =3D=3D -1) {
>> +        return;
>> +    }
>> +
>>      /*
>>       * When the VM is stopped, the sources are masked and the previou=
s
>>       * state is saved in anticipation of a migration. We should not
>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
>> index da6a00bc88cc..651bbfdf6966 100644
>> --- a/hw/intc/xics_kvm.c
>> +++ b/hw/intc/xics_kvm.c
>> @@ -68,6 +68,11 @@ static void icp_get_kvm_state(ICPState *icp)
>>      uint64_t state;
>>      int ret;
>> =20
>> +    /* The KVM XICS device is not in use */
>> +    if (kernel_xics_fd =3D=3D -1) {
>> +        return;
>> +    }
>> +
>>      /* ICP for this CPU thread is not in use, exiting */
>>      if (!icp->cs) {
>>          return;
>> @@ -104,6 +109,11 @@ static int icp_set_kvm_state(ICPState *icp, int v=
ersion_id)
>>      uint64_t state;
>>      int ret;
>> =20
>> +    /* The KVM XICS device is not in use */
>> +    if (kernel_xics_fd =3D=3D -1) {
>> +        return 0;
>> +    }
>> +
>>      /* ICP for this CPU thread is not in use, exiting */
>>      if (!icp->cs) {
>>          return 0;
>> @@ -140,8 +150,8 @@ static void icp_kvm_connect(ICPState *icp, Error *=
*errp)
>>      unsigned long vcpu_id;
>>      int ret;
>> =20
>> +    /* The KVM XICS device is not in use */
>>      if (kernel_xics_fd =3D=3D -1) {
>> -        abort();
>>          return;
>>      }
>> =20
>> @@ -220,6 +230,11 @@ static void ics_get_kvm_state(ICSState *ics)
>>      uint64_t state;
>>      int i;
>> =20
>> +    /* The KVM XICS device is not in use */
>> +    if (kernel_xics_fd =3D=3D -1) {
>> +        return;
>> +    }
>> +
>>      for (i =3D 0; i < ics->nr_irqs; i++) {
>>          ICSIRQState *irq =3D &ics->irqs[i];
>> =20
>> @@ -279,6 +294,11 @@ static int ics_set_kvm_state(ICSState *ics, int v=
ersion_id)
>>      int i;
>>      Error *local_err =3D NULL;
>> =20
>> +    /* The KVM XICS device is not in use */
>> +    if (kernel_xics_fd =3D=3D -1) {
>> +        return 0;
>> +    }
>> +
>>      for (i =3D 0; i < ics->nr_irqs; i++) {
>>          ICSIRQState *irq =3D &ics->irqs[i];
>>          int ret;
>> @@ -325,6 +345,9 @@ void ics_kvm_set_irq(void *opaque, int srcno, int =
val)
>>      struct kvm_irq_level args;
>>      int rc;
>> =20
>> +    /* The KVM XICS device should be in use */
>> +    assert(kernel_xics_fd !=3D -1);
>> +
>>      args.irq =3D srcno + ics->offset;
>>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MSI) {
>>          if (!val) {
>=20
