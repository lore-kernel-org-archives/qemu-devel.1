Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92AFC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9372D207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW2l+Kt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9372D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiRb-0004bY-Nd
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWiQR-0003HJ-PW
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:27:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWiQQ-0003fd-F2
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588865220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94Km/wbCBBX97gYvEqZSgF504ZoEK0uzZtkLQVDrGLs=;
 b=FW2l+Kt/KIL9MFFlITXRg1asNfAO7YvWEBVgO89abDYLaCuR+UHJ4ikYu/5hcSqXYzj6PY
 CcgQveqQLF9Y+gGnhg60UYIQ1/YuOEMzZsrGjwhI6n9/hr2J3NoULhBlfFM9kleOvshkHi
 PAKo6+XKHvHMhj7CLTf6hdsX7JLTtu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-jvGdllneN_OzOMhbymtr4w-1; Thu, 07 May 2020 11:26:56 -0400
X-MC-Unique: jvGdllneN_OzOMhbymtr4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA6F107ACCA;
 Thu,  7 May 2020 15:26:55 +0000 (UTC)
Received: from work-vm (ovpn-114-224.ams2.redhat.com [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65AE86295A;
 Thu,  7 May 2020 15:26:54 +0000 (UTC)
Date: Thu, 7 May 2020 16:26:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v3 4/7] migration/colo: Add missing
 error-propagation code
Message-ID: <20200507152651.GD17348@work-vm>
References: <20200413205250.687-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200413205250.687-1-f4bug@amsat.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> Running the coccinelle script produced:
>=20
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
>     --keep-comments --smpl-spacing --dir .
>   HANDLING: ./migration/colo.c
>   [[manual check required: error_propagate() might be missing in migrate_=
set_block_enabled() ./migration/colo.c:439:4]]
>=20
> Add the missing error_propagate() after review.
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Queued this entry for migration

> ---
>  migration/colo.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index a54ac84f41..57b2adb0cc 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -437,6 +437,9 @@ static int colo_do_checkpoint_transaction(MigrationSt=
ate *s,
> =20
>      /* Disable block migration */
>      migrate_set_block_enabled(false, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>      qemu_mutex_lock_iothread();
> =20
>  #ifdef CONFIG_REPLICATION
> --=20
> 2.21.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


