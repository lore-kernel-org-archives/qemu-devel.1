Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA7C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 18:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63E220815
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 18:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63E220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEeHb-0006jc-UM
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 14:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEeGe-0005wu-2b
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 14:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEeGc-0003hv-Uc
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 14:49:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEeGZ-0003QP-75; Sun, 29 Sep 2019 14:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7057685362;
 Sun, 29 Sep 2019 18:49:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62C1E19D70;
 Sun, 29 Sep 2019 18:49:51 +0000 (UTC)
Message-ID: <5e9da6ee2de81616cb1896da390515c53967077c.camel@redhat.com>
Subject: Re: [PATCH] nbd: Don't let client send oversize strings
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 29 Sep 2019 21:49:50 +0300
In-Reply-To: <20190928041301.16296-1-eblake@redhat.com>
References: <20190928041301.16296-1-eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Sun, 29 Sep 2019 18:49:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-27 at 23:13 -0500, Eric Blake wrote:
> Qemu as server currently won't accept export names larger than 256
> bytes, so most uses of qemu as client have no reason to get anywhere
> near the NBD spec maximum of a 4k limit per string.  However, we
> didn't actually have any code that prevented the client from violating
> the protocol, which, while useful for testing corner-case server
> reactions, is probably not ideal.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/nbd.h | 1 +
>  nbd/client.c        | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 316fd705a9e4..fcabdf0f37c3 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -232,6 +232,7 @@ enum {
>   * going larger would require an audit of more code to make sure we
>   * aren't overflowing some other buffer. */
>  #define NBD_MAX_NAME_SIZE 256
> +#define NBD_MAX_STRING_SIZE 4096
> 
>  /* Two types of reply structures */
>  #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
> diff --git a/nbd/client.c b/nbd/client.c
> index f6733962b49b..3f21722dd914 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -648,6 +648,10 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint32_t opt,
>      if (query) {
>          query_len = strlen(query);
>          data_len += sizeof(query_len) + query_len;
> +        if (query_len > NBD_MAX_STRING_SIZE) {
> +            error_setg(errp, "x_dirty_bitmap query too long to send to server");
Is there a way not to do this here? I don't know nbd well to be honest,
and it looks like this code currently is only called for x_dirty_bitmap but
there could be more cases in the future.


nbd_negotiate_simple_meta_context which seems to be the caller of this, already mentions
a 'hack' about this :-(

Of course if you think that this is not worth the time, you can leave this as is.


> +            return -1;
> +        }
>      } else {
>          assert(opt == NBD_OPT_LIST_META_CONTEXT);
>      }
> @@ -1010,6 +1014,10 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
>      bool base_allocation = info->base_allocation;
> 
>      assert(info->name);
> +    if (strlen(info->name) > NBD_MAX_STRING_SIZE) {
> +        error_setg(errp, "name too long to send to server");
Maybe 'export name'?


> +        return -EINVAL;
> +    }
>      trace_nbd_receive_negotiate_name(info->name);
> 
>      result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,

Why not to do the export name check when info->name is set, that is in nbd_client_connect?


Best regards,
	Maxim Levitsky


