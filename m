Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50812C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFA520702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMERqheA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFA520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcii-0002c6-Ag
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jqci3-0001rz-Q4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:23:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jqci0-0000Iy-He
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593609807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKNg4EeZJ9mAqr17xIJ3ufSFFPwK809/cs7wyVhpC80=;
 b=CMERqheAX0UR5SU3Qk2lzbRnMO1YC+9Xh8jSSAcg0JnuJyWSsS8xSDmaktSE9ypGgIB5uq
 G/Xp/WZprHePQWvGkn99GC/j1E+AzG6Nnd/DKmOQDwH99Kg/bIlUVlwe64QpXojQ+zmQcg
 1gmhKnN61HeI17DvJPDI3j17kiYWzRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-D5hFz_vXOYS-mjvc7FHq_g-1; Wed, 01 Jul 2020 09:23:23 -0400
X-MC-Unique: D5hFz_vXOYS-mjvc7FHq_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7640BFC1;
 Wed,  1 Jul 2020 13:23:22 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C05CACF92F;
 Wed,  1 Jul 2020 13:23:20 +0000 (UTC)
Subject: Re: [PATCH v5 1/3] qom: Introduce object_property_try_add_child()
To: Greg Kurz <groug@kaod.org>
References: <20200629193424.30280-1-eric.auger@redhat.com>
 <20200629193424.30280-2-eric.auger@redhat.com>
 <20200630154151.229e60eb@bahia.lan>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <883c3eee-b86e-3788-49e6-f515e82319cb@redhat.com>
Date: Wed, 1 Jul 2020 15:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630154151.229e60eb@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
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
Cc: berrange@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Greg,

On 6/30/20 3:41 PM, Greg Kurz wrote:
> On Mon, 29 Jun 2020 21:34:22 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> object_property_add() does not allow object_property_try_add()
>> to gracefully fail as &error_abort is passed as an error handle.
>>
>> However such failure can easily be triggered from the QMP shell when,
>> for instance, one attempts to create an object with an id that already
>> exists. This is achieved from the following call path:
>>
>> qmp_object_add -> user_creatable_add_dict -> user_creatable_add_type ->
>> object_property_add_child -> object_property_add
>>
>> For instance, from the qmp-shell, call twice:
>> object-add qom-type=memory-backend-ram id=mem1 props.size=1073741824
>> and QEMU aborts.
>>
>> This behavior is undesired as a user/management application mistake
>> in reusing a property ID shouldn't result in loss of the VM and live
>> data within.
>>
>> This patch introduces a new function, object_property_try_add_child()
>> which takes an error handle and turn object_property_try_add() into
>> a non-static one.
>>
>> Now the call path becomes:
>>
>> user_creatable_add_type -> object_property_try_add_child ->
>> object_property_try_add
>>
>> and the error is returned gracefully to the QMP client.
>>
>> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
>> {"return": {}}
>> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
>> {"error": {"class": "GenericError", "desc": "attempt to add duplicate property
>> 'mem2' to object (type 'container')"}}
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Fixes: d2623129a7de ("qom: Drop parameter @errp of object_property_add() & friends")
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
> 
> FWIW
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> and
> 
> Tested-by: Greg Kurz <groug@kaod.org>
Thanks!

Eric
> 
>> ---
>>
>> v3 -> v4:
>> - Took into account Markus' style related comments
>>
>> v2 -> v3:
>> - don't take the object reference on failure in
>>   object_property_try_add_child
>> ---
>>  include/qom/object.h    | 26 ++++++++++++++++++++++++--
>>  qom/object.c            | 21 ++++++++++++++++-----
>>  qom/object_interfaces.c |  7 +++++--
>>  3 files changed, 45 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 94a61ccc3f..1c5cdcd0e3 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1039,7 +1039,7 @@ Object *object_ref(Object *obj);
>>  void object_unref(Object *obj);
>>  
>>  /**
>> - * object_property_add:
>> + * object_property_try_add:
>>   * @obj: the object to add a property to
>>   * @name: the name of the property.  This can contain any character except for
>>   *  a forward slash.  In general, you should use hyphens '-' instead of
>> @@ -1056,10 +1056,23 @@ void object_unref(Object *obj);
>>   *   meant to allow a property to free its opaque upon object
>>   *   destruction.  This may be NULL.
>>   * @opaque: an opaque pointer to pass to the callbacks for the property
>> + * @errp: pointer to error object
>>   *
>>   * Returns: The #ObjectProperty; this can be used to set the @resolve
>>   * callback for child and link properties.
>>   */
>> +ObjectProperty *object_property_try_add(Object *obj, const char *name,
>> +                                        const char *type,
>> +                                        ObjectPropertyAccessor *get,
>> +                                        ObjectPropertyAccessor *set,
>> +                                        ObjectPropertyRelease *release,
>> +                                        void *opaque, Error **errp);
>> +
>> +/**
>> + * object_property_add:
>> + * Same as object_property_try_add() with @errp hardcoded to
>> + * &error_abort.
>> + */
>>  ObjectProperty *object_property_add(Object *obj, const char *name,
>>                                      const char *type,
>>                                      ObjectPropertyAccessor *get,
>> @@ -1495,10 +1508,11 @@ Object *object_resolve_path_type(const char *path, const char *typename,
>>  Object *object_resolve_path_component(Object *parent, const char *part);
>>  
>>  /**
>> - * object_property_add_child:
>> + * object_property_try_add_child:
>>   * @obj: the object to add a property to
>>   * @name: the name of the property
>>   * @child: the child object
>> + * @errp: pointer to error object
>>   *
>>   * Child properties form the composition tree.  All objects need to be a child
>>   * of another object.  Objects can only be a child of one object.
>> @@ -1512,6 +1526,14 @@ Object *object_resolve_path_component(Object *parent, const char *part);
>>   *
>>   * Returns: The newly added property on success, or %NULL on failure.
>>   */
>> +ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
>> +                                              Object *child, Error **errp);
>> +
>> +/**
>> + * object_property_add_child:
>> + * Same as object_property_try_add_child() with @errp hardcoded to
>> + * &error_abort
>> + */
>>  ObjectProperty *object_property_add_child(Object *obj, const char *name,
>>                                            Object *child);
>>  
>> diff --git a/qom/object.c b/qom/object.c
>> index 6ece96bc2b..dc10bb1889 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -1132,7 +1132,7 @@ void object_unref(Object *obj)
>>      }
>>  }
>>  
>> -static ObjectProperty *
>> +ObjectProperty *
>>  object_property_try_add(Object *obj, const char *name, const char *type,
>>                          ObjectPropertyAccessor *get,
>>                          ObjectPropertyAccessor *set,
>> @@ -1651,8 +1651,8 @@ static void object_finalize_child_property(Object *obj, const char *name,
>>  }
>>  
>>  ObjectProperty *
>> -object_property_add_child(Object *obj, const char *name,
>> -                          Object *child)
>> +object_property_try_add_child(Object *obj, const char *name,
>> +                              Object *child, Error **errp)
>>  {
>>      g_autofree char *type = NULL;
>>      ObjectProperty *op;
>> @@ -1661,14 +1661,25 @@ object_property_add_child(Object *obj, const char *name,
>>  
>>      type = g_strdup_printf("child<%s>", object_get_typename(child));
>>  
>> -    op = object_property_add(obj, name, type, object_get_child_property, NULL,
>> -                             object_finalize_child_property, child);
>> +    op = object_property_try_add(obj, name, type, object_get_child_property,
>> +                                 NULL, object_finalize_child_property,
>> +                                 child, errp);
>> +    if (!op) {
>> +        return NULL;
>> +    }
>>      op->resolve = object_resolve_child_property;
>>      object_ref(child);
>>      child->parent = obj;
>>      return op;
>>  }
>>  
>> +ObjectProperty *
>> +object_property_add_child(Object *obj, const char *name,
>> +                          Object *child)
>> +{
>> +    return object_property_try_add_child(obj, name, child, &error_abort);
>> +}
>> +
>>  void object_property_allow_set_link(const Object *obj, const char *name,
>>                                      Object *val, Error **errp)
>>  {
>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> index 7e26f86fa6..1e05e41d2f 100644
>> --- a/qom/object_interfaces.c
>> +++ b/qom/object_interfaces.c
>> @@ -82,8 +82,11 @@ Object *user_creatable_add_type(const char *type, const char *id,
>>      }
>>  
>>      if (id != NULL) {
>> -        object_property_add_child(object_get_objects_root(),
>> -                                  id, obj);
>> +        object_property_try_add_child(object_get_objects_root(),
>> +                                      id, obj, &local_err);
>> +        if (local_err) {
>> +            goto out;
>> +        }
>>      }
>>  
>>      user_creatable_complete(USER_CREATABLE(obj), &local_err);
> 


