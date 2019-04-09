Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43450C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCEC20857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCEC20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDjgf-0000ZQ-68
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 01:52:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjfr-0000F5-Nq
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjfq-0006wM-Mp
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDjfq-0006v4-Ck
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:51:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FBCA3082B40;
	Tue,  9 Apr 2019 05:51:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B2095D9C9;
	Tue,  9 Apr 2019 05:51:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A3C891138648; Tue,  9 Apr 2019 07:51:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Lidong Chen <lidong.chen@oracle.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
Date: Tue, 09 Apr 2019 07:51:51 +0200
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	(Lidong Chen's message of "Mon, 8 Apr 2019 15:04:36 -0400")
Message-ID: <87mukziv48.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 09 Apr 2019 05:51:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
	f4bug@amsat.org, darren.kenny@oracle.com,
	Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409055151.7m-VLjcfR-sisIDae2O00bDs_GuvZQRbKtcgLUsiCnQ@z>

Lidong Chen <lidong.chen@oracle.com> writes:

> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>      if (state == sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <= ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>  
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>      if (rsp == sd_r1b) {
>          rsp = sd_r1;
>      }
> -    assert(rsp <= ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }

This is the second fix for this bug pattern in a fortnight.  Where's
one, there are more:

$ git-grep '<= ARRAY_SIZE'
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {
hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);
hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));
hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));
tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));

Lidong Chen, would you like to have a look at these?

Cc'ing maintainers to help with further investigation.

