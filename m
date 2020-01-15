Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7ACC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32952187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MY0IBxgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32952187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irn7U-0000W8-Uf
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irn6X-0007zR-E4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irn6S-0007GI-MH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:09:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37170
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irn6S-0007Eq-EH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579111755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ICvsLcSIEez1063XYp5ku/CpgguVSiUHKyVHU89888=;
 b=MY0IBxgBGtav19iUa7hFkv2Ak99dIkRGHBuuA95vV1vmV9Xdx1IqaE6Y6GAuO2xaO0Wh0l
 RPZGmiMT8Zx78fIrx/dXSjIo/m0abNQxbDJEyhwtMl9HWZBdQr62fJXCRKIYX79j/xgROW
 kYTR9bHLKTdQ+PiiCopX5X20vP7DRjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-7d6UHV8MOyGYcXU2WT6HzQ-1; Wed, 15 Jan 2020 13:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB5D108443F;
 Wed, 15 Jan 2020 18:09:11 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A95DB5D9C9;
 Wed, 15 Jan 2020 18:09:09 +0000 (UTC)
Date: Wed, 15 Jan 2020 18:09:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 01/12] migration: Add multiRDMA capability support
Message-ID: <20200115180907.GH3811@work-vm>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-2-fengzhimin1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200109045922.904-2-fengzhimin1@huawei.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7d6UHV8MOyGYcXU2WT6HzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhimin Feng (fengzhimin1@huawei.com) wrote:
> From: fengzhimin <fengzhimin1@huawei.com>
>=20
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>

Instead of creating x-multirdma as a capability and the corresponding
parameter for the number of channels; it would be better just
to use the multifd parameters when used with an rdma transport;
as far as I know multifd doesn't work with rdma at the moment,
and to the user the idea of multifd over rdma is just the same thing.

Dave

> ---
>  migration/migration.c | 11 +++++++++++
>  migration/migration.h |  1 +
>  qapi/migration.json   |  4 +++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 354ad072fa..e98e236ef9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2176,6 +2176,15 @@ bool migrate_use_events(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_EVENTS];
>  }
> =20
> +bool migrate_use_multiRDMA(void)
> +{
> +    MigrationState *s;
> +
> +    s =3D migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIRDMA];
> +}
> +
>  bool migrate_use_multifd(void)
>  {
>      MigrationState *s;
> @@ -3509,6 +3518,8 @@ static Property migration_properties[] =3D {
>      DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
>      DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PAT=
H),
>      DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
> +    DEFINE_PROP_MIG_CAP("x-multirdma",
> +                        MIGRATION_CAPABILITY_MULTIRDMA),
> =20
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/migration/migration.h b/migration/migration.h
> index 79b3dda146..bb488028a6 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -296,6 +296,7 @@ bool migrate_ignore_shared(void);
>  bool migrate_validate_uuid(void);
> =20
>  bool migrate_auto_converge(void);
> +bool migrate_use_multiRDMA(void);
>  bool migrate_use_multifd(void);
>  bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b7348d0c8b..c995ffdc4c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -421,6 +421,8 @@
>  # @validate-uuid: Send the UUID of the source to allow the destination
>  #                 to ensure it is the same. (since 4.2)
>  #
> +# @multirdma: Use more than one channels for rdma migration. (since 4.2)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> @@ -428,7 +430,7 @@
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
>             'block', 'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> -           'x-ignore-shared', 'validate-uuid' ] }
> +           'x-ignore-shared', 'validate-uuid', 'multirdma' ] }
> =20
>  ##
>  # @MigrationCapabilityStatus:
> --=20
> 2.19.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


