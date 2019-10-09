Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B42BECE58D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2341920B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2341920B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFND-0005JZ-0N
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iI85e-0003IG-UD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iI85d-0006PZ-D0
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:17:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iI85d-0006Lq-5p
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:17:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x999Dkd2008024
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 05:16:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vhbewtwkt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 05:16:51 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 10:16:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 10:16:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x999GjRE31195366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 09:16:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FF1152054;
 Wed,  9 Oct 2019 09:16:45 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 34D9852051;
 Wed,  9 Oct 2019 09:16:45 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-55-18.uk.ibm.com [9.145.55.18])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 415BD220198;
 Wed,  9 Oct 2019 11:16:44 +0200 (CEST)
Subject: Re: [PATCH v4 07/19] spapr: Formalize notion of active interrupt
 controller
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 11:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100909-0020-0000-0000-0000037763B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100909-0021-0000-0000-000021CD6960
Message-Id: <68ad60ba-997e-8ed9-f953-52595bd2dd53@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090087
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x999Dkd2008024
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/2019 08:08, David Gibson wrote:
> spapr now has the mechanism of constructing both XICS and XIVE instance=
s of
> the SpaprInterruptController interface.  However, only one of the inter=
rupt
> controllers will actually be active at any given time, depending on fea=
ture
> negotiation with the guest.  This is handled in the current code via
> spapr_irq_current() which checks the OV5 vector from feature negotiatio=
n to
> determine the current backend.
>=20
> Determining the active controller at the point we need it like this
> can be pretty confusing, because it makes it very non obvious at what
> points the active controller can change.  This can make it difficult
> to reason about the code and where a change of active controller could
> appear in sequence with other events.
>=20
> Make this mechanism more explicit by adding an 'active_intc' pointer
> and an explicit spapr_irq_update_active_intc() function to update it
> from the CAS state.  We also add hooks on the intc backend which will
> get called when it is activated or deactivated.
>=20
> For now we just introduce the switch and hooks, later patches will
> actually start using them.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_irq.c         | 51 ++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h     |  5 ++--
>  include/hw/ppc/spapr_irq.h |  5 ++++
>  3 files changed, 59 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 83882cfad3..249a2688ac 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -586,6 +586,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int i=
rq)
> =20
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
>  {
> +    spapr_irq_update_active_intc(spapr);
>      return spapr->irq->post_load(spapr, version_id);
>  }
> =20
> @@ -593,6 +594,8 @@ void spapr_irq_reset(SpaprMachineState *spapr, Erro=
r **errp)
>  {
>      assert(!spapr->irq_map || bitmap_empty(spapr->irq_map, spapr->irq_=
map_nr));
> =20
> +    spapr_irq_update_active_intc(spapr);
> +
>      if (spapr->irq->reset) {
>          spapr->irq->reset(spapr, errp);
>      }
> @@ -619,6 +622,54 @@ int spapr_irq_get_phandle(SpaprMachineState *spapr=
, void *fdt, Error **errp)
>      return phandle;
>  }
> =20
> +static void set_active_intc(SpaprMachineState *spapr,
> +                            SpaprInterruptController *new_intc)
> +{
> +    SpaprInterruptControllerClass *sicc;
> +
> +    assert(new_intc);
> +
> +    if (new_intc =3D=3D spapr->active_intc) {
> +        /* Nothing to do */
> +        return;
> +    }
> +
> +    if (spapr->active_intc) {
> +        sicc =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +        if (sicc->deactivate) {
> +            sicc->deactivate(spapr->active_intc);
> +        }
> +    }
> +
> +    sicc =3D SPAPR_INTC_GET_CLASS(new_intc);
> +    if (sicc->activate) {
> +        sicc->activate(new_intc, &error_fatal);
> +    }
> +
> +    spapr->active_intc =3D new_intc;
> +}
> +
> +void spapr_irq_update_active_intc(SpaprMachineState *spapr)
> +{
> +    SpaprInterruptController *new_intc;
> +
> +    if (!spapr->ics) {
> +        /*
> +         * XXX before we run CAS, ov5_cas is initialized empty, which
> +         * indicates XICS, even if we have ic-mode=3Dxive.  TODO: clea=
n
> +         * up the CAS path so that we have a clearer way of handling
> +         * this.
> +         */
> +        new_intc =3D SPAPR_INTC(spapr->xive);
> +    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        new_intc =3D SPAPR_INTC(spapr->xive);
> +    } else {
> +        new_intc =3D SPAPR_INTC(spapr->ics);
> +    }
> +
> +    set_active_intc(spapr, new_intc);
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cbd1a4c9f3..763da757f0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -143,7 +143,6 @@ struct SpaprMachineState {
>      struct SpaprVioBus *vio_bus;
>      QLIST_HEAD(, SpaprPhbState) phbs;
>      struct SpaprNvram *nvram;
> -    ICSState *ics;
>      SpaprRtcState rtc;
> =20
>      SpaprResizeHpt resize_hpt;
> @@ -195,9 +194,11 @@ struct SpaprMachineState {
> =20
>      int32_t irq_map_nr;
>      unsigned long *irq_map;
> -    SpaprXive  *xive;
>      SpaprIrq *irq;
>      qemu_irq *qirqs;
> +    SpaprInterruptController *active_intc;
> +    ICSState *ics;
> +    SpaprXive *xive;
> =20
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      SpaprCapabilities def, eff, mig;
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index adfef0fcbe..593059eff5 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -44,6 +44,9 @@ typedef struct SpaprInterruptController SpaprInterrup=
tController;
>  typedef struct SpaprInterruptControllerClass {
>      InterfaceClass parent;
> =20
> +    int (*activate)(SpaprInterruptController *intc, Error **errp);
> +    void (*deactivate)(SpaprInterruptController *intc);
> +
>      /*
>       * These methods will typically be called on all intcs, active and
>       * inactive
> @@ -55,6 +58,8 @@ typedef struct SpaprInterruptControllerClass {
>      void (*free_irq)(SpaprInterruptController *intc, int irq);
>  } SpaprInterruptControllerClass;
> =20
> +void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> +
>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>                                PowerPCCPU *cpu, Error **errp);
> =20
>=20


