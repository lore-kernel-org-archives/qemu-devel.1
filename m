Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FDFC433EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FF020786
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPO3KrRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FF020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ATI-0007Ne-T2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0ASc-0006mQ-7m
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:15:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0ASZ-0007Iv-Fd
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595884498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAk04VUjpA9V11fU+d0OIfuJPDGWYmpHWRVZeKwWDoM=;
 b=YPO3KrRG838kWac3NkXeu113xGPxx99ipPLeBmTmrwMYPVX+/DU8gvjiZ1QBleUAnf9QXV
 D+uHh/BXRN6T2AX3zlf7jjLHd5n6fbPS78ZP/Bp+kejYFbCGF7upfXdUgPMlAsy8cEGLBe
 Tm57D7z+EO4Qj98jPgPTB34yDidCdDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-wsbCPAcsNzabSM5zrv1g9w-1; Mon, 27 Jul 2020 17:14:53 -0400
X-MC-Unique: wsbCPAcsNzabSM5zrv1g9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FD5102C808;
 Mon, 27 Jul 2020 21:14:51 +0000 (UTC)
Received: from [10.10.118.248] (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D87A319D82;
 Mon, 27 Jul 2020 21:14:50 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] block/nbd: allow drain during reconnect attempt
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200727184751.15704-1-vsementsov@virtuozzo.com>
 <20200727184751.15704-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d5f6efc0-5878-aaad-c3b5-6bdbb456f05b@redhat.com>
Date: Mon, 27 Jul 2020 16:14:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727184751.15704-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, berrange@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 1:47 PM, Vladimir Sementsov-Ogievskiy wrote:
> It should be to reenter qio_channel_yield() on io/channel read/write

be safe

> path, so it's safe to reduce in_flight and allow attaching new aio
> context. And no problem to allow drain itself: connection attempt is
> not a guest request. Moreover, if remote server is down, we can hang
> in negotiation, blocking drain section and provoking a dead lock.
> 
> How to reproduce the dead lock:
> 
> 1. Create nbd-fault-injector.conf with the following contents:
> 
> [inject-error "mega1"]
> event=data
> io=readwrite
> when=before
> 
> 2. In one terminal run nbd-fault-injector in a loop, like this:
> 
> n=1; while true; do
>      echo $n; ((n++));
>      ./nbd-fault-injector.py 127.0.0.1:10000 nbd-fault-injector.conf;
> done
> 
> 3. In another terminal run qemu-io in a loop, like this:
> 
> n=1; while true; do
>      echo $n; ((n++));
>      ./qemu-io -c 'read 0 512' nbd://127.0.0.1:10000;
> done
> 

> 
> Note, that the hang may be
> triggered by another bug, so the whole case is fixed only together with
> commit "block/nbd: on shutdown terminate connection attempt".
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 2ec6623c18..6d19f3c660 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -291,8 +291,22 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
>           goto out;
>       }
>   
> +    bdrv_dec_in_flight(s->bs);
> +
>       ret = nbd_client_handshake(s->bs, sioc, &local_err);
>   
> +    if (s->drained) {
> +        s->wait_drained_end = true;
> +        while (s->drained) {
> +            /*
> +             * We may be entered once from nbd_client_attach_aio_context_bh
> +             * and then from nbd_client_co_drain_end. So here is a loop.
> +             */
> +            qemu_coroutine_yield();
> +        }
> +    }
> +    bdrv_inc_in_flight(s->bs);
> +
>   out:
>       s->connect_status = ret;
>       error_free(s->connect_err);
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


