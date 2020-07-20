Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0DAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CE6206F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTcA/Jhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CE6206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYzO-0004ns-5o
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxYyp-0004Od-Tt
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:49:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50699
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxYyn-0007pq-G7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595263768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1cQbdDdgP6J5mJlFlacqW2gkZVZImoEvbIOcNxjjJFc=;
 b=iTcA/JhsPnNoUt2Lvi+/Ewp2CmI7X4HZQ1IwBt24zU9hZKgrsx/fffsLhwMuHunDT333l+
 NZ7H7VQbuA1K4QUrhhSSvFK/RGzBEVsbA1+sR1fZAWeyrQrHKnMYwYudFvc/YlSfZWF4MS
 4CjL/0DZAGuf6rh5hnxoQf5JJTHec0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-qPzXK-HdMYSE8CkeSwVw3g-1; Mon, 20 Jul 2020 12:49:26 -0400
X-MC-Unique: qPzXK-HdMYSE8CkeSwVw3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A12102C7EC;
 Mon, 20 Jul 2020 16:49:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 656227EF81;
 Mon, 20 Jul 2020 16:49:18 +0000 (UTC)
Subject: Re: [PATCH 1/4] fuzz: build without AddressSanitizer, by default
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200706195534.14962-1-alxndr@bu.edu>
 <20200706195534.14962-2-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7679810c-603f-6d26-9503-93ee763d9a45@redhat.com>
Date: Mon, 20 Jul 2020 18:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200706195534.14962-2-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: bsd@redhat.com, philmd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/07/2020 21.55, Alexander Bulekov wrote:
> We already have a nice --enable-sanitizers option to enable
> AddressSanitizer. There is no reason to duplicate and force this
> functionality in --enable-fuzzing. In the future, if more sanitizers are
> added to --enable-sanitizers, it might be impossible to build with both
> --enable-sanitizers and --enable-fuzzing, since not all sanitizers are
> compatible with libFuzzer. In that case, we could enable ASAN with
> --extra-cflags="-fsanitize=address"
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  configure | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/configure b/configure
> index 8a65240d4a..010c0ca479 100755
> --- a/configure
> +++ b/configure
> @@ -6319,7 +6319,7 @@ fi
>  # checks for fuzzer
>  if test "$fuzzing" = "yes" ; then
>    write_c_fuzzer_skeleton
> -  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address,fuzzer" ""; then
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
>        have_fuzzer=yes
>    fi
>  fi
> @@ -7858,11 +7858,11 @@ if test "$sheepdog" = "yes" ; then
>  fi
>  if test "$fuzzing" = "yes" ; then
>    if test "$have_fuzzer" = "yes"; then
> -    FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
> -    FUZZ_CFLAGS=" -fsanitize=address,fuzzer"
> -    CFLAGS=" -fsanitize=address,fuzzer-no-link"
> +    FUZZ_LDFLAGS=" -fsanitize=fuzzer"
> +    FUZZ_CFLAGS=" -fsanitize=fuzzer"
> +    CFLAGS=" -fsanitize=fuzzer-no-link"
>    else
> -    error_exit "Your compiler doesn't support -fsanitize=address,fuzzer"
> +    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
>      exit 1
>    fi
>  fi
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

I can add the missing $CFLAGS from commit 0ab6c2384ccae89 when picking
up the patch.

 Thomas


