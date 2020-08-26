Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1ACC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF1020866
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTjcyWAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF1020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqSg-0002w4-Sp
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqRx-0001QA-MF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:06:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqRw-0004fj-0e
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598429186;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eB8Jf216QnsIWI8C3LPMUK907ii9CSJzzUMzbX0AKg0=;
 b=dTjcyWAIrr+/jMEfAwPY9+fNFCjDGRk50fCxEZmb36z8PIwkY8ujUXwyKpJswqZ+bOZSfK
 faZ/1Z81OPj0V8E0s6RO9X9YcpXZlMG9tZC2YMBoJ29TR4tgQzKQHVLUxz5KEQApfxN0yN
 5B8VibNye5vQT4RrC7woUWZ2x1vTjDk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-pghKQcY5Nk2cGZhWsepCeA-1; Wed, 26 Aug 2020 04:06:24 -0400
X-MC-Unique: pghKQcY5Nk2cGZhWsepCeA-1
Received: by mail-wr1-f71.google.com with SMTP id j2so234784wrr.14
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=eB8Jf216QnsIWI8C3LPMUK907ii9CSJzzUMzbX0AKg0=;
 b=RYCUV8Fup+UrINlpnYXt+iIOdDGA4IEVd4kWWuqpcKHTErkIP0XucA0gLI8L5GMpg8
 GglUL5SQOZglRTpJdsZRURi68tFCGMkQ1HruQ9o1PlhrL4c6U2GOWEtT+RbTsTXSiRr5
 2dpptj6NyPde2u1jYJ5d5jWokK7v4Ss88Y7eyfl/Szpa4eqNuYH5JwNZG4QjIuOwLTh4
 OkUCgFPkjZ90ZJaNby28l70HEnCwBsbCqoKxEL8OEl+Z2e+uNOGflFzsr6/3VDZNijhK
 bUkrHMBBTlNkAeTq2KEu0k118Pfc11Gehxw8txultYFMCsZ2eBGp0uEcWFpOkuXZyDNy
 e1nw==
X-Gm-Message-State: AOAM530bcjWqIWn/LP5fl4wHYU1CSeeP8trUwrVY39s+EQUkOmoUpLW+
 G/Mnvw0GLtuK3DqGI6b3/6ZLbic/P32FfsMKGC0naVvxCMlodMjQWeGvnOL/KVpoicwxW50zW4T
 O0Pdqs3o66eOXoAs=
X-Received: by 2002:a5d:5712:: with SMTP id a18mr747563wrv.108.1598429182506; 
 Wed, 26 Aug 2020 01:06:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNTDwcKaV0Jl9/pCqKguvJXclxZ4OuwmRl2mGKWhZr+qvQNI79lqZBerB+x+fH94j8We0tdA==
X-Received: by 2002:a5d:5712:: with SMTP id a18mr747538wrv.108.1598429182240; 
 Wed, 26 Aug 2020 01:06:22 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id b8sm3916055wrx.76.2020.08.26.01.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 01:06:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 67/74] [automated] Use DECLARE_*CHECKER* macros (pass 2)
In-Reply-To: <20200825192110.3528606-68-ehabkost@redhat.com> (Eduardo
 Habkost's message of "Tue, 25 Aug 2020 15:21:03 -0400")
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-68-ehabkost@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 26 Aug 2020 10:06:20 +0200
Message-ID: <87k0xlygoz.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P.
 Berrange" <berrange@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> wrote:
>  $ ./scripts/codeconverter/converter.py -i \
>    --pattern=TypeCheckMacro $(git grep -l '' -- '*.[ch]')
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

...

> diff --git a/migration/migration.h b/migration/migration.h
> index 4103e549bb..bdc7450da3 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -116,12 +116,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
>  #define TYPE_MIGRATION "migration"
>  
>  typedef struct MigrationClass MigrationClass;
> -#define MIGRATION_OBJ_CLASS(klass) \
> -    OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
> -#define MIGRATION_OBJ(obj) \
> -    OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
> -#define MIGRATION_OBJ_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
> +DECLARE_OBJ_CHECKERS(MigrationState, MigrationClass,
> +                     MIGRATION_OBJ, TYPE_MIGRATION)
>  
>  struct MigrationClass {
>      /*< private >*/

Reviewed-by: Juan Quintela <quintela@redhat.com>


