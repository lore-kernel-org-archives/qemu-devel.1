Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF00C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E55A20731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 20:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk6THXpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E55A20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIHQe-00057C-6B
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 16:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIHPx-0004Zf-0R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 16:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIHPu-00025i-DX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 16:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600201145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytrKaJFGUbf39bPtEOpShZGZpXzbAoR/g9V7Ygb4Krw=;
 b=Bk6THXpryPVtc4ZZZRajrrJd7JyVVKQUeY/omQmjm1Y+4mRp1JfC6wHxB7IxJQnfv3ws9E
 /JAHtwYEMxTJAwS2TWivChsD0HCdBIXeYFmSvoFFUzn3IDznZPVZre4dJjwcWNJdXiB8AF
 zw+4jbXoH4SIUTngIHwc+LsGVSzRnNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-uKnMl-IAPbyadTk7rXnA2g-1; Tue, 15 Sep 2020 16:19:03 -0400
X-MC-Unique: uKnMl-IAPbyadTk7rXnA2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 763746409A;
 Tue, 15 Sep 2020 20:19:02 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2365DC08;
 Tue, 15 Sep 2020 20:19:02 +0000 (UTC)
Date: Tue, 15 Sep 2020 16:19:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] qom: Allow objects to be allocated with increased
 alignment
Message-ID: <20200915201901.GD7594@habkost.net>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
 <20200915174635.2333553-2-richard.henderson@linaro.org>
 <20200915180736.GB7594@habkost.net>
 <6d6a80bf-a542-6818-1638-0318f4aab336@linaro.org>
MIME-Version: 1.0
In-Reply-To: <6d6a80bf-a542-6818-1638-0318f4aab336@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 12:09:59PM -0700, Richard Henderson wrote:
> On 9/15/20 11:07 AM, Eduardo Habkost wrote:
> > On Tue, Sep 15, 2020 at 10:46:31AM -0700, Richard Henderson wrote:
> >> It turns out that some hosts have a default malloc alignment less
> >> than that required for vectors.
> >>
> >> We assume that, with compiler annotation on CPUArchState, that we
> >> can properly align the vector portion of the guest state.  Fix the
> >> alignment of the allocation by using qemu_memalloc when required.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> ---
> >>  include/qom/object.h |  4 ++++
> >>  qom/object.c         | 16 +++++++++++++---
> >>  2 files changed, 17 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/qom/object.h b/include/qom/object.h
> >> index 056f67ab3b..d52d0781a3 100644
> >> --- a/include/qom/object.h
> >> +++ b/include/qom/object.h
> >> @@ -770,6 +770,9 @@ struct Object
> >>   * @instance_size: The size of the object (derivative of #Object).  If
> >>   *   @instance_size is 0, then the size of the object will be the size of the
> >>   *   parent object.
> >> + * @instance_align: The required alignment of the object.  If @instance_align
> >> + *   is 0, then normal malloc alignment is sufficient; if non-zero, then we
> >> + *   must use qemu_memalign for allocation.
> >>   * @instance_init: This function is called to initialize an object.  The parent
> >>   *   class will have already been initialized so the type is only responsible
> >>   *   for initializing its own members.
> >> @@ -807,6 +810,7 @@ struct TypeInfo
> >>      const char *parent;
> >>  
> >>      size_t instance_size;
> >> +    size_t instance_align;
> >>      void (*instance_init)(Object *obj);
> >>      void (*instance_post_init)(Object *obj);
> >>      void (*instance_finalize)(Object *obj);
> >> diff --git a/qom/object.c b/qom/object.c
> >> index 387efb25eb..2e53cb44a6 100644
> >> --- a/qom/object.c
> >> +++ b/qom/object.c
> >> @@ -50,6 +50,7 @@ struct TypeImpl
> >>      size_t class_size;
> >>  
> >>      size_t instance_size;
> >> +    size_t instance_align;
> >>  
> >>      void (*class_init)(ObjectClass *klass, void *data);
> >>      void (*class_base_init)(ObjectClass *klass, void *data);
> >> @@ -114,6 +115,7 @@ static TypeImpl *type_new(const TypeInfo *info)
> >>  
> >>      ti->class_size = info->class_size;
> >>      ti->instance_size = info->instance_size;
> >> +    ti->instance_align = info->instance_align;
> >>  
> >>      ti->class_init = info->class_init;
> >>      ti->class_base_init = info->class_base_init;
> >> @@ -691,13 +693,21 @@ static void object_finalize(void *data)
> >>  static Object *object_new_with_type(Type type)
> >>  {
> >>      Object *obj;
> >> +    size_t size, align;
> >>  
> >>      g_assert(type != NULL);
> >>      type_initialize(type);
> >>  
> >> -    obj = g_malloc(type->instance_size);
> >> -    object_initialize_with_type(obj, type->instance_size, type);
> >> -    obj->free = g_free;
> >> +    size = type->instance_size;
> >> +    align = type->instance_align;
> >> +    if (align) {
> > 
> > If we check for (align > G_MEM_ALIGN) instead, we will be able to
> > set instance_align automatically at OBJECT_DEFINE_TYPE*.
> 
> I agree a value check would be good here, as well as setting this by default.
> 
> As for the value check itself...
> 
> I see that G_MEM_ALIGN isn't actually defined in an interesting or even correct
> way.  E.g. it doesn't take the long double type into account.
> 
> The usual mechanism is
> 
> struct s {
>   char pad;
>   union {
>     long l;
>     void *p;
>     double d;
>     long double ld;
>   } u;
> };
> 
> offsetof(s, u)
> 
> since all of these types are required to be taken into account by the system
> malloc.

Due to the existence of G_MEM_ALIGN, I thought GLib alignment
guarantees could be weaker than malloc().  I've just learned that
GLib uses system malloc() since 2.46.

> 
> E.g it doesn't take other host guarantees into account, e.g. i386-linux
> guarantees 16-byte alignment.  This possibly dubious ABI change was made 20+
> years ago with the introduction of SSE and is now set in stone.
> 
> Glibc has a "malloc-alignment.h" internal header that defaults to
> 
>   MIN(2 * sizeof(size_t), __alignof__(long double))
> 
> and is overridden for i386.  Sadly, it doesn't export MALLOC_ALIGNMENT.
> 
> Musl has two different malloc implementations.  One has UNIT = 16; the other
> has SIZE_ALIGN = 4*sizeof(size_t).  Both have a minimum value of 16, and this
> is not target-specific.
> 
> Any further comments on the subject, or should I put together something that
> computes the MAX of the above?

Once we move to C11, we can just use max_align_t.

While we don't move to C11, why not just use
  __alignof__(union { long l; void *p; double d; long double ld;})
?

-- 
Eduardo


