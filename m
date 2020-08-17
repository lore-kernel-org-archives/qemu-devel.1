Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B213CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5E122D71
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ylo9NCpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5E122D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hhp-0001Cc-Jh
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hch-0005w1-6L
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:04:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34973
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hcf-0002o0-C3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597680272;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1InrChuc0YZIAdoNwP1+33HVrRC2yNmXyDjMX/Qih8=;
 b=Ylo9NCpS8NXfDYt8B52zo31xmcpaBMIG3p0MitLxXDSirYIT9p8+KiXWsIjkuVmB92cumW
 GZhqOpeqDETX/qN0iCEVZSa0pK+EcJIoGHkPIE/yeEd0Vcj00tjkay3yhJsqsQaV70Ap0P
 zUJDg7gsZqNXmW6CN9Sc9tuXyX5udPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-q7rr58y7NouN6l87DRfiEA-1; Mon, 17 Aug 2020 12:04:30 -0400
X-MC-Unique: q7rr58y7NouN6l87DRfiEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5DE71015DC5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 16:04:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE8A6F15D;
 Mon, 17 Aug 2020 16:04:28 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:04:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 27/41] qom: Fix G_DEFINE_AUTOPTR_CLEANUP_FUNC
Message-ID: <20200817160425.GZ4775@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-28-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-28-ehabkost@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 06:26:11PM -0400, Eduardo Habkost wrote:
> ModuleObjName##Class was being used instead of ModuleObjName.
> Fix it.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/object.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


though I'd suggest just squashing it into the original buggy
patch.

> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index be64421089..f515230f61 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -571,7 +571,7 @@ struct Object
>      typedef struct ModuleObjName ModuleObjName; \
>      typedef struct ModuleObjName##Class ModuleObjName##Class; \
>      \
> -    G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName##Class, object_unref) \
> +    G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName, object_unref) \
>      \
>      static inline G_GNUC_UNUSED ModuleObjName##Class * \
>      MODULE_OBJ_NAME##_GET_CLASS(void *obj) \
> -- 
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


