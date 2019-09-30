Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56018C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E215224EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E215224EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF1Og-0002mZ-8M
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 15:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iF1MQ-0001R0-UW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iF1MP-00063e-JE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:29:30 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:42839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iF1MP-00062F-AD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:29:29 -0400
Received: from player730.ha.ovh.net (unknown [10.109.159.222])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id C5356191A48
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 21:29:26 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 08746A46F38D;
 Mon, 30 Sep 2019 19:29:14 +0000 (UTC)
Subject: Re: [PATCH v2 29/33] spapr, xics, xive: Move SpaprIrq::reset hook
 logic into activate/deactivate
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-30-david@gibson.dropbear.id.au>
 <f64cc1b3-95b1-08e8-8059-35cdf2e5153b@kaod.org>
 <20190930082543.GH11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9cbf05e4-c404-589f-e03f-9808f964a762@kaod.org>
Date: Mon, 30 Sep 2019 21:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930082543.GH11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 6311231928425941785
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedvgddufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.43.205
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
 groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/2019 10:25, David Gibson wrote:
> On Mon, Sep 30, 2019 at 08:11:56AM +0200, C=E9dric Le Goater wrote:
>> On 27/09/2019 07:50, David Gibson wrote:
>>> It turns out that all the logic in the SpaprIrq::reset hooks (and som=
e in
>>> the SpaprIrq::post_load hooks) isn't really related to resetting the =
irq
>>> backend (that's handled by the backends' own reset routines).  Rather=
 its
>>> about getting the backend ready to be the active interrupt controller=
 or
>>> stopping being the active interrupt controller - reset (and post_load=
) is
>>> just the only time that changes at present.
>>
>> This is a 'critical' part which impacts all the migration cases:=20
>>
>> ic-mode=3Dxics,xive,dual + kernel_irqchip=3Don/off + TCG
>=20
> Yes... and?

and it's fragile. =20

>>> To make this flow clearer, move the logic into the explicit backend
>>> activate and deactivate hooks.
>>
>> I don't see where the hooks are called ?
>=20
> spapr_irq_reset()
>   -> spapr_irq_update_active_intc()
>     -> set_active_intc()
>       -> activate/deactivate hooks
>=20
> Similarly via spapr_irq_post_load().
>=20
> I'm hoping to add one at CAS time to avoid the CAS reboot, too.

OK. I think the first 22 patches are ready, just some minor comments
if I am correct. Could you merge them ?

C.



