Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B1FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6851E21775
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC4P+oBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6851E21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUkPy-0007Uy-G6
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 01:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkPA-0006Up-S3
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUkPA-0000JE-1L
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:09:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkP9-0000Hs-LA
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588396175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ItbcosrXu41Khf/rRIqU1BzQH4/U+3fI+xUFEH6JqLI=;
 b=JC4P+oBNadxv2f7H1VqQIfnZieh/nOLjZr1XoIWhUBMvGbRtnq01OgBZD4SvlYb/fKCElC
 JhiBH9e9L8KOn7qTUc/F7sIUkGkCWfMakER/gVUNw6tgtdrLKzx+vS6/zBT3xvYkKgMjdv
 8hQAkmgIOEzsp4dyk+F25wdh3Uf+LMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-YsKYj886PvyTO4snWZpEaQ-1; Sat, 02 May 2020 01:09:33 -0400
X-MC-Unique: YsKYj886PvyTO4snWZpEaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74255464
 for <qemu-devel@nongnu.org>; Sat,  2 May 2020 05:09:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18518605CB;
 Sat,  2 May 2020 05:09:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B99B11358BD; Sat,  2 May 2020 07:09:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 13/17] qom: Drop parameter @errp of object_property_add()
 & friends
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-14-armbru@redhat.com>
 <0646ba28-d14c-a1aa-81bb-56ba232d4c5f@redhat.com>
Date: Sat, 02 May 2020 07:09:30 +0200
In-Reply-To: <0646ba28-d14c-a1aa-81bb-56ba232d4c5f@redhat.com> (Eric Blake's
 message of "Tue, 28 Apr 2020 13:43:49 -0500")
Message-ID: <87tv0y7wj9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 01:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/28/20 11:34 AM, Markus Armbruster wrote:
>> The only way object_property_add() can fail is when a property with
>> the same name already exists.  Since our property names are all
>> hardcoded, failure is a programming error, and the appropriate way to
>> handle it is passing &error_abort.
>>
>> Same for its variants, except for object_property_add_child(), which
>> additionally fails when the child already has a parent.  Parentage is
>> also under program control, so this is a programming error, too.
>>
>> We have a bit over 500 callers.  Almost half of them pass
>> &error_abort, slightly fewer ignore errors, one test case handles
>> errors, and the remaining few callers pass them to their own callers.
>>
>> The previous few commits demonstrated once again that ignoring
>> programming errors is a bad idea.
>>
>> Of the few ones that pass on errors, several violate the Error API.
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.  Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>> call.  ich9_pm_add_properties(), sparc32_ledma_realize(),
>> sparc32_dma_realize(), xilinx_axidma_realize(), xilinx_enet_realize()
>> are wrong that way.
>>
>> When the one appropriate choice of argument is &error_abort, letting
>> users pick the argument is a bad idea.
>>
>> Drop parameter @errp and assert the preconditions instead.
>>
>> There's one exception to "duplicate property name is a programming
>> error": the way object_property_add() implements the magic (and
>> undocumented) "automatic arrayification".  Don't drop @errp there.
>> Instead, rename object_property_add() to object_property_try_add(),
>> and add the obvious wrapper object_property_add().
>
> Huge. Could this last paragraph be done as a separate patch
> (ie. introduce object_property_try_add and adjust its clients), prior
> to the bulk mechanical patch that deletes the errp argument for all
> remaining instances?

It could.  Patch would look like this:

   @@ -1129,12 +1123,12 @@ void object_unref(Object *obj)
        }
    }

   -ObjectProperty *
   -object_property_add(Object *obj, const char *name, const char *type,
   -                    ObjectPropertyAccessor *get,
   -                    ObjectPropertyAccessor *set,
   -                    ObjectPropertyRelease *release,
   -                    void *opaque, Error **errp)
   +static ObjectProperty *
   +object_property_try_add(Object *obj, const char *name, const char *type=
,
   +                        ObjectPropertyAccessor *get,
   +                        ObjectPropertyAccessor *set,
   +                        ObjectPropertyRelease *release,
   +                        void *opaque, Error **errp)
    {
        ObjectProperty *prop;
        size_t name_len =3D strlen(name);
   @@ -1148,8 +1142,8 @@ object_property_add(Object *obj, const char *name,=
 const char *type,
            for (i =3D 0; ; ++i) {
                char *full_name =3D g_strdup_printf("%s[%d]", name_no_array=
, i);

   -            ret =3D object_property_add(obj, full_name, type, get, set,
   -                                      release, opaque, NULL);
   +            ret =3D object_property_try_add(obj, full_name, type, get, =
set,
   +                                          release, opaque, NULL);
                g_free(full_name);
                if (ret) {
                    break;
   @@ -1179,6 +1173,17 @@ object_property_add(Object *obj, const char *name=
, const char *type,
        return prop;
    }

   +ObjectProperty *
   +object_property_add(Object *obj, const char *name, const char *type,
   +                    ObjectPropertyAccessor *get,
   +                    ObjectPropertyAccessor *set,
   +                    ObjectPropertyRelease *release,
   +                    void *opaque, Error **errp)
   +{
   +    return object_property_try_add(obj, name, type, get, set, release,
   +                                   opaque, errp);
   +}
   +
    ObjectProperty *
    object_class_property_add(ObjectClass *klass,
                              const char *name,

Makes no sense on its own, so I'd have to explain in the commit message.
I doubt it's worthwhile.

>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qom/object.h                |  81 +++-----
>
>>   qom/container.c                     |   2 +-
>>   qom/object.c                        | 302 +++++++++-------------------
>>   qom/object_interfaces.c             |   5 +-
>
> The core of the patch lies in these files, but even then it is still
> large because of adding a new API at the same time as fixing an
> existing one.

It is large because we're fixing up 25 functions (object.h: 25
insertions(+), 56 deletions(-)), and their uses.  The new code is
actually quite small: 19 insertions(+), 8 deletions(-).

>>   190 files changed, 643 insertions(+), 987 deletions(-)
>>
>
>> +++ b/qom/object.c
>
>> @@ -1129,12 +1123,12 @@ void object_unref(Object *obj)
>>       }
>>   }
>>   -ObjectProperty *
>> -object_property_add(Object *obj, const char *name, const char *type,
>> -                    ObjectPropertyAccessor *get,
>> -                    ObjectPropertyAccessor *set,
>> -                    ObjectPropertyRelease *release,
>> -                    void *opaque, Error **errp)
>> +static ObjectProperty *
>> +object_property_try_add(Object *obj, const char *name, const char *type=
,
>> +                        ObjectPropertyAccessor *get,
>> +                        ObjectPropertyAccessor *set,
>> +                        ObjectPropertyRelease *release,
>> +                        void *opaque, Error **errp)
>>   {
>>       ObjectProperty *prop;
>>       size_t name_len =3D strlen(name);
>> @@ -1148,8 +1142,8 @@ object_property_add(Object *obj, const char *name,=
 const char *type,
>>           for (i =3D 0; ; ++i) {
>>               char *full_name =3D g_strdup_printf("%s[%d]", name_no_arra=
y, i);
>>   -            ret =3D object_property_add(obj, full_name, type, get,
>> set,
>> -                                      release, opaque, NULL);
>> +            ret =3D object_property_try_add(obj, full_name, type, get, =
set,
>> +                                          release, opaque, NULL);
>>               g_free(full_name);
>
> Here's the magic in the last paragraph.
>
>>               if (ret) {
>>                   break;
>> @@ -1179,6 +1173,17 @@ object_property_add(Object *obj, const char *name=
, const char *type,
>>       return prop;
>>   }
>>   +ObjectProperty *
>> +object_property_add(Object *obj, const char *name, const char *type,
>> +                    ObjectPropertyAccessor *get,
>> +                    ObjectPropertyAccessor *set,
>> +                    ObjectPropertyRelease *release,
>> +                    void *opaque)
>> +{
>> +    return object_property_try_add(obj, name, type, get, set, release,
>> +                                   opaque, &error_abort);
>> +}
>> +
>
> and if you were to split things into two patches, the first patch
> would be adding:
>
> ObjectProperty *
> object_property_add(Object *obj, const char *name, const char *type,
>                     ObjectPropertyAccessor *get,
>                     ObjectPropertyAccessor *set,
>                     ObjectPropertyRelease *release,
>                     void *opaque, Error **errp)
> {
>     return object_property_try_add(obj, name, type, get, set, release,
>                                    opaque, errp);
> }
>
> with the second changing the signature to drop errp and forward
> &error_abort.
>
>
>>   ObjectProperty *
>>   object_class_property_add(ObjectClass *klass,
>>                             const char *name,
>> @@ -1186,16 +1191,11 @@ object_class_property_add(ObjectClass *klass,
>>                             ObjectPropertyAccessor *get,
>>                             ObjectPropertyAccessor *set,
>>                             ObjectPropertyRelease *release,
>> -                          void *opaque,
>> -                          Error **errp)
>> +                          void *opaque)
>>   {
>>       ObjectProperty *prop;
>>   -    if (object_class_property_find(klass, name, NULL) !=3D NULL) {
>> -        error_setg(errp, "attempt to add duplicate property '%s' to cla=
ss (type '%s')",
>> -                   name, object_class_get_name(klass));
>> -        return NULL;
>> -    }
>> +    assert(!object_class_property_find(klass, name, NULL));
>
> If you do split, then deciding whether this type of cleanup belongs in
> the first patch (by ignoring the errp parameter, before mechanically
> dropping it) or the second is a fuzzier answer.

Hmm, that's another splitting idea: eliminate use of the @errp
parameters, then drop them.  I'll think about it.

> At any rate, my quick glance over the mechanical changes, and focused
> glance at these points of interest, sees nothing wrong.  So even if
> you do not split the patch, I can live with:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


