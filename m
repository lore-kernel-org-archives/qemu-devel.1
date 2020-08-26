Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C60C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB1C207DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfavUy3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB1C207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqPq-00088t-Ln
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqPC-0007Um-AI
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:03:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqP9-0004J6-S0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598429014;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=puHIupXWh/98+bp39BUwitjkfVs8C/U9AeQWj8Mpo1w=;
 b=XfavUy3AU+jykyIuXVqB/x5cnY/ZuKlg8ZiCRDWpWZSDeOC6meACfnueaX5E7gRS/vx4Db
 FkQpIdX10fUi1qJrqKhNooJrfyNJuXL5/r9BlMs170wGcPgPilfVcrJTgr7K4q1DrwTsBR
 We1GANDAF0VVWO2z3PurtvvAaxAtgNE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-9MbGPR3rMqKn9lmX4E5Wqg-1; Wed, 26 Aug 2020 04:03:33 -0400
X-MC-Unique: 9MbGPR3rMqKn9lmX4E5Wqg-1
Received: by mail-wr1-f71.google.com with SMTP id a10so225954wra.17
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=puHIupXWh/98+bp39BUwitjkfVs8C/U9AeQWj8Mpo1w=;
 b=np4G5Y9TbL2IFN2AD9FGSG5YHYYuQ1r/m7R0mMHdkh/9UiBMJfMTxprWmxQrOxjipN
 qdF8mfM9QowoBYrokRSeg/AYa9noDaGZPDm/Uu2nLYmiNGnbXtP+9wsktBpY4fEiHO0o
 VNJyzjPopMbcPpNDWnKeNco+4cT19axpgGGYDIzFaF4FTCDfTY/xv3FphkOgvBnKCYev
 Dg3/kLRsHZ0zC2stjJ19WetqoNKAmtyocjKlyoOYLZDCj2Ed83v5WF8KWitz9xxY9BEd
 tLg5mV2CClb5DrYxmsvpEbvWcFzzfuJmAEl3LokWbqyM6ucSUjBQEsTqMFKwYcDWmVuG
 +LhQ==
X-Gm-Message-State: AOAM530M/Y2w06sQ3m2d8qDC/CPdxQgfJnJRwXpXKn/PJbYfrMMt/iz/
 ra50/A8liJ4W6LnIqqFYV//RBcTruERcm/qYXsxBe1oh0TtEShmjOpOA7eljtySgep6R9QbqeYY
 XOp58q6VHoJvv2V8=
X-Received: by 2002:adf:e80a:: with SMTP id o10mr13873951wrm.312.1598429011850; 
 Wed, 26 Aug 2020 01:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUEUlYsLj5gxyXBHrhS5xMWv9kMpwID8tPzz9Ago5w5cQKXH93k3hODxyFMkdnOrz/xNg/yw==
X-Received: by 2002:adf:e80a:: with SMTP id o10mr13873921wrm.312.1598429011548; 
 Wed, 26 Aug 2020 01:03:31 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id v9sm3765370wru.37.2020.08.26.01.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 01:03:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 65/74] [automated] Move QOM typedefs and add missing
 includes (pass 2)
In-Reply-To: <20200825192110.3528606-66-ehabkost@redhat.com> (Eduardo
 Habkost's message of "Tue, 25 Aug 2020 15:21:01 -0400")
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-66-ehabkost@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 26 Aug 2020 10:03:29 +0200
Message-ID: <87tuwpygtq.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:47:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P.
 Berrange" <berrange@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> wrote:
> Some typedefs and macros are defined after the type check macros.
> This makes it difficult to automatically replace their
> definitions with OBJECT_DECLARE_TYPE.
>
> Patch generated using:
>
>  $ ./scripts/codeconverter/converter.py -i \
>    --pattern=QOMStructTypedefSplit $(git grep -l '' -- '*.[ch]')
>
> which will split "typdef struct { ... } TypedefName"
> declarations.
>
> Followed by:
>
>  $ ./scripts/codeconverter/converter.py -i --pattern=MoveSymbols \
>     $(git grep -l '' -- '*.[ch]')
>
> which will:
> - move the typedefs and #defines above the type check macros
> - add missing #include "qom/object.h" lines if necessary
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v2 -> v3: this is a new patch added in series v3
>
> The script was re-run after rebase and after additional patches
> were added to this series.
>
> This is being submitted as a separate patch to make review
> easier, but it can be squashed into the previous patch once it
> gets reviewed.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

> diff --git a/migration/migration.h b/migration/migration.h
> index ae497bd45a..4103e549bb 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -21,6 +21,7 @@
>  #include "qemu/coroutine_int.h"
>  #include "io/channel.h"
>  #include "net/announce.h"
> +#include "qom/object.h"
>  
>  struct PostcopyBlocktimeContext;
>  
> @@ -114,6 +115,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
>  
>  #define TYPE_MIGRATION "migration"
>  
> +typedef struct MigrationClass MigrationClass;
>  #define MIGRATION_OBJ_CLASS(klass) \
>      OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
>  #define MIGRATION_OBJ(obj) \
> @@ -121,10 +123,10 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
>  #define MIGRATION_OBJ_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
>  
> -typedef struct MigrationClass {
> +struct MigrationClass {
>      /*< private >*/
>      DeviceClass parent_class;
> -} MigrationClass;
> +};
>  
>  struct MigrationState
>  {

Reviewed-by: Juan Quintela <quintela@redhat.com>

for the migration bits.


