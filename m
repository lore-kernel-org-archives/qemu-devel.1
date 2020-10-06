Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF9DC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C0A206DD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C0A206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqRJ-0004il-RK
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPqQW-0004Bp-CZ; Tue, 06 Oct 2020 13:07:00 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:56931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPqQU-0004Cv-Fo; Tue, 06 Oct 2020 13:07:00 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.12])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id E5EC76957036;
 Tue,  6 Oct 2020 19:06:46 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 6 Oct 2020
 19:06:46 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002ddc99bd4-0fe6-4e2b-8a98-80e295145868,
 ABBA5CC1B3A583228A496F54FDB0659883642288) smtp.auth=groug@kaod.org
Date: Tue, 6 Oct 2020 19:06:45 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 5/6] spapr/xive: Activate StoreEOI at the source level
Message-ID: <20201006190645.33a05694@bahia.lan>
In-Reply-To: <20201005165147.526426-6-clg@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-6-clg@kaod.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 0a95b7fa-a4ad-477f-abe9-b8954898051f
X-Ovh-Tracer-Id: 11828141472394353059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeggddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 11:30:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 18:51:46 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When the StoreEOI capability is "on", the H_INT_GET_SOURCE_INFO will
> set the StoreEOI flag for all sources. This could be an issue if
> StoreEOI is not supported on a specific source, of a passthrough
> device for instance. In that case, we could either introduce a new KVM
> ioctl to query the characteristics of the source at the HW level or
> deactivate StoreEOI on the machine.
>=20
> This is theoretically unsafe on a POWER9 host but it still runs.
>=20

Patch looks good but as said before, what is the likeliness of something
really painful to happen on a POWER9 host ?

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c | 1 +
>  hw/ppc/spapr_irq.c   | 6 ++++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 1fa09f287ac0..41f2719ff93a 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -280,6 +280,7 @@ static void spapr_xive_instance_init(Object *obj)
>      SpaprXive *xive =3D SPAPR_XIVE(obj);
> =20
>      object_initialize_child(obj, "source", &xive->source, TYPE_XIVE_SOUR=
CE);
> +    object_property_add_alias(obj, "flags", OBJECT(&xive->source), "flag=
s");
> =20
>      object_initialize_child(obj, "end_source", &xive->end_source,
>                              TYPE_XIVE_END_SOURCE);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index f59960339ec3..cdf9f9df4173 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -325,9 +325,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Error =
**errp)
> =20
>      if (spapr->irq->xive) {
>          uint32_t nr_servers =3D spapr_max_server_number(spapr);
> +        uint64_t flags =3D 0;
>          DeviceState *dev;
>          int i;
> =20
> +        if (spapr_get_cap(spapr, SPAPR_CAP_STOREEOI) =3D=3D SPAPR_CAP_ON=
) {
> +            flags |=3D XIVE_SRC_STORE_EOI;
> +        }
> +
>          dev =3D qdev_new(TYPE_SPAPR_XIVE);
>          qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_=
BASE);
>          /*
> @@ -337,6 +342,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error *=
*errp)
>          qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
>          object_property_set_link(OBJECT(dev), "xive-fabric", OBJECT(spap=
r),
>                                   &error_abort);
> +        object_property_set_int(OBJECT(dev), "flags", flags, &error_abor=
t);
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> =20
>          spapr->xive =3D SPAPR_XIVE(dev);


