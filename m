Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A999FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC9620671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/rnJahL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC9620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmRT-0004eG-KY
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmQp-0003bn-Sa
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:44:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38938
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmQo-0001ts-VR
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590072261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kV/I8aVIuB6pwgwiJt7EiF0mOVfCoLK7MxJLtvljQU=;
 b=c/rnJahLfUBCaaHXlfGS6xXgZsyGD2sqF2Z7gteqfkNORuwK+m7L02xqXy2YAVM0yZExNU
 OSlQ/KlgbSTL40KQ2h3VneUFSMoScBeFlRphRTMl0jW6yh960ROLQ8KtAW8goMnEzb8AKv
 CRSL24DoAE8vybivR4WFQjLKTRVZlDQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-CuuCcMiRMjKGIuvuY-z_ww-1; Thu, 21 May 2020 10:44:20 -0400
X-MC-Unique: CuuCcMiRMjKGIuvuY-z_ww-1
Received: by mail-wr1-f71.google.com with SMTP id l12so3021496wrw.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8kV/I8aVIuB6pwgwiJt7EiF0mOVfCoLK7MxJLtvljQU=;
 b=JW8w2RJwgZi33vj91iY7VyGdqaFL9ES6F+3n3QwWR1Ny9HI8d9bNjzD+ZcYI7owN+i
 fpBbbKYxYSrAS0F9mhjteX3f3o+bXmkhrZdwtTUI5v3zCDX9xxIH1uv3Khq0aJi/c228
 0WwRoVelI60ixbJQ0CCnjQt047nz+KnTgynfsjqCqXJ6ndVEcpC4U6dxquqEPpzEjbaw
 r5FiBvKtuZofAlkdxw4WhJAJWl3qjBhL+EIiHbpiWBN1R5lm/8zpdip3GnfRp7KcQmbe
 EBRMoqGaj+QvQ/qWW6H9EWTBHDaLIzKr6gYVMJao6VCB2nI5K5qqqoZNb5vAfC8neS6o
 amLQ==
X-Gm-Message-State: AOAM531ICTKMmGIJEBBPNDw0dY0lnAIyJ46cNzZCTfkaY9udV9HJL02C
 0AkTnYKA7hXjzW6hIvGxx8bAB1JXVWK29to6Om3Y5QzF+C5BQYWg9GC9ZO03Ld0pI073K0Isz3P
 jVM2RYTZS01Hg/4Y=
X-Received: by 2002:a05:600c:230e:: with SMTP id
 14mr9580646wmo.45.1590072258904; 
 Thu, 21 May 2020 07:44:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrozJuxuKmT62dYBJvK3sKjmiIx2AnJTKQslkdaVtwbyN+B9esXipSQd79gztlbNpkIJl9Og==
X-Received: by 2002:a05:600c:230e:: with SMTP id
 14mr9580621wmo.45.1590072258543; 
 Thu, 21 May 2020 07:44:18 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id b145sm7254704wme.41.2020.05.21.07.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:44:18 -0700 (PDT)
Subject: Re: [PATCH] qom: remove index from object_resolve_abs_path()
To: Masahiro Yamada <masahiroy@kernel.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200510013235.954906-1-masahiroy@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5e77dc6-19ad-56c2-9ec0-cc169ad8ef61@redhat.com>
Date: Thu, 21 May 2020 16:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200510013235.954906-1-masahiroy@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/05/20 03:32, Masahiro Yamada wrote:
> You can advance 'parts' to track the current path fragment.
> The 'index' parameter is unneeded.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  qom/object.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index aa8a3f24e6..a3ee968b12 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2012,25 +2012,24 @@ Object *object_resolve_path_component(Object *parent, const gchar *part)
>  
>  static Object *object_resolve_abs_path(Object *parent,
>                                            gchar **parts,
> -                                          const char *typename,
> -                                          int index)
> +                                          const char *typename)
>  {
>      Object *child;
>  
> -    if (parts[index] == NULL) {
> +    if (*parts == NULL) {
>          return object_dynamic_cast(parent, typename);
>      }
>  
> -    if (strcmp(parts[index], "") == 0) {
> -        return object_resolve_abs_path(parent, parts, typename, index + 1);
> +    if (strcmp(*parts, "") == 0) {
> +        return object_resolve_abs_path(parent, parts + 1, typename);
>      }
>  
> -    child = object_resolve_path_component(parent, parts[index]);
> +    child = object_resolve_path_component(parent, *parts);
>      if (!child) {
>          return NULL;
>      }
>  
> -    return object_resolve_abs_path(child, parts, typename, index + 1);
> +    return object_resolve_abs_path(child, parts + 1, typename);
>  }
>  
>  static Object *object_resolve_partial_path(Object *parent,
> @@ -2042,7 +2041,7 @@ static Object *object_resolve_partial_path(Object *parent,
>      GHashTableIter iter;
>      ObjectProperty *prop;
>  
> -    obj = object_resolve_abs_path(parent, parts, typename, 0);
> +    obj = object_resolve_abs_path(parent, parts, typename);
>  
>      g_hash_table_iter_init(&iter, parent->properties);
>      while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&prop)) {
> @@ -2087,7 +2086,7 @@ Object *object_resolve_path_type(const char *path, const char *typename,
>              *ambiguousp = ambiguous;
>          }
>      } else {
> -        obj = object_resolve_abs_path(object_get_root(), parts, typename, 1);
> +        obj = object_resolve_abs_path(object_get_root(), parts + 1, typename);
>      }
>  
>      g_strfreev(parts);
> 

Queued, thanks.

Paolo


