Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE1EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3123A20716
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEfZahhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3123A20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItAw-00022Q-BM
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jItAE-0001XU-OH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jItAC-0004Lp-LV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:05:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40657)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jItAC-0004LV-GK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585569907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAXudhR6rg6uzzWEm4deH3b0uKE26UMtP0FDcaYHWqE=;
 b=QEfZahhqqji1R4+S3AVjypWEY1KaEgYq9UmIboWy2Gr3RgJHAfE/ul8ZblLZfHeANxk8cq
 E5as4dvqQLlu4AJCwdrmyPa03Mjc4JM7iwAgaDZhtnwGcfLV9N4cHQti8rfI4mFjn0M+Pj
 8YgHe7gdb+jepKy2fEn5kP66VPKrMng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-qpPNZP2FOHa-tvLiPUhI0A-1; Mon, 30 Mar 2020 08:05:03 -0400
X-MC-Unique: qpPNZP2FOHa-tvLiPUhI0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A54EE8014CE;
 Mon, 30 Mar 2020 12:05:02 +0000 (UTC)
Received: from redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A38F96B7C;
 Mon, 30 Mar 2020 12:05:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH 1/3] migration/migration: improve error reporting for
 migrate parameters
In-Reply-To: <20200329050131.26864-2-maozhongyi@cmss.chinamobile.com> (Mao
 Zhongyi's message of "Sun, 29 Mar 2020 13:01:29 +0800")
References: <20200329050131.26864-1-maozhongyi@cmss.chinamobile.com>
 <20200329050131.26864-2-maozhongyi@cmss.chinamobile.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 30 Mar 2020 14:05:00 +0200
Message-ID: <87a73ykpzn.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mao Zhongyi <maozhongyi@cmss.chinamobile.com> wrote:
> use QERR_INVALID_PARAMETER_VALUE instead of
> "Parameter '%s' expects" for consistency.

I agree with the idea.

> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  migration/migration.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 2b7b5bccfa..e0223f3b15 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1202,16 +1202,17 @@ static bool migrate_params_check(MigrationParamet=
ers *params, Error **errp)
>      }
> =20
>      if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX))=
 {
> -        error_setg(errp, "Parameter 'max_bandwidth' expects an integer i=
n the"
> -                         " range of 0 to %zu bytes/second", SIZE_MAX);
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "max_bandwidth",
> +                   "an integer in the range of 0 to '2^64 - 1' bytes/sec=
ond");
>          return false;
>      }

You are inlining the constants.  What about:

error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
           "max_bandwidth",
           "an integer in the range of 0 to '" stringify(SIZE_MAX)
           "'bytes/second");

Same for the others.

Thanks, Juan.


