Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCECC47257
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ADBC20714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDiB5nya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADBC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGyL-0006LA-MM
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWGwE-0004gV-8r
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:06:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWGwD-0001pB-Gm
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588759560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sca4DimLcCSEW3ONbAMD1mex1v/zWmy4JbmMNg40PDo=;
 b=LDiB5nyarC3XJPrwOirmpwJ+rPIARUKZOqlLfJ8+LL2XSO0J0/0YOYUk9MC/2pyvYHj0by
 N+UhyqAyP9Sbbm+c4+vgKuNRUp+FJiAYNcqaVEyQRfATzsdJ5a1CcP7/FDCFLulbYQc80+
 U4p2RMVfR1JfS8z4EyDsLM/u/rUP7mI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-KrHwd_lMNCWc3a8BN-xKFw-1; Wed, 06 May 2020 06:05:57 -0400
X-MC-Unique: KrHwd_lMNCWc3a8BN-xKFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17B0F83DD59;
 Wed,  6 May 2020 10:05:56 +0000 (UTC)
Received: from work-vm (ovpn-114-245.ams2.redhat.com [10.36.114.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D880D7052E;
 Wed,  6 May 2020 10:05:52 +0000 (UTC)
Date: Wed, 6 May 2020 11:05:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 2/4] migration: Introduce migrate_is_precopy()
Message-ID: <20200506100549.GF2743@work-vm>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200428194219.10963-3-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428194219.10963-3-peterx@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> Export a helper globally to check whether we're during a precopy.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Can you change this to 'migration_in_precopy' to match the existing
'migration_in_postcopy'.

Dave
> ---
>  include/migration/misc.h | 1 +
>  migration/migration.c    | 7 +++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index e338be8c30..b4f6bf7842 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -61,6 +61,7 @@ void migration_shutdown(void);
>  void qemu_start_incoming_migration(const char *uri, Error **errp);
>  bool migration_is_idle(void);
>  bool migration_is_active(MigrationState *);
> +bool migration_is_precopy(void);
>  void add_migration_state_change_notifier(Notifier *notify);
>  void remove_migration_state_change_notifier(Notifier *notify);
>  bool migration_in_setup(MigrationState *);
> diff --git a/migration/migration.c b/migration/migration.c
> index 187ac0410c..0082880279 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1795,6 +1795,13 @@ bool migration_is_active(MigrationState *s)
>              s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
>  }
> =20
> +bool migration_is_precopy(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s && s->state =3D=3D MIGRATION_STATUS_ACTIVE;
> +}
> +
>  void migrate_init(MigrationState *s)
>  {
>      /*
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


