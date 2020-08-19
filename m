Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DB6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134B720658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOooT4l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134B720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SvB-0001qE-8s
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8Ssp-00061g-Hr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:32:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8Ssm-0002IX-SS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597861939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrOtYn0fox3vyYzno7Xye2AttQFAgnnkiAUYE6107Qc=;
 b=LOooT4l4BK5AnM08bxAs8dIgKWnv8MFr+NJ7833m6FhtHrY80fMQ5LNox1LzvIev+PHw4K
 VKiX9V1POs/goUtZcNUfOWM814uLwBli83wZnBmnGt+flsfUOeI0oHCPIDsp70CGIo1YkH
 It136Az86IN8614IXfyRIE9uOJd2mys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-aWneYDt4MKOB68HMNy-Hcw-1; Wed, 19 Aug 2020 14:32:12 -0400
X-MC-Unique: aWneYDt4MKOB68HMNy-Hcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37DA581C478;
 Wed, 19 Aug 2020 18:31:46 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D75EC5C1D0;
 Wed, 19 Aug 2020 18:31:45 +0000 (UTC)
Subject: Re: [RFC PATCH 04/22] block/export: Add BlockExport infrastructure
 and block-export-add
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3573ab66-884e-d237-cd5e-12bd67b05d8c@redhat.com>
Date: Wed, 19 Aug 2020 13:31:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-5-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:29 AM, Kevin Wolf wrote:
> We want to have a common set of commands for all types of block exports.
> Currently, this is only NBD, but we're going to add more types.
> 
> This patch adds the basic BlockExport and BlockExportDriver structs and
> a QMP command block-export-add that creates a new export based on the
> given BlockExportOptions.
> 
> qmp_nbd_server_add() becomes a wrapper around qmp_block_export_add().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Seeing if I can spot anything beyond Max's fine points:

> +++ b/qapi/block-export.json
> @@ -170,3 +170,12 @@
>         'nbd': 'BlockExportOptionsNbd'
>      } }
>   
> +##
> +# @block-export-add:
> +#
> +# Creates a new block export.
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'block-export-add',
> +  'data': 'BlockExportOptions', 'boxed': true }

So if I read patch 3 correctly, the difference between nbd-server-add 
and block-export-add is that the latter includes a "type":"nbd" member. 
(If we ever play with allowing a default discriminator value in QAPI, we 
could declare the default for "type" to be NBD, and then the two would 
be identical - except that since you are adding a new command designed 
to extend to more than just nbd, I don't think keeping nbd as default 
makes sense)

> +++ b/block/export/export.c

> +void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
> +{
> +    BlockExportOptions export = {
> +        .type = BLOCK_EXPORT_TYPE_NBD,
> +        .u.nbd = *arg,
> +    };
> +    qmp_block_export_add(&export, errp);
> +}

And indeed, this matches that analysis.


> @@ -217,6 +220,8 @@ void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
>   
>    out:
>       aio_context_release(aio_context);
> +    /* TODO Remove the cast: Move to server.c which can access fields of exp */
> +    return (BlockExport*) exp;

Should this use container_of()?  Ah, the TODO says you want to, but 
can't because exp is an opaque type in this file...

>   }
>   
>   void qmp_nbd_server_remove(const char *name,
> diff --git a/nbd/server.c b/nbd/server.c
> index bee2ef8bd1..774325dbe5 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -18,6 +18,8 @@
>    */
>   
>   #include "qemu/osdep.h"
> +
> +#include "block/export.h"
>   #include "qapi/error.h"
>   #include "qemu/queue.h"
>   #include "trace.h"
> @@ -80,6 +82,7 @@ struct NBDRequestData {
>   };
>   
>   struct NBDExport {
> +    BlockExport common;

...but at least the cast is accurate.

Overall, the idea looks sane.  I'm happy if you want to move 
blockdev-nbd.c out of the top level.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


