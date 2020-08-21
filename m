Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2941207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y81m3mSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2941207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93R1-0002yb-Vx
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93QP-0002UD-Sc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:33:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93QM-0003h5-SG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598002404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68fAm+vvHxONvZ3Ywp9hCw6zmQqadgsDVsW6NVxIKEs=;
 b=Y81m3mSXHfJTMzN+W6YxH+n+mz1RhhjIR25mO5vmICLKljkXOysX6rM0M+qns5hCjswkvL
 ymDreGAmqs1ZqwO5uvvMjBCEnv4cwI/Kh6mD/IGhGXX7MkOIh8w4r5u6UmjDueEqScA5M3
 yz8Kn2ev9L6H2JPs5efR2KjyhL0ZUrM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-V42pqZ5SPOmbgyFZWBA2Wg-1; Fri, 21 Aug 2020 05:33:22 -0400
X-MC-Unique: V42pqZ5SPOmbgyFZWBA2Wg-1
Received: by mail-wm1-f71.google.com with SMTP id q15so597743wmj.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=167fzeq2iG6n27MbonAz/FxMTFlLdOLO+lc4VcHFUEI=;
 b=i6ch51qCINrqvyiuIaIuBZFF7MGWrToFtG2C4qmB9Clyxj3VCD+sI459iQr4G05/bn
 mc+ty3c/zpXjRebXoY7yQvZxDTaNhqHFCEo8Rdh1lJNjuy5tzjlcnLJYPn0D9eh9p68E
 qG7CVzFmFcnRVBxbgngYPEIrmbEd0xHvYb/HBbKvWQw3j9I4B1b+Te8CXu59KmAa2t09
 4gbUsMZOVAuTY8yvxZP8bxpjYh2xl1xfehgEpFSNf+fEQbzvgTBLxu9mrqNTMc1yL3t+
 TdXQsBeXDzAQeGvB1TgnCjS8E4/Bx8C5ZWx1PttP7dlGa+XQjQYc+AZMwsGww0uW+kgB
 skbA==
X-Gm-Message-State: AOAM5302wb+E+AKxUTQB/+Ay2vGo4OpWxyqSNyRJbYqB4mRWlm9xGMQ5
 2kW9Y/rX8ujKWw3qvNwQ82BRDN5lij9hECpVlAn2R9ibkHjVGRcbBnneofhcMeuuRONRd4BfYEa
 AF/HTG69jVE18Xcc=
X-Received: by 2002:adf:9125:: with SMTP id j34mr2106460wrj.157.1598002401136; 
 Fri, 21 Aug 2020 02:33:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFgtM0jAP8Yx1ToFpbykCZ99Ur95EEFivsGTjnbnzx3d2txoYzL/Fm+MzvKI2NAJNXv7Sdug==
X-Received: by 2002:adf:9125:: with SMTP id j34mr2106430wrj.157.1598002400782; 
 Fri, 21 Aug 2020 02:33:20 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id q7sm3045560wra.56.2020.08.21.02.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 02:33:20 -0700 (PDT)
Date: Fri, 21 Aug 2020 11:33:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 01/15] block/nvme: Replace magic value by SCALE_MS
 definition
Message-ID: <20200821093317.uehmv4qou2qaw2zg@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:58:47PM +0200, Philippe Mathieu-Daudé wrote:
> Use self-explicit SCALE_MS definition instead of magic value.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 374e2689157..2f5e3c2adfa 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -715,7 +715,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      /* Reset device to get a clean state. */
>      s->regs->cc = cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
>      /* Wait for CSTS.RDY = 0. */
> -    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * 1000000ULL;
> +    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
>      while (le32_to_cpu(s->regs->csts) & 0x1) {
>          if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
>              error_setg(errp, "Timeout while waiting for device to reset (%"
> -- 
> 2.26.2
> 
> 


