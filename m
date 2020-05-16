Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EECC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 14:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14E22065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 14:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14E22065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZy7b-00006S-Ss
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 10:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jZy6t-0007rj-39
 for qemu-devel@nongnu.org; Sat, 16 May 2020 10:48:19 -0400
Received: from relay68.bu.edu ([128.197.228.73]:33979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jZy6r-0001as-TM
 for qemu-devel@nongnu.org; Sat, 16 May 2020 10:48:18 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 04GElEfm031138
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 16 May 2020 10:47:18 -0400
Date: Sat, 16 May 2020 10:47:14 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] ati-vga: Do not allow unaligned access via index register
Message-ID: <20200516144706.zz54mgs7k7anq3cj@mozz.bu.edu>
References: <20200516132352.39E9374594E@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516132352.39E9374594E@zero.eik.bme.hu>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 10:48:17
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200516 1513, BALATON Zoltan wrote:
> According to docs bits 1 and 0 of MM_INDEX are hard coded to 0 so
> unaligned access via this register should not be possible.
> This also fixes problems reported in bug #1878134.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Hi Zoltan,
I applied this patch and confirmed that I cannot reproduce the crash in #1878134
Thanks!

Acked-by: Alexander Bulekov <alxndr@bu.edu>

>  hw/display/ati.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f4c4542751..2ee23173b2 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -531,7 +531,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>      }
>      switch (addr) {
>      case MM_INDEX:
> -        s->regs.mm_index = data;
> +        s->regs.mm_index = data & ~3;
>          break;
>      case MM_DATA ... MM_DATA + 3:
>          /* indexed access to regs or memory */
> -- 
> 2.21.3
> 
> 

