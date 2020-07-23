Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD5C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6642206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/9Mans/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6642206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyTGo-0006Eb-5l
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 00:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyTG2-0005e7-7m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:55:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyTFz-0004Q7-UU
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595480098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=wRe7aB4v4eHED9WDgUT3K8FMnG3YY4To3WeZZUj6Zwc=;
 b=b/9Mans/lKrFIjXLDw5C2INlNPtcLZ11GYAF/JQSttMq5/I2q/4OFBDzTp8y8MxrNhZeRP
 Bt9URV2g5/sYej2yXz6ghk37eUaQtDg1UbwWV/75Fm1XZFeR4iVYuzu5N5kZjblESfdZSu
 u6o0AyhS7TTLV6ykEQex83/v1ldhupk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-hEK31OCdMKG20Qw_QR5lcQ-1; Thu, 23 Jul 2020 00:54:56 -0400
X-MC-Unique: hEK31OCdMKG20Qw_QR5lcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF2657;
 Thu, 23 Jul 2020 04:54:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFDD91A888;
 Thu, 23 Jul 2020 04:54:52 +0000 (UTC)
Subject: Re: [PATCH 1/2] configure: avx2 and avx512f detection for clang
To: Shu-Chun Weng <scw@google.com>, rth@twiddle.net
References: <cover.1595463707.git.scw@google.com>
 <bf706105addcaa3f48391be8f7e5c09c3b1735ae.1595463707.git.scw@google.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0152137e-638a-dd06-741a-f03830c92ffd@redhat.com>
Date: Thu, 23 Jul 2020 06:54:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bf706105addcaa3f48391be8f7e5c09c3b1735ae.1595463707.git.scw@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/2020 02.27, Shu-Chun Weng wrote:
> Since clang does not support "#pragma GCC", the instruction sets are
> always disabled. In this change, we
> 
>  1. wrap "#pragma GCC" inside "#ifndef __clang__",
>  2. only retain them around "#include <{e,i,s}mmintrin.h>" to work
>     around gcc bug,
>  3. and annotate each function with `__attribute__((target(*)))` which
>     is recognized by both gcc and clang.
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  configure           | 16 ++++++++++++++--
>  util/bufferiszero.c | 33 +++++++++++++++++++++++----------
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/configure b/configure
> index 4bd80ed507..d9ce3aa5db 100755
> --- a/configure
> +++ b/configure
> @@ -5808,10 +5808,16 @@ fi
>  
>  if test "$cpuid_h" = "yes" && test "$avx2_opt" != "no"; then
>    cat > $TMPC << EOF
> +#include <cpuid.h>
> +#ifndef __clang__
>  #pragma GCC push_options
>  #pragma GCC target("avx2")
> -#include <cpuid.h>
> +#endif
>  #include <immintrin.h>
> +#ifndef __clang__
> +#pragma GCC pop_options
> +#endif
> +__attribute__((target("avx2")))
>  static int bar(void *a) {
>      __m256i x = *(__m256i *)a;
>      return _mm256_testz_si256(x, x);

I wonder whether it would make more sense to pass "-mavx2" to the
compile_object call afterwards and simply remove the #pragmas here?
Did you try that already?

 Thomas


