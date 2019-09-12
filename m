Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0406ECDE20
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A1F2084F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A1F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KOo-0004RW-Ls
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8KO3-0003vc-Io
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8KO2-0004Cp-G7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8KNz-0004Bv-R0; Thu, 12 Sep 2019 04:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8EE0800410;
 Thu, 12 Sep 2019 08:23:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-179.ams2.redhat.com [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBC0819C77;
 Thu, 12 Sep 2019 08:23:23 +0000 (UTC)
Date: Thu, 12 Sep 2019 10:23:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190912082322.GD5383@linux.fritz.box>
References: <20190911161521.59261-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911161521.59261-1-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 12 Sep 2019 08:23:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/server: attach client channel to the
 export's AioContext
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.09.2019 um 18:15 hat Sergio Lopez geschrieben:
> On creation, the export's AioContext is set to the same one as the
> BlockBackend, while the AioContext in the client QIOChannel is left
> untouched.
> 
> As a result, when using data-plane, nbd_client_receive_next_request()
> schedules coroutines in the IOThread AioContext, while the client's
> QIOChannel is serviced from the main_loop, potentially triggering the
> assertion at qio_channel_restart_[read|write].
> 
> To fix this, as soon we have the export corresponding to the client,
> we call qio_channel_attach_aio_context() to attach the QIOChannel
> context to the export's AioContext. This matches with the logic in
> blk_aio_attached().
> 
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1748253
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Oh, looks like I only fixed switching the AioContext after the fact, but
not starting the NBD server for a node that is already in a different
AioContext... :-/

> diff --git a/nbd/server.c b/nbd/server.c
> index 10faedcfc5..51322e2343 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -471,6 +471,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client,
>      QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
>      nbd_export_get(client->exp);
>      nbd_check_meta_export(client);
> +    qio_channel_attach_aio_context(client->ioc, client->exp->ctx);
>  
>      return 0;
>  }
> @@ -673,6 +674,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
>          QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
>          nbd_export_get(client->exp);
>          nbd_check_meta_export(client);
> +        qio_channel_attach_aio_context(client->ioc, exp->ctx);
>          rc = 1;
>      }
>      return rc;

I think I would rather do this once at the end of nbd_negotiate()
instead of duplicating it across the different way to open an export.
During the negotiation phase, we don't start requests yet, so doing
everything from the main thread should be fine.

Actually, not doing everything from the main thread sounds nasty because
I think the next QIOChannel callback could then already be executed in
the iothread while this one hasn't completed yet. Or do we have any
locking in place for the negotiation?

Kevin

