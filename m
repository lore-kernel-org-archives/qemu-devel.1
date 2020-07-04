Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF7AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 13:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3AC207CD
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 13:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rz7q7XYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3AC207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jri5I-0006Pw-0i
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 09:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jri4X-0005pw-2u
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 09:19:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jri4U-0001Op-Qo
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 09:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593868749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P/VRq/mZi47qEUcpFw/t63kLhDvmMAbqamoS8cX4IdY=;
 b=Rz7q7XYwfr0qccsnAk4pj8DlTz1nxHcuQhgP0JeHESUwmgJlu/IVg+Zx2D809NVsHORg4L
 Lsl0zInVhM6qLIcV0d++msdkYJPvQ3907Hn2BWtPHg371hLBd1x0m26xn/BWWLg+UbutPh
 BI2WKh55l7WgCnIa4hc1rYqcRVXaXcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-nZcjoXKQO_G6YMHsyhY5vw-1; Sat, 04 Jul 2020 09:19:06 -0400
X-MC-Unique: nZcjoXKQO_G6YMHsyhY5vw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CAF8107ACCA;
 Sat,  4 Jul 2020 13:19:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B3671682;
 Sat,  4 Jul 2020 13:19:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78F781138648; Sat,  4 Jul 2020 15:19:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 16/44] qapi: Make visitor functions taking Error **
 return bool, not void
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-17-armbru@redhat.com>
 <3dd46515-d6e9-7b26-9c21-03def1170a91@virtuozzo.com>
Date: Sat, 04 Jul 2020 15:19:02 +0200
In-Reply-To: <3dd46515-d6e9-7b26-9c21-03def1170a91@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 3 Jul 2020 17:32:23 +0300")
Message-ID: <87o8ovo1tl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 07:11:30
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 02.07.2020 18:49, Markus Armbruster wrote:
>> See recent commit "error: Document Error API usage rules" for
>> rationale.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   docs/devel/qapi-code-gen.txt  |  51 +++++------
>>   include/qapi/clone-visitor.h  |   8 +-
>>   include/qapi/visitor-impl.h   |  26 +++---
>>   include/qapi/visitor.h        | 102 ++++++++++++---------
>>   audio/audio_legacy.c          |  15 ++--
>>   qapi/opts-visitor.c           |  58 +++++++-----
>>   qapi/qapi-clone-visitor.c     |  67 ++++++++------
>>   qapi/qapi-dealloc-visitor.c   |  27 ++++--
>>   qapi/qapi-visit-core.c        | 165 ++++++++++++++++++----------------
>>   qapi/qobject-input-visitor.c  | 109 +++++++++++++---------
>>   qapi/qobject-output-visitor.c |  27 ++++--
>>   qapi/string-input-visitor.c   |  62 +++++++------
>>   qapi/string-output-visitor.c  |  32 ++++---
>>   scripts/qapi/visit.py         |  58 +++++-------
>>   14 files changed, 452 insertions(+), 355 deletions(-)
>>
>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
>> index a7794ef658..9bfc57063c 100644
>> --- a/docs/devel/qapi-code-gen.txt
>> +++ b/docs/devel/qapi-code-gen.txt
>> @@ -1408,42 +1408,38 @@ Example:
>>       #include "example-qapi-types.h"
>>     -    void visit_type_UserDefOne_members(Visitor *v, UserDefOne
>> *obj, Error **errp);
>> -    void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
>> -    void visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp);
>> +    bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp);
>> +    bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
>> +    bool visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp);
>>   -    void visit_type_q_obj_my_command_arg_members(Visitor *v,
>> q_obj_my_command_arg *obj, Error **errp);
>> +    bool visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp);
>>         #endif /* EXAMPLE_QAPI_VISIT_H */
>>       $ cat qapi-generated/example-qapi-visit.c
>
> should it be tests/test-qapi-visit.c ? [preexisting, don't care]

No, that one's generated from tests/qapi-schema/qapi-schema-test.json,
while this one is generated from example-schema.json.

>>   [Uninteresting stuff omitted...]
>>   -    void visit_type_UserDefOne_members(Visitor *v, UserDefOne
>> *obj, Error **errp)
>> +    bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
>>       {
>>           Error *err = NULL;
>>   -        visit_type_int(v, "integer", &obj->integer, &err);
>> -        if (err) {
>> -            goto out;
>> +        if (!visit_type_int(v, "integer", &obj->integer, errp)) {
>> +            return false;
>>           }
>>           if (visit_optional(v, "string", &obj->has_string)) {
>> -            visit_type_str(v, "string", &obj->string, &err);
>> -            if (err) {
>> -                goto out;
>> +            if (!visit_type_str(v, "string", &obj->string, errp)) {
>> +                return false;
>>               }
>>           }
>> -
>> -    out:
>>           error_propagate(errp, err);
>> +        return !err;
>
> Looks weird with redundant err variable.. Still works. I see, after the whole series it is handled, so, OK.

Eric spotted this in v1, and asked for an explanation.  Perhaps I should
have added a note to my commit message then.

This patch has a narrow scope: it does just enough to make the functions
return bool.  The result is a bit weird in places.  PATCH 39 will
straighten it out.

We can't drop the @err and error_propagate() here just yet, because the
generator can still generate code that needs it, just not for this
particular input.

>>       }
>>   -    void visit_type_UserDefOne(Visitor *v, const char *name,
>> UserDefOne **obj, Error **errp)
>> +    bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
>>       {
>>           Error *err = NULL;
>>   -        visit_start_struct(v, name, (void **)obj,
>> sizeof(UserDefOne), &err);
>> -        if (err) {
>> -            goto out;
>
> [..]
>
>> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
>> index 5fe0276c1c..6d8f4b6928 100644
>> --- a/qapi/opts-visitor.c
>> +++ b/qapi/opts-visitor.c
>> @@ -133,7 +133,7 @@ opts_visitor_insert(GHashTable *unprocessed_opts, const QemuOpt *opt)
>>   }
>>     
>
> [..]
>
>>     @@ -221,7 +224,7 @@ lookup_distinct(const OptsVisitor *ov, const
>> char *name, Error **errp)
>>   }
>>     -static void
>> +static bool
>>   opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
>>                   Error **errp)
>>   {
>> @@ -238,6 +241,7 @@ opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
>>       } else {
>>           *list = NULL;
>
> should return false here, as errp is set.

Falcon eyes!  I'll fix it.

>>       }
>> +    return true;
>>   }
>>     @@ -285,13 +289,14 @@ opts_next_list(Visitor *v, GenericList
>> *tail, size_t size)
>>   }
>>     
>
> [..]
>
>> diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
>> index daab6819b4..5a54bd593f 100644
>> --- a/qapi/qapi-clone-visitor.c
>> +++ b/qapi/qapi-clone-visitor.c
>> @@ -24,7 +24,7 @@ static QapiCloneVisitor *to_qcv(Visitor *v)
>>       return container_of(v, QapiCloneVisitor, visitor);
>>   }
>>   -static void qapi_clone_start_struct(Visitor *v, const char *name,
>> void **obj,
>> +static bool qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
>>                                       size_t size, Error **errp)
>>   {
>>       QapiCloneVisitor *qcv = to_qcv(v);
>> @@ -34,11 +34,12 @@ static void qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
>>           /* Only possible when visiting an alternate's object
>>            * branch. Nothing further to do here, since the earlier
>>            * visit_start_alternate() already copied memory. */
>> -        return;
>> +        return true;
>>       }
>>         *obj = g_memdup(*obj, size);
>>       qcv->depth++;
>> +    return true;
>>   }
>>     static void qapi_clone_end(Visitor *v, void **obj)
>> @@ -51,11 +52,12 @@ static void qapi_clone_end(Visitor *v, void **obj)
>>       }
>>   }
>>   -static void qapi_clone_start_list(Visitor *v, const char *name,
>> +static bool qapi_clone_start_list(Visitor *v, const char *name,
>>                                     GenericList **listp, size_t size,
>>                                     Error **errp)
>>   {
>>       qapi_clone_start_struct(v, name, (void **)listp, size, errp);
>> +    return true;
>
> should be return qapi_clone_start_struct(v, name, (void **)listp, size, errp);

You're right.

qapi_clone_start_struct() only ever returns true, but relying on that
would be unclean.

>>   }
>>     static GenericList *qapi_clone_next_list(Visitor *v, GenericList
>> *tail,
>> @@ -69,45 +71,49 @@ static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
>>       return tail->next;
>>   }
>>   -static void qapi_clone_start_alternate(Visitor *v, const char
>> *name,
>> +static bool qapi_clone_start_alternate(Visitor *v, const char *name,
>>                                          GenericAlternate **obj, size_t size,
>>                                          Error **errp)
>>   {
>>       qapi_clone_start_struct(v, name, (void **)obj, size, errp);
>> +    return true;
>
> similar here

Right again.

>>   }
>>   -static void qapi_clone_type_int64(Visitor *v, const char *name,
>> int64_t *obj,
>> -                                   Error **errp)
>> -{
>> -    QapiCloneVisitor *qcv = to_qcv(v);
>> -
>> -    assert(qcv->depth);
>> -    /* Value was already cloned by g_memdup() */
>> -}
>
>
> With three return values fixed:
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks!


