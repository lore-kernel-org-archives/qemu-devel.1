Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B82C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C2920752
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C2920752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKOc-0007lP-N0
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jWKNY-0007Ce-6w
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:46:28 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:59785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jWKNW-0000Wp-M2
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:46:27 -0400
Received: from player772.ha.ovh.net (unknown [10.108.57.95])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id E4BC120E83E
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 15:46:14 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id C5DAE12254ADE;
 Wed,  6 May 2020 13:46:09 +0000 (UTC)
Subject: Re: [PATCH] aspeed: sdmc: Implement AST2600 locking behaviour
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20200505090136.341426-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <46a86f01-0e46-f96f-c1d7-d4ffc9f2974d@kaod.org>
Date: Wed, 6 May 2020 15:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505090136.341426-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13809725309549906752
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrjeekgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.59.196; envelope-from=clg@kaod.org;
 helo=7.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 09:46:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 11:01 AM, Joel Stanley wrote:
> The AST2600 handles this differently with the extra 'hardlock' state, so
> move the testing to the soc specific class' write callback.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  hw/misc/aspeed_sdmc.c | 55 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 02940e7c2a76..7c688becf8c7 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -23,7 +23,12 @@
>  
>  /* Protection Key Register */
>  #define R_PROT            (0x00 / 4)
> +#define   PROT_UNLOCKED      0x01
> +#define   PROT_HARDLOCKED    0x10  /* AST2600 */
> +#define   PROT_SOFTLOCKED    0x00
> +
>  #define   PROT_KEY_UNLOCK     0xFC600309
> +#define   PROT_KEY_HARDLOCK   0xDEADDEAD /* AST2600 */
>  
>  /* Configuration Register */
>  #define R_CONF            (0x04 / 4)
> @@ -130,16 +135,6 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
>          return;
>      }
>  
> -    if (addr == R_PROT) {
> -        s->regs[addr] = (data == PROT_KEY_UNLOCK) ? 1 : 0;
> -        return;
> -    }
> -
> -    if (!s->regs[R_PROT]) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
> -        return;
> -    }
> -
>      asc->write(s, addr, data);
>  }
>  
> @@ -291,6 +286,16 @@ static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
>  static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>                                     uint32_t data)
>  {
> +    if (reg == R_PROT) {
> +        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED : PROT_SOFTLOCKED;
> +        return;
> +    }
> +
> +    if (!s->regs[R_PROT]) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
> +        return;
> +    }
> +
>      switch (reg) {
>      case R_CONF:
>          data = aspeed_2400_sdmc_compute_conf(s, data);
> @@ -339,6 +344,16 @@ static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
>  static void aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>                                     uint32_t data)
>  {
> +    if (reg == R_PROT) {
> +        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED : PROT_SOFTLOCKED;
> +        return;
> +    }
> +
> +    if (!s->regs[R_PROT]) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
> +        return;
> +    }
> +
>      switch (reg) {
>      case R_CONF:
>          data = aspeed_2500_sdmc_compute_conf(s, data);
> @@ -395,7 +410,27 @@ static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
>  static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
>                                     uint32_t data)
>  {
> +    if (s->regs[R_PROT] == PROT_HARDLOCKED) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked until system reset!\n",
> +                __func__);
> +        return;
> +    }
> +
> +    if (reg != R_PROT && s->regs[R_PROT] == PROT_SOFTLOCKED) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
> +        return;
> +    }
> +
>      switch (reg) {
> +    case R_PROT:
> +        if (data == PROT_KEY_UNLOCK)  {
> +            data = PROT_UNLOCKED;
> +        } else if (data == PROT_KEY_HARDLOCK) {
> +            data = PROT_HARDLOCKED;
> +        } else {
> +            data = PROT_SOFTLOCKED;
> +        }
> +        break;
>      case R_CONF:
>          data = aspeed_2600_sdmc_compute_conf(s, data);
>          break;
> 


