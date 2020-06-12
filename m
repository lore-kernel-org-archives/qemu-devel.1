Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A15C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B66207ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpPWeVwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B66207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmkl-0007aJ-5Y
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmju-0006kx-2o
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:41:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmjs-0007mK-5l
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591980067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4xBB9UESeUa7inym1PxyNQUxva3dRzfQlnrXIl/x1I=;
 b=cpPWeVwGCdEplMJygD4Shw4zgx9ozXLPVVSnj0hCAv+wBdVuYnoTOWwN0ukom61NWlOO1h
 L25sLhQU/qR5DiHFGWFHWa7dXJH3K1uhr80uUgzmr8zpSrgTga3W0D1WhZUOfPw20dg2JE
 pdn9BLPIlhP3bzL9WtztRP9Eox8mgDU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-JsXyLLC-P-CuXv-DPi0IdQ-1; Fri, 12 Jun 2020 12:41:05 -0400
X-MC-Unique: JsXyLLC-P-CuXv-DPi0IdQ-1
Received: by mail-wr1-f71.google.com with SMTP id e7so4242130wrp.14
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x4xBB9UESeUa7inym1PxyNQUxva3dRzfQlnrXIl/x1I=;
 b=JauyGJnyrw7xFBobzM+p+vCpxJ0R0d7niqNew5Rwz4EYblHw/1G4FGu/f1hcvGlCjK
 dK90UnCb6ZhTq4StfXPrsolMckVKx19RfvcgwMRWil3KmII8gC07MtJLpdE7IBrZcCBT
 jrUf97JpbH9I28fPNogrH983AoxP3ynQK+lK/64sjp27cQSIjG8LfsmvwiaVEZaU5272
 LmgR2j6aUZEDHFRu7HJhKsPmpzt+oM9Q6xZjGhT6tzWKTEK5iry4Qq8XmZiGqTMQJ6rw
 rzpX8Q97nuAHdQ5m/lULCRDXmiAMqKUy3tRt9Ohvx3bDGtDAaJqHOCSigfs8scTsp7Hk
 BBDw==
X-Gm-Message-State: AOAM532CGoQKSV0T29coWAIXkAFBW3MfJj14c2PmnTjkc7GEFFV7O/Gs
 aRE7zybxCLCuMpl/2uVj0r1a0wi5K6ssrt/qldZlRYDJknKNGgvBMO05YD7l2sk4/F1miDyuwxD
 D7vFXA/zBZV0w2cM=
X-Received: by 2002:adf:ef83:: with SMTP id d3mr15052085wro.145.1591980064055; 
 Fri, 12 Jun 2020 09:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm6mo8cMyTI3N2evBuP3T64kHlurE+EnGChJr60rSXOTP2pluFKjeYO/+34Gh80oS4JBAarQ==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr15052056wro.145.1591980063709; 
 Fri, 12 Jun 2020 09:41:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d?
 ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
 by smtp.gmail.com with ESMTPSA id z6sm10699672wrh.79.2020.06.12.09.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 09:41:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] softfloat, target/i386: fprem, fprem1 fixes
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 laurent@vivier.eu, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb560234-5bdc-e78a-a9c0-c823839f2010@redhat.com>
Date: Fri, 12 Jun 2020 18:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 18:54, Joseph Myers wrote:
> The x87 floating-point emulation of the fprem and fprem1 instructions
> works via conversion to and from double.  This is inherently
> unsuitable for a good emulation of any floatx80 operation.  This patch
> series adapts the softfloat floatx80_rem implementation to be suitable
> for these instructions and uses it to reimplement them.
> 
> There is an existing test for these instructions, test-i386-fprem.c,
> based on comparison of output.  It produces 1679695 lines of output,
> and before this patch series 415422 of those lines are different on
> hardware from the output produced by QEMU.  Some of those differences
> are because QEMU's x87 emulation does not yet produce the "denormal
> operand" exception; ignoring such differences (modifying the output
> from a native run not to report that exception), there are still
> 398833 different lines.  This patch series reduces that latter number
> to 1 (that one difference being because of missing checks for
> floating-point stack underflow, another global issue with the x87
> emulation), or 35517 different lines without the correction for lack
> of denormal operand exception support.
> 
> Several fixes to and new features in the softfloat support for this
> operation are needed; floatx80_mod, previously present in the m68k
> code only, is made generic and unified with floatx80_rem in a new
> floatx80_modrem of which floatx80_mod and floatx80_rem are thin
> wrappers.  The only architectures using float*_rem for other formats
> are arm (FPA emulation) and openrisc (instructions that have been
> removed in the latest architecture version); they do not appear to
> need any of the new features, and all the bugs fixed are specific to
> floatx80, so no changes are made to the remainder implementation for
> those formats.
> 
> A new feature added is returning the low bits of the quotient from
> floatx80_modrem, as needed for both x87 and m68k.  The logic used to
> determine the low 7 bits of the quotient for m68k
> (target/m68k/fpu_helper.c:make_quotient) appears completely bogus (it
> looks at the result of converting the remainder to integer, the
> quotient having been discarded by that point); this patch series does
> not change that to use the new interface, but the m68k maintainers may
> wish to do so.
> 
> The Intel instruction set documentation leaves unspecified the exact
> number of bits by which the remainder instructions reduce the operand
> each time.  The AMD documentation gives a specific formula, which
> empirically Intel processors follow as well, and that formula is
> implemented in the code.  The AMD documentation also specifies that
> flags other than C2 are cleared in the partial remainder case, whereas
> the Intel manual is silent on that (but the processors do appear to
> clear those flags); this patch implements that flag clearing, and
> keeps the existing flag clearing in cases where the instructions raise
> "invalid" (although it seems hardware in fact only clears some but not
> all flags in that case, leaving other flags unchanged).
> 
> The Intel manuals include an inaccurate table asserting that (finite
> REM 0) should raise "divide by zero"; actually, in accordance with
> IEEE semantics, it raises "invalid".  The AMD manuals inaccurately say
> for both fprem and fprem1 that if the exponent difference is negative,
> the numerator is returned unchanged, which is correct (apart from
> normalizing pseudo-denormals) for fprem but not for fprem1 (and the
> old QEMU code had an incorrect optimization following the AMD manuals
> for fprem1).
> 
> Changes in version 2 of the patch series: fix comment formatting and
> combine patches 6 and 7.
> 
> Joseph Myers (6):
>   softfloat: merge floatx80_mod and floatx80_rem
>   softfloat: fix floatx80 remainder pseudo-denormal check for zero
>   softfloat: do not return pseudo-denormal from floatx80 remainder
>   softfloat: do not set denominator high bit for floatx80 remainder
>   softfloat: return low bits of quotient from floatx80_modrem
>   target/i386: reimplement fprem, fprem1 using floatx80 operations
> 
>  fpu/softfloat.c          |  87 ++++++++++++++++++----
>  include/fpu/softfloat.h  |   3 +
>  target/i386/fpu_helper.c | 156 ++++++++++++---------------------------
>  target/m68k/softfloat.c  |  83 ---------------------
>  target/m68k/softfloat.h  |   1 -
>  5 files changed, 122 insertions(+), 208 deletions(-)
> 

Queued, thanks.

Paolo


