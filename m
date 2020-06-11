Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64677C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D397206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9hg7swh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D397206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOzS-00034T-ED
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjOsQ-0004Wv-Qq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:12:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjOsN-0003Lx-Hy
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591888338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=deFoKk7gNM/At55U2tuzz4P+LxVy3t7zfFh3JkK9FCM=;
 b=J9hg7swhipwUC3/GHCoydI9hpQCiamBKxxQb48Wd3E+hxilOvhsHrZDy3aPu4sJGcTeNcm
 UD/Zt85TMnH+makvdIXzGb5BD6yRH5JCh14iYHbs/sWsdEb5cBwKCnROWg4gIpjDzU0cGf
 jW+m4PR+7rwEkVVF6fh0c7rPll+QSuk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-YKmgSmR5OWKzB17r36ERcQ-1; Thu, 11 Jun 2020 11:12:06 -0400
X-MC-Unique: YKmgSmR5OWKzB17r36ERcQ-1
Received: by mail-wr1-f69.google.com with SMTP id p9so2679291wrx.10
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 08:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=deFoKk7gNM/At55U2tuzz4P+LxVy3t7zfFh3JkK9FCM=;
 b=ZiHPUdsweGgIKfwdOKft+leH4EHdMzs+wnmADKevRMBZlbXt5P9bDOS2EI48FCTLdL
 os8bKxnAQdX1NeQEbLNec3u3HfCS0z3ZFik5wGASc3nnIV3bT9oMi+TslbVyFT732kUc
 ZoJUTcA0UL/D2pmoAQdytBY34HZMDc+DBsPCy0YGAS5YzaWDA144/bH5xxxYvhLx0wEq
 lRPT7wwci4vZi9BREQs+5nYCw/XZRUIdc+fvDKXrtebzxW8aBA6yhTOnxTDBlHcJOv4W
 r5p/hKDQZ2B2Y47rC1QLBhC0nzLcyX8aIZncPMSaB5Og9lnwwOJ6p6YYah2iWF/GXiKY
 no1w==
X-Gm-Message-State: AOAM532vXpGQX8xm/hyga9txMWecAZhYToQkrsw0a+6BJ75cg3p3IynO
 AgvFU2RfXA42gPEVlGbX0CClOzLQAZPeu/eYME7mbRq/oLLrHxlihGVx30mfixu8nTz5SPp5CIQ
 RcHzGLR2viFt/Kg0=
X-Received: by 2002:adf:f2c2:: with SMTP id d2mr9663095wrp.424.1591888324887; 
 Thu, 11 Jun 2020 08:12:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiK+zmnTnnd16SZ6xjRG8+5lUWRe/1R5JXhsronq6xUjdvqjq4d1Y7fSvEF6cGN5oKpr9QQg==
X-Received: by 2002:adf:f2c2:: with SMTP id d2mr9663072wrp.424.1591888324630; 
 Thu, 11 Jun 2020 08:12:04 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z22sm4603295wmf.9.2020.06.11.08.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 08:12:04 -0700 (PDT)
Subject: Re: [RFC PATCH] logging: add a LOG_TCG_WARN for temp leaks
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200611144531.20142-1-alex.bennee@linaro.org>
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
Message-ID: <999a1545-48df-c6f7-cf37-6cd0c394da77@redhat.com>
Date: Thu, 11 Jun 2020 17:12:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200611144531.20142-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 4:45 PM, Alex Bennée wrote:
> Pretty much all calls to qemu_log are either wrapped in some other
> enabling check or only enabled with debug defines. Add a specific flag
> for TCG warnings and expand the documentation of the qemu_log
> function.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/log-for-trace.h | 9 ++++++++-
>  include/qemu/log.h           | 2 ++
>  accel/tcg/translator.c       | 4 ++--
>  util/log.c                   | 2 ++
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index 2f0a5b080ea..521d7936243 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -29,7 +29,14 @@ static inline bool qemu_loglevel_mask(int mask)
>      return (qemu_loglevel & mask) != 0;
>  }
>  
> -/* main logging function */
> +/**
> + * qemu_log: main logging function
> + *
> + * Most users shouldn't be calling qemu_log unconditionally as it adds
> + * noise to logging output. Either use qemu_log_mask() or wrap
> + * successive log calls a qemu_loglevel_mask() check and
> + * qemu_log_lock/unlock(). The tracing infrastructure does similar wrapping.
> + */
>  int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);
>  
>  #endif
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index f4724f73301..e1574ef7c14 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -64,6 +64,8 @@ static inline bool qemu_log_separate(void)
>  #define CPU_LOG_PLUGIN     (1 << 18)
>  /* LOG_STRACE is used for user-mode strace logging. */
>  #define LOG_STRACE         (1 << 19)
> +/* Additional TCG warnings */
> +#define LOG_TCG_WARN       (1 << 20)
>  
>  /* Lock output for a series of related logs.  Since this is not needed
>   * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 603d17ff831..44396ccd7ad 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -26,8 +26,8 @@
>  void translator_loop_temp_check(DisasContextBase *db)
>  {
>      if (tcg_check_temp_count()) {
> -        qemu_log("warning: TCG temporary leaks before "
> -                 TARGET_FMT_lx "\n", db->pc_next);
> +        qemu_log_mask(LOG_TCG_WARN, "warning: TCG temporary leaks before "
> +                      TARGET_FMT_lx "\n", db->pc_next);

Why not replace by warn_report_once()?

>      }
>  }
>  
> diff --git a/util/log.c b/util/log.c
> index bdb3d712e88..fad25d9317f 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -334,6 +334,8 @@ const QEMULogItem qemu_log_items[] = {
>  #endif
>      { LOG_STRACE, "strace",
>        "log every user-mode syscall, its input, and its result" },
> +    { LOG_TCG_WARN, "tcg",
> +      "log TCG warnings useful to developers." },
>      { 0, NULL, NULL },
>  };
>  
> 


