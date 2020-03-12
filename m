Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DC32071C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlScxwe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DC32071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49659 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTwe-00042P-1A
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCTjP-00062x-S3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCTjO-0002G3-O7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCTjO-0002FR-Jh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584042177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WUNWxSc4ky3PeMgsyReA6nF3hSlGxt/hqMniCgFnl+k=;
 b=HlScxwe8Oujbuzdz2DHZJybcNi5iAbNMH8bCBqzfUtIgLZTKPL7/Ph6PedOdVjy9tkM1aU
 v+fqJJUOBoIPbRCCvX/N3wdBtm0OKfrmEoglOu2KY2D5Ip8bli89+nh5HfiG4xMnyZqWMi
 BCP47iSTiDZXCoUCG1ILTfL+EiJSg50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-3fP_7PFeORu_eJUPSI0Qbw-1; Thu, 12 Mar 2020 15:42:54 -0400
X-MC-Unique: 3fP_7PFeORu_eJUPSI0Qbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D6CC100DFE2;
 Thu, 12 Mar 2020 19:42:53 +0000 (UTC)
Received: from work-vm (ovpn-116-106.ams2.redhat.com [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 286DD92D48;
 Thu, 12 Mar 2020 19:42:51 +0000 (UTC)
Date: Thu, 12 Mar 2020 19:42:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH V2 6/8] migration: recognize COLO as part of activating
 process
Message-ID: <20200312194249.GO3211@work-vm>
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-7-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200224065414.36524-7-zhang.zhanghailiang@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: danielcho@qnap.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> We will migrate parts of dirty pages backgroud lively during the gap time
> of two checkpoints, without this modification, it will not work
> because ram_save_iterate() will check it before send RAM_SAVE_FLAG_EOS
> at the end of it.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.

> ---
>  migration/migration.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index e8c62c6e2e..f71c337600 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -840,6 +840,7 @@ bool migration_is_setup_or_active(int state)
>      case MIGRATION_STATUS_PRE_SWITCHOVER:
>      case MIGRATION_STATUS_DEVICE:
>      case MIGRATION_STATUS_WAIT_UNPLUG:
> +    case MIGRATION_STATUS_COLO:
>          return true;
> =20
>      default:
> --=20
> 2.21.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


