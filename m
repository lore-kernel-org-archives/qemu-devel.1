Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE47C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02BC20754
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ4CJ94+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02BC20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdT2-0000N3-UI
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOdS0-0008IU-Ui
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOdRy-0005W9-EV
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601715808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qHIM1wiG6dxC9QZtfl4pNWjg//CXNW26r/dhQ7Lqwhw=;
 b=WQ4CJ94+Tm1MuId5PwNzvsTQq9YdWZfzHn4+DLI1W9+/+o7wc9Y9liSKUsfPzex9Hx2YEl
 k+G048bzOF4/zHjOosaimvSLuHzLYccckMVVD67Yvq2DIjYXpMI3o/9aFiYuRFiGJsEzSY
 GtAEWXCZDjXg3rwJ7rZN+Sqdui5dC8s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-IHNkGXkSNWOuhcEfjA1cvw-1; Sat, 03 Oct 2020 05:03:27 -0400
X-MC-Unique: IHNkGXkSNWOuhcEfjA1cvw-1
Received: by mail-wr1-f72.google.com with SMTP id d13so1585504wrr.23
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qHIM1wiG6dxC9QZtfl4pNWjg//CXNW26r/dhQ7Lqwhw=;
 b=WbFnXYjMQ8eKfVIvcmjPXpa1P8xJ7nlvB7dNGcZoyWpbWHEK8N+/11tHnqiMjjWiMf
 uWE02WzVK3J+uYXCfyDEBCqRBhQCcTFO3t9ub6gDTu5Cq9IwczyhhfwnsrM7G1Wfptse
 E33tVNS/RzG/QZzubLkuK50VG3yJSQhR+Bw1D/pPUHdti0wcdbFAU3bFPx643Bte72T4
 5LQvu8b6ku1XnYWjV3Rsn9zGC5ZW1XytP8Tt7UiTsht5DRvuP+kIB5I9KJYgLeIUJZUK
 i+St3+h9teP0Z7YXYRl22hiYHweGb4YYCdPAyD2usbSsBz95yu56JbtH2ZDdHdSmml13
 iy9w==
X-Gm-Message-State: AOAM532w61Xp1icrMouI64YGtPjsEQLM27EK4Z5jHueDWWlZwHMYS0f6
 1qk8uWItpbJIOg8ZtIzwfSCtk2XZBQ7qU1L8Ls8wWd7lrRDYlDg29BDyjqDU1VymWVyaT+YjXpa
 hd0OCNYtXiFXWgsc=
X-Received: by 2002:a1c:bbc6:: with SMTP id l189mr7301172wmf.52.1601715806069; 
 Sat, 03 Oct 2020 02:03:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgtt+qJtNXjXb3lZ38OvVF6GPYWCwUpWzUB8bHvNkVqzmG2TAe3N5uOEBXHU46a5cAEunE+A==
X-Received: by 2002:a1c:bbc6:: with SMTP id l189mr7301154wmf.52.1601715805835; 
 Sat, 03 Oct 2020 02:03:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f6ef:6259:374d:b794?
 ([2001:b07:6468:f312:f6ef:6259:374d:b794])
 by smtp.gmail.com with ESMTPSA id h8sm4662184wrw.68.2020.10.03.02.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:03:25 -0700 (PDT)
Subject: Re: [PATCH 5/6] docs/devel/qom: Remove usage of <code>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201003025424.199291-1-ehabkost@redhat.com>
 <20201003025424.199291-6-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e311d19b-69ec-1839-6ec4-997d90dfc23a@redhat.com>
Date: Sat, 3 Oct 2020 11:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003025424.199291-6-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 04:54, Eduardo Habkost wrote:
> <code> is not valid reST syntax.
> 
> Function @argument references don't need additional markup, so
> just remove <code></code>.
> 
> Constants were changed to use reST ``code`` syntax
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/object.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e738dfc6744..16c9bcdf3b0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1256,7 +1256,7 @@ char *object_property_get_str(Object *obj, const char *name,
>   * Writes an object's canonical path to a property.
>   *
>   * If the link property was created with
> - * <code>OBJ_PROP_LINK_STRONG</code> bit, the old target object is
> + * ``OBJ_PROP_LINK_STRONG`` bit, the old target object is
>   * unreferenced, and a reference is added to the new target object.
>   *
>   * Returns: %true on success, %false on failure.
> @@ -1603,16 +1603,16 @@ void object_property_allow_set_link(const Object *obj, const char *name,
>   *
>   * Links form the graph in the object model.
>   *
> - * The <code>@check()</code> callback is invoked when
> + * The @check() callback is invoked when
>   * object_property_set_link() is called and can raise an error to prevent the
> - * link being set.  If <code>@check</code> is NULL, the property is read-only
> + * link being set.  If @check is NULL, the property is read-only
>   * and cannot be set.
>   *
>   * Ownership of the pointer that @child points to is transferred to the
> - * link property.  The reference count for <code>*@child</code> is
> + * link property.  The reference count for *@child is
>   * managed by the property from after the function returns till the
>   * property is deleted with object_property_del().  If the
> - * <code>@flags</code> <code>OBJ_PROP_LINK_STRONG</code> bit is set,
> + * @flags ``OBJ_PROP_LINK_STRONG`` bit is set,
>   * the reference count is decremented when the property is deleted or
>   * modified.

You can use % too in this case and in the first hunk above; there's
actually no difference between ``a`` and %a except the latter is
shorter.  Linux generally prefers %a, though kernel-doc also knows about
``a`` so that ``%x`` is interpreted correctly when the percent sign
should be a literal.

Apart from that.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

>   *
> @@ -1823,7 +1823,7 @@ ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
>   * Add an alias for a property on an object.  This function will add a property
>   * of the same type as the forwarded property.
>   *
> - * The caller must ensure that <code>@target_obj</code> stays alive as long as
> + * The caller must ensure that @target_obj stays alive as long as
>   * this property exists.  In the case of a child object or an alias on the same
>   * object this will be the case.  For aliases to other objects the caller is
>   * responsible for taking a reference.
> 


