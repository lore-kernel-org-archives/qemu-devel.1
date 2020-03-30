Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B914C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A09206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5BN2izA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A09206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwlR-0003Iy-Co
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIwkl-0002bv-9y
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIwkj-00073X-UK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:55:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIwkj-00071x-Od
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585583704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQnHApp8lPqiIFMMF7akc29th5wLj7UAm0TLX0/dEOw=;
 b=Y5BN2izAWsGTT/B8SnNv/ke4slbiEsa5NLM8PFnoNcWgK9xawmG0DggMexgsOjrtjREZs/
 7AXjFCnapm6taM9MSZO7qiG/lU5geYRUTmqdZnwEHuUmVNmIaZf2dH1ty7jupRccRBcawH
 uRBQyLDoiFVBpKSF5TLh0IDZ36vnXuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-kmqVlNF8NiCA1eFDVjKmkA-1; Mon, 30 Mar 2020 11:55:03 -0400
X-MC-Unique: kmqVlNF8NiCA1eFDVjKmkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D75E0190A7A2;
 Mon, 30 Mar 2020 15:55:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6C4360BE1;
 Mon, 30 Mar 2020 15:54:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD40A11385E2; Mon, 30 Mar 2020 17:54:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/6] dump/win_dump: fix use after free of err
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-4-vsementsov@virtuozzo.com>
Date: Mon, 30 Mar 2020 17:54:54 +0200
In-Reply-To: <20200324153630.11882-4-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 24 Mar 2020 18:36:27 +0300")
Message-ID: <871rp9u9bl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> It's possible that we'll try to set err twice (or more). It's bad, it
> will crash.

True.

> Instead, use warn_report().

Improvement even without the potential crash enabled by the loop.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  dump/win_dump.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index eda2a48974..652c7bad99 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -304,13 +304,11 @@ static void restore_context(WinDumpHeader64 *h,
>                              struct saved_context *saved_ctx)
>  {
>      int i;
> -    Error *err =3D NULL;
> =20
>      for (i =3D 0; i < h->NumberProcessors; i++) {
>          if (cpu_memory_rw_debug(first_cpu, saved_ctx[i].addr,
>                  (uint8_t *)&saved_ctx[i].ctx, sizeof(WinContext), 1)) {
> -            error_setg(&err, "win-dump: failed to restore CPU #%d contex=
t", i);
> -            warn_report_err(err);
> +            warn_report("win-dump: failed to restore CPU #%d context", i=
);
>          }
>      }
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


