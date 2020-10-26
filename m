Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB292C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681B6217A0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQY9MSsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681B6217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3oi-00010E-8r
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX3gs-0000eN-FB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX3gp-0001Cj-28
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603723297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VRTse6vWGwDMrc/6eK4CzzO+8Zu1B2sG+mIsGywxh/o=;
 b=FQY9MSskmM/UptmWM0SR7fTqAyWAXG8WrhIW8wvWwObm697l/7Bq0/zbnIfFHZN5weOwjr
 6yPGyQ4qOrVdHOacc/UNkqGISBaMGaywbhddg8wQJimuNiQvfTcwxuHfKxakCVty8cqctL
 UhtIT9obWbfy9OAM6IRKfDX2Gdw7lMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-wlVcYa4lPiWTqvNbi9ibyQ-1; Mon, 26 Oct 2020 10:41:34 -0400
X-MC-Unique: wlVcYa4lPiWTqvNbi9ibyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9621A1087D65;
 Mon, 26 Oct 2020 14:41:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B7F21C4;
 Mon, 26 Oct 2020 14:41:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA264113865F; Mon, 26 Oct 2020 15:41:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 03/12] nbd: Utilize QAPI_CLONE for type conversion
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-4-eblake@redhat.com>
Date: Mon, 26 Oct 2020 15:41:28 +0100
In-Reply-To: <20201023183652.478921-4-eblake@redhat.com> (Eric Blake's message
 of "Fri, 23 Oct 2020 13:36:43 -0500")
Message-ID: <87r1pl3v8n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 rjones@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> Rather than open-coding the translation from the deprecated
> NbdServerAddOptions type to the preferred BlockExportOptionsNbd, it's
> better to utilize QAPI_CLONE_MEMBERS.  This solves a couple of issues:
> first, if we do any more refactoring of the base type (which an
> upcoming patch plans to do), we don't have to revisit the open-coding.
> Second, our assignment to arg->name is fishy: the generated QAPI code
> currently does not visit it if arg->has_name is false, but if it DID
> visit it, we would have introduced a double-free situation when arg is
> finally freed.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  blockdev-nbd.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 8174023e5c47..cee9134b12eb 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -14,6 +14,8 @@
>  #include "sysemu/block-backend.h"
>  #include "hw/block/block.h"
>  #include "qapi/error.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-block-export.h"
>  #include "qapi/qapi-commands-block-export.h"
>  #include "block/nbd.h"
>  #include "io/channel-socket.h"
> @@ -195,7 +197,8 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
>       * the device name as a default here for compatibility.
>       */
>      if (!arg->has_name) {
> -        arg->name = arg->device;
> +        arg->has_name = true;
> +        arg->name = g_strdup(arg->device);
>      }

This is the fix you mentioned in the commit message.

>
>      export_opts = g_new(BlockExportOptions, 1);
> @@ -205,15 +208,9 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
       *export_opts = (BlockExportOptions) {
           .type                   = BLOCK_EXPORT_TYPE_NBD,
           .id                     = g_strdup(arg->name),
>          .node_name              = g_strdup(bdrv_get_node_name(bs)),
>          .has_writable           = arg->has_writable,
>          .writable               = arg->writable,

Explicit initialization of all the common members, except for
@writethrough.  @writethrough is optional, so not mentioning it makes it
absent.  I don't mind.

> -        .u.nbd = {
> -            .has_name           = true,
> -            .name               = g_strdup(arg->name),
> -            .has_description    = arg->has_description,
> -            .description        = g_strdup(arg->description),
> -            .has_bitmap         = arg->has_bitmap,
> -            .bitmap             = g_strdup(arg->bitmap),

Explicit initialization of all the variant members: copy of @arg.

> -        },
>      };
> +    QAPI_CLONE_MEMBERS(BlockExportOptionsNbd, &export_opts->u.nbd,
> +                       qapi_NbdServerAddOptions_base(arg));

Another (and better) way to copy.

>
>      /*
>       * nbd-server-add doesn't complain when a read-only device should be

Reviewed-by: Markus Armbruster <armbru@redhat.com>


