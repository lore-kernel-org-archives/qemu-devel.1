Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACAC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 04:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1B92080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 04:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="DsaXz8IB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zcCUfpDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1B92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBAVO-000535-Ba
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 00:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iBARj-0002JC-GD
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iBAFX-0000FS-3P
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:10:28 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iBAFV-0000D2-EF; Fri, 20 Sep 2019 00:10:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 8858A43B;
 Fri, 20 Sep 2019 00:10:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Fri, 20 Sep 2019 00:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=UW1Cg
 mzJ7CdZcE8MiL6kgnKE/N4lIiJRMpjE0HFtCl4=; b=DsaXz8IBNKHv7T9zWfwtf
 FZOt5Y7XO7B6fRpz7omkuvp20iaGoNTrpEKIj5QgvCJNyBuy1qCKYdHNV4uvdXV1
 Ho5/16Sx1YLpojCutoqvTexX8UeMFKmQFnqFs9EgZHaUDSnGwjFwIwRaBOmSmwZc
 w1iLbMynKpb+EwdpUGJ6JygJGINT+VKE+3PZP+yq3V8HLEioJ5O93TEIuxkUP+Lj
 e9oEQjs8s8/s193G70re55sdbpi5g2eZKNpvcHW38BKx3z4x9MxbgvnJyESBnOAD
 hNQmbRf8pfw0+fRPGQ6yWjKeunhojz+uGUpTUMQy7yPoyiIq+N2qwj+T2IDCuIFC
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=UW1CgmzJ7CdZcE8MiL6kgnKE/N4lIiJRMpjE0HFtC
 l4=; b=zcCUfpDJghFAelT+A5siZrZk+qCrqdkBPh42N/6tKw2d5lqEi6jpivVYt
 xSwmPMihvyK5moG+Vuow9dSTUsiNnzxhh9YJ1fpQrYCxyworel4p+6Ly+rz9hkVC
 XABcVOWpZTBZTAO6bQrtlhpEGdpASJFmi9CrQ/1MoUucygUk7bAbyW1q4FHVtXvd
 8k3osFsCkhV+7v/TvD8Qe2uEVs0ujsc6tRsWO1M9Y2En47QaDBKN6Pz68XeNMVN9
 uknO4BeqkLB01qSDQNr7UhJyqNlKAepaDrVjMGVWNsSXAxoiuhiif0E8aFVUjqSX
 +IKBBmRxHBDpdyoV636MrMuaem1LA==
X-ME-Sender: <xms:LlGEXboU_Qk2lXc0-TW2Ot_Rxhud_wUWAtF54MPOXGbShCEw2oaNPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddugdejlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
 rhfuihiivgeptd
X-ME-Proxy: <xmx:LlGEXdHmqroc77K2MSlS64zJQPlBWqLBkkcpY3yTuD0afj-RGhANFg>
 <xmx:LlGEXVkVTkFSyzM81e0XQUFl7MHGU5BUlziWf-F55x3MDjlrDRXVIg>
 <xmx:LlGEXYmQQ7qtSkidxFDD85GfFhZbcKeac9dqmaUtrwVvlI_2gCtOIQ>
 <xmx:L1GEXYtLgMyK_jYSUc5y_i-9zTrm28XEvic08YL2Ens_N7hu3WIy1Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4A997E00A9; Fri, 20 Sep 2019 00:10:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-238-g170a812-fmstable-20190913v1
Mime-Version: 1.0
Message-Id: <139c3f7e-465e-4efb-b6c7-213dcd2ec6b7@www.fastmail.com>
In-Reply-To: <20190919055002.6729-4-clg@kaod.org>
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-4-clg@kaod.org>
Date: Fri, 20 Sep 2019 13:40:58 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 03/21] hw: aspeed_scu: Add AST2600 support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 64.147.123.20
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 19 Sep 2019, at 15:19, C=C3=A9dric Le Goater wrote:
> From: Joel Stanley <joel@jms.id.au>
>=20
> The SCU controller on the AST2600 SoC has extra registers. Increase
> the number of regs of the model and introduce a new field in the class=

> to customize the MemoryRegion operations depending on the SoC model.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> [clg: - improved commit log
>       - changed vmstate version
>       - reworked model integration into new objet class ]
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/misc/aspeed_scu.h |   7 +-
>  hw/misc/aspeed_scu.c         | 190 +++++++++++++++++++++++++++++++++-=
-
>  2 files changed, 189 insertions(+), 8 deletions(-)

...

> +static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,=20
> uint64_t data,
> +                                     unsigned size)
> +{
> +    AspeedSCUState *s =3D ASPEED_SCU(opaque);
> +    int reg =3D TO_REG(offset);
> +
> +    if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%"=20
> HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n",=20
> __func__);
> +    }
> +
> +    trace_aspeed_scu_write(offset, size, data);
> +
> +    switch (reg) {
> +    case AST2600_PROT_KEY:
> +        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> +        return;
> +    case AST2600_HW_STRAP1:
> +    case AST2600_HW_STRAP2:
> +        if (s->regs[reg + 2]) {
> +            return;
> +        }
> +        /* fall through */
> +    case AST2600_SYS_RST_CTRL:
> +    case AST2600_SYS_RST_CTRL2:
> +        /* W1S (Write 1 to set) registers */
> +        s->regs[reg] |=3D data;
> +        return;
> +    case AST2600_SYS_RST_CTRL_CLR:
> +    case AST2600_SYS_RST_CTRL2_CLR:
> +    case AST2600_HW_STRAP1_CLR:
> +    case AST2600_HW_STRAP2_CLR:
> +        /* W1C (Write 1 to clear) registers */
> +        s->regs[reg] &=3D ~data;

This clear should respect the protection register for each strap case.

Andrew

