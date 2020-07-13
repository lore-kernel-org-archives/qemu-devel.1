Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0A6206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCHpCk1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0A6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juy7o-0006s9-0f
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juy70-0006KC-Hy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:03:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juy6x-00053n-HE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594645390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U81DiCaQOMBQ1xzUJTM2jeKmqPxiHUMgiPmk6uluT+0=;
 b=jCHpCk1PGOjXsLHZJIPYw5g/rfLWDWN942cbKKP+mhyLFSRt6dgQJh6gw3cQWfiIfOl6mn
 zmUmazZLwD9wKxearWTMpZqiCO33pZC/eNgL2Ks0N573x2PanmvuvvrsG2YXW4h6X0PYtY
 dJMtq3uD2LdODdEZ1Fmte7v5rj0WFoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-TCUntIIMO6yurhD-mDlXOA-1; Mon, 13 Jul 2020 09:03:08 -0400
X-MC-Unique: TCUntIIMO6yurhD-mDlXOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7268027F2;
 Mon, 13 Jul 2020 13:03:07 +0000 (UTC)
Received: from [10.3.112.134] (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 987965BAD5;
 Mon, 13 Jul 2020 13:03:02 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] nbd: make nbd_export_close_all() synchronous
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200701105331.121670-1-vsementsov@virtuozzo.com>
 <20200701105331.121670-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b6866659-ed60-9743-b103-8325aa69fa3e@redhat.com>
Date: Mon, 13 Jul 2020 08:03:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701105331.121670-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 5:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Consider nbd_export_close_all(). The call-stack looks like this:
>   nbd_export_close_all() -> nbd_export_close -> call client_close() for
> each client.
> 
> client_close() doesn't guarantee that client is closed: nbd_trip()
> keeps reference to it. So, nbd_export_close_all() just reduce
> reference counter on export and removes it from the list, but doesn't
> guarantee that nbd_trip() finished neither export actually removed.
> 
> Let's wait for all exports actually removed.
> 
> Without this fix, the following crash is possible:
> 
> - export bitmap through internal Qemu NBD server
> - connect a client
> - shutdown Qemu
> 
> On shutdown nbd_export_close_all is called, but it actually don't wait
> for nbd_trip() to finish and to release its references. So, export is
> not release, and exported bitmap remains busy, and on try to remove the
> bitmap (which is part of bdrv_close()) the assertion fails:
> 
> bdrv_release_dirty_bitmap_locked: Assertion `!bdrv_dirty_bitmap_busy(bitmap)' failed
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v2: rewritten, try to wait exports directly.
> 
> Note: I'm not sure in my understanding of AIO_WAIT_WHILE and related things
> and really hope for review.

I'm also a bit weak on whether the AIO_WAIT_WHILE is being used 
correctly.  But the idea behind the patch makes sense to me, and since 
it is a bug fix, it will be okay to apply this for -rc1 or even -rc2 if 
needed (I'm not including it in my pull request today, however).

> 
> 
>   nbd/server.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 20754e9ebc..9d64b00f4b 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -102,6 +102,8 @@ struct NBDExport {
>   };
>   
>   static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
> +static QTAILQ_HEAD(, NBDExport) closed_exports =
> +        QTAILQ_HEAD_INITIALIZER(closed_exports);
>   
>   /* NBDExportMetaContexts represents a list of contexts to be exported,
>    * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
> @@ -1655,6 +1657,7 @@ void nbd_export_close(NBDExport *exp)
>           g_free(exp->name);
>           exp->name = NULL;
>           QTAILQ_REMOVE(&exports, exp, next);
> +        QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
>       }
>       g_free(exp->description);
>       exp->description = NULL;
> @@ -1717,7 +1720,9 @@ void nbd_export_put(NBDExport *exp)
>               g_free(exp->export_bitmap_context);
>           }
>   
> +        QTAILQ_REMOVE(&closed_exports, exp, next);
>           g_free(exp);
> +        aio_wait_kick();
>       }
>   }
>   
> @@ -1737,6 +1742,9 @@ void nbd_export_close_all(void)
>           nbd_export_close(exp);
>           aio_context_release(aio_context);
>       }
> +
> +    AIO_WAIT_WHILE(NULL, !(QTAILQ_EMPTY(&exports) &&
> +                           QTAILQ_EMPTY(&closed_exports)));
>   }
>   
>   static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
> 

weak:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


