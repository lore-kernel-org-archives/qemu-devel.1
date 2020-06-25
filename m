Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FEEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93909206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4TtKtUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93909206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTBV-0002HD-TG
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joTAh-0001iY-KV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:48:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joTAf-0007VK-UL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593096489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfvG751z2WfiZy2Emvo4KZ3CzZYwEIjrKivXTlRwJFA=;
 b=A4TtKtUXbxPpQG7QJnqsnmw4j5GJ7R7q1cQKrtzF6/MPYFrEnFBpc8DF4euOXeo3kuRSHL
 A6/siz/5GhhrV817Nh+3JY6PBa8Dh4SQ0sdApxt9dCPz/aZ7cOKA5IQ4Li9zmKsvksTyii
 zCwcH4J6mkpzoIpU1FC1s2v9gDt4WZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-q89WAwrRPFe4Ml1RXighmA-1; Thu, 25 Jun 2020 10:48:06 -0400
X-MC-Unique: q89WAwrRPFe4Ml1RXighmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41B2800D5C;
 Thu, 25 Jun 2020 14:48:05 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15990101E665;
 Thu, 25 Jun 2020 14:48:04 +0000 (UTC)
Subject: Re: [PATCH 3/4] nbd: make client_close synchronous
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
 <20200625142540.24589-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3bc83011-61c9-d373-227e-7e6b1f0c7bdc@redhat.com>
Date: Thu, 25 Jun 2020 09:48:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625142540.24589-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 9:25 AM, Vladimir Sementsov-Ogievskiy wrote:
> client_close doesn't guarantee that client is closed: nbd_trip() keeps
> reference to it. Let's wait for nbd_trip to finish.
> 
> Without this fix, the following crash is possible:
> 
> - export bitmap through unternal Qemu NBD server

internal

> - connect a client
> - shutdown Qemu
> 
> On shutdown nbd_export_close_all is called, but it actually don't wait
> for nbd_trip() to finish and to release its references. So, export is
> not release, and exported bitmap remains busy, and on try to remove the
> bitmap (which is part of bdrv_close()) the assertion fairs:

fails

> 
> bdrv_release_dirty_bitmap_locked: Assertion `!bdrv_dirty_bitmap_busy(bitmap)' failed
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 20754e9ebc..5e27a8d31a 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1419,6 +1419,8 @@ static void client_close(NBDClient *client, bool negotiated)
>       qio_channel_shutdown(client->ioc, QIO_CHANNEL_SHUTDOWN_BOTH,
>                            NULL);
>   
> +    AIO_WAIT_WHILE(client->exp->ctx, client->recv_coroutine);
> +
>       /* Also tell the client, so that they release their reference.  */
>       if (client->close_fn) {
>           client->close_fn(client, negotiated);
> @@ -2450,6 +2452,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>   
>       trace_nbd_trip();
>       if (client->closing) {
> +        client->recv_coroutine = NULL;
>           nbd_client_put(client);
>           return;
>       }
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


