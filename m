Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFAE206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQXWb3Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFAE206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSFS-0007fh-Rh
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSEV-0006bN-P9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:11:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52933
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSEU-0000R5-0W
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592377896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UCp+j+Zo+0lN7BhouwSYRrY7hZpMTbZcn99yMu9leYU=;
 b=eQXWb3QzK6F4tDE5U5Nx5+/gAm3exqqnhStQQsMGJSVQJwFllmoXdfFVOc0/tPFFx58CTg
 vFlKYbk1EbqQzm0emQKnZZ5SxSrCcfQJhlE3Nqn3gtquN3De5ENRC0Qc6S7iOj6d+fja4W
 MUvOGKfAvvwtIicuBJJ90UTA78eke+U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-soVmfsoTOky5S2QgPq0RCw-1; Wed, 17 Jun 2020 03:11:32 -0400
X-MC-Unique: soVmfsoTOky5S2QgPq0RCw-1
Received: by mail-wm1-f70.google.com with SMTP id r1so487064wmh.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UCp+j+Zo+0lN7BhouwSYRrY7hZpMTbZcn99yMu9leYU=;
 b=mUiqgjk5IxJLJNoJztpXhRVK1aQFU5yCVi7dCX2yWBhXREjUtljteRcrm2sXwaZhdW
 GG4mJZQNwrvXCZn9VbEu+pDypZVJqNzXIvmh52+ylGCy4I256WCmVfOdB7NCQSnTzExs
 sBHtP+M+7ivb8lj48hH2Hl+gMdU+bNJQEPbR+rMXQ1TT+h2KIxw4thn/Ahqj8Nm/8CUL
 Ls1QJnax/2clWmcpJ1igIVnB0esyhowaWiOhuTwjD0rbPDaQT8j8vsTbLmSIK9zw5r3E
 rLFQiWM9l+cW19Dd5MEk8waqW2lHWU9pY0pyfzpXMVL9OAGI+oO49jZ/+mnVDZkMColH
 iOMA==
X-Gm-Message-State: AOAM531lVBMFYgcObAL8AmQo7kB/9OtRvutj47TvcHs0q50zU5ae6Xoc
 CrB1xYMSB1gv/D1Mu6wl4TUz4zLWrTgqr7qB24zwomTh64p1QtsBQ4b3QYodU7nJmDKxrLkENc1
 uvdj4unMr+ugM6v4=
X-Received: by 2002:adf:a18b:: with SMTP id u11mr6852658wru.102.1592377891424; 
 Wed, 17 Jun 2020 00:11:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzapZ1w8J6N5O+2sU0mTkZkepu9BT5P+l8rdIlaJnD60P1G4QLP/+nptuqIuNmlq2Om/u7i0A==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr6852638wru.102.1592377891226; 
 Wed, 17 Jun 2020 00:11:31 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id g187sm7591819wma.17.2020.06.17.00.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 00:11:30 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] configure: Clean up warning flag lists
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
 <20200617043757.1623337-4-richard.henderson@linaro.org>
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
Message-ID: <588db04a-086f-3e2e-301d-1aee43843a34@redhat.com>
Date: Wed, 17 Jun 2020 09:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617043757.1623337-4-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 6:37 AM, Richard Henderson wrote:
> Use a helper function to tidy the assembly of gcc_flags.
> Separate flags that disable warnings from those that enable,
> and sort the disable warnings to the end.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/configure b/configure
> index b01b5e3bed..a8bef95282 100755
> --- a/configure
> +++ b/configure
> @@ -97,6 +97,11 @@ do_cxx() {
>      do_compiler "$cxx" "$@"
>  }
>  
> +# Append $2 to the variable named $1, with space separation
> +add_to() {
> +    eval $1=\${$1:+\"\$$1 \"}\$2
> +}

Nice trick Eric!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  update_cxxflags() {
>      # Set QEMU_CXXFLAGS from QEMU_CFLAGS by filtering out those
>      # options which some versions of GCC's C++ compiler complain about
> @@ -2024,16 +2029,33 @@ if ! compile_prog "" "" ; then
>      error_exit "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v5.1)"
>  fi
>  
> -gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
> -gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
> -gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
> -gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
> -gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
> -gcc_flags="-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
> -# Note that we do not add -Werror to gcc_flags here, because that would
> -# enable it for all configure tests. If a configure test failed due
> -# to -Werror this would just silently disable some features,
> -# so it's too error prone.
> +# Accumulate -Wfoo and -Wno-bar separately.
> +# We will list all of the enable flags first, and the disable flags second.
> +# Note that we do not add -Werror, because that would enable it for all
> +# configure tests. If a configure test failed due to -Werror this would
> +# just silently disable some features, so it's too error prone.
> +
> +warn_flags=
> +add_to warn_flags -Wold-style-declaration
> +add_to warn_flags -Wold-style-definition
> +add_to warn_flags -Wtype-limits
> +add_to warn_flags -Wformat-security
> +add_to warn_flags -Wformat-y2k
> +add_to warn_flags -Winit-self
> +add_to warn_flags -Wignored-qualifiers
> +add_to warn_flags -Wempty-body
> +add_to warn_flags -Wnested-externs
> +add_to warn_flags -Wendif-labels
> +add_to warn_flags -Wexpansion-to-defined
> +
> +nowarn_flags=
> +add_to nowarn_flags -Wno-initializer-overrides
> +add_to nowarn_flags -Wno-missing-include-dirs
> +add_to nowarn_flags -Wno-shift-negative-value
> +add_to nowarn_flags -Wno-string-plus-int
> +add_to nowarn_flags -Wno-typedef-redefinition
> +
> +gcc_flags="$warn_flags $nowarn_flags"
>  
>  cc_has_warning_flag() {
>      write_c_skeleton;
> 


