Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D51C2D0ED
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B43206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXq428XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B43206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtuE-0006mH-VX
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHtta-0006IO-6X
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHttY-00059q-0w
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:39:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHttX-00058v-RJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585334390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUeAYgR0jYVILYEpMJqIEcKL+JoY1EJAMBHzpU/d4nE=;
 b=UXq428XJBB73sYHzNxva6MTuKhLf0j2LthYYu1xJvimaW87dg00TUnAgaHuq/X2yIU8hgz
 emVvk5QcXegGdB/xqgk4iCNPgBR9H0n1ibx6HopU0P9h496vCqCAOp+K5I3V28zhs814qE
 1XQcug6ldyRJtdHWSJeYyGl7ys4TAuw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-rZyoA0V0MmiyEYA0VnIDwg-1; Fri, 27 Mar 2020 14:39:49 -0400
X-MC-Unique: rZyoA0V0MmiyEYA0VnIDwg-1
Received: by mail-wm1-f71.google.com with SMTP id m4so5874733wme.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+hpJFkq4EHPR3JIh3yYN15Xgiwb87CE/C2CgJ6aYP90=;
 b=WD8iWKGVh4aFdPFVcDyLaLnBtr3XgqV5A76lpo5a9UVVwgTwLI6/2lP6lAAM0ll4X2
 4JdGYlpkWP9h4yjUQZCx8kW/B2EUVz5KBTpwgGzeZRDm5hI2OrvNVXuikI9VG3y3b0Tm
 EekbGjsDisHAPZaFpqVWUwZAxaMBjqiYmr3ZVX6S8PalISDWG/5KkmBQehpnRH9LzR5U
 IOLS5pdvsovWUskamQRB4R+orD6gUXG0G/AjlLeZuZpQ+FeuhzOHk3F+tbkqXlDtkljx
 KmvOxo5Xwgu3EDwvMbf3paGbqIVrVVvY/T61KXqASsphAOxeaqsv4IiApYW69pXvrLC1
 5VEw==
X-Gm-Message-State: ANhLgQ3eevD7Dai4jQ0Nq5hsVDAwYtILePMUoDL9XMT9Qamr12f19cJ7
 XQb6BVX3B5wMpQy0VwyTbyn/8Vz0RHwQe69yNqPjA0pJx4rxFVbAak/bk+bdqV266wztuVTs+IH
 M86QtkY2+Eydgi/A=
X-Received: by 2002:a5d:674f:: with SMTP id l15mr812052wrw.196.1585334387518; 
 Fri, 27 Mar 2020 11:39:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvIo807PvS90s/qokPCuzFdUlIsXRNEbs+E9ATMQBE2OES5VzCsDMFHkGq56uUlEHr5gDvDrQ==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr812029wrw.196.1585334387199; 
 Fri, 27 Mar 2020 11:39:47 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id o26sm8559560wmc.33.2020.03.27.11.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:39:46 -0700 (PDT)
Date: Fri, 27 Mar 2020 19:39:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH v2] monitor/hmp-cmds: add units for migrate_parameters.
Message-ID: <20200327183944.ioggi7eibzbn7yqe@steredhat>
References: <bfceb9751f76533c823e9ec91ac14f4bc94a47b6.1585324937.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <bfceb9751f76533c823e9ec91ac14f4bc94a47b6.1585324937.git.maozhongyi@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 28, 2020 at 12:14:54AM +0800, Mao Zhongyi wrote:
> When running:
> (qemu) info migrate_parameters
> announce-initial: 50 ms
> announce-max: 550 ms
> announce-step: 100 ms
> compress-wait-thread: on
> ...
> max-bandwidth: 33554432 bytes/second
> downtime-limit: 300 milliseconds
> x-checkpoint-delay: 20000
> ...
> xbzrle-cache-size: 67108864
>=20
> add units for the parameters 'x-checkpoint-delay' and
> 'xbzrle-cache-size', it's easier to read, also move
> milliseconds to ms to keep the same style.
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  monitor/hmp-cmds.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 2a900a528a..790fad3afe 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -436,11 +436,11 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>              params->max_bandwidth);
>          assert(params->has_downtime_limit);
> -        monitor_printf(mon, "%s: %" PRIu64 " milliseconds\n",
> +        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
>              params->downtime_limit);
>          assert(params->has_x_checkpoint_delay);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_printf(mon, "%s: %u ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELA=
Y),
>              params->x_checkpoint_delay);
>          assert(params->has_block_incremental);
> @@ -453,7 +453,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSI=
ON),
>              MultiFDCompression_str(params->multifd_compression));
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> +        monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
>              params->xbzrle_cache_size);
>          monitor_printf(mon, "%s: %" PRIu64 "\n",
> --=20
> 2.17.1
>=20
>=20
>=20


