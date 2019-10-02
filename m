Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F75CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2487821783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487821783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfvz-0003T3-9o
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFfvE-0002vb-Nq
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFfvC-0005mk-Db
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:48:08 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:58703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFfvC-0005lP-3G
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:48:06 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.175])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 796CD144086
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 16:48:03 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id A9B65A74F321;
 Wed,  2 Oct 2019 14:47:57 +0000 (UTC)
Subject: Re: [PATCH] spapr/xive: skip partially initialized vCPUs in presenter
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <20191001085722.32755-1-clg@kaod.org>
 <20191001130614.226ef6a2@bahia.w3ibm.bluemix.net>
 <fad6aae9-8722-498c-730d-fa204f07e3c5@kaod.org>
 <20191001185629.0b284ba1@bahia.lan> <20191002010245.GT11105@umbus.fritz.box>
 <20191002162142.7ce18dcb@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3db4ae61-a4f0-3ddf-e734-5795c7176559@kaod.org>
Date: Wed, 2 Oct 2019 16:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002162142.7ce18dcb@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13303914777820826451
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeeigdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.175
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2019 16:21, Greg Kurz wrote:
> On Wed, 2 Oct 2019 11:02:45 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
>> On Tue, Oct 01, 2019 at 06:56:28PM +0200, Greg Kurz wrote:
>>> On Tue, 1 Oct 2019 13:56:10 +0200
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>> On 01/10/2019 13:06, Greg Kurz wrote:
>>>>> On Tue,  1 Oct 2019 10:57:22 +0200
>>>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>>>
>>>>>> When vCPUs are hotplugged, they are added to the QEMU CPU list bef=
ore
>>>>>> being fully realized. This can crash the XIVE presenter because th=
e
>>>>>> 'tctx' pointer is not necessarily initialized when looking for a
>>>>>> matching target.
>>>>>>
>>>>>
>>>>> Ouch... :-\
>>>>>
>>>>>> These vCPUs are not valid targets for the presenter. Skip them.
>>>>>>
>>>>>
>>>>> This likely fixes this specific issue, but more generally, this
>>>>> seems to indicate that using CPU_FOREACH() is rather fragile.
>>>>>
>>>>> What about tracking XIVE TM contexts with a QLIST in xive.c ?
>>>>
>>>> This is a good idea. =20
>>>>
>>>> On HW, the thread interrupt contexts belong to the XIVE presenter=20
>>>> subengine. This is the logic doing the CAM line matching to find
>>>> a target for an event notification. So we should model the context=20
>>>> list below the XiveRouter in QEMU which models both router and=20
>>>> presenter subengines. We have done without a presenter model for=20
>>>> the moment and I don't think we will need to introduce one. =20
>>>>
>>>> This would be a nice improvements of my patchset adding support
>>>> for xive escalations and better support of multi chip systems.=20
>>>> I have introduced a PNV_CHIP_CPU_FOREACH in this patchset which=20
>>>> would become useless with a list of tctx under the XIVE interrupt
>>>> controller, XiveRouter, SpaprXive, PnvXive.
>>>>
>>>
>>> I agree. It makes more sense to have the list below the XiveRouter,
>>> rather than relying on CPU_FOREACH(), which looks a bit weird from
>>> a device emulation code perspective.
>>
>> That does sound like a better idea long term.  However, for now, I
>> think the NULL check is a reasonable way of fixing the real error
>> we're hitting, so I've applied the patch here.
>>
>=20
> Fair enough.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
>> Future cleanups to a different approach remain welcome, of course.
>>
>=20
> I've started to look. This should simplify Cedric's "add XIVE support
> for KVM guests" series, but I'll wait for your massive cleanup series
> to get merged first.


This is a combo patchset.=20


These are prereqs fixes related to the presenter and how CAM lines
are scanned. This is in direct relation with the CPU_FOREACH() issue.

  ppc/xive: Introduce a XivePresenter interface
  ppc/xive: Implement the XivePresenter interface
  ppc/pnv: Introduce a PNV_CHIP_CPU_FOREACH() helper
  ppc/pnv: Introduce a pnv_xive_is_cpu_enabled() helper
  ppc/xive: Introduce a XiveFabric interface
  ppc/pnv: Implement the XiveFabric interface
  ppc/spapr: Implement the XiveFabric interface
  ppc/xive: Use the XiveFabric and XivePresenter interfaces

These are for interrupt resend (escalation). To be noted, the removal=20
of the get_tctx() XiveRouter handler which has some relation with=20
the previous subserie.

  ppc/xive: Extend the TIMA operation with a XivePresenter parameter
  ppc/pnv: Clarify how the TIMA is accessed on a multichip system
  ppc/xive: Move the TIMA operations to the controller model
  ppc/xive: Remove the get_tctx() XiveRouter handler
  ppc/xive: Introduce a xive_tctx_ipb_update() helper
  ppc/xive: Introduce helpers for the NVT id
  ppc/xive: Synthesize interrupt from the saved IPB in the NVT

This is a bug :

  ppc/pnv: Remove pnv_xive_vst_size() routine
  ppc/pnv: Dump the XIVE NVT table
  ppc/pnv: Skip empty slots of the XIVE NVT table

This is a model for the block id configuration and better support
for multichip systems :=20

  ppc/pnv: Introduce a pnv_xive_block_id() helper
  ppc/pnv: Extend XiveRouter with a get_block_id() handler

Misc improvements :=20

  ppc/pnv: Quiesce some XIVE errors
  ppc/xive: Introduce a xive_os_cam_decode() helper
  ppc/xive: Check V bit in TM_PULL_POOL_CTX
  ppc/pnv: Improve trigger data definition
  ppc/pnv: Use the EAS trigger bit when triggering an interrupt from PSI


I should move some in front to have them merged before hand if=20
possible. They have been on the list for 3 months.=20
=20


>>>> Next step would be to get rid of the tctx->cs pointer. In my latest
>>>> patches, it is only used to calculate the HW CAM line.=20
>>>>
>>>> There might be some consequences on the object hierarchy and it will
>>>> break migration.
>>>>
>>>
>>> This could break if the contexts were devices sitting in a bus, which
>>> isn't the case here. I'll try to come up with a proposal for spapr,
>>> and we can work out the changes on your recent XIVE series for pnv.
>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>>
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>>> index 6d38755f8459..89b9ef7f20b1 100644
>>>>> --- a/include/hw/ppc/xive.h
>>>>> +++ b/include/hw/ppc/xive.h
>>>>> @@ -319,6 +319,8 @@ typedef struct XiveTCTX {
>>>>>      qemu_irq    os_output;
>>>>> =20
>>>>>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
>>>>> +
>>>>> +    QTAILQ_ENTRY(XiveTCTX) next;
>>>>>  } XiveTCTX;
>>>>> =20
>>>>>  /*
>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>>> index b7417210d817..f7721c711041 100644
>>>>> --- a/hw/intc/xive.c
>>>>> +++ b/hw/intc/xive.c
>>>>> @@ -568,6 +568,8 @@ static void xive_tctx_reset(void *dev)
>>>>>          ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
>>>>>  }
>>>>> =20
>>>>> +static QTAILQ_HEAD(, XiveTCTX) xive_tctx_list =3D QTAILQ_HEAD_INIT=
IALIZER(xive_tctx_list);
>>>>> +
>>>>>  static void xive_tctx_realize(DeviceState *dev, Error **errp)
>>>>>  {
>>>>>      XiveTCTX *tctx =3D XIVE_TCTX(dev);
>>>>> @@ -609,10 +611,14 @@ static void xive_tctx_realize(DeviceState *de=
v, Error **errp)
>>>>>      }
>>>>> =20
>>>>>      qemu_register_reset(xive_tctx_reset, dev);
>>>>> +    QTAILQ_INSERT_HEAD(&xive_tctx_list, tctx, next);
>>>>>  }
>>>>> =20
>>>>>  static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
>>>>>  {
>>>>> +    XiveTCTX *tctx =3D XIVE_TCTX(dev);
>>>>> +
>>>>> +    QTAILQ_REMOVE(&xive_tctx_list, tctx, next);
>>>>>      qemu_unregister_reset(xive_tctx_reset, dev);
>>>>>  }
>>>>> =20
>>>>> @@ -1385,15 +1391,14 @@ static bool xive_presenter_match(XiveRouter=
 *xrtr, uint8_t format,
>>>>>                                   bool cam_ignore, uint8_t priority=
,
>>>>>                                   uint32_t logic_serv, XiveTCTXMatc=
h *match)
>>>>>  {
>>>>> -    CPUState *cs;
>>>>> +    XiveTCTX *tctx;
>>>>> =20
>>>>>      /*
>>>>>       * TODO (PowerNV): handle chip_id overwrite of block field for
>>>>>       * hardwired CAM compares
>>>>>       */
>>>>> =20
>>>>> -    CPU_FOREACH(cs) {
>>>>> -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
>>>>> +    QTAILQ_FOREACH(tctx, &xive_tctx_list, next) {
>>>>>          int ring;
>>>>> =20
>>>>>          /*
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>>> ---
>>>>>>  hw/intc/xive.c | 8 ++++++++
>>>>>>  1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>>>> index b7417210d817..29df06df1136 100644
>>>>>> --- a/hw/intc/xive.c
>>>>>> +++ b/hw/intc/xive.c
>>>>>> @@ -1396,6 +1396,14 @@ static bool xive_presenter_match(XiveRouter=
 *xrtr, uint8_t format,
>>>>>>          XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
>>>>>>          int ring;
>>>>>> =20
>>>>>> +        /*
>>>>>> +         * Skip partially initialized vCPUs. This can happen when
>>>>>> +         * vCPUs are hotplugged.
>>>>>> +         */
>>>>>> +        if (!tctx) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>>          /*
>>>>>>           * HW checks that the CPU is enabled in the Physical Thre=
ad
>>>>>>           * Enable Register (PTER).
>>>>>
>>>>
>>>
>>
>=20


