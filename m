Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD81C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CEC20714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiiUQybS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CEC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlKX-0002w4-JG
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHlJQ-0002IT-Cg
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHlJO-0007Uq-N4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:29:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHlJO-0007Tb-Gi
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585301397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyXcrg91JyE2KbIL0MZEqnY9HdrKS+wvu0th9Q69f2M=;
 b=OiiUQybSb0mSQ3QlCCJXpUT/s2tgqzVdbnaGGlXgK9ozkahfarl/sgk3s/smd0ZaQ7Zx1v
 BQUll0c0SU/jBndMYC/bKL49rApjLo69kwmYFKeNBu/9EwnsFK0gihYMWBg1RBxrv42SIU
 YS6/YterUp/Ee7oRkKZQjY7I7UkBB30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-b3TLHKCtPM6B-UN4S0NjFw-1; Fri, 27 Mar 2020 05:29:55 -0400
X-MC-Unique: b3TLHKCtPM6B-UN4S0NjFw-1
Received: by mail-wm1-f71.google.com with SMTP id t22so3665852wmt.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AL+lmiQ1hgrsCe5J3CjAM0u7Gx9sDIWLvlootjtZmD8=;
 b=TgaTHcnD8E50/ZQSm6C47DpF8AI+kikIHiNrQ3z5OdTboJfA7j1UQ12/iT8iAw9aek
 JbtwkM9TwkpIbrBdd+irGdP+Wjjro3V4N+9zPpsyAptJgEE43vdhXu5abQkmTjJaIWiQ
 cM9dSROxvCz66fprCD/Vr3ZUvS3NCjZFnzB4rSyyrnUS39f72r5eJ2HomVLpXXLCzDIh
 Ja0sLRKCkVW47zbMROMQPRgf6ukwRW5VyHRD76mtiIM3Wxl6/Ed9XfK8Tovchkqo4PBG
 uA8IvHCjgxuFN4gV3kudiLfP46bu60Jlge/bzVSAgQ53Gi8nS4vsOqHNFQZpoAOcrhcR
 UZRA==
X-Gm-Message-State: ANhLgQ23YOvKUd47ud/CZGAroRTsdODbyU9MlWAvwa7/emNWiImPgFU3
 osubnA5mUtCPHLGqPK2LjDyPZdqIsXfdnC5gFSqKOUvrraeVLVxeKWprbq7LZhLHnFn7fZU8RvF
 bmL/WE09mziZ2v4E=
X-Received: by 2002:a1c:8193:: with SMTP id c141mr4307488wmd.14.1585301394552; 
 Fri, 27 Mar 2020 02:29:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvmj4lVlCSnxZp8tcUl6Qx4Y8TMqTReUcfwHbdAboU7WPPpxdwHeaBzS/lweCwhT3lxMg0tsQ==
X-Received: by 2002:a1c:8193:: with SMTP id c141mr4307464wmd.14.1585301394243; 
 Fri, 27 Mar 2020 02:29:54 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id o9sm7687145wrx.48.2020.03.27.02.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:29:53 -0700 (PDT)
Date: Fri, 27 Mar 2020 10:29:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH] monitor/hmp-cmds: add units for mirate_parameters.
Message-ID: <20200327092951.bu4ju7rh53ig5t3l@steredhat>
References: <20200327073210.198080-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200327073210.198080-1-maozhongyi@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Hi Mao,

On Fri, Mar 27, 2020 at 03:32:10PM +0800, Mao Zhongyi wrote:
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
> 'xbzrle-cache-size', it's easier to read.
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  monitor/hmp-cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 2a900a528a..8d22f96e57 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -440,7 +440,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
>              params->downtime_limit);
>          assert(params->has_x_checkpoint_delay);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_printf(mon, "%s: %u" " milliseconds\n",
                                       ^
here we can remove the space and use a single string "%s: %u milliseconds\n=
"

I've noticed that we use both ms or milliseconds, if you want to clean up i=
n a
separate patch, maybe we could use one of these everywhere. (I vote for 'ms=
')

Thanks,
Stefano

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
>=20


