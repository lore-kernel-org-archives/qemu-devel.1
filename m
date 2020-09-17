Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086C0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F475208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVsWw35p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F475208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyu7-0007ZC-F7
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIysk-0006Ac-6K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:43:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIysg-0002jJ-68
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600368220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZWsL7YYl3QT65g7SeKAjBZZqf2lcdb1o65yV/CC4Ao=;
 b=PVsWw35pszMomV3DODwsYCHvePLnxD4js/gNsViDhPOej+BhUxFi5Oc82K2U0i5bhYioRY
 +L4bbTFW9z455KSjqRNpEI4yxalfiJ/OHGrm8YCLYkbn0EyZWjYeCH6XvCLBqvSxgDHgHg
 YcZ7A0Bs+cEiNx9LakSsUwMHiXefIpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-5fSi5dq0M5iVUx7EDXtVSQ-1; Thu, 17 Sep 2020 14:43:38 -0400
X-MC-Unique: 5fSi5dq0M5iVUx7EDXtVSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EE131008550;
 Thu, 17 Sep 2020 18:43:37 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D82119D6C;
 Thu, 17 Sep 2020 18:43:36 +0000 (UTC)
Date: Thu, 17 Sep 2020 14:43:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 1/6] util/oslib-win32: Use _aligned_malloc for
 qemu_try_memalign
Message-ID: <20200917184335.GW7594@habkost.net>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
 <20200916004638.2444147-2-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200916004638.2444147-2-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 05:46:33PM -0700, Richard Henderson wrote:
> We do not need or want to be allocating page sized quanta.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Would it be safe to keep patches 2-6 applied in case this one
gets dropped or reverted for any reason?

I consider patches 2-6 bug fixes (that I'd like to merge soon),
and this one as an optimization (that could be merged later).

> ---
> Cc: Stefan Weil <sw@weilnetz.de>
> ---
>  util/oslib-win32.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index c654dafd93..8d838bf342 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -56,10 +56,8 @@ void *qemu_try_memalign(size_t alignment, size_t size)
>  {
>      void *ptr;
>  
> -    if (!size) {
> -        abort();
> -    }
> -    ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
> +    assert(size != 0);
> +    ptr = _aligned_malloc(alignment, size);
>      trace_qemu_memalign(alignment, size, ptr);
>      return ptr;
>  }
> @@ -93,9 +91,7 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
>  void qemu_vfree(void *ptr)
>  {
>      trace_qemu_vfree(ptr);
> -    if (ptr) {
> -        VirtualFree(ptr, 0, MEM_RELEASE);
> -    }
> +    _aligned_free(ptr);
>  }
>  
>  void qemu_anon_ram_free(void *ptr, size_t size)
> -- 
> 2.25.1
> 
> 

-- 
Eduardo


