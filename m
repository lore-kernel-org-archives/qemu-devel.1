Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC64C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1CA206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El0ftFrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1CA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmCn-0006tR-U6
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkmBx-0006S4-UI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:18:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45196
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkmBv-000433-Nq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592216290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8mem7F/qE3XEnvkm1870aRjVvu58QzmTlW+wtxHm8tI=;
 b=El0ftFrD2Dw3b3314ojiDaBUCLi8bSe565SYj2TXLia4ORRKaH4w/IQSEVCk3Jk1uiEa0K
 QzLFhDPmaoipAS+hBgWZ8q474CInzTxzL41F2LsCC8L6Ui7SLs4BYvxTbklCaaykkTD2Fr
 WbVRL3CVnkLru8I7MovD4eYyFK298XI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-fb9kGy7GMuG2M4CFErEzxA-1; Mon, 15 Jun 2020 06:18:07 -0400
X-MC-Unique: fb9kGy7GMuG2M4CFErEzxA-1
Received: by mail-wm1-f71.google.com with SMTP id v24so6499381wmh.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8mem7F/qE3XEnvkm1870aRjVvu58QzmTlW+wtxHm8tI=;
 b=VOvUUObGCPQVyGw+CV5cqoH2yOOn9ozNDrl/OWU8qjPUb5gYROqiuS94Tk9ZlBIv8i
 p0gSfNQKekNDaLxQu5+hP3oymQvGFAcRSxdCGfkfrhfhrwCglWBLofRcUh9K+Mfjig6O
 PE3nsfmBr8C2wPc6v1jJpYJ/SZ+vtSBIHkusYuIZWnDdNsxQfxBDiWLsGgdnOZgwR8Vo
 9Q7/SlDMHzAnGoWxYAL3lHONrAeTgrY+KWA6LyZFDPTWr8aNTdQtZ1V2ViPw4UOmvTY6
 hqAACDWE2ttSR2TMrBGkRFTLbDx4P42KFcG7Vb6928SRfussgWQdqFMwoGdm2DQ2+WT6
 KChA==
X-Gm-Message-State: AOAM531X8JtbJbYe7kkWJ2xkk00T29teNN4xTiYw73JJ7vJJabjvkidS
 4dquEqdy4JKCvhQbS6EYi9pxoVda6/r13QmSEFuG3nZV2rS+GZx50VCPqq198OlfZWZbUtzdC3h
 xvMafloBQlz66U9g=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr27537446wrq.420.1592216286187; 
 Mon, 15 Jun 2020 03:18:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrbHO1uJcJqOH68UJ5VLe4f6M1/KHJVqvPgz//0L/pQQjFJHb0bAj/jxgOiKYg5Qc7fwcBHg==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr27537424wrq.420.1592216285840; 
 Mon, 15 Jun 2020 03:18:05 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o82sm22542167wmo.40.2020.06.15.03.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 03:18:05 -0700 (PDT)
Subject: Re: [PULL 082/116] target/i386: correct fix for pcmpxstrx substring
 search
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200612160755.9597-1-pbonzini@redhat.com>
 <20200612160755.9597-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <530b3231-0e47-80af-4bb1-17e50e231efa@redhat.com>
Date: Mon, 15 Jun 2020 12:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200612160755.9597-2-pbonzini@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 6:07 PM, Paolo Bonzini wrote:
> From: Joseph Myers <joseph@codesourcery.com>
> 
> This corrects a bug introduced in my previous fix for SSE4.2 pcmpestri
> / pcmpestrm / pcmpistri / pcmpistrm substring search, commit
> ae35eea7e4a9f21dd147406dfbcd0c4c6aaf2a60.
> 
> That commit fixed a bug that showed up in four GCC tests with one libc
> implementation.  The tests in question generate random inputs to the
> intrinsics and compare results to a C implementation, but they only
> test 1024 possible random inputs, and when the tests use the cases of
> those instructions that work with word rather than byte inputs, it's
> easy to have problematic cases that show up much less frequently than
> that.  Thus, testing with a different libc implementation, and so a
> different random number generator, showed up a problem with the
> previous patch.
> 
> When investigating the previous test failures, I found the description
> of these instructions in the Intel manuals (starting from computing a
> 16x16 or 8x8 set of comparison results) confusing and hard to match up
> with the more optimized implementation in QEMU, and referred to AMD
> manuals which described the instructions in a different way.  Those
> AMD descriptions are very explicit that the whole of the string being
> searched for must be found in the other operand, not running off the
> end of that operand; they say "If the prototype and the SUT are equal
> in length, the two strings must be identical for the comparison to be
> TRUE.".  However, that statement is incorrect.
> 
> In my previous commit message, I noted:
> 
>   The operation in this case is a search for a string (argument d to
>   the helper) in another string (argument s to the helper); if a copy
>   of d at a particular position would run off the end of s, the
>   resulting output bit should be 0 whether or not the strings match in
>   the region where they overlap, but the QEMU implementation was
>   wrongly comparing only up to the point where s ends and counting it
>   as a match if an initial segment of d matched a terminal segment of
>   s.  Here, "run off the end of s" means that some byte of d would
>   overlap some byte outside of s; thus, if d has zero length, it is
>   considered to match everywhere, including after the end of s.
> 
> The description "some byte of d would overlap some byte outside of s"
> is accurate only when understood to refer to overlapping some byte
> *within the 16-byte operand* but at or after the zero terminator; it
> is valid to run over the end of s if the end of s is the end of the
> 16-byte operand.  So the fix in the previous patch for the case of d
> being empty was correct, but the other part of that patch was not
> correct (as it never allowed partial matches even at the end of the
> 16-byte operand).  Nor was the code before the previous patch correct
> for the case of d nonempty, as it would always have allowed partial
> matches at the end of s.
> 
> Fix with a partial revert of my previous change, combined with
> inserting a check for the special case of s having maximum length to
> determine where it is necessary to check for matches.
> 
> In the added test, test 1 is for the case of empty strings, which
> failed before my 2017 patch, test 2 is for the bug introduced by my
> 2017 patch and test 3 deals with the case where a match of an initial
> segment at the end of the string is not valid when the string ends
> before the end of the 16-byte operand (that is, the case that would be
> broken by a simple revert of the non-empty-string part of my 2017
> patch).
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> Message-Id: <alpine.DEB.2.21.2006121344290.9881@digraph.polyomino.org.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/ops_sse.h                |  4 ++--
>  tests/tcg/i386/Makefile.target       |  3 +++
>  tests/tcg/i386/test-i386-pcmpistri.c | 33 ++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/i386/test-i386-pcmpistri.c
> 
> diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
> index 01d6017412..14f2b16abd 100644
> --- a/target/i386/ops_sse.h
> +++ b/target/i386/ops_sse.h
> @@ -2089,10 +2089,10 @@ static inline unsigned pcmpxstrx(CPUX86State *env, Reg *d, Reg *s,
>              res = (2 << upper) - 1;
>              break;
>          }
> -        for (j = valids - validd; j >= 0; j--) {
> +        for (j = valids == upper ? valids : valids - validd; j >= 0; j--) {
>              res <<= 1;
>              v = 1;
> -            for (i = validd; i >= 0; i--) {
> +            for (i = MIN(valids - j, validd); i >= 0; i--) {
>                  v &= (pcmp_val(s, ctrl, i + j) == pcmp_val(d, ctrl, i));
>              }
>              res |= v;
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index 43ee2e181e..53efec0668 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -10,6 +10,9 @@ ALL_X86_TESTS=$(I386_SRCS:.c=)
>  SKIP_I386_TESTS=test-i386-ssse3
>  X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
>  
> +test-i386-pcmpistri: CFLAGS += -msse4.2
> +run-test-i386-pcmpistri: QEMU_OPTS += -cpu max

This test fails on our CI:
https://travis-ci.org/github/qemu/qemu/jobs/698006621#L4246

> +
>  #
>  # hello-i386 is a barebones app
>  #
> diff --git a/tests/tcg/i386/test-i386-pcmpistri.c b/tests/tcg/i386/test-i386-pcmpistri.c
> new file mode 100644
> index 0000000000..1e81ae611a
> --- /dev/null
> +++ b/tests/tcg/i386/test-i386-pcmpistri.c
> @@ -0,0 +1,33 @@
> +/* Test pcmpistri instruction.  */
> +
> +#include <nmmintrin.h>
> +#include <stdio.h>
> +
> +union u {
> +    __m128i x;
> +    unsigned char uc[16];
> +};
> +
> +union u s0 = { .uc = { 0 } };
> +union u s1 = { .uc = "abcdefghijklmnop" };
> +union u s2 = { .uc = "bcdefghijklmnopa" };
> +union u s3 = { .uc = "bcdefghijklmnab" };
> +
> +int
> +main(void)
> +{
> +    int ret = 0;
> +    if (_mm_cmpistri(s0.x, s0.x, 0x4c) != 15) {
> +        printf("FAIL: pcmpistri test 1\n");
> +        ret = 1;
> +    }
> +    if (_mm_cmpistri(s1.x, s2.x, 0x4c) != 15) {
> +        printf("FAIL: pcmpistri test 2\n");
> +        ret = 1;
> +    }
> +    if (_mm_cmpistri(s1.x, s3.x, 0x4c) != 16) {
> +        printf("FAIL: pcmpistri test 3\n");
> +        ret = 1;
> +    }
> +    return ret;
> +}
> 


