Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E9C83007
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF35420730
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asxRXZw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF35420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVE2-0005N0-Qu
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVD2-0003yH-Ty
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVD2-0003Bu-0O
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:43:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55154
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTVD1-000392-FI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588099434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SY2OyndTyvQD2CkIo/IzC++xQiNiSgKOaqbRpZkqv8=;
 b=asxRXZw32gP5DuS1ZbJygXYBzWvZY5dVnHLR2IQhI2JaAND6XI+VHzZzi/IR0YtwuuZlnA
 +SlTZNMd7uRfQyX7/mTTbywprJ/nQaMIzwxo2/kkL5APZ/4qw8XgEiQxovse7Iq0+usfha
 AOOI8gJ9w2+RhwMF9bAlHcTZoHIpb8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-f1UB7ErwM9W7GqOx5EKeBw-1; Tue, 28 Apr 2020 14:43:52 -0400
X-MC-Unique: f1UB7ErwM9W7GqOx5EKeBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5A6800C78
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 18:43:51 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C55F600D2;
 Tue, 28 Apr 2020 18:43:50 +0000 (UTC)
Subject: Re: [PATCH 13/17] qom: Drop parameter @errp of object_property_add()
 & friends
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-14-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0646ba28-d14c-a1aa-81bb-56ba232d4c5f@redhat.com>
Date: Tue, 28 Apr 2020 13:43:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-14-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:34 AM, Markus Armbruster wrote:
> The only way object_property_add() can fail is when a property with
> the same name already exists.  Since our property names are all
> hardcoded, failure is a programming error, and the appropriate way to
> handle it is passing &error_abort.
> 
> Same for its variants, except for object_property_add_child(), which
> additionally fails when the child already has a parent.  Parentage is
> also under program control, so this is a programming error, too.
> 
> We have a bit over 500 callers.  Almost half of them pass
> &error_abort, slightly fewer ignore errors, one test case handles
> errors, and the remaining few callers pass them to their own callers.
> 
> The previous few commits demonstrated once again that ignoring
> programming errors is a bad idea.
> 
> Of the few ones that pass on errors, several violate the Error API.
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.  ich9_pm_add_properties(), sparc32_ledma_realize(),
> sparc32_dma_realize(), xilinx_axidma_realize(), xilinx_enet_realize()
> are wrong that way.
> 
> When the one appropriate choice of argument is &error_abort, letting
> users pick the argument is a bad idea.
> 
> Drop parameter @errp and assert the preconditions instead.
> 
> There's one exception to "duplicate property name is a programming
> error": the way object_property_add() implements the magic (and
> undocumented) "automatic arrayification".  Don't drop @errp there.
> Instead, rename object_property_add() to object_property_try_add(),
> and add the obvious wrapper object_property_add().

Huge. Could this last paragraph be done as a separate patch (ie. 
introduce object_property_try_add and adjust its clients), prior to the 
bulk mechanical patch that deletes the errp argument for all remaining 
instances?

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qom/object.h                |  81 +++-----

>   qom/container.c                     |   2 +-
>   qom/object.c                        | 302 +++++++++-------------------
>   qom/object_interfaces.c             |   5 +-

The core of the patch lies in these files, but even then it is still 
large because of adding a new API at the same time as fixing an existing 
one.

>   190 files changed, 643 insertions(+), 987 deletions(-)
> 

> +++ b/qom/object.c

> @@ -1129,12 +1123,12 @@ void object_unref(Object *obj)
>       }
>   }
>   
> -ObjectProperty *
> -object_property_add(Object *obj, const char *name, const char *type,
> -                    ObjectPropertyAccessor *get,
> -                    ObjectPropertyAccessor *set,
> -                    ObjectPropertyRelease *release,
> -                    void *opaque, Error **errp)
> +static ObjectProperty *
> +object_property_try_add(Object *obj, const char *name, const char *type,
> +                        ObjectPropertyAccessor *get,
> +                        ObjectPropertyAccessor *set,
> +                        ObjectPropertyRelease *release,
> +                        void *opaque, Error **errp)
>   {
>       ObjectProperty *prop;
>       size_t name_len = strlen(name);
> @@ -1148,8 +1142,8 @@ object_property_add(Object *obj, const char *name, const char *type,
>           for (i = 0; ; ++i) {
>               char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
>   
> -            ret = object_property_add(obj, full_name, type, get, set,
> -                                      release, opaque, NULL);
> +            ret = object_property_try_add(obj, full_name, type, get, set,
> +                                          release, opaque, NULL);
>               g_free(full_name);

Here's the magic in the last paragraph.

>               if (ret) {
>                   break;
> @@ -1179,6 +1173,17 @@ object_property_add(Object *obj, const char *name, const char *type,
>       return prop;
>   }
>   
> +ObjectProperty *
> +object_property_add(Object *obj, const char *name, const char *type,
> +                    ObjectPropertyAccessor *get,
> +                    ObjectPropertyAccessor *set,
> +                    ObjectPropertyRelease *release,
> +                    void *opaque)
> +{
> +    return object_property_try_add(obj, name, type, get, set, release,
> +                                   opaque, &error_abort);
> +}
> +

and if you were to split things into two patches, the first patch would 
be adding:

ObjectProperty *
object_property_add(Object *obj, const char *name, const char *type,
                     ObjectPropertyAccessor *get,
                     ObjectPropertyAccessor *set,
                     ObjectPropertyRelease *release,
                     void *opaque, Error **errp)
{
     return object_property_try_add(obj, name, type, get, set, release,
                                    opaque, errp);
}

with the second changing the signature to drop errp and forward 
&error_abort.


>   ObjectProperty *
>   object_class_property_add(ObjectClass *klass,
>                             const char *name,
> @@ -1186,16 +1191,11 @@ object_class_property_add(ObjectClass *klass,
>                             ObjectPropertyAccessor *get,
>                             ObjectPropertyAccessor *set,
>                             ObjectPropertyRelease *release,
> -                          void *opaque,
> -                          Error **errp)
> +                          void *opaque)
>   {
>       ObjectProperty *prop;
>   
> -    if (object_class_property_find(klass, name, NULL) != NULL) {
> -        error_setg(errp, "attempt to add duplicate property '%s' to class (type '%s')",
> -                   name, object_class_get_name(klass));
> -        return NULL;
> -    }
> +    assert(!object_class_property_find(klass, name, NULL));

If you do split, then deciding whether this type of cleanup belongs in 
the first patch (by ignoring the errp parameter, before mechanically 
dropping it) or the second is a fuzzier answer.

At any rate, my quick glance over the mechanical changes, and focused 
glance at these points of interest, sees nothing wrong.  So even if you 
do not split the patch, I can live with:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


