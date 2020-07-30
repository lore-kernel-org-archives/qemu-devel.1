Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071BBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4AA20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0xf/zHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4AA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BFX-0002dR-5z
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1BEm-0002Ag-E8
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:16:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30594
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1BEk-0001Ly-Ny
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596125813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3R1pJ/E5h8B4EXgzvQDEYSsQm5QZYnxUa8aiQNhvHDM=;
 b=Q0xf/zHuZ9BZqkQBcY2EWh1J0dlA9ntnWbJMklC7ujD15N4CA5ZRHK/9fa5idMhLUtjt/U
 LHbVBdCd59ASHoYLw9K1L+uLiz8LJ4DXIMYy4VVTOf3WKnqaI8sdAVJg6ulGLRBbBPFhPs
 qCobYjFxpQ9VYK4NvZWDe3kbD7fbwQI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-ktHCTiaaPka-7WrNReuSWQ-1; Thu, 30 Jul 2020 12:16:51 -0400
X-MC-Unique: ktHCTiaaPka-7WrNReuSWQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so7084238wrr.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3R1pJ/E5h8B4EXgzvQDEYSsQm5QZYnxUa8aiQNhvHDM=;
 b=L1QTEfSaseS7DTcygVBcHh5AYFPE5TPuI77fG9LRYj7h2CzAvr74DY3r1qRmu/8t3f
 hGpYs7GmX13tSyIxOXulB9BfRVGhUgZ7Vvc4Gw+eLACKhNggmMUpuD/KPEKqR1y2kZhO
 n5O8VJ8jY5u0XOEbPpRezFbO6IN7Jl0BzgwAUBFPe8dOFZg9f5jxmMEXAl69l/5bNH6t
 uNp6Y2bjyXoWU1Fz9p5+ZMZslA/f0YwQGifaZ0WBq7d66/HV5ghXAtF5RloKoF88g3ih
 7a8h/29OPS1QQVXCSk+U9VgN4kC+N2Sj+Ly1bpisI8jTz2kYUBtPpE4iodtnwXKJhpXD
 l1zA==
X-Gm-Message-State: AOAM531hBWgVuGUbIUBcHExK0KvNbCjbiSVCufQIXURvPXa88zjTIew/
 VJHtY3hdoQQJDHm+CpgUlPT9dq77g8HCB/rx6ZO4Retw+qZurwWZLFh19NqvFwGk9MU5lyf1kLg
 QJC3TjR//NheAVgY=
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr80715wmn.6.1596125809639;
 Thu, 30 Jul 2020 09:16:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2Plmj17pJv2cOwfYbJQCf6Nh5MlOysl8bv07kQugkpxik84a48j4FyrrvwHvu733yQbJnQw==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr80705wmn.6.1596125809408;
 Thu, 30 Jul 2020 09:16:49 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id v12sm10851179wrs.2.2020.07.30.09.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 09:16:48 -0700 (PDT)
Subject: Re: [PATCH for-5.1] tracetool: carefully define SDT_USE_VARIADIC
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200729153926.127083-1-stefanha@redhat.com>
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
Message-ID: <fe193d2f-1569-e402-7f30-0deee5729f09@redhat.com>
Date: Thu, 30 Jul 2020 18:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200729153926.127083-1-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/20 5:39 PM, Stefan Hajnoczi wrote:
> The dtrace backend defines SDT_USE_VARIADIC as a workaround for a
> conflict with a LTTng UST header file, which requires SDT_USE_VARIADIC
> to be defined.
> 
> LTTng UST <lttng/tracepoint.h> breaks if included after generated dtrace
> headers because SDT_USE_VARIADIC will already be defined:
> 
>   #ifdef LTTNG_UST_HAVE_SDT_INTEGRATION
>   #define SDT_USE_VARIADIC <-- error, it's already defined
>   #include <sys/sdt.h>
> 
> Be more careful when defining SDT_USE_VARIADIC. This fixes the build
> when both the dtrace and ust tracers are enabled at the same time.
> 
> Fixes: 27e08bab94f7c6ebe0b75938c98c394c969e3fd8 ("tracetool: work around ust <sys/sdt.h> include conflict")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/backend/dtrace.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
> index b7fe4c1b50..fc0c8fc52f 100644
> --- a/scripts/tracetool/backend/dtrace.py
> +++ b/scripts/tracetool/backend/dtrace.py
> @@ -44,11 +44,15 @@ def generate_h_begin(events, group):
>      # require SDT_USE_VARIADIC to be defined. If dtrace includes <sys/sdt.h>
>      # first without defining SDT_USE_VARIADIC then ust breaks because the
>      # STAP_PROBEV() macro is not defined.
> +    out('#ifndef SDT_USE_VARIADIC')
>      out('#define SDT_USE_VARIADIC 1')
> +    out('#endif')
>  
>      out('#include "%s"' % header,
>          '')
>  
> +    out('#undef SDT_USE_VARIADIC')
> +
>      # SystemTap defines <provider>_<name>_ENABLED() but other DTrace
>      # implementations might not.
>      for e in events:
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


