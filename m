Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735E1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CBE22260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zK+TSUmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CBE22260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYK1-0004vp-KQ
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kUYGH-0001LT-Gr; Mon, 19 Oct 2020 12:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kUYGE-00076H-2v; Mon, 19 Oct 2020 12:43:52 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4522222EA;
 Mon, 19 Oct 2020 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603125827;
 bh=Zz71mlDUXQ/ADoWnOSUfGr6Dba0b+/BragPLql0yfy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zK+TSUmYa2EjLjkcaGUCZXBsQgSGYBCnGmnlZOiae6THaFqjKqtxbG4rPsPIVUAmo
 rJyw26W6FO+nP/84ci3mN3kcdTfELubbJWGF/zjZnd5UCJckVgLwtTWNSf/MPpf4mA
 mJLicZnu0L60uo6zoeV2qObswHpQFNKCAJP9UUdk=
Date: Mon, 19 Oct 2020 09:43:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] hw/block/nvme: fix aer logic
Message-ID: <20201019164332.GB1435260@dhcp-10-100-145-180.wdc.com>
References: <20201019065416.34638-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019065416.34638-1-its@irrelevant.dk>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 12:35:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 08:54:16AM +0200, Klaus Jensen wrote:
> @@ -844,6 +838,12 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
>          return;
>      }
>  
> +    /* ignore if masked (cqe posted, but event not cleared) */
> +    if (n->aer_mask & (1 << event_type)) {
> +        trace_pci_nvme_aer_masked(event_type, n->aer_mask);
> +        return;
> +    }

The 'mask' means the host hasn't yet acknowledged the AER with the
appropriate log. The controller should continue to internally enqueue
subsequent events of this type, but suppress sending the notification
for them until the host unlatches the event type.

>      event = g_new(NvmeAsyncEvent, 1);
>      event->result = (NvmeAerResult) {
>          .event_type = event_type,
> @@ -859,9 +859,15 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
>  
>  static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
>  {
> +    NvmeAsyncEvent *event, *next;
> +
>      n->aer_mask &= ~(1 << event_type);
> -    if (!QTAILQ_EMPTY(&n->aer_queue)) {
> -        nvme_process_aers(n);
> +
> +    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
> +        if (event->result.event_type == event_type) {
> +            QTAILQ_REMOVE(&n->aer_queue, event, entry);

Memory leaking the 'event'?

> +            n->aer_queued--;
> +        }
>      }
>  }

