Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD62AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771722081A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2IA13ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771722081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joCFm-0007WZ-Km
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joCF9-00071O-Cn
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:43:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joCF6-00017k-GK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593031415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLKzwJ067qNsf863b+ji1L6JtXia76Df9pO+cuGg90Q=;
 b=H2IA13jabQMg4zizsuM9Vav8rTwG1pnL/Ur3A61oY2JHbd+jWoNzeTC9lnHTFdY2OJmnCs
 mbOe4c55BF7cZiV9GaSsefM9VEZboYyZKoFLWbK/urWI8BDpw5muFX/oY59d1P/wtO9l0x
 gBE7Iza+nymj5o95+S4T5L4cvHzvCwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-9V6QHpVxM4Cfy-_CFKs8Ow-1; Wed, 24 Jun 2020 16:43:27 -0400
X-MC-Unique: 9V6QHpVxM4Cfy-_CFKs8Ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D3FE800FEA;
 Wed, 24 Jun 2020 20:43:26 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 777F36EDBE;
 Wed, 24 Jun 2020 20:43:25 +0000 (UTC)
Subject: Re: [PATCH 22/46] qapi: Make visitor functions taking Error ** return
 bool, not void
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-23-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1de6c7d2-636a-4185-e069-3e03c953ed84@redhat.com>
Date: Wed, 24 Jun 2020 15:43:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-23-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 11:43 AM, Markus Armbruster wrote:
> See recent commit "error: Document Error API usage rules" for
> rationale.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/devel/qapi-code-gen.txt  |  51 +++++------
>   include/qapi/clone-visitor.h  |   8 +-
>   include/qapi/visitor-impl.h   |  26 +++---
>   include/qapi/visitor.h        | 102 ++++++++++++---------
>   audio/audio_legacy.c          |  15 ++--
>   qapi/opts-visitor.c           |  58 +++++++-----
>   qapi/qapi-clone-visitor.c     |  33 ++++---
>   qapi/qapi-dealloc-visitor.c   |  27 ++++--
>   qapi/qapi-visit-core.c        | 165 ++++++++++++++++++----------------
>   qapi/qobject-input-visitor.c  | 109 +++++++++++++---------
>   qapi/qobject-output-visitor.c |  27 ++++--
>   qapi/string-input-visitor.c   |  62 +++++++------
>   qapi/string-output-visitor.c  |  32 ++++---
>   scripts/qapi/visit.py         |  58 +++++-------
>   14 files changed, 435 insertions(+), 338 deletions(-)

Hefty, but I don't see a sane way to split it further.

> 
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index a7794ef658..9bfc57063c 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt

> -    void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
> +    bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
>       {
>           Error *err = NULL;
>   
> -        visit_type_int(v, "integer", &obj->integer, &err);
> -        if (err) {
> -            goto out;
> +        if (!visit_type_int(v, "integer", &obj->integer, errp)) {
> +            return false;
>           }
>           if (visit_optional(v, "string", &obj->has_string)) {
> -            visit_type_str(v, "string", &obj->string, &err);
> -            if (err) {
> -                goto out;
> +            if (!visit_type_str(v, "string", &obj->string, errp)) {
> +                return false;
>               }
>           }

Is this worth compressing two 'if's into one:

if (visit_optional(...) &&
     !visit_type_str(...)) {
     return false;
}

> -
> -    out:
>           error_propagate(errp, err);
> +        return !err;

Now that 'err' is never anything but NULL, why aren't you dropping the 
error_propagate() and merely using 'return true;'?

>       }
>   
> -    void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
> +    bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
>       {
>           Error *err = NULL;
>   
> -        visit_start_struct(v, name, (void **)obj, sizeof(UserDefOne), &err);
> -        if (err) {
> -            goto out;
> +        if (!visit_start_struct(v, name, (void **)obj, sizeof(UserDefOne), errp)) {
> +            return false;
>           }
>           if (!*obj) {
>               /* incomplete */
> @@ -1461,19 +1457,18 @@ Example:

Adding context:

>             assert(visit_is_dealloc(v));
>             goto out_obj;
>         }
>         visit_type_UserDefOne_members(v, *obj, &err);
>         if (err) {
>             goto out_obj;

Should this be:

> if (!visit_type_UserDefOne_members(v, *obj, &err)) {
>     goto out_obj;
> 
>         }
>         visit_check_struct(v, &err);
>     out_obj:
>         visit_end_struct(v, (void **)obj);
>         if (err && visit_is_input(v)) {


>               qapi_free_UserDefOne(*obj);
>               *obj = NULL;
>           }
> -    out:
>           error_propagate(errp, err);
> +        return !err;

Here, err is still used by out_obj:, so this one is fine.

>       }
>   
> -    void visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp)
> +    bool visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp)
>       {
>           Error *err = NULL;
>           UserDefOneList *tail;
>           size_t size = sizeof(**obj);
>   
> -        visit_start_list(v, name, (GenericList **)obj, size, &err);
> -        if (err) {
> -            goto out;
> +        if (!visit_start_list(v, name, (GenericList **)obj, size, errp)) {
> +            return false;
>           }
>   
>           for (tail = *obj; tail;
> @@ -1492,21 +1487,19 @@ Example:

Adding context:

>              tail = (UserDefOneList *)visit_next_list(v, (GenericList *)tail, size)) {
>             visit_type_UserDefOne(v, NULL, &tail->value, &err);
>             if (err) {
>                 break;
>             }

Should this be:
if (visit_type_UserDefOne(...)) {
     break;

>         }
> 
>         if (!err) {
>             visit_check_list(v, &err);
>         }
>         visit_end_list(v, (void **)obj);
>         if (err && visit_is_input(v)) {


>               qapi_free_UserDefOneList(*obj);
>               *obj = NULL;
>           }
> -    out:
>           error_propagate(errp, err);
> +        return !err;
>       }

Again, err is still used, so this one is fine.

>   
> -    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp)
> +    bool visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp)
>       {
>           Error *err = NULL;
>   
> -        visit_type_UserDefOneList(v, "arg1", &obj->arg1, &err);
> -        if (err) {
> -            goto out;
> +        if (!visit_type_UserDefOneList(v, "arg1", &obj->arg1, errp)) {
> +            return false;
>           }
> -
> -    out:
>           error_propagate(errp, err);
> +        return !err;
>       }

But this is another one where err is unused.

>   
>   [Uninteresting stuff omitted...]
> diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
> index 5b665ee38c..adf9a788e2 100644
> --- a/include/qapi/clone-visitor.h

> +++ b/include/qapi/visitor.h
> @@ -286,6 +284,8 @@ void visit_free(Visitor *v);
>    * On failure, set *@obj to NULL and store an error through @errp.
>    * Can happen only when @v is an input visitor.
>    *
> + * Return true on succes, false on failure.

success

(copied several times in this file)

> +++ b/qapi/qapi-clone-visitor.c

> -static void qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
> +static bool qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
>                                      Error **errp)

Pre-existing indentation glitch that you could fix while here.

>   {
>       QapiCloneVisitor *qcv = to_qcv(v);
>   
>       assert(qcv->depth);
>       /* Value was already cloned by g_memdup() */
> +    return true;
>   }
>   
> -static void qapi_clone_type_uint64(Visitor *v, const char *name,
> +static bool qapi_clone_type_uint64(Visitor *v, const char *name,
>                                       uint64_t *obj, Error **errp)

Ditto for several more functions in this file.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


