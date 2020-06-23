Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDA2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2BD206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9RU96+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2BD206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnlik-0000jV-5O
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnlhb-00087X-Uv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:23:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnlhZ-0002Su-KL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592929392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1VktOXI6G9efkHXGoSLVD4RorANMJX3XM0OVQxWslM=;
 b=Y9RU96+d1tuhhua36YikwZ/Rjtf1B/zJ5ocRFgFW+885Q39XQ6QlKxyJc1BY4h1Z96rS8J
 XXpwqkyn4TTRl5dTNtRnzX53Mq7+b058KgGWZN4KpdvQiCVTQ2c5PZxV4ekauyHX1LLxWa
 AuV838T1ieNkKLrGx/r5vz1Bmkta6TM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-sE9I40dINuenVVrhFHB7Dw-1; Tue, 23 Jun 2020 12:23:10 -0400
X-MC-Unique: sE9I40dINuenVVrhFHB7Dw-1
Received: by mail-wr1-f71.google.com with SMTP id i14so5248439wru.17
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u1VktOXI6G9efkHXGoSLVD4RorANMJX3XM0OVQxWslM=;
 b=ThJ1J7nFuPqbl3vmNF4WablPi5Uf8YXVk2vB3O32PLqy4rMNTRIN1NYi9zXI5o9Y5c
 FznHQmzxSYC7hS4pzkfFvKQu3RQ1F0F6XaWxiCKymz8iYombY4wlf00wJl8EThyXD2G5
 48UVDHyk14HQ+CPpDVy+thGzVdLjn+V2XDvlv0ycqiiWNnW6Q6Axq1VK3HKJjVHwq+DJ
 HECjj+tncomlWc8HE0ZeIvqrq2u6xfPu0gEvnuCtN2s9CxC8X3ryqlP2CbZmkadCIs8f
 h9ndUM+LHvL2iSOOet5c/sIABriC1L+4Olvvo/0tRfCsjrLW6BkMaRRjCcTbhtXPY8ZA
 wT7A==
X-Gm-Message-State: AOAM531WzJB/y/XgWUr6vqVor5EDsz2E/b85O3/WHfrnO6hw2sx5Xtnz
 PtAKeQUs4feqauaKLE9UyOuU9vysIaI+LpIybbmqU2Lf79QBLIJm2ncL4nlwGhBISP1UgogMyme
 gSrg2RG55MyCo8iI=
X-Received: by 2002:a1c:f203:: with SMTP id s3mr23019849wmc.126.1592929389067; 
 Tue, 23 Jun 2020 09:23:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPeygbXo8fScWYwxudEhqbTWqT7JjdDCxkI8ruphdOELbqJ6cNUQeEEesa/YcEjnOl4BxmSA==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr23019819wmc.126.1592929388642; 
 Tue, 23 Jun 2020 09:23:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id a16sm22438727wrx.8.2020.06.23.09.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 09:23:08 -0700 (PDT)
Subject: Re: [PATCH] qom: Allow object_property_add_child() to fail
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200623155452.30954-1-eric.auger@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36a1f20b-339e-68c3-287d-4b2d2ac8b719@redhat.com>
Date: Tue, 23 Jun 2020 18:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623155452.30954-1-eric.auger@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 23/06/20 17:54, Eric Auger wrote:
> object_property_add() does not allow object_property_try_add()
> to gracefully fail as &error_abort is passed as an error handle.
> 
> However such failure can easily be triggered from the QMP shell when,
> for instance, one attempts to create an object with an id that already
> exists:
> 
> For instance, call twice:
> object-add qom-type=memory-backend-ram id=mem1 props.size=1073741824
> and QEMU aborts.
> 
> This behavior is undesired as a user/management application mistake
> in reusing a property ID shouldn't result in loss of the VM and live
> data within.
> 
> This patch introduces two new functions, object_property_add_err() and
> object_property_add_child_err() whose prototype features an error handle.
> object_property_add_child_err() now gets called from user_creatable_add_type.
> This solution was chosen instead of changing the prototype of existing
> functions because the number of existing callers is huge.
> 
> The error now is returned gracefully to the QMP client.
> 
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"return": {}}
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"error": {"class": "GenericError", "desc": "attempt to add duplicate property
> 'mem2' to object (type 'container')"}}

... also, please add a testcase for this.

Paolo

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/qom/object.h    | 24 ++++++++++++++++++++++--
>  qom/object.c            | 33 ++++++++++++++++++++++++++++-----
>  qom/object_interfaces.c |  7 +++++--
>  3 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 94a61ccc3f..29652a1563 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1039,7 +1039,7 @@ Object *object_ref(Object *obj);
>  void object_unref(Object *obj);
>  
>  /**
> - * object_property_add:
> + * object_property_add_err:
>   * @obj: the object to add a property to
>   * @name: the name of the property.  This can contain any character except for
>   *  a forward slash.  In general, you should use hyphens '-' instead of
> @@ -1056,10 +1056,22 @@ void object_unref(Object *obj);
>   *   meant to allow a property to free its opaque upon object
>   *   destruction.  This may be NULL.
>   * @opaque: an opaque pointer to pass to the callbacks for the property
> + * @errp: error handle
>   *
>   * Returns: The #ObjectProperty; this can be used to set the @resolve
>   * callback for child and link properties.
>   */
> +ObjectProperty *object_property_add_err(Object *obj, const char *name,
> +                                        const char *type,
> +                                        ObjectPropertyAccessor *get,
> +                                        ObjectPropertyAccessor *set,
> +                                        ObjectPropertyRelease *release,
> +                                        void *opaque, Error **errp);
> +
> +/**
> + * object_property_add: same as object_property_add with
> + * errp hardcoded to &error_abort
> + */
>  ObjectProperty *object_property_add(Object *obj, const char *name,
>                                      const char *type,
>                                      ObjectPropertyAccessor *get,
> @@ -1495,10 +1507,11 @@ Object *object_resolve_path_type(const char *path, const char *typename,
>  Object *object_resolve_path_component(Object *parent, const char *part);
>  
>  /**
> - * object_property_add_child:
> + * object_property_add_child_err:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @child: the child object
> + * @errp: error handle
>   *
>   * Child properties form the composition tree.  All objects need to be a child
>   * of another object.  Objects can only be a child of one object.
> @@ -1512,6 +1525,13 @@ Object *object_resolve_path_component(Object *parent, const char *part);
>   *
>   * Returns: The newly added property on success, or %NULL on failure.
>   */
> +ObjectProperty *object_property_add_child_err(Object *obj, const char *name,
> +                                              Object *child, Error **errp);
> +
> +/**
> + * object_property_add_child: same as object_property_add_child_err with
> + * errp hardcoded to &error_abort
> + */
>  ObjectProperty *object_property_add_child(Object *obj, const char *name,
>                                            Object *child);
>  
> diff --git a/qom/object.c b/qom/object.c
> index 6ece96bc2b..2ec72fae7c 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1182,6 +1182,17 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>      return prop;
>  }
>  
> +ObjectProperty *
> +object_property_add_err(Object *obj, const char *name, const char *type,
> +                        ObjectPropertyAccessor *get,
> +                        ObjectPropertyAccessor *set,
> +                        ObjectPropertyRelease *release,
> +                        void *opaque, Error **errp)
> +{
> +    return object_property_try_add(obj, name, type, get, set, release,
> +                                   opaque, errp);
> +}
> +
>  ObjectProperty *
>  object_property_add(Object *obj, const char *name, const char *type,
>                      ObjectPropertyAccessor *get,
> @@ -1189,7 +1200,7 @@ object_property_add(Object *obj, const char *name, const char *type,
>                      ObjectPropertyRelease *release,
>                      void *opaque)
>  {
> -    return object_property_try_add(obj, name, type, get, set, release,
> +    return object_property_add_err(obj, name, type, get, set, release,
>                                     opaque, &error_abort);
>  }
>  
> @@ -1651,8 +1662,8 @@ static void object_finalize_child_property(Object *obj, const char *name,
>  }
>  
>  ObjectProperty *
> -object_property_add_child(Object *obj, const char *name,
> -                          Object *child)
> +object_property_add_child_err(Object *obj, const char *name,
> +                              Object *child, Error **errp)
>  {
>      g_autofree char *type = NULL;
>      ObjectProperty *op;
> @@ -1661,14 +1672,26 @@ object_property_add_child(Object *obj, const char *name,
>  
>      type = g_strdup_printf("child<%s>", object_get_typename(child));
>  
> -    op = object_property_add(obj, name, type, object_get_child_property, NULL,
> -                             object_finalize_child_property, child);
> +    op = object_property_add_err(obj, name, type, object_get_child_property,
> +                                 NULL, object_finalize_child_property,
> +                                 child, errp);
> +    if (!op) {
> +        goto out;
> +    }
>      op->resolve = object_resolve_child_property;
> +out:
>      object_ref(child);
>      child->parent = obj;
>      return op;
>  }
>  
> +ObjectProperty *
> +object_property_add_child(Object *obj, const char *name,
> +                          Object *child)
> +{
> +    return object_property_add_child_err(obj, name, child, &error_abort);
> +}
> +
>  void object_property_allow_set_link(const Object *obj, const char *name,
>                                      Object *val, Error **errp)
>  {
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 7e26f86fa6..c7fabda284 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -82,8 +82,11 @@ Object *user_creatable_add_type(const char *type, const char *id,
>      }
>  
>      if (id != NULL) {
> -        object_property_add_child(object_get_objects_root(),
> -                                  id, obj);
> +        object_property_add_child_err(object_get_objects_root(),
> +                                      id, obj, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
>      }
>  
>      user_creatable_complete(USER_CREATABLE(obj), &local_err);
> 


