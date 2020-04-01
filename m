Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B1C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7BB20772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkjf6isU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7BB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXsD-00078s-FC
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 03:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jJXrJ-0006fB-9m
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jJXrH-0007qN-W9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:32:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59763
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jJXrH-0007n7-S8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585726339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHD0FspKdm2EDHFAelQ0tCUSmtlu4qEt32CF1uF6w+4=;
 b=Jkjf6isU8/N1wCzFufhZmau+jCqKCj/XPBf65VUvkSfNmFB/QPNsRwFIw6v3Asl6hEdzam
 C6MLPdK1HR/hVjb6sUHLY/srGRFzZDjYfZPGEBi+18Vs7yGr7HA0zSD4m+I+683EdN9GdP
 QznUJK4/UV3sYGnRWsz7NeGa1vg6dZU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-ZAWSx69cOAiy5kTLQlDwBw-1; Wed, 01 Apr 2020 03:32:17 -0400
X-MC-Unique: ZAWSx69cOAiy5kTLQlDwBw-1
Received: by mail-wm1-f71.google.com with SMTP id f8so2091544wmh.4
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 00:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JJwZ8+nD/FhZre0s/SVthAxcnW5Sb5+k7T3jWHYSZBM=;
 b=e4Mv4PY8uxMmBOww1Ef2iyXdgh8QjXFP9mXDb+QkKHknw6NcHa8VtxhH+0kgtm29NI
 Ija8gp73qipqe7eHHkD2/jFbzOgC1cCFw+SD04+0WY7qLIqdyo1fR7ZZVmIVQUpxo3/N
 pdzxunnOm2JNWnjpYUmTuKilsgso9LTHZGhRiJ9saqxxrQ7+TRnyDCB1Bp3eX4IEvWlM
 TVaU+A0/DN5iej+pDGArZSoGNzolxneZOVAtQ2g4vByZ133uhpxXI9Ip18LJeNP4AYo8
 xzODabjJ5vhDVJ5uSe4H7Y30oX1+WkJaE+f9y1gqpNHkRaYPNtjnT1S1tspFPxzncY3M
 wKsQ==
X-Gm-Message-State: AGi0PuYMFY7soGlvcuJw3TJwSMy+6RYyRKRxXdP9d2eRw+bH8KGyh1i4
 4LXOggw6CvwT9t9y2BJ01KfAPKQVPKi1sNQ0Yc5wl6LhtN6DxkKPu8u6UQ48iRyBhA5Lu48El7A
 srVPZkuVuRxxjuZs=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr2764275wmd.135.1585726336120; 
 Wed, 01 Apr 2020 00:32:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ/sQtPcS22wLZxCouf8TuCRxHWwJQx1S9UjQa4NVbHMs9Qv/ngOOwAMpjamG7fijH83FkAjg==
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr2764257wmd.135.1585726335881; 
 Wed, 01 Apr 2020 00:32:15 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id i2sm1824429wrx.22.2020.04.01.00.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 00:32:15 -0700 (PDT)
Date: Wed, 1 Apr 2020 09:32:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH v2 3/3] migration: move the units of migrate parameters
 from milliseconds to ms
Message-ID: <20200401073213.wxcqnoyun6pbub2p@steredhat>
References: <cover.1585641083.git.maozhongyi@cmss.chinamobile.com>
 <474bb6cf67defb8be9de5035c11aee57a680557a.1585641083.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <474bb6cf67defb8be9de5035c11aee57a680557a.1585641083.git.maozhongyi@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 04:22:07PM +0800, Mao Zhongyi wrote:
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  monitor/hmp-cmds.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Thank you for these changes!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 5a6436d035..b3d36d1467 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1214,7 +1214,7 @@ static bool migrate_params_check(MigrationParameter=
s *params, Error **errp)
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     "downtime_limit",
>                     "an integer in the range of 0 to "
> -                    stringify(MAX_MIGRATE_DOWNTIME)" milliseconds");
> +                    stringify(MAX_MIGRATE_DOWNTIME)" ms");
>          return false;
>      }
> =20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 63097ddcc8..c5de8af1ee 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -231,18 +231,18 @@ void hmp_info_migrate(Monitor *mon, const QDict *qd=
ict)
>              monitor_printf(mon, "\n");
>          }
> =20
> -        monitor_printf(mon, "total time: %" PRIu64 " milliseconds\n",
> +        monitor_printf(mon, "total time: %" PRIu64 " ms\n",
>                         info->total_time);
>          if (info->has_expected_downtime) {
> -            monitor_printf(mon, "expected downtime: %" PRIu64 " millisec=
onds\n",
> +            monitor_printf(mon, "expected downtime: %" PRIu64 " ms\n",
>                             info->expected_downtime);
>          }
>          if (info->has_downtime) {
> -            monitor_printf(mon, "downtime: %" PRIu64 " milliseconds\n",
> +            monitor_printf(mon, "downtime: %" PRIu64 " ms\n",
>                             info->downtime);
>          }
>          if (info->has_setup_time) {
> -            monitor_printf(mon, "setup: %" PRIu64 " milliseconds\n",
> +            monitor_printf(mon, "setup: %" PRIu64 " ms\n",
>                             info->setup_time);
>          }
>      }
> --=20
> 2.17.1
>=20
>=20
>=20
>=20


