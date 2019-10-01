Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8639C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBF120640
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBF120640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFGn2-0006Xv-MP
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 07:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFGlQ-0005Xx-S9
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFGlP-0005PV-G0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:56:20 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:51692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFGlP-0005Np-9I
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:56:19 -0400
Received: from player738.ha.ovh.net (unknown [10.108.57.141])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id A9AC0118F11
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 13:56:16 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 3235BA8DD751;
 Tue,  1 Oct 2019 11:56:11 +0000 (UTC)
Subject: Re: [PATCH] spapr/xive: skip partially initialized vCPUs in presenter
To: Greg Kurz <groug@kaod.org>
References: <20191001085722.32755-1-clg@kaod.org>
 <20191001130614.226ef6a2@bahia.w3ibm.bluemix.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fad6aae9-8722-498c-730d-fa204f07e3c5@kaod.org>
Date: Tue, 1 Oct 2019 13:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001130614.226ef6a2@bahia.w3ibm.bluemix.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4530621229039061843
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeeggdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.49
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/2019 13:06, Greg Kurz wrote:
> On Tue,  1 Oct 2019 10:57:22 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> When vCPUs are hotplugged, they are added to the QEMU CPU list before
>> being fully realized. This can crash the XIVE presenter because the
>> 'tctx' pointer is not necessarily initialized when looking for a
>> matching target.
>>
>=20
> Ouch... :-\
>=20
>> These vCPUs are not valid targets for the presenter. Skip them.
>>
>=20
> This likely fixes this specific issue, but more generally, this
> seems to indicate that using CPU_FOREACH() is rather fragile.
>=20
> What about tracking XIVE TM contexts with a QLIST in xive.c ?

This is a good idea. =20

On HW, the thread interrupt contexts belong to the XIVE presenter=20
subengine. This is the logic doing the CAM line matching to find
a target for an event notification. So we should model the context=20
list below the XiveRouter in QEMU which models both router and=20
presenter subengines. We have done without a presenter model for=20
the moment and I don't think we will need to introduce one. =20

This would be a nice improvements of my patchset adding support
for xive escalations and better support of multi chip systems.=20
I have introduced a PNV_CHIP_CPU_FOREACH in this patchset which=20
would become useless with a list of tctx under the XIVE interrupt
controller, XiveRouter, SpaprXive, PnvXive.

Next step would be to get rid of the tctx->cs pointer. In my latest
patches, it is only used to calculate the HW CAM line.=20

There might be some consequences on the object hierarchy and it will
break migration.

Thanks,

C.

>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 6d38755f8459..89b9ef7f20b1 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -319,6 +319,8 @@ typedef struct XiveTCTX {
>      qemu_irq    os_output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> +
> +    QTAILQ_ENTRY(XiveTCTX) next;
>  } XiveTCTX;
> =20
>  /*
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index b7417210d817..f7721c711041 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -568,6 +568,8 @@ static void xive_tctx_reset(void *dev)
>          ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
>  }
> =20
> +static QTAILQ_HEAD(, XiveTCTX) xive_tctx_list =3D QTAILQ_HEAD_INITIALI=
ZER(xive_tctx_list);
> +
>  static void xive_tctx_realize(DeviceState *dev, Error **errp)
>  {
>      XiveTCTX *tctx =3D XIVE_TCTX(dev);
> @@ -609,10 +611,14 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
>      }
> =20
>      qemu_register_reset(xive_tctx_reset, dev);
> +    QTAILQ_INSERT_HEAD(&xive_tctx_list, tctx, next);
>  }
> =20
>  static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
>  {
> +    XiveTCTX *tctx =3D XIVE_TCTX(dev);
> +
> +    QTAILQ_REMOVE(&xive_tctx_list, tctx, next);
>      qemu_unregister_reset(xive_tctx_reset, dev);
>  }
> =20
> @@ -1385,15 +1391,14 @@ static bool xive_presenter_match(XiveRouter *xr=
tr, uint8_t format,
>                                   bool cam_ignore, uint8_t priority,
>                                   uint32_t logic_serv, XiveTCTXMatch *m=
atch)
>  {
> -    CPUState *cs;
> +    XiveTCTX *tctx;
> =20
>      /*
>       * TODO (PowerNV): handle chip_id overwrite of block field for
>       * hardwired CAM compares
>       */
> =20
> -    CPU_FOREACH(cs) {
> -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> +    QTAILQ_FOREACH(tctx, &xive_tctx_list, next) {
>          int ring;
> =20
>          /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index b7417210d817..29df06df1136 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1396,6 +1396,14 @@ static bool xive_presenter_match(XiveRouter *xr=
tr, uint8_t format,
>>          XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
>>          int ring;
>> =20
>> +        /*
>> +         * Skip partially initialized vCPUs. This can happen when
>> +         * vCPUs are hotplugged.
>> +         */
>> +        if (!tctx) {
>> +            continue;
>> +        }
>> +
>>          /*
>>           * HW checks that the CPU is enabled in the Physical Thread
>>           * Enable Register (PTER).
>=20


