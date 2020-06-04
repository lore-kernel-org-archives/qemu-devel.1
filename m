Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B56DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2AD206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUqfOi5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2AD206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgu8Z-0004H0-3d
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgu7t-0003og-Ei
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:58:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgu7s-0000a6-0t
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591293477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YsqNAC+JYfP4YuPiX2Hs5pCUSKgDJr7RI5KFA26g320=;
 b=ZUqfOi5y62qFAW0WhtoLWSdBu0fHD6filxhq4TkylG/RZRsP9EXp9AAtFdV000iXQdeVCv
 CyzF0dpV0qIu/ciY9yR/u3GU+fIA/F9dRnxDA2Grycm3bym03JmosqLGpXXi7k8qGKzVey
 I7CyIjs8WQY26YoW8jnptYBba/rrdvY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-OQ9GyrLBNemqhYxa26yH5Q-1; Thu, 04 Jun 2020 13:57:54 -0400
X-MC-Unique: OQ9GyrLBNemqhYxa26yH5Q-1
Received: by mail-wr1-f70.google.com with SMTP id n6so2730466wrv.6
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 10:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YsqNAC+JYfP4YuPiX2Hs5pCUSKgDJr7RI5KFA26g320=;
 b=rQ2lC5TuBgAHlv6JTd2zHGIVUTaLRzzXi7HO84r1beqpFjTZhWJRfcPmDfg8NEPYjy
 0l2E5zd+Cce8y1u/6tCncjnxhvK5QHn765d1spBhhQbmCB0s6ETt7kfCnSlvzhCfs1+Q
 vt1jZX8aZVDi50zOHEUs9nXOhdjhkv9xQ/mODhD1TGBYbWLuCjEWY4l3PVa0d3VpaX82
 QQAhDUOWBogq9GSL/LP9vfGEsiQxBc20fYPA+dYid1s+0EnLuXib+zysBblWkWU8FWDX
 W8zGEba364DjOoNZlPFRy2/viWb5Z8IezzUl44LPjDbLyqdK/93NVdXb9Z7M3gSpfECh
 qSKw==
X-Gm-Message-State: AOAM532EB6WSLO8g8GrE0hLSS3WYUSzpJI8X5XmHeBjoqpDyf0pEGLqh
 YxZIBIBe5DPerNs73gBlMfcFVNVlllJiHtw7muGLXzk62/+F+PgP5V3Pu8wB4j3Fp+z4a5OKh19
 STSVW0/O76k7UhCg=
X-Received: by 2002:a5d:5551:: with SMTP id g17mr5287497wrw.45.1591293472901; 
 Thu, 04 Jun 2020 10:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzatk9E5WucTkoQIMne4FrLKc5tW8aWOIZE8zHRA4Snnk6cfRW9risdiH/kFzuuiM7a7k012A==
X-Received: by 2002:a5d:5551:: with SMTP id g17mr5287477wrw.45.1591293472670; 
 Thu, 04 Jun 2020 10:57:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id o10sm8117869wrq.40.2020.06.04.10.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 10:57:52 -0700 (PDT)
Subject: Re: [PATCH] configure: Do not ignore malloc value
To: Leonid Bloch <lb.workbox@gmail.com>, qemu-devel@nongnu.org
References: <20200524221204.9791-1-lb.workbox@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d5eec2d-f95e-4c12-4427-8e6b68fa1426@redhat.com>
Date: Thu, 4 Jun 2020 19:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200524221204.9791-1-lb.workbox@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 12:22:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/05/20 00:12, Leonid Bloch wrote:
> From: Leonid Bloch <lbloch@janustech.com>
> 
> Not checking the value of malloc will cause a warning with GCC 10.1,
> which may result in configuration failure, with the following line in
> config.log:
> 
> config-temp/qemu-conf.c:2:18: error: ignoring return value of ‘malloc’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
>     2 | int main(void) { malloc(1); return 0; }
>       |                  ^~~~~~~~~
> 
> Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
> ---
>  configure | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 2fc05c4465..d0220b2944 100755
> --- a/configure
> +++ b/configure
> @@ -4567,7 +4567,13 @@ fi
>  if test "$tcmalloc" = "yes" ; then
>    cat > $TMPC << EOF
>  #include <stdlib.h>
> -int main(void) { malloc(1); return 0; }
> +int main(void) {
> +    void *tmp = malloc(1);
> +    if (tmp != NULL) {
> +        return 0;
> +    }
> +    return 1;
> +}
>  EOF
>  
>    if compile_prog "" "-ltcmalloc" ; then
> @@ -4583,7 +4589,13 @@ fi
>  if test "$jemalloc" = "yes" ; then
>    cat > $TMPC << EOF
>  #include <stdlib.h>
> -int main(void) { malloc(1); return 0; }
> +int main(void) {
> +    void *tmp = malloc(1);
> +    if (tmp != NULL) {
> +        return 0;
> +    }
> +    return 1;
> +}
>  EOF
>  
>    if compile_prog "" "-ljemalloc" ; then
> @@ -6144,7 +6156,9 @@ if test "$sanitizers" = "yes" ; then
>  #include <stdlib.h>
>  int main(void) {
>      void *tmp = malloc(10);
> -    return *(int *)(tmp + 2);
> +    if (tmp != NULL) {
> +        return *(int *)(tmp + 2);
> +    }
>  }
>  EOF
>    if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
> 

Queued, thanks.

Paolo


