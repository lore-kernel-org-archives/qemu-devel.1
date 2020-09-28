Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04111C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC5E2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVIP2hOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC5E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxFb-0008Dp-CZ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kMwyC-0003Lj-PR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kMwy9-00081D-83
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:29:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601314181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKk46sdFk/P7SA14/DSbPrreDC+Np0hWeiYURj4cHNY=;
 b=WVIP2hOpn7JiOpMDuklCEWSb/AYA3FwdAslfbI73Yc2Hk7xw9UCB31Y9LaeNQ0sJz/B5f5
 xeeDsvzoTky98tidJ+PmbUvvyq91kRbeBPUI7POXyISnQDlMVYqxji+3CpriScu7Svmk65
 cRhCU9mEpU9JK7jgHNdu0cWZ2l6U8nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-8sdpYu-oOpaZtLCNKlG6vA-1; Mon, 28 Sep 2020 13:29:37 -0400
X-MC-Unique: 8sdpYu-oOpaZtLCNKlG6vA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B347A80572E;
 Mon, 28 Sep 2020 17:29:36 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D19A573666;
 Mon, 28 Sep 2020 17:29:34 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] qemu/bswap: Replace bswapXXs() by compiler
 __builtin_bswap()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <82d583fa-6c71-2e79-2af7-b2ccdfe07b3a@redhat.com>
Date: Mon, 28 Sep 2020 19:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200928131934.739451-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/2020 15.19, Philippe Mathieu-Daudé wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/bswap.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 41131d3d76e..fed96dddd7a 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -38,29 +38,31 @@ static inline uint64_t bswap64(uint64_t x)
>  
>  static inline void bswap16s(uint16_t *s)
>  {
> -    *s = bswap16(*s);
> +    *s = __builtin_bswap16(*s);
>  }
>  
>  static inline void bswap32s(uint32_t *s)
>  {
> -    *s = bswap32(*s);
> +    *s = __builtin_bswap32(*s);
>  }
>  
>  static inline void bswap64s(uint64_t *s)
>  {
> -    *s = bswap64(*s);
> +    *s = __builtin_bswap64(*s);
>  }
>  
>  #if defined(HOST_WORDS_BIGENDIAN)
>  #define be_bswap(v, size) (v)
> -#define le_bswap(v, size) glue(bswap, size)(v)
> +#define le_bswap(v, size) glue(__builtin_bswap, size)(v)
>  #define be_bswaps(v, size)
> -#define le_bswaps(p, size) do { *p = glue(bswap, size)(*p); } while(0)
> +#define le_bswaps(p, size) \
> +            do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>  #else
>  #define le_bswap(v, size) (v)
> -#define be_bswap(v, size) glue(bswap, size)(v)
> +#define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>  #define le_bswaps(v, size)
> -#define be_bswaps(p, size) do { *p = glue(bswap, size)(*p); } while(0)
> +#define be_bswaps(p, size) \
> +            do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>  #endif

What's the advantage of the renaming here if bswap is already #defined
to the builtin function (or another useful function from a system
header)? This just looks like code churn to me?

 Thomas


