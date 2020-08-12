Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FEBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DD1206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QupwEUGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DD1206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nN5-0004QT-RO
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5nMQ-0003Un-Qj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:47:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5nMP-0007Ka-3s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597225672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EZ1eFdrtHjPt2+u5Kn9geSH54/kWsbLQxQvawp+wdY=;
 b=QupwEUGsqHCrSqcp6Shpw72/PacCbYIgXWpU4uhf03Edtyk/EAMi+RA/2IGy/iDtxS/AXp
 HXtDDKwJpFeWn8uZS6ftOQ7Jr6qsMgwhZFP47Gdvi8w2Q4d6ns5UG0AghVGf1MsS0zUWg6
 zuI6DZoymQuTxibHoPpSsFjZvvRzReI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-xzZ5WlQXMcy7qy90pbmcog-1; Wed, 12 Aug 2020 05:47:51 -0400
X-MC-Unique: xzZ5WlQXMcy7qy90pbmcog-1
Received: by mail-wr1-f72.google.com with SMTP id f7so694460wrs.8
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 02:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3EZ1eFdrtHjPt2+u5Kn9geSH54/kWsbLQxQvawp+wdY=;
 b=AThhRV9pEBnze7TkhPe7ODEveSkyyWqUNd/qSd+k6gReqlrzoR6U2P8FzAQMU4Fmho
 /s3YPuY69c8dW5SCA81Gp5/Y9y0MXO7/f5arcZpF5o1Ytwf2qG7e6ZXdGmvINRQfYx+j
 o8s4v3ftfLg5/gqp5y0ML50okmpkJvtMPCE247yyC7N5h09tRM09aNLCyuHjjGuSH6dA
 Va3KgbR3jSLlwLbMMU0H9n94b+c3C6zRkwzEUQrSA07pV/Nu6TEWavfreItxCuv/VRiT
 AMYfPxY7iRThEwqcNVxg7+2nSJ5CoRDw/5WUiSSfXBstXC1zxMMDNMg1/1P221uIKuSf
 SPCQ==
X-Gm-Message-State: AOAM530S4T+CizacoJW8RcOoODikUhWlj1FMSy7whZmusPab3k+Fiwjc
 huh33+BemPVoZlKPDaOuuEKTAnijlG+RBv++WnpXAjJs1nPEpSuec4/HtiBTNxhyauzQKE+G+6C
 FPmcDFXF7l2kxKbo=
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr7571183wmf.31.1597225669862; 
 Wed, 12 Aug 2020 02:47:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRgAPWOkUpXRJrFE3fUikvl943GzFIiSlO6bjaT/kITjD/LlI9B+EKiwpGVeMidXO64TUh9A==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr7571158wmf.31.1597225669564; 
 Wed, 12 Aug 2020 02:47:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:744e:cb44:4103:26d3?
 ([2001:b07:6468:f312:744e:cb44:4103:26d3])
 by smtp.gmail.com with ESMTPSA id h14sm2848082wml.30.2020.08.12.02.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 02:47:49 -0700 (PDT)
Subject: Re: [PATCH 06/11] tests/Makefile: Add $(EXESUF) to fp-test target
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-7-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44421020-7d46-8e3c-e865-528b5e8dbf36@redhat.com>
Date: Wed, 12 Aug 2020 11:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200804170055.2851-7-thuth@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/20 19:00, Thomas Huth wrote:
> In case we ever want to compile this for Windows, we need the $(EXESUF)
> here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 2806e062d0..e2532e12e2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -687,7 +687,7 @@ check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check
>  # generic Makefile expansions. Once we are cleanly passing all
>  # the tests we can simplify the make syntax.
>  
> -FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
> +FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test$(EXESUF)
>  
>  # the build dir is created by configure
>  $(FP_TEST_BIN): config-host.h $(test-util-obj-y)
> 

When converting it to Meson, fptest broke badly for me on Windows due to
namespace pollution (Windows headers use FLOAT128 and LITTLEENDIAN
symbols).  I would just leave out this patch since check-softfloat has
been converted to meson already.

Paolo


