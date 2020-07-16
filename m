Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B78C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5226620739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWAhGQDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5226620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3FO-0006kk-Li
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw3DV-0005J4-4g
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:42:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw3DS-0003kv-LC
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594903341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8zfmQsx9puYHraSYSqEVNExJkd6wk6PAp6jkXbjYdM=;
 b=SWAhGQDMq+UmQYLdLEwSZkZ+k4hlyaagTNd1WKUK6tC5YOrMe5QcA3GLRfTk5UyuDLasmf
 8s9xY5AtOZzoVBGrquUhMJBgktr2JROZkYxSmP6XJxh2BeAZqa5vdhLImDPDqrQEbQaYd/
 XF8jDVi3HDUkGYYOPPEIbB4PHrUhfGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-dtn9_aGTM1CbDdfHjLUlCw-1; Thu, 16 Jul 2020 08:42:19 -0400
X-MC-Unique: dtn9_aGTM1CbDdfHjLUlCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ECED1083E83;
 Thu, 16 Jul 2020 12:42:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC14878471;
 Thu, 16 Jul 2020 12:42:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6916B11385E0; Thu, 16 Jul 2020 14:42:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Qiang <liq3ea@163.com>
Subject: Re: [PATCH] qapi: record the last element in order to avoid memory
 leak
References: <20200715151153.15054-1-liq3ea@163.com>
Date: Thu, 16 Jul 2020 14:42:16 +0200
In-Reply-To: <20200715151153.15054-1-liq3ea@163.com> (Li Qiang's message of
 "Wed, 15 Jul 2020 08:11:53 -0700")
Message-ID: <87mu3zoclz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, liq3ea@gmail.com,
 armbru@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Li Qiang <liq3ea@163.com> writes:

> While executing 'tests/test-qobject-input-visitor'. I got
> following error:
>
> /visitor/input/fail/alternate: OK
> /visitor/input/fail/union-list: OK
>
> =================================================================
> ==4353==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x7f192d0c5d28 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
>     #1 0x7f192cd21b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
>     #2 0x556725f6bbee in visit_next_list qapi/qapi-visit-core.c:86
>     #3 0x556725f49e15 in visit_type_UserDefOneList tests/test-qapi-visit.c:474
>     #4 0x556725f4489b in test_visitor_in_fail_struct_in_list tests/test-qobject-input-visitor.c:1086
>     #5 0x7f192cd42f29  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72f29)
>
> SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).

Good catch!

Regressed in commit cdd2b228b9 "qapi: Smooth visitor error checking in
generated code".

> This is because in 'visit_type_UserDefOneList' function when
> 'visit_type_UserDefOne' failed and we go to out_obj. And have
> no chance to process the last element. The path is:
> visit_type_UserDefOneList
>     ->visit_type_UserDefOne(error occured)
>         ->qapi_free_UserDefOneList
>             -->visit_type_UserDefOneList(again)
>
> In the last 'visit_type_UserDefOneList' we will free the elements
> allocated in the first 'visit_type_UserDefOneList'. However we delete
> the element in 'qapi_dealloc_next_list'. If then 'visit_type_UserDefOne'
> return false we will skip the element that still in the 'obj' linked
> list. This is why the ASAN complains this memory leak.
> This patch store the recent processing elements in 'QapiDeallocVisitor'.
> In 'qapi_dealloc_end_list' if it is not NULL, we free it.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>

Before commit cdd2b228b9, visit_type_UserDefOne() succeeded for the last
element with the dealloc visitor.  Since then, it fails.  That's wrong.

> ---
>  qapi/qapi-dealloc-visitor.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
> index ef283f2966..6335cadd9c 100644
> --- a/qapi/qapi-dealloc-visitor.c
> +++ b/qapi/qapi-dealloc-visitor.c
> @@ -20,8 +20,14 @@
>  struct QapiDeallocVisitor
>  {
>      Visitor visitor;
> +    void *last;
>  };
>  
> +static QapiDeallocVisitor *to_qdv(Visitor *v)
> +{
> +    return container_of(v, QapiDeallocVisitor, visitor);
> +}
> +
>  static bool qapi_dealloc_start_struct(Visitor *v, const char *name, void **obj,
>                                        size_t unused, Error **errp)
>  {
> @@ -46,19 +52,25 @@ static bool qapi_dealloc_start_list(Visitor *v, const char *name,
>                                      GenericList **list, size_t size,
>                                      Error **errp)
>  {
> +    QapiDeallocVisitor *qdv = to_qdv(v);
> +    qdv->last = *list;
>      return true;
>  }
>  
>  static GenericList *qapi_dealloc_next_list(Visitor *v, GenericList *tail,
>                                             size_t size)
>  {
> +    QapiDeallocVisitor *qdv = to_qdv(v);
>      GenericList *next = tail->next;
> +    qdv->last = next;
>      g_free(tail);
>      return next;
>  }
>  
>  static void qapi_dealloc_end_list(Visitor *v, void **obj)
>  {
> +    QapiDeallocVisitor *qdv = to_qdv(v);
> +    g_free(qdv->last);
>  }
>  
>  static bool qapi_dealloc_type_str(Visitor *v, const char *name, char **obj,

I'm sure your patch plugs the leak.  But we should really make
visit_type_UserDefOne() behave as it did before I broke it.  This should
do:

diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 3fb2f30510..cdabc5fa28 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -249,6 +249,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     if (!*obj) {
         /* incomplete */
         assert(visit_is_dealloc(v));
+        ok = true;
         goto out_obj;
     }
     if (!visit_type_%(c_name)s_members(v, *obj, errp)) {


