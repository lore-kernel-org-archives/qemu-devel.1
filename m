Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECBF206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSHoIpsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECBF206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4Lk-0006jz-T9
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kD4Kx-00069s-5a
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kD4Kq-0006w1-6x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598959218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5fL4nZ34dz/JaDHgORh4kNwj81Q+OD9Qj7nhgGwKcQ=;
 b=XSHoIpsBT7MD4Ma++wF2eJp4AE4mC3gHuZwgKvTrBnAO/U3nPo0xqgJk9gmswpqNb5TPTm
 EdthgLwz/mlQql4yV/R7vtMsx2DTsqTfXDFsILJIg+G3nAvCJHJ0/1XTpZK6opbyoreWN8
 1lcmuOMMHP3xPf4YlLgM88wekb/uKrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-KMRXGI4IPEa6HBTP-ed90A-1; Tue, 01 Sep 2020 07:20:16 -0400
X-MC-Unique: KMRXGI4IPEa6HBTP-ed90A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08C60420EA;
 Tue,  1 Sep 2020 11:20:16 +0000 (UTC)
Received: from starship (unknown [10.35.206.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF69672C0;
 Tue,  1 Sep 2020 11:20:14 +0000 (UTC)
Message-ID: <283e2c4566bfa47e3a996efc7a6220921a00e0b0.camel@redhat.com>
Subject: Re: [PATCH] qcow2: cleanup created file when qcow2_co_create
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 01 Sep 2020 14:20:13 +0300
In-Reply-To: <20200716113359.15656-1-mlevitsk@redhat.com>
References: <20200716113359.15656-1-mlevitsk@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-07-16 at 14:33 +0300, Maxim Levitsky wrote:
> This is basically the same thing as commit
> 'crypto.c: cleanup created file when block_crypto_co_create_opts_luks fails'
> does but for qcow2 files to ensure that we don't leave qcow2 files
> when creation fails.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Very kind ping on this patch.

Best regards,
	Maxim levitsky

> ---
>  block/qcow2.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index fadf3422f8..8b848924b5 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3794,6 +3794,17 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
>      /* Create the qcow2 image (format layer) */
>      ret = qcow2_co_create(create_options, errp);
>      if (ret < 0) {
> +
> +        Error *local_delete_err = NULL;
> +        int r_del = bdrv_co_delete_file(bs, &local_delete_err);
> +        /*
> +         * ENOTSUP will happen if the block driver doesn't support
> +         * the 'bdrv_co_delete_file' interface. This is a predictable
> +         * scenario and shouldn't be reported back to the user.
> +         */
> +        if ((r_del < 0) && (r_del != -ENOTSUP)) {
> +            error_report_err(local_delete_err);
> +        }
>          goto finish;
>      }
>  



