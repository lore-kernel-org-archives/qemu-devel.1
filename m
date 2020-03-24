Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CBC54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B202076E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeYpWhxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B202076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpRu-00089g-CH
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jGpR9-0007Zw-6Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jGpR8-0001P3-5Y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:42:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jGpR8-0001Oh-2Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585078925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pYW3f5VhgZPxaNnMEssHpC8KYoVeutBROU2Z2/M9i0=;
 b=UeYpWhxl1M/FglphEMiE9bfLAoJMYJAkhW0nbzjpQZfYDRj6kzwU3CCih7yN3L4GG+cYOY
 KyWWFTwwqQFnbdvcikrEgkP6tB88h3Lfeq1If0w08l5lLrM94yezoLJ98oxD42QKElYUzB
 YiN5wGCV0FNDwU6jcCVYjpXz8Sbn7so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-wQpNKm1zNKCWGmE4A-uEFw-1; Tue, 24 Mar 2020 15:42:04 -0400
X-MC-Unique: wQpNKm1zNKCWGmE4A-uEFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A621A1922020;
 Tue, 24 Mar 2020 19:42:02 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4530510027A3;
 Tue, 24 Mar 2020 19:41:56 +0000 (UTC)
Date: Tue, 24 Mar 2020 19:41:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 5/6] migration/ram: fix use after free of local_err
Message-ID: <20200324194154.GG2645@work-vm>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200324153630.11882-6-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, marcandre.lureau@redhat.com,
 jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> local_err is used again in migration_bitmap_sync_precopy() after
> precopy_notify(), so we must zero it. Otherwise try to set
> non-NULL local_err will crash.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  migration/ram.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index c12cfdbe26..04f13feb2e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -980,6 +980,7 @@ static void migration_bitmap_sync_precopy(RAMState *r=
s)
>       */
>      if (precopy_notify(PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC, &local_err)) {
>          error_report_err(local_err);
> +        local_err =3D NULL;

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.


>      }
> =20
>      migration_bitmap_sync(rs);
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


