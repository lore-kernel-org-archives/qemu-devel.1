Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9881C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8C62076D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cutkz5PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8C62076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juaSe-0004d9-OV
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 07:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1juaS2-0003uy-8R
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:47:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1juaRy-0007tq-H6
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594554436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6bQW/4yOypkVuci4LTEF/9baRaLfPTcymyDVALtpFY=;
 b=Cutkz5PLMGPDLMIrPp0bgHmZFKasxE9JMjPtm0l+7R4kZuszx6E7NU6ShCP7T0XA00fvLR
 BY9OXEkJ5ZHL8hlbfmdKBGa2UoaysgE56LE4Cd7CIT+t0cs328gRAfF/llruh0PIyAIcHM
 LlvKnwFQ1yXEWwkFSj7VMee+utgRhkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-JrifH-jjMhuuuNOUZlInog-1; Sun, 12 Jul 2020 07:47:15 -0400
X-MC-Unique: JrifH-jjMhuuuNOUZlInog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25CAC8064AA;
 Sun, 12 Jul 2020 11:47:14 +0000 (UTC)
Received: from starship (unknown [10.35.206.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C18675BAD5;
 Sun, 12 Jul 2020 11:47:12 +0000 (UTC)
Message-ID: <476ca0873c38ad1c63be03eae0f626741aac7238.camel@redhat.com>
Subject: Re: [PATCH] block/amend: Check whether the node exists
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 12 Jul 2020 14:47:11 +0300
In-Reply-To: <20200710095037.10885-1-mreitz@redhat.com>
References: <20200710095037.10885-1-mreitz@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 07:24:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-07-10 at 11:50 +0200, Max Reitz wrote:
> We should check whether the user-specified node-name actually refers to
> a node.  The simplest way to do that is to use bdrv_lookup_bs() instead
> of bdrv_find_node() (the former wraps the latter, and produces an error
> message if necessary).
> 
> Reported-by: Coverity (CID 1430268)
> Fixes: ced914d0ab9fb2c900f873f6349a0b8eecd1fdbe
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/amend.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/amend.c b/block/amend.c
> index f4612dcf08..392df9ef83 100644
> --- a/block/amend.c
> +++ b/block/amend.c
> @@ -69,8 +69,12 @@ void qmp_x_blockdev_amend(const char *job_id,
>      BlockdevAmendJob *s;
>      const char *fmt = BlockdevDriver_str(options->driver);
>      BlockDriver *drv = bdrv_find_format(fmt);
> -    BlockDriverState *bs = bdrv_find_node(node_name);
> +    BlockDriverState *bs;
>  
> +    bs = bdrv_lookup_bs(NULL, node_name, errp);
> +    if (!bs) {
> +        return;
> +    }
>  
>      if (!drv) {
>          error_setg(errp, "Block driver '%s' not found or not supported", fmt);

Yep, this looks like a real bug, sorry about that.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


