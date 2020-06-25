Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ECBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F55B20768
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHmonHds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F55B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTJp-0006ge-MX
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTJ6-0005rb-7P
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:56:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTJ4-000655-9R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593097009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCysxeUtxGy+ZJdT/rzeTwgFWw3YiOBxRjqVLfi1iGk=;
 b=iHmonHdsL0UDR4ki7jN0vdFstX/nHssZ8WfMJc89A/GHi/lfHi+tCpbw8xLIG0RaFWEWEn
 VzH2NRGoB5BolRIGmj6GY8fyuxLENFELsk9Wu6uJJ0nVlVrUGuAabg8JnDrfmlcmbuj8Rw
 iw9KTdNg1cYlFN1iCf3GeSgH9MfQDyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-_AjvTvAtMQORcP5LTfwztQ-1; Thu, 25 Jun 2020 10:56:44 -0400
X-MC-Unique: _AjvTvAtMQORcP5LTfwztQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCFA3193F564;
 Thu, 25 Jun 2020 14:56:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 877657B603;
 Thu, 25 Jun 2020 14:56:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1379A11384D4; Thu, 25 Jun 2020 16:56:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 22/46] qapi: Make visitor functions taking Error ** return
 bool, not void
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-23-armbru@redhat.com>
 <1de6c7d2-636a-4185-e069-3e03c953ed84@redhat.com>
Date: Thu, 25 Jun 2020 16:56:40 +0200
In-Reply-To: <1de6c7d2-636a-4185-e069-3e03c953ed84@redhat.com> (Eric Blake's
 message of "Wed, 24 Jun 2020 15:43:24 -0500")
Message-ID: <87pn9nxkgn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 6/24/20 11:43 AM, Markus Armbruster wrote:
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
>>   qapi/qapi-clone-visitor.c     |  33 ++++---
>>   qapi/qapi-dealloc-visitor.c   |  27 ++++--
>>   qapi/qapi-visit-core.c        | 165 ++++++++++++++++++----------------
>>   qapi/qobject-input-visitor.c  | 109 +++++++++++++---------
>>   qapi/qobject-output-visitor.c |  27 ++++--
>>   qapi/string-input-visitor.c   |  62 +++++++------
>>   qapi/string-output-visitor.c  |  32 ++++---
>>   scripts/qapi/visit.py         |  58 +++++-------
>>   14 files changed, 435 insertions(+), 338 deletions(-)
>
> Hefty, but I don't see a sane way to split it further.

I kept its scope as narrow as I could.  More on that below.

>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
>> index a7794ef658..9bfc57063c 100644
>> --- a/docs/devel/qapi-code-gen.txt
>> +++ b/docs/devel/qapi-code-gen.txt
>
>> -    void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
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
>
> Is this worth compressing two 'if's into one:
>
> if (visit_optional(...) &&
>     !visit_type_str(...)) {
>     return false;
> }

This is due to the structure of the code generator:

       for memb in members:
           ret += gen_if(memb.ifcond)
           if memb.optional:
               ret += mcgen('''
       if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
   ''',
                            name=memb.name, c_name=c_name(memb.name))
               push_indent()
           ret += mcgen('''
       if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
           return false;
       }
   ''',
                        c_type=memb.type.c_name(), name=memb.name,
                        c_name=c_name(memb.name))
           if memb.optional:
               pop_indent()
               ret += mcgen('''
       }
   ''')
           ret += gen_endif(memb.ifcond)

Note how we splice in the if (visit_optional(...)) without affecting the
common part.

I doubt messing with it is worthwhile.

>> -
>> -    out:
>>           error_propagate(errp, err);
>> +        return !err;
>
> Now that 'err' is never anything but NULL, why aren't you dropping the
> error_propagate() and merely using 'return true;'?

We can't drop the error_propagate() just yet, because the generator can
still generate code that needs it, just not for this particular input.

Narrow scope: this patch does just enough to make the functions return
bool.  It freely uses such bool function values for this purpose, but it
refrains from exploiting them for more.  That's left to later patches,
in this case PATCH 25.

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
>> +        if (!visit_start_struct(v, name, (void **)obj, sizeof(UserDefOne), errp)) {
>> +            return false;
>>           }
>>           if (!*obj) {
>>               /* incomplete */
>> @@ -1461,19 +1457,18 @@ Example:
>
> Adding context:
>
>>             assert(visit_is_dealloc(v));
>>             goto out_obj;
>>         }
>>         visit_type_UserDefOne_members(v, *obj, &err);
>>         if (err) {
>>             goto out_obj;
>
> Should this be:
>
>> if (!visit_type_UserDefOne_members(v, *obj, &err)) {
>>     goto out_obj;

Also left for PATCH 25.

>>         }
>>         visit_check_struct(v, &err);
>>     out_obj:
>>         visit_end_struct(v, (void **)obj);
>>         if (err && visit_is_input(v)) {
>
>
>>               qapi_free_UserDefOne(*obj);
>>               *obj = NULL;
>>           }
>> -    out:
>>           error_propagate(errp, err);
>> +        return !err;
>
> Here, err is still used by out_obj:, so this one is fine.
>
>>       }
>>   -    void visit_type_UserDefOneList(Visitor *v, const char *name,
>> UserDefOneList **obj, Error **errp)
>> +    bool visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp)
>>       {
>>           Error *err = NULL;
>>           UserDefOneList *tail;
>>           size_t size = sizeof(**obj);
>>   -        visit_start_list(v, name, (GenericList **)obj, size,
>> &err);
>> -        if (err) {
>> -            goto out;
>> +        if (!visit_start_list(v, name, (GenericList **)obj, size, errp)) {
>> +            return false;
>>           }
>>             for (tail = *obj; tail;
>> @@ -1492,21 +1487,19 @@ Example:
>
> Adding context:
>
>>              tail = (UserDefOneList *)visit_next_list(v, (GenericList *)tail, size)) {
>>             visit_type_UserDefOne(v, NULL, &tail->value, &err);
>>             if (err) {
>>                 break;
>>             }
>
> Should this be:
> if (visit_type_UserDefOne(...)) {
>     break;

Likewise.

>>         }
>>
>>         if (!err) {
>>             visit_check_list(v, &err);
>>         }
>>         visit_end_list(v, (void **)obj);
>>         if (err && visit_is_input(v)) {
>
>
>>               qapi_free_UserDefOneList(*obj);
>>               *obj = NULL;
>>           }
>> -    out:
>>           error_propagate(errp, err);
>> +        return !err;
>>       }
>
> Again, err is still used, so this one is fine.
>
>>   -    void visit_type_q_obj_my_command_arg_members(Visitor *v,
>> q_obj_my_command_arg *obj, Error **errp)
>> +    bool visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp)
>>       {
>>           Error *err = NULL;
>>   -        visit_type_UserDefOneList(v, "arg1", &obj->arg1, &err);
>> -        if (err) {
>> -            goto out;
>> +        if (!visit_type_UserDefOneList(v, "arg1", &obj->arg1, errp)) {
>> +            return false;
>>           }
>> -
>> -    out:
>>           error_propagate(errp, err);
>> +        return !err;
>>       }
>
> But this is another one where err is unused.

Generated by the code as visit_type_UserDefOne_members() above.

>>     [Uninteresting stuff omitted...]
>> diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
>> index 5b665ee38c..adf9a788e2 100644
>> --- a/include/qapi/clone-visitor.h
>
>> +++ b/include/qapi/visitor.h
>> @@ -286,6 +284,8 @@ void visit_free(Visitor *v);
>>    * On failure, set *@obj to NULL and store an error through @errp.
>>    * Can happen only when @v is an input visitor.
>>    *
>> + * Return true on succes, false on failure.
>
> success
>
> (copied several times in this file)

Will fix.

>> +++ b/qapi/qapi-clone-visitor.c
>
>> -static void qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
>> +static bool qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
>>                                      Error **errp)
>
> Pre-existing indentation glitch that you could fix while here.

Will do.

>>   {
>>       QapiCloneVisitor *qcv = to_qcv(v);
>>         assert(qcv->depth);
>>       /* Value was already cloned by g_memdup() */
>> +    return true;
>>   }
>>   -static void qapi_clone_type_uint64(Visitor *v, const char *name,
>> +static bool qapi_clone_type_uint64(Visitor *v, const char *name,
>>                                       uint64_t *obj, Error **errp)
>
> Ditto for several more functions in this file.

ACK.

Thanks!


