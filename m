Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA848C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDD420659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDD420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqjI-0000C2-MD
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHqQR-0005yF-AG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHqQQ-0007ul-6e
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iHqQQ-0007uU-0i
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10049806A72;
 Tue,  8 Oct 2019 14:25:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B125860605;
 Tue,  8 Oct 2019 14:25:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30B4B1138648; Tue,  8 Oct 2019 16:24:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 02/31] hw/core/loader-fit: fix freeing errp in
 fit_load_fdt
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-3-vsementsov@virtuozzo.com>
Date: Tue, 08 Oct 2019 16:24:45 +0200
In-Reply-To: <20191001155319.8066-3-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 1 Oct 2019 18:52:50 +0300")
Message-ID: <87d0f7iac2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 08 Oct 2019 14:25:17 +0000 (UTC)
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Paul Burton <pburton@wavecomp.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> fit_load_fdt forget to check that errp is not NULL and to zero it after
> freeing. Fix it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/core/loader-fit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 953b16bc82..3ee9fb2f2e 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -200,7 +200,10 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
>      err = fit_image_addr(itb, img_off, "load", &load_addr, errp);
>      if (err == -ENOENT) {
>          load_addr = ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
> -        error_free(*errp);
> +        if (errp) {
> +            error_free(*errp);
> +            *errp = NULL;
> +        }
>      } else if (err) {
>          error_prepend(errp, "unable to read FDT load address from FIT: ");
>          ret = err;

Hmm.  Should we have error_clear(), similar to g_clear_error()?

https://developer.gnome.org/glib/stable/glib-Error-Reporting.html#g-clear-error

