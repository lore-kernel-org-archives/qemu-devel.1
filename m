Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA87B2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFuu/eW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA87B2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8UTK-000665-Vv
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 16:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8USm-0005cM-0B
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:13:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8USj-0006Zw-Jc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597868012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9t6xTobedTdcP8an9TS0n+JJ3ErXI5SSQddN5XzHmw=;
 b=NFuu/eW8aeQizcOhz1Km9xNbHeXQDyL0yyyWRZhRNq7pJhuphq9+X+ieNED/qnv+/S4iVe
 a0LhRWw0u/Btik48m59Eu5hJWQKt5jnzJ9fypnBNt6IiZ/2vDdSmZ8PUhcdMWBCEKirbck
 pCedLcj2Pp9uNJ714KULKhIJQRV2mMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-8Zu2_HP0Ou2ODcUMQCzohA-1; Wed, 19 Aug 2020 16:13:30 -0400
X-MC-Unique: 8Zu2_HP0Ou2ODcUMQCzohA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494A21015DC4;
 Wed, 19 Aug 2020 20:13:29 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECA2E6F120;
 Wed, 19 Aug 2020 20:13:28 +0000 (UTC)
Subject: Re: [RFC PATCH 09/22] nbd: Add writethrough to block-export-add
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-10-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <178271b2-e90e-8d85-3bda-403e16ffa91d@redhat.com>
Date: Wed, 19 Aug 2020 15:13:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-10-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:29 AM, Kevin Wolf wrote:
> qemu-nbd allows use of writethrough cache modes, which mean that write
> requests made through NBD will cause a flush before they complete.
> Expose the same functionality in block-export-add.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-export.json | 7 ++++++-
>   blockdev-nbd.c         | 2 +-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 

> +++ b/blockdev-nbd.c
> @@ -218,7 +218,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
>   
>       exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
>                            !arg->writable, !arg->writable,
> -                         NULL, false, errp);
> +                         NULL, exp_args->writethrough, errp);

It would someday be nice to get rid of exp_args->has_writethrough in 
QAPI generated code, but that's independent of this series.  Meanwhile, 
you are safe in relying on writethrough being false when 
has_writethrough is false.

This change makes sense to me interface-wise.  QAPI-wise, should we try 
harder to make writethrough settable only for writable exports (and an 
error for read-only exports)?  I'm not sure what QAPI contortions would 
have to look like to make that enforced by the QMP parser; but it's also 
not the end of the world if we just always permit the optional field and 
then apply a post-parse semantic check.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


