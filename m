Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E509C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42DF2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpFquQlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42DF2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Up8-0002pN-Jr
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 16:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8UoS-0002Lr-I0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8UoR-00017y-2Z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597869357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivCRRWzxbhB+3GWjwW5rVUgp23SHERrgJ2yW78gEzHw=;
 b=LpFquQlArpUOEw9YuF4/57mWNmlL0RovHkx1OOvULkHUW3HuD/O+WRhpIVVBMteb6f+bh4
 TuLiP4nK9FFIgvt4DOaDRTVxBCt9zYNUi2WfxXNxQJjMXnfJhDsPOH7eENtXd4CUmNc9zR
 NMdC9HAnXO90EKZ2OscFDUPaClzwfWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-HskML4tpN2258PWke5hrtA-1; Wed, 19 Aug 2020 16:35:35 -0400
X-MC-Unique: HskML4tpN2258PWke5hrtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E29195D563;
 Wed, 19 Aug 2020 20:35:34 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D2C319C78;
 Wed, 19 Aug 2020 20:35:34 +0000 (UTC)
Subject: Re: [RFC PATCH 11/22] qemu-nbd: Use blk_exp_add() to create the export
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-12-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2e7221ad-1080-7eb7-d427-866c1aa82b7a@redhat.com>
Date: Wed, 19 Aug 2020 15:35:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-12-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 16:17:40
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:29 AM, Kevin Wolf wrote:
> With this change, NBD exports are only created through the BlockExport
> interface any more. This allows us finally to move things from the NBD

s/are only/are now only/; s/any more //

> layer to the BlockExport layer if they make sense for other export
> types, too.
> 
> blk_exp_add() returns only a weak reference, so the explicit
> nbd_export_put() goes away.

Feel free to rename get/put to ref/unref in your series if that makes 
life any easier.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> @@ -1050,9 +1050,27 @@ int main(int argc, char **argv)
>   
>       bs->detect_zeroes = detect_zeroes;
>   
> -    export = nbd_export_new(bs, export_name,
> -                            export_description, bitmap, readonly, shared > 1,
> -                            writethrough, &error_fatal);
> +    nbd_server_is_qemu_nbd(true);

Feels a bit like a backdoor hack, but gets the job done (and as you 
said, we had quite an IRC conversation about what it would take to get 
socket activation working, so leaving that in qemu-nbd for now is 
reasonable for the first patch series).

> +
> +    export_opts = g_new(BlockExportOptions, 1);
> +    *export_opts = (BlockExportOptions) {
> +        .type               = BLOCK_EXPORT_TYPE_NBD,
> +        .has_writethrough   = true,
> +        .writethrough       = writethrough,
> +        .u.nbd = {
> +            .device             = g_strdup(bdrv_get_node_name(bs)),
> +            .has_name           = true,
> +            .name               = g_strdup(export_name),
> +            .has_description    = !!export_description,
> +            .description        = g_strdup(export_description),
> +            .has_writable       = true,
> +            .writable           = !readonly,
> +            .has_bitmap         = !!bitmap,
> +            .bitmap             = g_strdup(bitmap),
> +        },
> +    };
> +    blk_exp_add(export_opts, &error_fatal);
> +    qapi_free_BlockExportOptions(export_opts);

Looks sane.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


