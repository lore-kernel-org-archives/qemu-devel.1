Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57DDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F53E2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fteO+qqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F53E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0eOc-0000zO-TA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 01:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0eNY-0008Pf-W0
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 01:11:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0eNX-0007Un-Dh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 01:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595999506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S52/lXUnIoD7MsR6V3NDehd1Y+cQhaTA2MN3aVDWT5Y=;
 b=fteO+qqceOwHZlkGHZOhajW+8OIcJVhMAArLZmR/hYJjiICoX45IUNy3IxtP02BbhCtU9Z
 p7CWNMrL9IqN0d0YmW9h5NRBgJt14YC5c/VZG04SLDx04wgNkG9/elLu9chMk5b7lnAziq
 0y6uP9V5x5rLSCnIJKu0pOFQhuYouEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-SEjWS88-OQGTMNediToBUQ-1; Wed, 29 Jul 2020 01:11:42 -0400
X-MC-Unique: SEjWS88-OQGTMNediToBUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CAEE80183C;
 Wed, 29 Jul 2020 05:11:41 +0000 (UTC)
Received: from starship (unknown [10.35.206.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E59D1002393;
 Wed, 29 Jul 2020 05:11:39 +0000 (UTC)
Message-ID: <3194309570324998f7fea417c1063ea7df84cf3f.camel@redhat.com>
Subject: Re: [PATCH] qcow2: cleanup created file when qcow2_co_create
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 Jul 2020 08:11:38 +0300
In-Reply-To: <20200716113359.15656-1-mlevitsk@redhat.com>
References: <20200716113359.15656-1-mlevitsk@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.74; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:11:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Any update on this? Do you think we can add this to 5.1 or is it too late?
Best regards,
	Maxim Levitsky


