Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD06C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2666D23359
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOPmthSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2666D23359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppD0-0005OU-Dj
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jppCO-0004uw-0g
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:31:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jppCL-0004Yq-Lx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593419488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTD+G4Z8+I/NoMc6jGPpDrPy9CXlN5rZ0Uk+ZlXI1O8=;
 b=bOPmthSdoCOnsCd3frI6TaW+F+LCXKhCSBHiXC80qW7UCPvkU5BPVFygpXiSRsAiuC0zwG
 Qyx6FNwIQUG1kwKNj0HNUNpX6Bc06f6SGmqEdU/KBFJRA9qhgsMgVBMIqbwTKXpZ6T0JEn
 GMQOLVLIrvrcdRZDvkn8MuRsXURh8BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-hvkPmHHoN-WIUuKQwCFHCQ-1; Mon, 29 Jun 2020 04:31:26 -0400
X-MC-Unique: hvkPmHHoN-WIUuKQwCFHCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73C8691136;
 Mon, 29 Jun 2020 08:31:25 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE2D55D9CD;
 Mon, 29 Jun 2020 08:31:23 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] qom: Introduce object_property_try_add_child()
To: Markus Armbruster <armbru@redhat.com>
References: <20200624194809.26600-1-eric.auger@redhat.com>
 <20200624194809.26600-2-eric.auger@redhat.com>
 <87wo3v4hxa.fsf@dusky.pond.sub.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9e9f4998-211d-21bb-0978-1d3b8aea31c8@redhat.com>
Date: Mon, 29 Jun 2020 10:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87wo3v4hxa.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus

On 6/25/20 11:24 AM, Markus Armbruster wrote:
> Eric Auger <eric.auger@redhat.com> writes:
> 
>> object_property_add() does not allow object_property_try_add()
>> to gracefully fail as &error_abort is passed as an error handle.
>>
>> However such failure can easily be triggered from the QMP shell when,
>> for instance, one attempts to create an object with an id that already
>> exists. This is achived from the following call path:
>>
>> user_creatable_add_type -> object_property_add_child ->
>> object_property_add
>>
>> For instance, call twice:
>> object-add qom-type=memory-backend-ram id=mem1 props.size=1073741824
>> and QEMU aborts.
> 
> qmp_object_add -> user_creatable_add_dict -> user_creatable_add_type ->
> ...
OK
> 
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
> 
> What's this?  qmp-shell?
yes qmp-shell, I will add this info
> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Fixes: d2623129a7de ("qom: Drop parameter @errp of object_property_add() & friends")
>>
>> ---
>>
>> v2 -> v3:
>> - don't take the object reference on failure in
>>   object_property_try_add_child
>> ---
>>  include/qom/object.h    | 24 ++++++++++++++++++++++--
>>  qom/object.c            | 21 ++++++++++++++++-----
>>  qom/object_interfaces.c |  7 +++++--
>>  3 files changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 94a61ccc3f..91cf058d86 100644
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
>> @@ -1056,10 +1056,22 @@ void object_unref(Object *obj);
>>   *   meant to allow a property to free its opaque upon object
>>   *   destruction.  This may be NULL.
>>   * @opaque: an opaque pointer to pass to the callbacks for the property
>> + * @errp: error handle
> 
> We have several descriptions of @errp parameters in this file already,
> and you're inventing a new one :)
> 
> Suggest to pick one of the existing ones instead:
> 
>     * @errp: a pointer to an Error that is filled if getting/setting fails.
>     * @errp: If an error occurs, a pointer to an area to store the error
>     * @errp: pointer to error object
OK
>     * @errp: returns an error if this function fails
> 
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
>> + * object_property_add: same as object_property_try_add with
>> + * errp hardcoded to &error_abort
>> + */
> 
> Style:
> 
>    /**
>     * object_property_add:
>     * Same as object_property_try_add() with @errp hardcoded to
>     * &error_abort.
>     */
> 
> The line break after ':' matches the rest of the file (personally, I
> think the whole line is a complete waste then, but let's go with the
> flow).  The @ in @errp and the () in object_property_try_add() help
> tools with highlighting and linking.  Sentences start with a capital
> letter, and end with punctuation.
OK
> 
>>  ObjectProperty *object_property_add(Object *obj, const char *name,
>>                                      const char *type,
>>                                      ObjectPropertyAccessor *get,
>> @@ -1495,10 +1507,11 @@ Object *object_resolve_path_type(const char *path, const char *typename,
>>  Object *object_resolve_path_component(Object *parent, const char *part);
>>  
>>  /**
>> - * object_property_add_child:
>> + * object_property_try_add_child:
>>   * @obj: the object to add a property to
>>   * @name: the name of the property
>>   * @child: the child object
>> + * @errp: error handle
> 
> Likewise.
ok
> 
>>   *
>>   * Child properties form the composition tree.  All objects need to be a child
>>   * of another object.  Objects can only be a child of one object.
>> @@ -1512,6 +1525,13 @@ Object *object_resolve_path_component(Object *parent, const char *part);
>>   *
>>   * Returns: The newly added property on success, or %NULL on failure.
>>   */
>> +ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
>> +                                              Object *child, Error **errp);
>> +
>> +/**
>> + * object_property_add_child: same as object_property_try_add_child with
>> + * errp hardcoded to &error_abort
>> + */
> 
> Likewise.
ok
> 
>>
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
> Preferably with the comments touched up:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
Thanks!

Eric
> 


