Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEE6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478EC206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZdvtpHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478EC206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdiP-00073z-6p
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVdXT-0003NE-Rl
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:01:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVdXS-0006NQ-Dx
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588608109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oteUFkoRWwfr00JqJHBJcLJssbkYoJ+zNl29JlZMnk=;
 b=HZdvtpHRUbWIr8suSbvFIGs3WvrwlKvOW+FWpTllZ9GyNLAiyjGUkG7ocV+DrJ2NMvdAMJ
 nz6JEaypaLm/T3DGRb37cu9yny8kuBQ0isxx7c35ZKXPINR5hbzJFvjBlGeIpIxKbfleqU
 pr2hm4j1oP88XxgVfpGUE0o/srQhw98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-do-C4LW4NFe5zV5UvNE1-g-1; Mon, 04 May 2020 12:01:24 -0400
X-MC-Unique: do-C4LW4NFe5zV5UvNE1-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479068014D5;
 Mon,  4 May 2020 16:01:23 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD1EE6247E;
 Mon,  4 May 2020 16:01:22 +0000 (UTC)
Subject: Re: [PATCH v3] qcow2: Avoid integer wraparound in qcow2_co_truncate()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20200504155217.10325-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6fefd4af-3687-7f38-3933-aa67f2f221e8@redhat.com>
Date: Mon, 4 May 2020 11:01:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504155217.10325-1-berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 10:52 AM, Alberto Garcia wrote:
> After commit f01643fb8b47e8a70c04bbf45e0f12a9e5bc54de when an image is
> extended and BDRV_REQ_ZERO_WRITE is set then the new clusters are
> zeroized.
> 
> The code however does not detect correctly situations when the old and
> the new end of the image are within the same cluster. The problem can
> be reproduced with these steps:
> 
>     qemu-img create -f qcow2 backing.qcow2 1M
>     qemu-img create -f qcow2 -F qcow2 -b backing.qcow2 top.qcow2
>     qemu-img resize --shrink top.qcow2 520k
>     qemu-img resize top.qcow2 567k
> 
> In the last step offset - zero_start causes an integer wraparound.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---

> +++ b/block/qcow2.c
> @@ -4239,15 +4239,17 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>            * requires a cluster-aligned start. The end may be unaligned if it is
>            * at the end of the image (which it is here).
>            */
> -        ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
> -        if (ret < 0) {
> -            error_setg_errno(errp, -ret, "Failed to zero out new clusters");
> -            goto fail;
> +        if (offset > zero_start) {
> +            ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "Failed to zero out new clusters");
> +                goto fail;
> +            }
>           }
>   
>           /* Write explicit zeros for the unaligned head */
>           if (zero_start > old_length) {
> -            uint64_t len = zero_start - old_length;
> +            uint64_t len = MIN(zero_start, offset) - old_length;

Yes, that's better.

> +++ b/tests/qemu-iotests/292
> @@ -0,0 +1,73 @@

> +_supported_fmt qcow2
> +_supported_proto file

Do we have to limit it to qcow2 and file?  Yes, it's testing a bugfix 
for qcow2, but are there other formats that it doesn't hurt to have the 
extra testing?  Also, I don't see anything preventing this from working 
with non-file protocol.

But whether we widen the test scope or not, we at least test that we 
don't regress.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


