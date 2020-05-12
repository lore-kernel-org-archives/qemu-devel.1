Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5025CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794C3206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794C3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXXF-0001PY-IC
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1jYXWH-0000kl-BD; Tue, 12 May 2020 12:12:37 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:8521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1jYXWE-00067s-L1; Tue, 12 May 2020 12:12:36 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EFA7442D8B;
 Tue, 12 May 2020 18:03:03 +0200 (CEST)
Subject: Re: [RFC PATCH 2/3] block: Allow bdrv_run_co() from different
 AioContext
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-3-kwolf@redhat.com>
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
Message-ID: <47293da5-b5e5-e61f-753d-4d16712f6d12@proxmox.com>
Date: Tue, 12 May 2020 18:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200512144318.181049-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 12:03:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, s.reiter@proxmox.com, armbru@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 4:43 PM, Kevin Wolf wrote:
> Coroutine functions that are entered through bdrv_run_co() are already
> safe to call from synchronous code in a different AioContext because
> bdrv_coroutine_enter() will schedule them in the context of the node.
> 
> However, the coroutine fastpath still requires that we're already in the
> right AioContext when called in coroutine context.
> 
> In order to make the behaviour more consistent and to make life a bit
> easier for callers, let's check the AioContext and automatically move
> the current coroutine around if we're not in the right context yet.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/block/io.c b/block/io.c
> index c1badaadc9..7808e8bdc0 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -895,8 +895,21 @@ static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
>                         void *opaque, int *ret)
>  {
>      if (qemu_in_coroutine()) {
> -        /* Fast-path if already in coroutine context */
> +        Coroutine *self = qemu_coroutine_self();
> +        AioContext *bs_ctx = bdrv_get_aio_context(bs);
> +        AioContext *co_ctx = qemu_coroutine_get_aio_context(self);
> +
> +        if (bs_ctx != co_ctx) {
> +            /* Move to the iothread of the node */
> +            aio_co_schedule(bs_ctx, self);
> +            qemu_coroutine_yield();
> +        }
>          entry(opaque);
> +        if (bs_ctx != co_ctx) {
> +            /* Move back to the original AioContext */
> +            aio_co_schedule(bs_ctx, self);

shouldn't it use co_ctx here, as else it's just scheduled again on the one from bs?

Looks OK for me besides that.

> +            qemu_coroutine_yield();
> +        }
>      } else {
>          Coroutine *co = qemu_coroutine_create(entry, opaque);
>          *ret = NOT_DONE;
> 



