Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC01C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6D02084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DShsu/2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6D02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnrk-0005ht-7E
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irnqs-0004jN-3I
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irnqq-0002Ix-W6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:57:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irnqq-0002Ib-S2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579114632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hCxZwkuwsCLWctpF5J25+intxGtCZpj2FVOIDp7bo4=;
 b=DShsu/2htz1FyGmUPnVecw9dAjMkQ7MhDUN/3ynF8JWpOl97cTzUZ43SpjEzbNhYJ8Q2v3
 VwDsyGB3NkONLZI3lrNJg79/jLnrkor/qjHTkdbVpPumK8Dc5A8gJ4O6BMRuUxMk1e9Apo
 +3Op9/MIk2rCHWpMVbp4lHJUb4sQb0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-TVXkkk81NiOR9Lz5AkD5eQ-1; Wed, 15 Jan 2020 13:57:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B446110054E3;
 Wed, 15 Jan 2020 18:57:07 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38ADE60BE0;
 Wed, 15 Jan 2020 18:57:06 +0000 (UTC)
Date: Wed, 15 Jan 2020 18:57:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 02/12] migration: Export the
 'migration_incoming_setup' function            and add the
 'migrate_use_rdma_pin_all' function
Message-ID: <20200115185703.GJ3811@work-vm>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-3-fengzhimin1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200109045922.904-3-fengzhimin1@huawei.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TVXkkk81NiOR9Lz5AkD5eQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> We need to call the 'migration_incoming_setup' function in migration/rdma=
.c,
> so it has to be changed to a global function.
>=20
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>

OK, but this should probably be split into two patches.

With a split;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 11 ++++++++++-
>  migration/migration.h |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index e98e236ef9..d9d73a5eac 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -518,7 +518,7 @@ fail:
>      exit(EXIT_FAILURE);
>  }
> =20
> -static void migration_incoming_setup(QEMUFile *f)
> +void migration_incoming_setup(QEMUFile *f)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> =20
> @@ -2185,6 +2185,15 @@ bool migrate_use_multiRDMA(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIRDMA];
>  }
> =20
> +bool migrate_use_rdma_pin_all(void)
> +{
> +    MigrationState *s;
> +
> +    s =3D migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL];
> +}
> +
>  bool migrate_use_multifd(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index bb488028a6..0a23375b2f 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -265,6 +265,7 @@ struct MigrationState
> =20
>  void migrate_set_state(int *state, int old_state, int new_state);
> =20
> +void migration_incoming_setup(QEMUFile *f);
>  void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
> @@ -297,6 +298,7 @@ bool migrate_validate_uuid(void);
> =20
>  bool migrate_auto_converge(void);
>  bool migrate_use_multiRDMA(void);
> +bool migrate_use_rdma_pin_all(void);
>  bool migrate_use_multifd(void);
>  bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
> --=20
> 2.19.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


