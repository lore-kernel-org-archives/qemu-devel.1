Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F0D206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XESmvsYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F0D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsm8Y-0003x8-Oj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 07:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsm7y-0003SV-T2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:51:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsm7x-00026d-7L
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594122668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBLynoeep6og++bY9jk5mk2q18IZRa6XrSa1NJS2z70=;
 b=XESmvsYtofu14lFsFtuiuQxfMapvDhwf2+C9srUAYjUkz8DSS8LfKssbi3uxWLxMKDsr7m
 kI/tbswRQv1yMpNlauo7LSqndMFq6uy0Jvbuv/I74oKaPEDELQDjoZbSrVMO2xtp7uHCQH
 dLXUuVBghjDY9MsVHtBYeDHeo/cFu2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-St_xP8gGM3esafObPekx7Q-1; Tue, 07 Jul 2020 07:51:06 -0400
X-MC-Unique: St_xP8gGM3esafObPekx7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89D3107ACCA;
 Tue,  7 Jul 2020 11:51:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70C34512FE;
 Tue,  7 Jul 2020 11:51:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2B981132FD2; Tue,  7 Jul 2020 13:51:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v11 7/8] nbd: introduce ERRP_AUTO_PROPAGATE
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
 <20200703090816.3295-8-vsementsov@virtuozzo.com>
Date: Tue, 07 Jul 2020 13:51:02 +0200
In-Reply-To: <20200703090816.3295-8-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 3 Jul 2020 12:08:15 +0300")
Message-ID: <87h7uj8rx5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &error_fatal

Same for &error_abort, but to fix that, ERRP_AUTO_PROPAGATE() would have
to compromise stack backtraces, so it doesn't.

> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.

Unclear what exactly is being fixed here, if anything.  What are the
cases?  Can they happen?

The following look like possible cases: nbd_read(),
nbd_send_option_request(), nbd_handle_reply_err(), nbd_opt_info_or_go(),
nbd_start_negotiate(), nbd_receive_negotiate(),
nbd_negotiate_send_rep_verr(), nbd_negotiate_send_rep_list(),
nbd_negotiate_handle_export_name(), nbd_negotiate(),
nbd_export_remove().

Additionally in PATCH 6, v9fs_device_realize_common().

Nothing in PATCH 3+4+5+8 as far as I can tell.

If we lack the time to provide a complete assessment in the commit
messages, let's say so there.

> If we want to check error after errp-function call, we need to
> introduce local_err and then propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatal, this means that we don't break error_abort
>    (we'll abort on error_set, not on error_propagate)

Direct use of @errp improves behavior when the argument is
&error_abort.  Worth mentioning, I think.

>
> This commit is generated by command
>
>     sed -n '/^Network Block Device (NBD)$/,/^$/{s/^F: //p}' \
>         MAINTAINERS | \
>     xargs git ls-files | grep '\.[hc]$' | \
>     xargs spatch \
>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --in-place --no-show-diff --max-width 80
>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


