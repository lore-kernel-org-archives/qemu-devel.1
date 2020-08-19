Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DC1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92BA2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNljdWD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92BA2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8VBK-00076w-36
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 16:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8VAU-0006bN-Er
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:58:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8VAS-0004YX-48
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597870723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doKDOnJEz1BPETmmH4SHO+ZuHR9Dgxw08qL/Ukp7xH0=;
 b=TNljdWD+IttpLtjsw6h2jIIDIyADMmd8f8kcu6tAulpKRdX1eJYpVZHdUsFl6Mz89c53FB
 DLlvJ0o1l8fmFpldkY34HhjviXUjnLbwFQVnzsEuEhLE9cRwrsCy27gyHtqL1PV8s0HaRo
 8+n5DJewn42o2kdfLz/3/AtipZa1m8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-1We99girOAeGgN_eI2pv6w-1; Wed, 19 Aug 2020 16:58:41 -0400
X-MC-Unique: 1We99girOAeGgN_eI2pv6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C5651885D82;
 Wed, 19 Aug 2020 20:58:40 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5BDA19C4F;
 Wed, 19 Aug 2020 20:58:39 +0000 (UTC)
Subject: Re: [RFC PATCH 13/22] block/export: Move refcount from NBDExport to
 BlockExport
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-14-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0ff82c83-16eb-c544-553a-9a58c9453133@redhat.com>
Date: Wed, 19 Aug 2020 15:58:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-14-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 16:00:16
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
> Having a refcount makes sense for all types of block exports. It is also
> a prerequisite for keeping a list of all exports at the BlockExport
> level.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/include/block/export.h
> @@ -21,14 +21,24 @@ typedef struct BlockExport BlockExport;
>   typedef struct BlockExportDriver {
>       BlockExportType type;
>       BlockExport *(*create)(BlockExportOptions *, Error **);
> +    void (*delete)(BlockExport *);
>   } BlockExportDriver;
>   
>   struct BlockExport {
>       const BlockExportDriver *drv;
> +
> +    /*
> +     * Reference count for this block export. This includes strong references
> +     * both from the owner (qemu-nbd or the monitor) and clients connected to
> +     * the export.

I guess 'the monitor' includes qemu-storage-daemon.

> +     */
> +    int refcount;
>   };
>   
>   extern const BlockExportDriver blk_exp_nbd;
>   
>   BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
> +void blk_exp_ref(BlockExport *exp);
> +void blk_exp_unref(BlockExport *exp);

Yay, I think this naming is more consistent with the rest of qemu...

>   
>   #endif
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 23030db3f1..af8509ab70 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -336,8 +336,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
>   void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
>   void nbd_export_close(NBDExport *exp);
>   void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
> -void nbd_export_get(NBDExport *exp);
> -void nbd_export_put(NBDExport *exp);

...as opposed to this which is common in kernel but less so in this 
project.  No hard feelings from me :)

> +++ b/blockdev-nbd.c
> @@ -232,7 +232,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
>       /* The list of named exports has a strong reference to this export now and
>        * our only way of accessing it is through nbd_export_find(), so we can drop
>        * the strong reference that is @exp. */
> -    nbd_export_put(exp);
> +    blk_exp_unref((BlockExport*) exp);

Even a helper function that converts NBDBlockExport* to BlockExport* 
rather than a cast might be nicer, but then again, I see from Max's 
review that this may be a temporary state of things.

(The QAPI contains such type-safe container casts, such as 
qapi_DriveBackup_base(), if that helps...)


> @@ -1537,7 +1536,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
>   
>       exp = g_new0(NBDExport, 1);
>       exp->common = (BlockExport) {
> -        .drv = &blk_exp_nbd,
> +        .drv        = &blk_exp_nbd,
> +        .refcount   = 1,

I'm not sure whether trying to align the '=' is good, because the moment 
you add a longer field name, every other line has to be touched.  I'm 
fine with just one space on both side of =, even if it is more ragged to 
read.  But you're the author, so you get to pick.


> @@ -1626,8 +1625,9 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
>       exp->ctx = ctx;
>       blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
>   
> +    blk_exp_ref(&exp->common);
>       QTAILQ_INSERT_TAIL(&exports, exp, next);
> -    nbd_export_get(exp);
> +

Is there any consequence to this changed ordering in grabbing the 
reference vs. updating the list?


Overall looks nice.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


