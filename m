Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE9DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A20620792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIa4hWkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A20620792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqsv-0003ym-TM
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxqrK-0002Z3-SD
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:54:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxqrI-0006q9-Jm
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595332495;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YpDFqCWbp8eOSZd2N34+6/6EiwYtvD567MAiKNWDXJA=;
 b=VIa4hWkFXukyPHUzen/c7rPXzJwuWMcRUugUAk4h5/TsIQj3DewMkG5cgSmDXIUs58+pPv
 V3EtYYG2E9p0BxL8EMqCuIPre2iRxdQPthl7JwLuoWCwBijbBrt+etawQQ3CY/6v0R6aQ2
 a0EzPViqih3Zjx3KY4otroFdazZRVcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-9i7ZFV5XP3qGWRk9lY5TYQ-1; Tue, 21 Jul 2020 07:54:51 -0400
X-MC-Unique: 9i7ZFV5XP3qGWRk9lY5TYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E025107BEFA;
 Tue, 21 Jul 2020 11:54:50 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 929841057F27;
 Tue, 21 Jul 2020 11:54:47 +0000 (UTC)
Date: Tue, 21 Jul 2020 12:54:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1] migration: tls: unref creds after used
Message-ID: <20200721115445.GG843362@redhat.com>
References: <20200717091943.1942-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200717091943.1942-1-yezhenyu2@huawei.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: xiexiangyou@huawei.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 05:19:43PM +0800, Zhenyu Ye wrote:
> We add the reference of creds in migration_tls_get_creds(),
> but there was no place to unref it.  So the OBJECT(creds) will
> never be freed and result in memory leak.
> 
> Unref the creds after creating the tls-channel server/client.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  migration/tls.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/tls.c b/migration/tls.c
> index 5171afc6c4..0740d02976 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -97,7 +97,7 @@ void migration_tls_channel_process_incoming(MigrationState *s,
>          s->parameters.tls_authz,
>          errp);
>      if (!tioc) {
> -        return;
> +        goto cleanup;
>      }
>  
>      trace_migration_tls_incoming_handshake_start();
> @@ -107,6 +107,9 @@ void migration_tls_channel_process_incoming(MigrationState *s,
>                                NULL,
>                                NULL,
>                                NULL);
> +
> +cleanup:
> +    object_unref(OBJECT(creds));
>  }
>  
>  
> @@ -146,13 +149,13 @@ void migration_tls_channel_connect(MigrationState *s,
>      }
>      if (!hostname) {
>          error_setg(errp, "No hostname available for TLS");
> -        return;
> +        goto cleanup;
>      }
>  
>      tioc = qio_channel_tls_new_client(
>          ioc, creds, hostname, errp);
>      if (!tioc) {
> -        return;
> +        goto cleanup;
>      }
>  
>      trace_migration_tls_outgoing_handshake_start(hostname);
> @@ -162,4 +165,7 @@ void migration_tls_channel_connect(MigrationState *s,
>                                s,
>                                NULL,
>                                NULL);
> +
> +cleanup:
> +    object_unref(OBJECT(creds));
>  }

Simpler to just change  migration_tls_get_creds() to remove the
object_ref() call, since we're fine to use the borrowed reference
in these methods.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


