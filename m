Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A88C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D7920772
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bADJn2l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ho3-0005D7-4L
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hgs-0007ZE-8P
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hgo-0003TF-L9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597680528;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuhbjpJs7xqk/i49veWBNnSYpETlxXjM6enjP6KXZvo=;
 b=bADJn2l2QxKQCQRiWltq0FcMj+BDdKbAiewK5flh/ALl9psDtx4XaXjRuvOI0YkwOlSDIM
 BHCB+v91tJADLadVj1jS80c0fdwN1eSm2qTQOJP9bFGTxPizUixog/AtjYTBzRPUtSMKJT
 e6GCevpyt7RUD742Wv7r5LlrE16i+/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-nF60wvq4Ma-nRiwlFGXqFQ-1; Mon, 17 Aug 2020 12:08:46 -0400
X-MC-Unique: nF60wvq4Ma-nRiwlFGXqFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA3D71005E65
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 16:08:45 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB0931A886;
 Mon, 17 Aug 2020 16:08:44 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:08:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 30/41] qom: Make type checker functions accept const
 pointers
Message-ID: <20200817160841.GC4775@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-31-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-31-ehabkost@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Aug 13, 2020 at 06:26:14PM -0400, Eduardo Habkost wrote:
> The existing type check macros all unconditionally drop const
> qualifiers from their arguments.  Keep this behavior in the
> macros generated by DECLARE_*CHECKER* by now.
> 
> In the future, we might use _Generic to preserve const-ness of
> the cast function arguments.

I'm not sure what you mean by "use _Generic" ?

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/object.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 4cd84998c2..1d6a520d35 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -567,7 +567,7 @@ struct Object
>   */
>  #define DECLARE_INSTANCE_CHECKER(InstanceType, OBJ_NAME, TYPENAME) \
>      static inline G_GNUC_UNUSED InstanceType * \
> -    OBJ_NAME(void *obj) \
> +    OBJ_NAME(const void *obj) \
>      { return OBJECT_CHECK(InstanceType, obj, TYPENAME); }
>  
>  /**
> @@ -581,14 +581,16 @@ struct Object
>   *
>   * This macro will provide the three standard type cast functions for a
>   * QOM type.
> + *
> + *FIXME: Use _Generic to make this const-safe
>   */
>  #define DECLARE_CLASS_CHECKERS(ClassType, OBJ_NAME, TYPENAME) \
>      static inline G_GNUC_UNUSED ClassType * \
> -    OBJ_NAME##_GET_CLASS(void *obj) \
> +    OBJ_NAME##_GET_CLASS(const void *obj) \
>      { return OBJECT_GET_CLASS(ClassType, obj, TYPENAME); } \
>      \
>      static inline G_GNUC_UNUSED ClassType * \
> -    OBJ_NAME##_CLASS(void *klass) \
> +    OBJ_NAME##_CLASS(const void *klass) \
>      { return OBJECT_CLASS_CHECK(ClassType, klass, TYPENAME); }
>  
>  /**
> -- 
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


