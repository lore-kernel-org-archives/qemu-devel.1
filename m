Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9481C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407E521D40
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5lEGqEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407E521D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuvz-0001rA-8a
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZuvB-0000am-4x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZuv8-0008Pb-D0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604404571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMwjYshHHNNDPsfRAKKXqUFVQxg37tbAnaPOB1Mtzr8=;
 b=H5lEGqEpFog7DFalzD+ufwvgzTYqArzl085rn2FJC4PVOauZ+qEv2rnsSZEkQXsjRiNX3d
 MoeRHXb1WYe678I8XCD7w8X0X6/sC+FL4TGLcz+pXq4gwULVidYaCUHpd0J7U8iQuZZ5a7
 uX1DQpxhdgo0cA+8BtQD6Z1N83TJuEw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-7E3xscg4OHC-SCoNI2c9DA-1; Tue, 03 Nov 2020 06:56:10 -0500
X-MC-Unique: 7E3xscg4OHC-SCoNI2c9DA-1
Received: by mail-ej1-f70.google.com with SMTP id d13so5307880ejz.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wMwjYshHHNNDPsfRAKKXqUFVQxg37tbAnaPOB1Mtzr8=;
 b=AENpOs6LLxxws71SMMHtzYJWkR+gHndt8A7D4Lj1GiPEiYCptKUusYn8inmWAfsmwn
 3+xh6yyY63KA+qw2C3C/1/qUqAZb8ye9FXi8C3gXhrfYhgu86+bPhXWre2cXVsXENshK
 6eDQ+jRU/sABo3r1rpUPzMczUBZyj8uo4dXNu/6k7g+t2dyjNGvzXkQwXxr0EIJzX+i0
 gx0HxRBqhtwiUVzVgFMf9k/EV9D7NUcnXuUaFzzN8kHszYYYNTnLwc8MxLpPmfChv1Wp
 stVRhOcUX/qagJenUISBGI3JAgZuCuaUvRY2ZAp2Q4Omjj5cLFPOnjE6vTjJcm6IE3Sk
 mfoA==
X-Gm-Message-State: AOAM531s6ON54GWMavdonWkTLo/ipomehDYxyyEa/ghtPLh149UjAGQU
 WLiza0qjqtyd1kX7+ZrKcWwzCHeVMWHgQp7ZOyKbHQSltazPvUdHTgl9ucInU/szgiw9GvosNgl
 pBLPGZ3fsSpR7OVw=
X-Received: by 2002:aa7:c358:: with SMTP id j24mr21518970edr.265.1604404568957; 
 Tue, 03 Nov 2020 03:56:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNzXFgMCMcCsyS38anJ/RDAMAroI7Zoe8x1kJ0ZaxnvnSowqw9nZF1F5LUpcegoJVJ+hiLwA==
X-Received: by 2002:aa7:c358:: with SMTP id j24mr21518949edr.265.1604404568775; 
 Tue, 03 Nov 2020 03:56:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id c3sm11726333edl.60.2020.11.03.03.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 03:56:08 -0800 (PST)
Subject: Re: [PATCH] tests/qtest/libqos/ahci.c: Avoid NULL dereference in
 ahci_exec()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201103115257.23623-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d42056d2-32cb-aed0-a45f-974ae0fdb10c@redhat.com>
Date: Tue, 3 Nov 2020 12:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103115257.23623-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 12:52, Peter Maydell wrote:
> In ahci_exec() we attempt to permit the caller to pass a NULL pointer
> for opts_in (in which case we use a default set of options).  However
> although we check for NULL when setting up the opts variable at the
> top of the function, we unconditionally dereference opts_in at the
> end of the function as part of freeing the opts->buffer.
> 
> Switch to checking whether the final buffer is the same as the
> buffer we started with, instead of assuming the value we started
> with is always opts_in->buffer.
> 
> At the moment all the callers pass a non-NULL opts argument, so
> we never saw any crashes in practice.
> 
> Fixes: Coverity CID 1432302
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/libqos/ahci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> index 2946abc15ae..fba3e7a954e 100644
> --- a/tests/qtest/libqos/ahci.c
> +++ b/tests/qtest/libqos/ahci.c
> @@ -637,10 +637,13 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
>      AHCICommand *cmd;
>      int rc;
>      AHCIOpts *opts;
> +    uint64_t buffer_in;
>  
>      opts = g_memdup((opts_in == NULL ? &default_opts : opts_in),
>                      sizeof(AHCIOpts));
>  
> +    buffer_in = opts->buffer;
> +
>      /* No guest buffer provided, create one. */
>      if (opts->size && !opts->buffer) {
>          opts->buffer = ahci_alloc(ahci, opts->size);
> @@ -686,7 +689,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
>          g_assert_cmpint(rc, ==, 0);
>      }
>      ahci_command_free(cmd);
> -    if (opts->buffer != opts_in->buffer) {
> +    if (opts->buffer != buffer_in) {
>          ahci_free(ahci, opts->buffer);
>      }
>      g_free(opts);
> 

Queued, thanks.

Paolo


